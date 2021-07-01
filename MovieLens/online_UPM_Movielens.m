data = fopen('movielens_occupation_random.txt','r');
%������Ҷ˹����ṹ
N = 6; %�����ڵ㣬�ֱ���age,gender,occupation,preference,genres,rating
%�ֱ�������䣬�Ա�ְҵ��ƫ��(������)�����ͣ����֣�
dag = zeros(N,N);
age = 1; gender = 2; occupation = 3; preference = 4; genres = 5; rating = 6;
%�ڵ��ȡֵ��Χ
agenum = 7; gendernum = 2; occupationnum = 21; preferencenum = 18; genresnum = preferencenum; ratingnum = 5;
%�ڵ�֮������ӹ�ϵ
dag(age,occupation) = 1;
dag(gender,occupation) = 1;
dag(age,preference) = 1;
dag(gender,preference) = 1; 
dag(occupation,preference) = 1; 
dag(preference,genres) = 1;
dag(preference,rating) = 1;
dag(genres,rating) = 1;
%��ʼѧϰ��
%e0 = 0.8;    %�汾1
%e0 = 0.01;  %�汾2 ��ְҵ������
e0 =0.1;
%��ȡ��ʼ�������
load oc_input.mat

%--------------------------------------------------------------------����Ϊ������ʼģ��
%��ʼ����ѧϰ
time = 0;
%t = zeros(agenum,gendernum);
last = 0;
while feof(data)==0
    time = time + 1;
    p1 = zeros(1,agenum);
    p2 = zeros(1,gendernum);
    p3 = zeros(agenum,gendernum,occupationnum);
    p4 = zeros(agenum,gendernum,occupationnum,preferencenum);
    p5 = zeros(preferencenum,genresnum);
    p6 = zeros(preferencenum,genresnum,ratingnum);
    %����ģ�ͼ�����Ȩ���� w(age,gender,occupation,genres,rating,preference)
    for k1=1:agenum
        for k2=1:gendernum
            for k3=1:occupationnum
                for k5=1:genresnum
                    for k6=1:ratingnum
                        s=0;
                        for k4=1:preferencenum
                            s=s+v1(k1)*v2(k2)*v3(k1,k2,k3)*v4(k1,k2,k3,k4)*v5(k4,k5)*v6(k4,k5,k6);
                        end
                        if s~=0
                            for k4=1:preferencenum
                                w(k1,k2,k3,k5,k6,k4) = v1(k1)*v2(k2)*v3(k1,k2,k3)*v4(k1,k2,k3,k4)*v5(k4,k5)*v6(k4,k5,k6)/s;
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
    %��ȡһ���µ�������
    newdata = str2num(fgetl(data));%newdata=[age,gender,occupation,genres,rating]
    %Ԥ�������ݵ�������ȡֵ����
    %for i=1:preferencenum
    %    c(i)=w(newdata(1),newdata(2),newdata(3),newdata(4),newdata(5),i);
    %end
    %����Voting EM�㷨��������ѧϰ
    %t(newdata(1),newdata(2)) = t(newdata(1),newdata(2))+1;
    %e = e0/(1+time);%ѧϰ������Ӧ����
    %e = 1/time-0.000000001;  %�汾1
    e = e0/(1+0.0001*time);  %�汾2
    %e = 0.01;%�汾4
    for i=1:preferencenum
        h = [newdata(1),newdata(2),newdata(3),i,newdata(4),newdata(5)];
        c(i) = w(newdata(1),newdata(2),newdata(3),newdata(4),newdata(5),i);
        %����age�ڵ�Ĳ���
        for j=1:agenum
            if j==h(age) 
                vv1(j) = e+(1-e)*v1(j);
            else
                vv1(j) = (1-e)*v1(j);
            end
        end
        %����gender�ڵ�Ĳ���
        for j=1:gendernum
            if j==h(gender)
                vv2(j) = e+(1-e)*v2(j);
            else
                vv2(j) = (1-e)*v2(j);
            end
        end
        %����occupation�ڵ�Ĳ���
        for j=1:occupationnum
            for k=1:agenum
                for m=1:gendernum
                    if(j==h(occupation))&&(k==h(age))&&(m==h(gender))
                        vv3(k,m,j) = e+(1-e)*v3(k,m,j);
                    elseif (j~=h(occupation))&&(k==h(age))&&(m==h(gender))
                        vv3(k,m,j) = (1-e)*v3(k,m,j);
                    else
                        vv3(k,m,j) = v3(k,m,j);
                    end
                end
            end
        end    
        %����preference�ڵ�Ĳ���
        for j=1:preferencenum
            for k=1:agenum
                for m=1:gendernum
                    for n=1:occupationnum
                        if (j==h(preference))&&(k==h(age))&&(m==h(gender))&&(n==h(occupation))
                            vv4(k,m,n,j) = e+(1-e)*v4(k,m,n,j);
                        elseif (j~=h(preference))&&(k==h(age))&&(m==h(gender))&&(n==h(occupation))
                            vv4(k,m,n,j) = (1-e)*v4(k,m,n,j);
                        else
                            vv4(k,m,n,j) = v4(k,m,n,j);
                        end
                    end
                end
            end
        end
        %����genres�ڵ�Ĳ���
        for j=1:genresnum
            for k=1:preferencenum
                if (j==h(genres))&&(k==h(preference))
                    vv5(k,j) = e+(1-e)*v5(k,j);
                elseif (j~=h(genres))&&(k==h(preference))
                    vv5(k,j) = (1-e)*v5(k,j);
                else
                    vv5(k,j) = v5(k,j);
                end
            end
        end
        %����rating�ڵ�Ĳ���
        for j=1:ratingnum
            for k=1:preferencenum
                for m=1:genresnum
                    if (j==h(rating))&&(k==h(preference))&&(m==h(genres))
                        vv6(k,m,j) = e+(1-e)*v6(k,m,j);
                    elseif (j~=h(rating))&&(k==h(preference))&&(m==h(genres))
                        vv6(k,m,j) = (1-e)*v6(k,m,j);
                    else
                        vv6(k,m,j) = v6(k,m,j);
                    end
                end
            end
        end
        %�����º�Ĳ�����Ȩ�����ս��
        p1 = p1+c(i)*vv1;
        p2 = p2+c(i)*vv2;
        p3 = p3+c(i)*vv3;
        p4 = p4+c(i)*vv4;
        p5 = p5+c(i)*vv5;
        p6 = p6+c(i)*vv6;
    end
    %���²�����
    v1 = p1;
    v2 = p2;
    v3 = p3;
    v4 = p4;
    v5 = p5;
    v6 = p6;
end
