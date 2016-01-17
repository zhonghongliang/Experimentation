clear;clc;
%load('exp/final/mediamill.mat');
%load('exp/final/rcv1.mat');
%load('exp/final/yeast.mat');
%load('DATA_thesis/multilabel/yeast/yeast.mat');
load('DATA_thesis/multilabel/Image/Image.mat');
[n,d] = size(X);
%y=full(y);
K = size(Y,2);
W = zeros(K,d);
% parameter
epsilon = 0.5;
C = 0.001;
ml_criteria = zeros(n,10);%this is a standard criteria parameters. 
%1:OneError; 2:Precision; 3:Recall; 4:Accuracy; 5:hammingloss; 6:F1-M;
%7:loss; 8:Regret
%start to learn
for i = 1:n
    i
%    if epsilon>0.5
%        epsilon = 0.5;
%    else
%        epsilon = 1/log(i);
%    end
    t0 = clock;
    xt = X(i,:)/sqrt(X(i,:)*X(i,:)');
    [HY,TY,loss,W,ymax] = Update(W,xt,Y(i,:),epsilon,C);
    ml_criteria(i,9) = etime(clock,t0);%time for each instance
    ml_criteria(i,10) = sum(HY);%card
    ml_criteria(i,1) = 1-Y(i,ymax);%1:OneError;
    ml_criteria(i,2) = sum(Y(i,:).* HY')/sum(Y(i,:)); %2:Precision; 
    ml_criteria(i,3) = sum(Y(i,:).* HY')/sum(HY);%3:Recall; 
    ml_criteria(i,4) = sum(Y(i,:).* HY')/sum((Y(i,:)+HY')>0);%4:Accuracy; 
    ml_criteria(i,5) = (sum((Y(i,:)+HY')>0) - sum(Y(i,:).* HY'));%5:hammingloss; 
    ml_criteria(i,6) = 2*sum(Y(i,:).* HY')/(sum(Y(i,:))+sum(HY));%6:F1-M;
    ml_criteria(i,7) = loss/(norm(W)*K);%7:loss/W^2/K
    ml_criteria(i,8) = sum(ml_criteria(1:i,7));%Regret/normWt
    ml_criteria(i,11) = loss;%Regret/normWt
    ml_criteria(i,12) = sum(ml_criteria(1:i,11));%Regret/normWt
end
ml = ml_criteria;
n_ = floor(n/100);
Precision = sum(reshape(ml(1:n_*100,2),100,n_))/100;
Recall = sum(reshape(ml(1:n_*100,3),100,n_))/100;
OneError = sum(reshape(ml(1:n_*100,1),100,n_))/100;
Hammingloss = sum(reshape(ml(1:n_*100,5),100,n_))/100;
temp1 = reshape(ml(1:n_*100,8),100,n_);
Regret_Norm = temp1(100,:);
temp2 = reshape(ml(1:n_*100,12),100,n_);
Regret = temp2(100,:);
card = sum(ml(:,10))/n;
time = sum(ml(:,9))/n;