function getKey(src,event)
key=event.Key;
angle=evalin('base','angle');
if char(key)=='k'
    ok=false;
    assignin('base','ok',ok);
end
x0=25;y0=3;z0=5;
k=0;g=10;m=3;r=3;
v0x = evalin('base','v0x');
v0y = evalin('base','v0y');
v0z = evalin('base','v0z');
if char(key)=='m'
    angle=angle+1;
    assignin('base','angle',angle);
end
if char(key)=='n'
    angle=0;
    assignin('base','angle',angle);
end
if char(key)=='z'
    v0z=v0z+1;
end
if char(key)=='x'
    v0z=v0z-1;
end
if char(key)=='d'
    v0x=v0x+1;
end
if char(key)=='a'
    v0x=v0x-1;
end
if char(key)=='w'
    v0y=v0y+1;
end
if char(key)=='s'
    v0y=v0y-1;
end
if char(key)=='c'
    v0x=0;v0y=7;v0z=20;
end
assignin('base','v0x',v0x);assignin('base','v0y',v0y);
assignin('base','v0z',v0z);

h=0.1;
S=[x0;v0x;y0;v0y;z0;v0z];
t=0;
X=zeros(1,100);Y=zeros(1,100);Z=zeros(1,100);
for i=1:100
    k1i=F(t,S,k,m,g);
    k2i=F(t+(h/2),S+(h/2).*k1i,k,m,g);
    k3i=F(t+(h/2),S+(h/2).*k2i,k,m,g);
    k4i=F(t+h    ,S +   h.*k3i,k,m,g);
    S=S +(h/6).*(k1i + 2.*k2i + 2.*k3i  + k4i );
    t=t+h;
    X(i)=S(1);Y(i)=S(3);Z(i)=S(5);
end
X=[x0 X];Y=[y0 Y];Z=[z0 Z];

clf
set(gca,'xtick',[],'ytick',[],'ztick',[]);hold on;
plotcube([50 50 50],[0 0 0],.1,[0 0 0]);
hold on;
plot3(X,Y,Z,'+');
hold on;
axis([0  50    0  50    0  50])
view([-10-angle  20])


Sw = evalin('base','Sw');nw = evalin('base','nw');
S=Sw;
hold on;
[XS,YS,ZS] = sphere;
for j=1:nw
    if(S(8,j)~=0)
        hSurface=surf(XS*r+S(2,j), YS*r+S(4,j), ZS*r+S(6,j));
        hold on
        set(hSurface,'FaceColor',[0 0 1],'FaceAlpha',1,'FaceLighting','gouraud','EdgeColor','none');
        hold on;
    end
end
end

