%load data
clear;clc;
%load('KernelDATA/pendigits.mat');%the datasets contains X,Y
load('poker.mat');
[n,d] = size(X);
%the labels number K
K = max(Y);
Container = cell(K,1);
Container(:) = {zeros(1,d)};
epsilon = 0.1;
cumulativeR = 0;
model = 'laplace';
%model = 'linear';
parameter = 10;
for i=1:10000
    i
	xt = X(i,:);
	score = zeros(K,1);
    for j = 1:K
		score(j) = Kernel(Container{j,1},xt,model,parameter);
        %-norm(A(i,:)-B)/parameter
    end
    [dummy,hy] = max(score);
	P = ones(K,1) * epsilon / K;
	P(hy) = P(hy) + 1-epsilon ;
	dummy = mnrnd(1,P);
	[dummy2,ty] = max(dummy);
	BF = (ty == Y(i));
	lt = max( (1-BF) + (1-2*BF)*score(ty),0);
    if lt~=0
    	Container{ty,1} = [Container{ty,1};(2*BF-1)*(lt/Kernel(xt,xt,model,parameter))*xt];
    end
    cumulativeR = cumulativeR + (hy~=Y(i));
end