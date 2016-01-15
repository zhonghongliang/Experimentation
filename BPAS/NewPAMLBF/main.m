clear;clc;
%load('exp/final/mediamill.mat');
%load('exp/final/rcv1.mat');
%load('exp/final/yeast.mat');
%load('yeast/yeast.mat');
load('Image.mat');
[n,d] = size(X);
%y=full(y);
K = size(Y,2);
W = zeros(K,d);
% parameter
epsilon = 0.5;
C = 0.001;
hammingloss = zeros(n,1);
Precision = zeros(n,1);
Recall = zeros(n,1);
OneError = zeros(n,1);
R = zeros(n,1);
r = zeros(n,1);
cardinality = zeros(n,1);
%start to learn
for i = 1:n
    i
%    if epsilon>0.5
%        epsilon = 0.5;
%    else
%        epsilon = 1/log(i);
%    end
    xt = X(i,:)/sqrt(X(i,:)*X(i,:)');
    [ HY,TY,loss,W,ymax] = Update(W,xt,Y(i,:),epsilon,C);
    HY = HY';
    TY = TY';
%[y_pre,y_trade,loss,Wt,ymax] = Update(Wt,xt,yt,epsilon,C)
    if i ==1
        R(i) = loss;
    else
        R(i) = R(i-1)+ loss;
    end
    r(i) = R(i)/(norm(W)*K);
    hammingloss(i) = sum(HY~=Y(i,:))/K;
    temp = sum(Y(i,:).*HY);
    if sum(Y(i,:))==0
        Precision(i)=1;
    else
        Precision(i) = temp/sum(Y(i,:));
    end
    if sum(HY)==0
        Recall(i) = 1;
    else
        Recall(i) = temp/sum(HY);
    end
    if Y(i,ymax) ==1
        OneError(i) = 0;
    else
        OneError(i) = 1;
    end
    cardinality(i) = sum(HY);
end
sum(hammingloss)/n
sum(OneError)/n
sum(Precision)/n
sum(Recall)/n
sum(cardinality)/n