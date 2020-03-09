function gameBuildFunc()
level = evalin('base','level');
v0x = evalin('base','v0x');
v0y = evalin('base','v0y');
v0z = evalin('base','v0z');

k=0;g=10;m=3;r=3;h=0.2;
x0=25;y0=3;z0=5;

Sw = evalin('base','Sw');
nw = evalin('base','nw');

S=[0;x0;v0x;y0;v0y;z0;v0z;1]; %chaque colonne est une point
S=[Sw S];
fig = evalin('base','fig');[XS,YS,ZS] = sphere;
%set(fig,'KeyPressFcn',@getKey);
i=0;np=1;
ok=true;
assignin('base','ok',ok);

while((sum(S(8,:))-sum(S(1,:)==-1))~=0 && ishghandle(fig)&& ok)%-some ll 3aychin
    ok=evalin('base','ok');
    %draw all point
    clf;set(gca,'xtick',[],'ytick',[],'ztick',[]);hold on;
    plotcube([50 50 50],[0 0 0],.1,[0 0 0]);hold on;
    axis([0  50    0  50    0  50])
    view([-10  20])
    for j=1:np+nw
        if(S(8,j)~=0)
        hSurface=surf(XS*r+S(2,j), YS*r+S(4,j), ZS*r+S(6,j));
        hold on
        if(S(1,j)==-1)
        set(hSurface,'FaceColor',[0 0 1],'FaceAlpha',1,'FaceLighting','gouraud','EdgeColor','none');
        else
        set(hSurface,'FaceColor',[1 1 1],'FaceAlpha',0.7,'FaceLighting','gouraud','EdgeColor','none');
        end
        hold on;
        end
    end
    drawnow
    
    %calculate the new points
    i=i+1;
    for j=nw+1:np+nw
    if S(8,j)~=0
    k1i=F(S(1,j),S(2:end-1,j),k,m,g);
    k2i=F(S(1,j)+(h/2),S(2:end-1,j)+(h/2).*k1i,k,m,g);
    k3i=F(S(1,j)+(h/2),S(2:end-1,j)+(h/2).*k2i,k,m,g);
    k4i=F(S(1,j)+h    ,S(2:end-1,j)+   h.*k3i,k,m,g);
    S(2:end-1,j)=S(2:end-1,j) +(h/6).*(k1i + 2.*k2i + 2.*k3i  + k4i );
    S(1,j)=S(1,j)+h;
    end
    end
    
    %change behavior if collision
    for j=nw+1:np+nw
    if S(8,j)~=0
        %collision with sides detect
        %X0
        if S(2,j) >= 50 - r
            S(2:3,j)=[50 - r;-S(3,j)];
            S(1,j)=0;
        end
        if S(2,j) <= r
            S(2:3,j)=[r;-S(3,j)];
            S(1,j)=0;
        end
        %Y0 
        if S(4,j) >= 50 - r
            S(4:5,j)=[50-r;-S(5,j)];
            S(1,j)=0;
        end
        if S(4,j) <= -r-1
            S(8,j) = 0;
        end
        %Z0
        if S(6,j) >= 50 -r
            S(6:7,j)=[50-r;-S(7,j)];
            S(1,j)=0;
        end
        if S(6,j) <= r
            S(6:7,j)=[r;-S(7,j)];
            S(1,j)=0;
        end
        %collision with other balls
        for k2 = 1:np+nw
            if j ~= k2 && S(8,k2)~=0
                P1=[S(2,j);S(4,j);S(6,j)];
                P2=[S(2,k2);S(4,k2);S(6,k2)];
                D=P1-P2;
                dist=norm(D);
                if dist <= 2*r
                    Vb1=[S(3,j);S(5,j);S(7,j)];Vb2=[S(3,k2);S(5,k2);S(7,k2)];
                    [Va1,Va2,N] = ElasticCollisionF(m,P1,Vb1,m,P2,Vb2);
                    S(3,j)=Va1(1);S(5,j)=Va1(2);S(7,j)=Va1(3);
                    S(3,k2)=Va2(1);S(5,k2)=Va2(2);S(7,k2)=Va2(3);
                    if S(1,k2)==-1
                        S(:,k2)=0;
                    end
                    deltaN=r+r-norm(P1-P2);
                    V=deltaN*N';
                    S(2,j)=S(2,j)+V(1);S(4,j)=S(4,j)+V(2);S(6,j)=S(6,j)+V(3); 
                end
            end
        end        

        
    end
    end
    %a new ball to be thrown
    if((mod(i,3)==0)&& np<level)
        np=np+1;
        S(:,np+nw)=[0;x0;v0x;y0;v0y;z0;v0z;1];
    end
end

So=S(:,1:nw);
if(sum(S(8,1:nw))==0)
    f = msgbox('you win');
    return
end

Sw=zeros(8,4);
for w=1:4
    Sw(1,w)=-1;Sw(2,w)=w*10;Sw(3,w)=0;Sw(4,w)=40;Sw(5,w)=0;Sw(6,w)=r+2*level*r;
    Sw(7,w)=0;Sw(8,w)=1;
end
Sw=[So Sw];
nw=nw+4;
assignin('base','nw',nw);
assignin('base','Sw',Sw);
increaseLevel();
return
end