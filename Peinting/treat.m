function [result] = treat(vector,model)
    [n1,n2] = size(vector);
    result = vector(1,1);
    switch model
        case 'de'%down
            for i = 2:n2
                if vector(1,i)>vector(1,i-1)*1.1
                    result = [result, vector(1,i-1)*1.1];
                else
                    result = [result, vector(1,i)];
                end
            end
        case 'cr'%up
            for i = 2:n2
                if vector(1,i)<vector(1,i-1)*0.9
                    result = [result, vector(1,i-1)*0.9];
                else
                    result = [result, vector(1,i)];
                end
            end
        case 'eq'%no change
            for i = 2:n2
                result = [result, vector(1,i)];
            end
    end
end