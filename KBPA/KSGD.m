clear;clc;
load('KernelDATA/pendigits.mat');%the datasets contains X,Y
[n,d] = size(X);
%the labels number K
K = max(Y);
Container = cell(K,1);
Container(:) = {zeros(1,d)};
epsilon = 0.3;
lambda = 0.02;
eta = 0.2;
tau = 200;
cumulativeR = 0;
model = 'linear';
parameter = 0.1;
for i=1:n
    i
	xt = X(i,:)/sqrt(Kernel(X(i,:),X(i,:),model,parameter));
	score = zeros(K,1);
    for j = 1:K
		score(j) = Kernel(Container{j,1},xt,model,parameter);
    end				
	[dummy,hy] = max(score);
	P = ones(K,1)* epsilon /K;
	P(hy) = P(hy) + 1- epsilon;
	dummy = mnrnd(1,P);
	[dummy2,ty] = max(dummy);
	BF = (ty == Y(i));
	lt = max(1-BF+(1-2*BF)*score(ty),0);
    if lt~= 0
        if size(Container{ty,1},2)>=tau
            %Container{ty,1} = [(1-lambda*eta)*Container{ty,1}(2:tau,:);eta*(2*BF-1)*xt];
            Container{ty,1} = [(1-lambda*eta)*Container{ty,1}(2:tau,:);eta*(2*BF-1)*xt];
        else
            %Container{ty,1} = [(1-lambda*eta)*Container{ty,1};eta*(2*BF-1)*xt];
            Container{ty,1} = [(1-lambda*eta)*Container{ty,1};eta*(2*BF-1)*xt];
        end
    end
    cumulativeR = cumulativeR + (hy~=Y(i));
end