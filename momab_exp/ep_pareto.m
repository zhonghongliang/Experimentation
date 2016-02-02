function [index] = ep_pareto(points,epsilon)
    ind1=[];
    ind2=[];
    %sets=[];
    [n,d] = size(points);
    [temp,index_t] = sortrows(points,-1);
    max1 = temp(1,2);
    %sets = [sets; temp(1,:)];
    ind1 = [ind1; index_t(1)];
    for i = 2:n
        if temp(i,2)+epsilon>max1
            %sets = [sets;temp(i,:)];
            max1 = max(max1,temp(i,2));
            ind1 = [ ind1; index_t(i)];
        end
    end
    [temp,index_t] = sortrows(points,-2);
    max2 = temp(1,1);
    %sets = [sets; temp(1,:)];
    ind2 = [ind2; index_t(1)];
    for i = 2:n
        if temp(i,1)+epsilon>max2
            %sets = [sets;temp(i,:)];
            max2 = max(max2,temp(i,1));
            ind2 = [ ind2; index_t(i)];
        end
    end
    index = union(ind1,ind2);
    %index = ind1;
end