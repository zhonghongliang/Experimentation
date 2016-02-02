clear;clc;
%here define the detail of this dataset
m = 30;%the number of points
d = 2;%the dimension of each point
model = 'concave';%linear convex concave
Points = points_maker(m,d,model);
%index1 is the set of all true optimal arms
%for each method should compare their solutions with this set
%to get the original pareto
[pareto1,index1] = pareto(Points);
%Identification epsilon Pareto
[index2] = IPF(Points);

%annealing
[index3] = annealing(Points);

%pareto_UCB
%[pareto4,index4] = pareto_UCB(Points);

%here draw a picture with four graphs, in order of these graphs are
%original; epsilon-pareto; annealing; UCB-pareto
%subplot(3,5,1), scatter(Points(:,1),Points(:,2))
for i = 1:4
    subplot(2,2,i), scatter(Points(:,1),Points(:,2),'k')
    axis([0 1 0 1]);
    title(i)
    hold on
end
subplot(2,2,2), scatter(Points(index1,1),Points(index1,2),'r')
subplot(2,2,3), scatter(Points(index2,1),Points(index2,2),'b')
subplot(2,2,4), scatter(Points(index3,1),Points(index3,2),'g')
%subplot(2,2,4), scatter(Points(index4,1),Points(index4,2),'m')
n1 = size(index1,1);%the number of pareto front
n2 = size(intersect(index1,index2),1);%of IPF
n22=size(index2,1)-n2;
n3 = size(intersect(index1,index3),1);%of annealing
n33=size(index3,1)-n3;
%n4 = size(index4,1);%of pareto UCB

