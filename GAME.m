%  clear all
%  clc
x0=25;y0=3;z0=5;r=3;m=3;
v0x=0;v0y=7;v0z=20;
ok=true;
angle=0;
level=1;
nw=4;
Sw=zeros(8,nw);
for w=1:4
    Sw(1,w)=-1;Sw(2,w)=w*10;Sw(3,w)=0;Sw(4,w)=40;Sw(5,w)=0;Sw(6,w)=r;
    Sw(7,w)=0;Sw(8,w)=1;
end

fig=figure('units','normalized','outerposition',[0 0 1 1],'WindowButtonDownFcn',@(src,evnt)gameBuildFunc(),'KeyPressFcn',@getKey);
set(gca,'xtick',[],'ytick',[],'ztick',[]);hold on;
plotcube([50 50 50],[0 0 0],.1,[0 0 0]);
hold on;
axis([0  50    0  50    0  50])
view([-10  20])




