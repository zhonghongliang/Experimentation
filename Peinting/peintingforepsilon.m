%rcv1-v2
x = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9];
% 1:PA 2:BPAs 3:Confidit
precision = [0.280	0.330	0.387	0.411	0.440	0.455	0.466	0.471	0.483];

recall = [0.733	0.709	0.689	0.682	0.670	0.667	0.661	0.656	0.647];

OneError = [0.222	0.225	0.226	0.226	0.228	0.232	0.237	0.241	0.256];

Hammingloss = [0.038	0.037	0.036	0.036	0.036	0.035	0.035	0.036	0.036];

Cardinality = [1.396	1.723	2.081	2.260	2.481	2.584	2.672	2.730	2.834];

a = plot(x,precision,'-^',x,recall,'-o',x,OneError,'-X',x,Hammingloss, '-*');
a.set('Markersize',16);
axis([0 1 0 1])
xlabel('the values of epsilon');
ylabel('Rate of multilabels');
title('The performance of BPAs by different epsilon value in MediaMill ');
b = legend(['Recall'],['Precision'],['OneError'],['Hamming loss']);
b.set('FontSize',18);

%a = plot(x,Cardinality,'-+');
%a.set('Markersize',16);
%axis([0 1 1 3])
%xlabel('the values of epsilon');
%ylabel('Cardinality');
%title('The performance of BPAs by different epsilon in MediaMill ');
%b = legend(['Cardinality']);
%b.set('FontSize',18);
%grid on