function [value] = Kernel(A,alpha,B,model,parameter)
    [na,da] = size(A);
    [nb,db] = size(B);
    switch model
        case 'linear'
            value = sum(alpha.*(A*B'));
        case 'laplace'
            temp = zeros(na,1);
            for i =1:na
                temp(i) = exp(-norm(A(i,:)-B)/parameter);
            end
            value = sum (alpha.*temp);
        case 'rational'
            temp = zeros(na,1);
            for i = 1:na
                xy = norm(A(i,:)-B);
                temp(i) = 1 - xy/(xy^2+parameter);
            end
            value = sum(alpha.*temp);
        case 'multiquadratic'
            temp = zeros(na,1);
            for i = 1:na
                temp(i) = sqrt((A(i,:)-B)*(A(i,:)-B)'+parameter);
            end
            value = sum(alpha.*temp);
        case 'power'
            temp = zeros(na,1);
            for i = 1:na
                temp(i) = -(norm(A(i,:)-B))^parameter;
            end
            value = sum(alpha.*temp);
        case 'log'
            temp = zeros(na,1);
            for i = 1:na
                temp(i) = -log(norm(A(i,:)-B)^parameter+1);
            end
            value = sum(alpha.*temp);
        case 'polynomial'
            temp = zeros(na,1);
            for i = 1:na
                temp(i) = (1+A(i,:)*B')^parameter;
            end
            value = sum(alpha.*temp);
    end
end