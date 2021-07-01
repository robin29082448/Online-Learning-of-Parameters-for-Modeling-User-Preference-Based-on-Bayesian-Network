data = fopen('data.txt','r');
%建立贝叶斯网络结构
N = 6; %六个节点，分别是age,gender,location,preference,type,rating
%分别代表年龄，性别，位置，偏好(隐变量)，类型，评分；
dag = zeros(N,N);
age = 1; gender = 2; location = 3; preference = 4; type = 5; rating = 6;
%节点的取值范围
agenum = 4; gendernum = 2; locationnum = 20; preferencenum = 28; typenum = preferencenum; ratingnum = 5;
%节点之间的连接关系
dag(age,preference) = 1;
dag(gender,preference) = 1;
dag(location,preference) = 1;
dag(location,type) = 1; 
dag(preference,type) = 1;
dag(preference,rating) = 1;
dag(type,rating) = 1;
%初始学习率
%e0 = 0.8;    %版本1
%e0 = 0.01;  %版本2 无职业版最终
e0 =0.1;
%读取初始随机参数
load dzdp_cpt_input.mat

%--------------------------------------------------------------------以上为建立初始模型
%开始在线学习
time = 0;
%t = zeros(agenum,gendernum);
last = 0;
while feof(data)==0
    p1 = zeros(1,agenum);
    p2 = zeros(1,gendernum);
    p3 = zeros(1,locationnum);
    p4 = zeros(agenum,gendernum,locationnum,preferencenum);
    p5 = zeros(locationnum,preferencenum,typenum);
    p6 = zeros(preferencenum,typenum,ratingnum);
    %根据模型计算碎权样本 w(age,gender,location,type,rating,preference)
    for k1=1:agenum
        for k2=1:gendernum
            for k3=1:locationnum
                for k5=1:typenum
                    for k6=1:ratingnum
                        s=0;
                        for k4=1:preferencenum
                            s=s+v1(k1)*v2(k2)*v3(k3)*v4(k1,k2,k3,k4)*v5(k3,k4,k5)*v6(k4,k5,k6);
                        end
                        if s~=0
                            for k4=1:preferencenum
                                w(k1,k2,k3,k5,k6,k4) = v1(k1)*v2(k2)*v3(k3)*v4(k1,k2,k3,k4)*v5(k3,k4,k5)*v6(k4,k5,k6)/s;
                            end
                        else
                            for k4=1:preferencenum
                                w(k1,k2,k3,k5,k6,k4) = 1/preferencenum;
                            end
                        end
                    end
                end
            end
        end
    end
    %获取一个新到达数据
    newdata = str2num(fgetl(data));%newdata=[age,gender,location,type,rating]
    %预测新数据的隐变量取值概率
    %for i=1:preferencenum
    %    c(i)=w(newdata(1),newdata(2),newdata(3),newdata(4),newdata(5),i);
    %end
    %基于Voting EM算法进行在线学习
    %t(newdata(1),newdata(2)) = t(newdata(1),newdata(2))+1;
    %e = e0/(1+time);%学习率自适应调整
    %e = 1/time-0.000000001;  %版本1
    e = e0/(1+0.0001*time);  %版本2
    %e = 0.01;%版本4
    for i=1:preferencenum
        h = [newdata(1),newdata(2),newdata(3),i,newdata(4),newdata(5)];
        c(i) = w(newdata(1),newdata(2),newdata(3),newdata(4),newdata(5),i);
        %更新age节点的参数
        for j=1:agenum
            if j==h(age) 
                vv1(j) = e+(1-e)*v1(j);
            else
                vv1(j) = (1-e)*v1(j);
            end
        end
        %更新gender节点的参数
        for j=1:gendernum
            if j==h(gender)
                vv2(j) = e+(1-e)*v2(j);
            else
                vv2(j) = (1-e)*v2(j);
            end
        end
        %更新location节点的参数
        for j=1:locationnum
            if j==h(location)
                vv3(j) = e+(1-e)*v3(j);
            else
                vv3(j) = (1-e)*v3(j);
            end
        end
        %更新preference节点的参数
        for j=1:preferencenum
            for k=1:agenum
                for m=1:gendernum
                    for n=1:locationnum
                        if (j==h(preference))&&(k==h(age))&&(m==h(gender))&&(n==h(location))
                            vv4(k,m,n,j) = e+(1-e)*v4(k,m,n,j);
                        elseif (j~=h(preference))&&(k==h(age))&&(m==h(gender))&&(n==h(location))
                            vv4(k,m,n,j) = (1-e)*v4(k,m,n,j);
                        else
                            vv4(k,m,n,j) = v4(k,m,n,j);
                        end
                    end
                end
            end
        end
        %更新type节点的参数
        for j=1:typenum
            for k=1:locationnum
                for m=1:preferencenum
                    if (j==h(type))&&(k==h(location))&&(m==h(preference))
                        vv5(k,m,j) = e+(1-e)*v5(k,m,j);
                    elseif (j~=h(type))&&(k==h(location))&&(m==h(preference))
                        vv5(k,m,j) = (1-e)*v5(k,m,j);
                    else
                        vv5(k,m,j) = v5(k,m,j);
                    end
                end
            end
        end
        %更新rating节点的参数
        for j=1:ratingnum
            for k=1:preferencenum
                for m=1:typenum
                    if (j==h(rating))&&(k==h(preference))&&(m==h(type))
                        vv6(k,m,j) = e+(1-e)*v6(k,m,j);
                    elseif (j~=h(rating))&&(k==h(preference))&&(m==h(type))
                        vv6(k,m,j) = (1-e)*v6(k,m,j);
                    else
                        vv6(k,m,j) = v6(k,m,j);
                    end
                end
            end
        end
        %将更新后的参数加权进最终结果
        p1 = p1+c(i)*vv1;
        p2 = p2+c(i)*vv2;
        p3 = p3+c(i)*vv3;
        p4 = p4+c(i)*vv4;
        p5 = p5+c(i)*vv5;
        p6 = p6+c(i)*vv6;
    end
    %更新参数集
    v1 = p1;
    v2 = p2;
    v3 = p3;
    v4 = p4;
    v5 = p5;
    v6 = p6;
end
