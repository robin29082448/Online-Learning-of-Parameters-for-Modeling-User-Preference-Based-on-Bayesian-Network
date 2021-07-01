%newdata = textread('dzdp_data_random.txt');

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
discrete_nodes = 1:N; %离散节点
node_sizes = [agenum,gendernum,locationnum,preferencenum,typenum,ratingnum];%节点状态数
bnet =mk_bnet(dag,node_sizes,'names',{'age','gender','location','preference','type','rating'},'discrete',discrete_nodes);

load EM_dzdp_out10.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{location} = tabular_CPD(bnet,location,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{type} = tabular_CPD(bnet,type,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:4
    for j=1:2
        for k=1:20
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{location} = k;
            % evidence{genres} = typein;
            % evidence{rating} = ratingin;
            [engine, loglike] = enter_evidence(engine, evidence);
            %计算单个节点后验概率，即进行推理
            marg1 = marginal_nodes(engine,preference);
            [like,index] = sort(marg1.T,'descend');
            u1(user,:)=index;
            ul1(user,:)=like;
        end
    end
end


load EM_dzdp_out30.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{location} = tabular_CPD(bnet,location,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{type} = tabular_CPD(bnet,type,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:4
    for j=1:2
        for k=1:20
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{location} = k;
            % evidence{genres} = typein;
            % evidence{rating} = ratingin;
            [engine, loglike] = enter_evidence(engine, evidence);
            %计算单个节点后验概率，即进行推理
            marg1 = marginal_nodes(engine,preference);
            [like,index] = sort(marg1.T,'descend');
            u3(user,:)=index;
            ul3(user,:)=like;
        end
    end
end

load EM_dzdp_out50.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{location} = tabular_CPD(bnet,location,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{type} = tabular_CPD(bnet,type,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:4
    for j=1:2
        for k=1:20
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{location} = k;
            % evidence{genres} = typein;
            % evidence{rating} = ratingin;
            [engine, loglike] = enter_evidence(engine, evidence);
            %计算单个节点后验概率，即进行推理
            marg1 = marginal_nodes(engine,preference);
            [like,index] = sort(marg1.T,'descend');
            u5(user,:)=index;
            ul5(user,:)=like;
        end
    end
end

load EM_dzdp_out70.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{location} = tabular_CPD(bnet,location,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{type} = tabular_CPD(bnet,type,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:4
    for j=1:2
        for k=1:20
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{location} = k;
            % evidence{genres} = typein;
            % evidence{rating} = ratingin;
            [engine, loglike] = enter_evidence(engine, evidence);
            %计算单个节点后验概率，即进行推理
            marg1 = marginal_nodes(engine,preference);
            [like,index] = sort(marg1.T,'descend');
            u7(user,:)=index;
            ul7(user,:)=like;
        end
    end
end

load EM_dzdp_out90.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{location} = tabular_CPD(bnet,location,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{type} = tabular_CPD(bnet,type,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:4
    for j=1:2
        for k=1:20
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{location} = k;
            % evidence{genres} = typein;
            % evidence{rating} = ratingin;
            [engine, loglike] = enter_evidence(engine, evidence);
            %计算单个节点后验概率，即进行推理
            marg1 = marginal_nodes(engine,preference);
            [like,index] = sort(marg1.T,'descend');
            u9(user,:)=index;
            ul9(user,:)=like;
        end
    end
end