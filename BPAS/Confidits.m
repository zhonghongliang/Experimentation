clear;clc;
load('exp/final/mediamill.mat');
%load('exp/final/rcv1.mat');
%load('exp/final/yeast.mat');
[n,d]=size(x);
K = size(y,2);
%parameter
a = 0.5;
alpha = 2^(-1); %alpha = 2^{-8,-7,...,6,7,8}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = cell(K,1);
%for i = 1:K
%    A{i} = eye(d,d);
%end
%to simplify
A = zeros(K,d);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W = zeros(K,d);
%evaluation
hammingloss = zeros(n,1);
Precision = zeros(n,1);
Recall = zeros(n,1);
OneError = zeros(n,1);
cardinality = zeros(n,1);
R = zeros(n,1);
%start to train
for t = 1:n
    t
    xt = x(t,:)/norm(x(t,:));
    HY = zeros(1,K);
    xAx= zeros(K,1);
    Ax = zeros(K,d);
    Bandit = zeros(K,1);
    W_ = W;
    WT = xt * W';
    [dummy,ymax] = max(WT);
    for k = 1:K
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        %to simplify
        %xAx(k) = xt/A{k}*xt';
        %Ax(k,:) = xt/A{k};
        xAx(k) = xt.*A(k,:)*xt';
        Ax(k,:) = xt./A(k,:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        if WT(k)>1
            W_(k,:) = W(k,:) - ((WT(k)-1)/xAx(k))*Ax(k,:);
        elseif WT(k)<-1
            W_(k,:) = W(k,:) - ((WT(k)+1)/xAx(k))*Ax(k,:);
        else
            W_(k,:) = W(k,:);
        end
    end
    delta = xt*W_';
    epsilon = alpha * log(t+1) * xAx';
    P = zeros(K,1);
    for k=1:K
        tempo = delta(k)+epsilon(k);
        if tempo>1
            P(k) = 1;
        elseif tempo<-1
            P(k) = 0;
        else
            P(k) = (1+tempo)/2;
        end
    end
    card = 1;
    [delta_,index] = sort(delta,'descend');
    Loss = 1-2*P(index(1));
    for k = 1 : K
        tempo = 1- 2*P(index(k));
        if Loss +tempo <= Loss
            card = k;
        end
        Loss = Loss + tempo;
    end
    cardinality(t) = card;
    HY(index(1:card)) = 1;
    HYy = HY + 2*y(t,:);
    for k = 1:K
        if HYy(k) == 3
            Bandit(k) = 1;
        elseif HYy(k) ==1;
            Bandit(k) = -1;
        else
            Bandit(k) = 0;
        end
        %update
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %to simplify
        %A{k} = A{k} + Bandit(k)^2* (xt'*xt);
        %W(k,:) = W_(k,:) - (Bandit(k)*delta(k)-1)*Bandit(k)*xt/A{k};
        A(k,:) = A(k,:) + Bandit(k)^2*(xt.*xt);
        W(k,:) = W_(k,:) - (Bandit(k)*delta(k)-1)*Bandit(k)*(xt./A(k,:));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    hammingloss(t) = sum(HY~=y(t,:))/K;
    temp = y(t,:)*HY';
    if sum(y(t,:))==0
        Precision(t)=0;
    else
        Precision(t) = temp/sum(y(t,:));
    end
    if sum(HY)==0
        Recall(t) = 1;
    else
        Recall(t) = temp/sum(HY);
    end
    if y(t,ymax) ==1
        OneError(t) = 0;
    else
        OneError(t) = 1;
    end
    for j=1:K
        if HY(j)==1
            if y(t,j)==1
                delta = 1;
            else
                delta = 0;
            end
        else
          delta = 0.5;  
        end
    end
    loss = sum(max(HY+(ones(1,K)-2*delta).*(W*x(t,:)')',zeros(1,K)));
    if t ==1
        R(t) = loss;
    else
        R(t) = R(t-1)+ loss;
    end
end
%to change the evaluation
s = floor(n/1000);
ratioP = sum(reshape(Precision(1:s*1000),1000,s))/1000;
ratioR = sum(reshape(Recall(1:s*1000),1000,s))/1000;
ratioO = sum(reshape(OneError(1:s*1000),1000,s))/1000;
ratioH = sum(reshape(hammingloss(1:s*1000),1000,s))/1000;
sum(cardinality)/n