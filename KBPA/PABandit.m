clear;clc;
load('poker.mat');
%load('KernelDATA/pendigits.mat');%the datasets contains X,Y
%load('XY100000.mat');%the datasets contains X,Y
[n,d] = size(X);
%the labels number K
K = max(Y);
epsilon=0.3;
W=sparse(zeros(K,d));%0.1*rand(k,d);
cumulativeR = 0;
%C = 1000;
for i=1:10000
    i
    %Xt=X_train(i,:);
    score=W(:,:)*X(i,:)';
    [dummy,hy]=max(score);
    P = ones(K,1)* epsilon /K;
	P(hy) = P(hy) + 1- epsilon;
	dummy = mnrnd(1,P);
	[dummy2,ty] = max(dummy);
    BF = (ty == Y(i));  
    lt = max((1-BF)+(1-2*BF)*score(ty),0);
    %if lt~=0
        %W(ty,:) = W(ty,:) + (2*BF-1)*(lt/(Xt(:)'*Xt(:)+0.5/C))*Xt(:)';
        W(ty,:) = W(ty,:)+ (2*BF-1)*(lt/(X(i,:)*X(i,:)'))*X(i,:);
    %end
    %error(i) = (Y(i) ~= y_C);
    cumulativeR = cumulativeR + (hy~=Y(i));
end