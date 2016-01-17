function [y_pre,y_trade,l,Wt,ymax] = Update(Wt,xt,yt,epsilon,C)
%UPDATE Summary of this function goes here
[K,d] = size(Wt);
%normalization for xt
score = Wt*xt';
[dummy,ymax]=max(score);
y_pre = (score>0);
if sum(y_pre) == 0
    y_pre(ymax) = 1;
end
P = (1-epsilon)*y_pre + ones(K,1)*epsilon * sum(y_pre)/K;
prob = zeros(K,2);
prob(:,1) = P;
prob(:,2) = ones(K,1) - P;
dummy = mnrnd(1,prob,K);
y_trade = dummy(:,1);
if (y_trade == zeros(K,1))
    y_trade = y_pre;
end
BF = zeros(K,1);
for j = 1:K
    if y_trade(j)==1 && yt(j) == 1
        BF(j) = 1;
    elseif y_trade(j)==1 && yt(j) == 0
        BF(j) = 0;
    else
        BF(j) = 0.5;
    end
end
loss = max( y_trade + (ones(K,1)-2*BF).*score, zeros(K,1));
if (2*BF-1)'*(2*BF-1)==0
    tau = 0;
else
    tau = sum(loss)/((2*BF-1)'*(2*BF-1));
end
l =sum(loss);
Wt = Wt + tau * (2*BF-ones(K,1)) * xt;
end