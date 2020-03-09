% clear all
% clc
% v0x=6;v0y=3;v0z=30;%initial speed
% x0=1;y0=1;z0=1;%initial position
% tmin=0;tmax=6;%time
% m=1;%weight
% k=0.1;%friction consatnt
% g=10;%gravity
% R=2;

N=100;
h=(tmax-tmin)/N;
t=linspace(tmin,tmax,N);

X=zeros(1,N);Y=zeros(1,N);Z=zeros(1,N);
Vx=zeros(1,N);Vy=zeros(1,N);Vz=zeros(1,N);

Si=[x0;v0x;y0;v0y;z0;v0z];

for i=1:N
    
    k1i=F(t(i),Si,k,m,g);
    k2i=F(t(i)+(h/2),Si+(h/2).*k1i,k,m,g);
    k3i=F(t(i)+(h/2),Si+(h/2).*k2i,k,m,g);
    k4i=F(t(i)+h    ,Si +   h.*k3i,k,m,g);
    
    Si=Si +(h/6).*(k1i + 2.*k2i + 2.*k3i  + k4i );
    X(i)=Si(1);Y(i)=Si(3);Z(i)=Si(5);
    Vx(i)=Si(2);Vy(i)=Si(4);Vz(i)=Si(6);
    
    
end

t=[t tmax+h];
X=[x0 X];Y=[y0 Y];Z=[z0 Z];
maxX=max(X);maxY=max(Y);maxZ=max(Z);maxAxe=max([maxX maxY maxZ]);
Vx=[v0x Vx];Vy=[v0y Vy];Vz=[v0z Vz];

%cas ideal
Xi=zeros(1,N);Yi=zeros(1,N);Zi=zeros(1,N);
Vxi=zeros(1,N);Vyi=zeros(1,N);Vzi=zeros(1,N);

Sii=[x0;v0x;y0;v0y;z0;v0z];
for i=1:N
    
    k1i=F(t(i),Sii,0,m,10);
    k2i=F(t(i)+(h/2),Sii+(h/2).*k1i,0,m,10);
    k3i=F(t(i)+(h/2),Sii+(h/2).*k2i,0,m,10);
    k4i=F(t(i)+h    ,Sii +   h.*k3i,0,m,10);
    
    Sii=Sii +(h/6).*(k1i + 2.*k2i + 2.*k3i  + k4i );
    Xi(i)=Sii(1);Yi(i)=Sii(3);Zi(i)=Sii(5);
    Vxi(i)=Sii(2);Vyi(i)=Sii(4);Vzi(i)=Sii(6);
    
    
end

Xi=[x0 Xi];Yi=[y0 Yi];Zi=[z0 Zi];
maxX=max(Xi);maxY=max(Yi);maxZ=max(Zi);maxAxe=max([maxX maxY maxZ maxAxe]);
Vxi=[v0x Vxi];Vyi=[v0y Vyi];Vzi=[v0z Vzi];


[XS,YS,ZS] = sphere;

figure('units','normalized','outerposition',[0 0 1 1])
for i = 1:length(t)
    clf
    plotcube([maxAxe+R maxAxe+R maxAxe+R],[0 0 0],.1,[0 0 0]);
    hold on
    Xz = X(i)*ones(1,10);
    Yz = linspace(0,maxAxe,10);
    Zz = Z(i)*ones(1,10);
    plot3(Xz,Yz,Zz,'-');
    hold on
    Xz = linspace(0,maxAxe,10);
    Yz = Y(i)*ones(1,10);
    Zz = Z(i)*ones(1,10);
    plot3(Xz,Yz,Zz,'-');
    hold on
    Xz = X(i)*ones(1,10);
    Yz = Y(i)*ones(1,10);
    Zz = linspace(0,maxAxe,10);
    plot3(Xz,Yz,Zz,'-');
    hold on
    plot3(X,Y,Z,'.');
    hold on
    plot3(Xi,Yi,Zi,'-');
    hold on
    hSurface=surf(XS*R+X(i), YS*R+Y(i), ZS*R+Z(i));
    hold on
    set(hSurface,'FaceColor',[1 0 0], ...
      'FaceAlpha',0.7,'FaceLighting','gouraud','EdgeColor','none')
    axis([0 maxAxe+R 0 maxAxe+R 0 maxAxe+R])
    axis square
    view([-20  20])
    drawnow
end
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1);
plot(t,Vx)
title('Vx(t)')
hold on;
subplot(2,3,2);
plot(t,Vy)
title('Vy(t)')
hold on;
subplot(2,3,3);
plot(t,Vz)
title('Vz(t)')
hold on;
subplot(2,3,4);
plot(t,X)
title('x(t)')
hold on;
subplot(2,3,5);
plot(t,Y)
title('y(t)')
hold on;
subplot(2,3,6);
plot(t,Z)
title('z(t)')
