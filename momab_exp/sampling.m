    % how to generate a point according to a fixed probability
    % for example p1 = [0.3,0.5]
    % P = [p1;1-p1]'
    function [s_p] = sampling(proba)
        d = size(proba,2);
        P =[proba;1-proba]';
        temp = mnrnd(1,P);
        s_p = temp(:,1)';
    end