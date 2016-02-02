function [index] = annealing(Points)
    
    [K,d] = size(Points);
    S = 15;
    eps=0.3;
    T = K;
    times = zeros(K,d);
    N = 5000;
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
                if temp(temp_P(k),1)<dummy- (eps)^t/(K*d)
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
        end
        A_opt = union(A_opt,temp_P);
        reward(opt_s,:) = reward(opt_s,:)+sampling(Points(opt_s,:));
        times(opt_s,:)=times(opt_s,:)+ones(1,d);
    end
    index = A_opt;
end