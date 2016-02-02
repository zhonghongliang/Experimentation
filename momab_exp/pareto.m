%it takes the finding maxima way to get the true pareto dataset
function [sets,index] = pareto(Points)
[n,d] = size(Points);
sets = [];
index = [];
    if d == 2
        [temp,index_t] = sortrows(Points,-1);
        max = temp(1,2);
        sets = [sets; temp(1,:)];
        index = [index; index_t(1)];
        for i = 2:n
            if temp(i,2)>max
                sets = [sets;temp(i,:)];
                max = temp(i,2);
                index = [ index; index_t(i)];
            end
        end
    elseif d==3
        [temp,index_t] = sortrows(Points,-1);
        max = temp(1,2);
        sets = [sets; temp(1,:)];
        index = [index; index_t(1)];
        for i = 2:n
            if temp(i,2)>max
                sets = [sets;temp(i,:)];
                max = temp(i,2);
                index = [ index; index_t(i)];
            end
        end
    else
        [temp,index_t] = sortrows(Points,-1);
        max = temp(1,2);
        sets = [sets; temp(1,:)];
        index = [index; index_t(1)];
        for i = 2:n
            if temp(i,2)>max
                sets = [sets;temp(i,:)];
                max = temp(i,2);
                index = [ index; index_t(i)];
            end
        end
    end
end