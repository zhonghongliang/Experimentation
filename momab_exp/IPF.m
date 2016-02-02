function [index] = IPF(Points)
    epsilon = 0.1;%1;
    delta = 0.1;
    %pareto2 = [];
    [K,d] = size(Points);
    reward = zeros(K,d);
    times = zeros(K,1);
    % to to sample a point according to its probability: sampling(points(i,:) )
    n_lower = floor(2*K/(epsilon^2)*(log(2)+1/d*log(K/delta)));
    n_upper = floor(2*K/(epsilon^2)*log(2*d*K/delta));
    %\lower times
    for i = 1:K
        %i
        for j = 1:n_lower
            j
            i
            x=sampling(Points(i,:));
            reward(i,:) = reward(i,:)+ x ;
            times(i,1) = times(i,1)+1;
        end
    end
    ind1 = ep_pareto(reward./(times*ones(1,2)),epsilon);
    for i = 1:size(ind1,1)
        i
        for j = 1:n_upper-n_lower
            j
            i
            reward(ind1(i,1),:) = reward(ind1(i,1),:)+sampling(Points(ind1(i,1),:));
            times(ind1(i),1) = times(ind1(i),1) + 1;
        end
    end
    ind2 = ep_pareto(reward(ind1,:)./(n_upper*ones(size(ind1,1),2)),epsilon*0.1);
    index = ind1(ind2);
end