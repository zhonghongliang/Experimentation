%this script is used to creat some points
function [points] = points_maker(n, d, m) %n=number of points, d=dimension, m =model
    points = [];
    i = size(points,1);
    switch m
        case 'linear'
            while i<n
                generate = rand(1,d);
                if sum(generate) <= 1
                    points = [points; generate];
                else
                    points = points;
                end
                i = size(points,1);
            end
        case 'convex'
            while i<n
                generate = rand(1,d);
                if generate*generate' <= 1
                    points = [points; generate];
                else
                    points = points;
                end
                i = size(points,1);
            end
        case 'concave'
            while i<n
                generate = rand(1,d);
                if (ones(1,d)-generate)*(ones(1,d)-generate)' >= 1
                    points = [points; generate];
                else
                    points = points;
                end
                i = size(points,1);
            end
    end
  %  return points;
end 