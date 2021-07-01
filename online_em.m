% dmu1=[0 0];
% dS1=[0.8 0.1];
% data1=mvnrnd(dmu1,dS1,1000);
% plot(data1(:,1),data1(:,2),'r.');
% hold on;
% 
% dmu2=[2 4];
% dS2=[0.4 1.3];
% data2=mvnrnd(dmu2,dS2,1000);
% plot(data2(:,1),data2(:,2),'g.');
% 
% dmu3=[-2 3];
% dS3=[2.4 1.3];
% data3=mvnrnd(dmu3,dS3,1000);
% plot(data3(:,1),data3(:,2),'b.');

dmu1=0;
dS1=0.8;
data1=mvnrnd(dmu1,dS1,1000);
plot(data1(:,1),'r.');
hold on;

dmu2=2;
dS2=0.4;
data2=mvnrnd(dmu2,dS2,1000);
plot(data2(:,1),'g.');

dmu3=-2;
dS3=2.4;
data3=mvnrnd(dmu3,dS3,1000);
plot(data3(:,1),'b.');

%利用EM算法对高斯混合模型聚类
data=[data1;data2;data3];

X = data;
k = 3;
%function [mu, Sigma, weight] = online_EM(X, k)
[n, d] = size(X); 

% initialization
mu = rand(k, d);
Sigma = zeros(d, d, k);
for j = 1:k
    Sigma(:,:,j) = eye(d,d);
end
weight = ones(1,k)/k;
w_bar = zeros(1,k);
w_bar_x = mu;
w_bar_x2 = Sigma;


for i = 1:n
    lr = 1/i;
    % E step
    for j = 1:k
        w_bar(j) = weight(j)*mvnpdf(X(i,:), mu(j, :), Sigma(:,:,j));
    end
    w_bar = w_bar/sum(w_bar);
    
    % M step
    weight = weight + lr*(w_bar-weight);
    w_bar_x = w_bar_x + lr*(w_bar'*X(i,:) - w_bar_x);
    for j = 1:k
        w_bar_x2(:,:,j) = w_bar_x2(:,:,j) + lr*(w_bar(j)*X(i,:)'*X(i,:)-w_bar_x2(:,:,j));
    end
    
    if i > 20
%         mu = w_bar_x./repmat(w_bar', [1,d]);
        for j = 1:k
            mu(j,:) = w_bar_x(j,:)/weight(j);
            Sigma(:,:,j) = (w_bar_x2(:,:,j) - w_bar_x(j,:)'*mu(j,:))/weight(j);
            Sigma(:,:,j) = (Sigma(:,:,j)+Sigma(:,:,j)')/2;
        end
    end
    
end


%end