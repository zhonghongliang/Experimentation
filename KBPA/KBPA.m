%load data
clear;clc;
%load('KernelDATA/pendigits.mat');%the datasets contains X,Y
%load('Data_thesis/multiclass/segment.mat');
load('/Users/hongliang/Documents/MATLAB/DATA_thesis/multiclass/pendigits.mat')
[n,d] = size(X);
%the labels number K
K = max(Y);
Container = cell(K,1);
for k = 1:K
    Container{k,1}.x = zeros(1,d);
    Container{k,1}.alpha = 0;
end
epsilon = 0.3;
mcc = zeros(n,4);%mc_criteria 1:loss;2:Regret;3:Error; 4:time
model = 'laplace';
%model = 'linear';
parameter = 1;
for i=1:n
    i
    t0 = clock;
	xt = X(i,:);
	score = zeros(K,1);
    for j = 1:K
		score(j) = Kernel(Container{j,1}.x,Container{j,1}.alpha,xt,model,parameter);
    end
    [dummy,hy] = max(score);
	P = ones(K,1) * epsilon / K;
	P(hy) = P(hy) + 1-epsilon ;
	dummy = mnrnd(1,P);
	[dummy2,ty] = max(dummy);
	BF = (ty == Y(i));
	lt = max( (1-BF) + (1-2*BF)*score(ty),0);
    if lt~=0
    	Container{ty,1}.x = [Container{ty,1}.x; xt];
        Container{ty,1}.alpha = [Container{ty,1}.alpha;(2*BF-1)*lt/Kernel(xt,1,xt,model,parameter)];
    end
    mcc(i,4) = etime(clock,t0);
    mcc(i,1) = lt;
    mcc(i,2) = sum(mcc(1:i,1))/norm(W);
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