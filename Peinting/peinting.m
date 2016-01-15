%mediamill
x = [5000	10000	15000	20000	25000	30000	35000	40000	43000];
% 1:PA 2:BPAs 3:Confidit
precision1 = [0.65686	0.66053	0.63964	0.62512	0.64097	0.59114	0.63921	0.62629	0.64722];
precision2 = [0.47742   0.43367 0.43521 0.43703 0.41554 0.44204 0.44996 0.45085 0.46806];
precision3 = [0.51377   0.48521 0.47322 0.44918 0.46834 0.43344 0.44958 0.45370 0.46705];

recall1 = [0.51570	0.53824	0.52752	0.51820	0.52484	0.52760	0.53124	0.52788	0.52253];
recall2 = [0.70322	0.71410	0.67495	0.63303	0.66772	0.65264	0.66833	0.66355	0.64878];
recall3 = [0.68144	0.70896	0.71299	0.71249	0.72155	0.72622	0.73734	0.72107	0.73392];

OneError1 = [0.20520	0.20260	0.23280	0.22340	0.21880	0.23720	0.20780	0.21880	0.21300];
OneError2 = [0.20220	0.19020	0.23260	0.21240	0.23280	0.22440	0.19500	0.19580	0.20233];
OneError3 = [0.18740	0.16740	0.19220	0.16720	0.18920	0.17920	0.16760	0.17420	0.17200];

a = plot(x,precision1,'-+',x,precision2,'-o',x,precision3,'-X');
a.set('Markersize',16);
axis([1000 43000 0 1])
xlabel('Number of examples');
ylabel('Recall of multilabels');
title('Mediamill');
b = legend(['PA'],['BPAs'],['2OD-UCB']);
b.set('FontSize',18);
%grid on

%a = plot(x,recall1,'-+',x,recall2,'-o',x,recall3,'-X');
%a.set('Markersize',16);
%axis([1000 43000 0 1])
%xlabel('Number of examples');
%ylabel('Precision of multilabels');
%title('Mediamill');
%b = legend(['PA'],['BPAs'],['2OD-UCB']);
%b.set('FontSize',18);
%grid on

%a = plot(x,OneError1,'-+',x,OneError2,'-o',x,OneError3,'-X');
%a.set('Markersize',16);
%axis([1000 43000 0 0.5])
%xlabel('Number of examples');
%ylabel('OneError rate of multilabels');
%title('Mediamill');
%b = legend(['PA'],['BPAs'],['2OD-UCB']);
%b.set('FontSize',18);
%grid on
