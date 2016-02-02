function [pareto,index] = pareto_UCB(points_origin)
    pareto = [];    
    [n,d] = size(points_origin);
    reward = zeros(n,d);
    times = zeros(n,1);
    % to to sample a point according to its probability: sampling(points(i,:) )  
    %index = intersect(index0,index1);
end