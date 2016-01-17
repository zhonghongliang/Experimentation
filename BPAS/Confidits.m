clear;clc;
%load('exp/final/mediamill.mat');
%load('exp/final/rcv1.mat');
%load('DATA_thesis/multilabel/yeast/yeast.mat');
load('DATA_thesis/multilabel/Image/Image.mat');
[n,d]=size(X);
K = size(Y,2);
%parameter
a = 0.5;
alpha = 2^(-1); %alpha = 2^{-8,-7,...,6,7,8}
R = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = cell(K,1);
A(:) = {eye(d,d)};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W = zeros(K,d);
%evaluation
ml_criteria = zeros(n,10);%this is a standard criteria parameters. 
%1:OneError; 2:Precision; 3:Recall; 4:Accuracy; 5:hammingloss; 6:F1-M;
%7:hammingloss;8:Regret
%start to train
for t = 1:n
    t
    t0 = clock;
    xt = X(t,:)/norm(X(t,:));
    xAx= zeros(K,1);
    Ax = zeros(K,d);
    BF = zeros(K,1);%Bandit Feedback
    W_ = W;
    wx = W * xt';
    for k = 1:K
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        %to simplify
        %xAx(k) = xt/A{k}*xt';
        %Ax(k,:) = xt/A{k};
        xAx(k) = xt/A{k}*xt';
        Ax(k,:) = (A{k}\xt')';
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        if wx(k)>R
            W_(k,:) = W(k,:) - ((wx(k)-R)/xAx(k))*Ax(k,:);
        elseif wx(k)<-R
            W_(k,:) = W(k,:) - ((wx(k)+R)/xAx(k))*Ax(k,:);
        else
            W_(k,:) = W(k,:);
        end
    end
    score = xt*W_';
    [dummy,ymax] = max(score);
    epsilon = alpha * log(t+1) * xAx';
    P = zeros(K,1);
    for k=1:K
        tempo = score(k)+epsilon(k);
        if tempo>1
            P(k) = 1;
        elseif tempo<-1
            P(k) = 0;
        else
            P(k) = (1+tempo)/2;
        end
    end
    HY = (P > 0.5);
    if sum(HY) == 0
        HY(ymax)=1;
    end
    for k = 1:K
        if HY(k) ==1 && Y(t,k)==1
            BF(k) = 1;
        elseif HY(k) == 1 && Y(t,k) == 0
            BF(k) = -1;
        else
            BF(k) = 0;
        end
        A{k} = A{k} + BF(k)^2*(xt'*xt);
        W(k,:) = W_(k,:) - (BF(k)*score(k)-1)*BF(k)*(A{k}\xt')';
    end
    i=t;
    ml_criteria(i,9) = etime(clock,t0);%time for each instance
    ml_criteria(i,10) = sum(HY);%card
    ml_criteria(i,1) = 1-Y(i,ymax);%1:OneError;
    ml_criteria(i,2) = sum(Y(i,:).* HY')/sum(Y(i,:)); %2:Precision; 
    ml_criteria(i,3) = sum(Y(i,:).* HY')/sum(HY);%3:Recall; 
    ml_criteria(i,4) = sum(Y(i,:).* HY')/sum((Y(i,:)+HY')>0);%4:Accuracy; 
    ml_criteria(i,5) = (sum((Y(i,:)+HY')>0) - sum(Y(i,:).* HY'));%5:hammingloss; 
    ml_criteria(i,6) = 2*sum(Y(i,:).* HY')/(sum(Y(i,:))+sum(HY));%6:F1-M;
    %ml_criteria(i,7) = loss/(norm(W)*K);%7:loss/W^2/K
    ml_criteria(i,8) = sum(ml_criteria(1:i,7));%Regret/normWt
    %ml_criteria(i,11) = loss;%Regret/normWt
    %ml_criteria(i,12) = sum(ml_criteria(1:i,11));%Regret/normWt
end
ml = ml_criteria;
n_ = floor(n/100);
Precision = sum(reshape(ml(1:n_*100,2),100,n_))/100;
Recall = sum(reshape(ml(1:n_*100,3),100,n_))/100;
OneError = sum(reshape(ml(1:n_*100,1),100,n_))/100;
Hammingloss = sum(reshape(ml(1:n_*100,5),100,n_))/100;
temp1 = reshape(ml(1:n_*100,8),100,n_);
Regret_Norm = temp1(100,:);
%temp2 = reshape(ml(1:n_*100,12),100,n_);
%Regret = temp2(100,:);
card = sum(ml_criteria(i,10))/n;
time = sum(ml_criteria(i,9))/n;