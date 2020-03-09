% clear all
% n=2;
% R=[10;100];
% S=[0 1000 500;1000 1000 500];
% V0=[20 0 0;0 0 0];
% M=[1 ;1000];
% xR=20;
% v=50;
% xm=1000;

n=2;
R=[10;10*xR];
S=[0 1000 500;1000 1000 500];
V0=[v 0 0;0 0 0];
M=[1 ;xm];

deltat=1;

X0=1.2*max(max(S))+max(R);
Y0=1.2*max(max(S))+max(R);
Z0=1.2*max(max(S))+max(R);





bounceFunc3(S,R,M,V0,deltat, X0, Y0, Z0);

[Va1,Va2,N] = ElasticCollisionF(1,S(1,:)',V0(1,:)',xm,S(2,:)',V0(2,:)')

t=linspace(0,50,50);
v1=[v*ones(1,25) Va1(1)*ones(1,25)];
v2=[0*ones(1,25) Va2(1)*ones(1,25)];
figure('units','normalized','outerposition',[0 0 1 1])
plot(t,v1,t,v2,'r');
title('speed after collision');
set(gca,'xtick',[]);
