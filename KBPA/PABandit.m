clear;clc;
%load('Data_thesis/multiclass/segment.mat');
load('/Users/hongliang/Documents/MATLAB/DATA_thesis/multiclass/pendigits.mat')
%load('KernelDATA/pendigits.mat');%the datasets contains X,Y
%load('XY100000.mat');%the datasets contains X,Y
[n,d] = size(X);
%the labels number K
K = max(Y);
epsilon=0.3;
W=sparse(zeros(K,d));%0.1*rand(k,d);
mcc = zeros(n,2);%mc_criteria 1:loss;2:Regret;3:Error
%C = 1000;
for i=1:n
    i
    t0 = clock;
    %Xt=X_train(i,:);
    xt = X(i,:)/norm(X(i,:));
    score=W(:,:)*xt';
    [dummy,hy]=max(score);
    P = ones(K,1)* epsilon /K;
	P(hy) = P(hy) + 1- epsilon;
	dummy = mnrnd(1,P);
	[dummy2,ty] = max(dummy);
    BF = (ty == Y(i));  
    lt = max((1-BF)+(1-2*BF)*score(ty),0);
    W(ty,:) = W(ty,:)+ (2*BF-1)*lt*xt;
    mcc(i,4) = etime(clock,t0);
    mcc(i,1) = lt;
    mcc(i,2) = sum(mcc(1:i,1));
    mcc(i,3) = 1- (hy ==Y(i));
end
n_ = floor(n/100);
T = sum(reshape(mcc(1:n_*100,4),100,n_))/100;
M = sum(reshape(mcc(1:n_*100,3),100,n_))/100;
temp = reshape(mcc(1:n_*100,2),100,n_);
R = temp(100,:);
%xaxis = [];
%for i = 1:n_
%    xaxis = [xaxis, i];
%end
%yaxis = T;
%values = spcrv([[xaxis(1) xaxis xaxis(end)];[yaxis(1) yaxis yaxis(end)]],3);
%plot(values(1,:),values(2,:), 'g');