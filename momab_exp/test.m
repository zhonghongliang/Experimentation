clear;clc;    
    K = 15;%the number of points
    d = 2;%the dimension of each point
    model = 'linear';%linear convex concave
    Points = points_maker(K,d,model);
    [pareto1,index1] = pareto(Points);
    [K,d] = size(Points);
    N=2000;
    S = 20;
    eps=0.3;
    T = 100;
    times = zeros(K,d);
    reward = zeros(K,d);
    A_opt = [];
    AS=[1:1:K]';

    for i = 1:K
        for j = 1:N
            reward(i,:) = reward(i,:)+sampling(Points(i,:));
            times(i,:) = times(i,:)+ones(1,d);
        end
    end

    for s = 1:S
        diff = [];
        fs = rand(1,d);
        temp_P = [1:1:K]';
        for t=1:T
            Points_em = reward./times;
            temp = Points_em*fs';
            [dummy,opt_s] = max(temp);
            for k=1:size(temp_P,1)
                if temp(temp_P(k),1)< dummy- (eps)^t/(K*d)
                    diff = [diff; temp_P(k)];
                    temp_P(k) = 0;
                end
            end
            if isempty(diff) == 0
                for delete = 1:size(diff,1)
                    indicator =0;
                    for compare=1:K
                        if sum(double(Points_em(compare,:)-Points_em(diff(delete),1)>=0))==d
                            indicator = 1;
                        end
                    end
                    if indicator ~= 1
                        temp_P = [temp_P;diff(delete)];
                    end
                end
            end
            temp_P = setdiff(temp_P,[0]);
            reward(opt_s,:) = reward(opt_s,:)+sampling(Points(opt_s,:));
            times(opt_s,:)=times(opt_s,:)+ones(1,d);
        end
        A_opt = union(A_opt,temp_P);
    end
    index = A_opt;
 
for i = 1:3
    subplot(2,2,i), scatter(Points(:,1),Points(:,2),'k')
    title(i)
    hold on
end
subplot(2,2,1), scatter(Points(index1,1),Points(index1,2),'r')
subplot(2,2,2), scatter(Points(index,1),Points(index,2),'b')
%subplot(2,2,3), scatter(Points(ind1(ind2),1),Points(ind1(ind2),2),'b')
