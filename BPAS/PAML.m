clear;clc;
load('exp/final/mediamill.mat');
%load('exp/final/rcv1.mat');
%load('exp/final/yeast.mat');
%details of data
[n,d] = size(x);
% the number of classes
K = size(y,2);
%construit the classifier W
W =zeros(K,d);
hammingloss = zeros(n,1);
Precision = zeros(n,1);
Recall = zeros(n,1);
OneError = zeros(n,1);
R = zeros(n,1);
cardinality = zeros(n,1);
%start to train
for i = 1:n
    i
    cardi = ceil(sum(sum(y(1:i,:)))/i);
    if cardi == 0
        cardi =1;
    end
    cardinality(i) = cardi;
    [value, ordre]= sort(W * x(i,:)','descend');
    % to find the st and rt, which does not belong to Yt
    [dummy,ymax] = max(W*x(i,:)');
    HY = zeros(1,K);
    HY(ordre(1:cardi))=1;
    argmin = value(1);
    argmax = value(K);
    s=K;
    r=1;
    for j = 1:K
        if value(j)>= argmax
            if y(i,ordre(j)) == 0
                r=ordre(j);
                argmax = value(j);
            end
        end
        if value(j)<= argmin
            if y(i,ordre(j)) == 1
                s=ordre(j);
                argmin = value(j);
            end
        end
    end
    l = max(1-argmin+argmax,0);
    tau = l/(2*x(i,:)*x(i,:)');
    W(r,:) = W(r,:) - tau*x(i,:);
    W(s,:) = W(s,:) + tau*x(i,:);
    hammingloss(i) = sum(HY~=y(i,:))/K;
    temp = y(i,:)*HY';
    if sum(y(i,:))==0
        Precision(i)=0;
    else
        Precision(i) = temp/sum(y(i,:));
    end
    if sum(HY)==0
        Recall(i) = 1;
    else
        Recall(i) = temp/sum(HY);
    end
    if y(i,ymax) ==1
        OneError(i) = 0;
    else
        OneError(i) = 1;
    end
    for j=1:K
        if HY(j)==1
            if y(i,j)==1
                delta = 1;
            else
                delta = 0;
            end
        else
          delta = 0.5;  
        end
    end
    loss = sum(max(HY+(ones(1,K)-2*delta).*(W*x(i,:)')',zeros(1,K)));
    if i ==1
        R(i) = loss;
    else
        R(i) = R(i-1)+ loss;
    end
end
%to change the evaluation
s = floor(n/1000);
ratioP = sum(reshape(Precision(1:s*1000),1000,s))/1000;
ratioR = sum(reshape(Recall(1:s*1000),1000,s))/1000;
ratioO = sum(reshape(OneError(1:s*1000),1000,s))/1000;
ratioH = sum(reshape(hammingloss(1:s*1000),1000,s))/1000;
sum(cardinality)/n