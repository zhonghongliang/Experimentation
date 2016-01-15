%rcv1-v2
x = [3000	6000	9000	12000	15000	18000	21000	23000];
% 1:PA 2:BPAs 3:Confidit
precision1 = [0.756	0.842	0.861	0.873	0.868	0.858	0.868	0.882];
precision2 = [0.157	0.170	0.131	0.141	0.150	0.150	0.161	0.211];
precision3 = [0.150	0.177	0.168	0.174	0.177	0.171	0.168	0.191];

recall1 = [0.564	0.625	0.632	0.625	0.654	0.634	0.649	0.651];
recall2 = [0.976	0.989	0.989	0.995	0.996	0.992	0.990	0.995];
recall3 = [0.985	0.989	0.983	0.979	0.979	0.984	0.987	0.981];

OneError1 = [0.141	0.078	0.069	0.051	0.055	0.063	0.053	0.047];
OneError2 = [0.235	0.190	0.159	0.144	0.142	0.129	0.104	0.089];
OneError3 = [0.356	0.285	0.235	0.183	0.166	0.134	0.134	0.126];

%a = plot(x,precision1,'-+',x,precision2,'-o',x,precision3,'-X');
%a.set('Markersize',18);
%axis([1000 23000 0 1])
%c = xlabel('Number of examples');
%d = ylabel('Recall of multilabels');
%e = title('RCV1-v2');
%b = legend(['PA'],['BPAs'],['2OD-UCB']);
%b.set('FontSize',18);
%c.set('FontSize',18);
%d.set('FontSize',18);
%e.set('FontSize',18);


%grid on

%a = plot(x,recall1,'-+',x,recall2,'-o',x,recall3,'-X');
%a.set('Markersize',18);
%axis([1000 23000 0.5 1.2])
%c=xlabel('Number of examples');
%d=ylabel('Precision of multilabels');
%e=title('RCV1-v2');
%b = legend(['PA'],['BPAs'],['2OD-UCB']);
%b.set('FontSize',18);
%c.set('FontSize',18);
%d.set('FontSize',18);
%e.set('FontSize',18);
%grid on

a = plot(x,OneError1,'-+',x,OneError2,'-o',x,OneError3,'-X');
a.set('Markersize',18);
axis([1000 23000 0 0.5])
c=xlabel('Number of examples');
d=ylabel('OneError rate of multilabels');
e=title('RCV1-v2');
b = legend(['PA'],['BPAs'],['2OD-UCB']);
b.set('FontSize',18);
c.set('FontSize',18);
d.set('FontSize',18);
e.set('FontSize',18);
%grid on