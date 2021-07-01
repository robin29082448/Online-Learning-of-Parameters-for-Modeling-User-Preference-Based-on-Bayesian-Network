%newdata = textread('dzdp_data_random.txt');

%建立贝叶斯网络结构
N = 6; %六个节点，分别是age,gender,occupation,preference,genres,rating
%分别代表年龄，性别，职业，偏好(隐变量)，类型，评分；
dag = zeros(N,N);
age = 1; gender = 2; occupation = 3; preference = 4; genres = 5; rating = 6;
%节点的取值范围
agenum = 7; gendernum = 2; occupationnum = 21; preferencenum = 18; genresnum = preferencenum; ratingnum = 5;
%节点之间的连接关系
dag(age,occupation) = 1;
dag(gender,occupation) = 1;
dag(age,preference) = 1;
dag(gender,preference) = 1; 
dag(occupation,preference) = 1; 
dag(preference,genres) = 1;
dag(preference,rating) = 1;
dag(genres,rating) = 1;
discrete_nodes = 1:N; %离散节点
node_sizes = [agenum,gendernum,occupationnum,preferencenum,genresnum,ratingnum];%节点状态数
bnet =mk_bnet(dag,node_sizes,'names',{'age','gender','occupation','preference','genres','rating'},'discrete',discrete_nodes);

u1=zeros(294,18);
ul1=zeros(294,18);
load EM_Movielens_out10.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{occupation} = tabular_CPD(bnet,occupation,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{genres} = tabular_CPD(bnet,genres,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:7
    for j=1:2
        for k=1:21
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{occupation} = k;
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

u3=zeros(294,18);
ul3=zeros(294,18);
load EM_Movielens_out30.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{occupation} = tabular_CPD(bnet,occupation,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{genres} = tabular_CPD(bnet,genres,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:7
    for j=1:2
        for k=1:21
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{occupation} = k;
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

u5=zeros(294,18);
ul5=zeros(294,18);
load EM_Movielens_out50.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{occupation} = tabular_CPD(bnet,occupation,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{genres} = tabular_CPD(bnet,genres,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:7
    for j=1:2
        for k=1:21
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{occupation} = k;
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

u7=zeros(294,18);
ul7=zeros(294,18);
load EM_Movielens_out70.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{occupation} = tabular_CPD(bnet,occupation,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{genres} = tabular_CPD(bnet,genres,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:7
    for j=1:2
        for k=1:21
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{occupation} = k;
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

u9=zeros(294,18);
ul9=zeros(294,18);
load EM_Movielens_out90.mat v1 v2 v3 v4 v5 v6
bnet.CPD{age} = tabular_CPD(bnet,age,v1);
bnet.CPD{gender} = tabular_CPD(bnet,gender,v2);
bnet.CPD{occupation} = tabular_CPD(bnet,occupation,v3);
bnet.CPD{preference} = tabular_CPD(bnet,preference,v4);
bnet.CPD{genres} = tabular_CPD(bnet,genres,v5);
bnet.CPD{rating} = tabular_CPD(bnet,rating,v6);
user=0;
for i=1:7
    for j=1:2
        for k=1:21
            user = user + 1;
            %选择jtree_inf_engine推理引擎。
            engine = jtree_inf_engine(bnet);
            evidence = cell(1,N);
            evidence{age} = i;
            evidence{gender} = j;
            evidence{occupation} = k;
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