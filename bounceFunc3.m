function bounceFunc3(S,R,M,V0,deltat, X0, Y0, Z0)
n = length(R);
%Colors:
C= rand(n,3);

[XS,YS,ZS] = sphere;

fig=figure('units','normalized','outerposition',[0 0 1 1]);
while(ishghandle(fig))
    for k = 1:n
        %Updates positions of the kth ball
        S(k,1)=S(k,1)+deltat*V0(k,1);
        S(k,2)=S(k,2)+deltat*V0(k,2);
        S(k,3)=S(k,3)+deltat*V0(k,3);
        %Bouncing on the sides of the wall
        if S(k,1) >= X0 - R(k)
            S(k,1) = X0 - R(k);
            V0(k,1) = -V0(k,1);
        end
        if S(k,1) <= R(k)
            S(k,1) = R(k);
            V0(k,1) = -V0(k,1);
        end
        
        if S(k,2) >= Y0 - R(k)
            V0(k,2) = -V0(k,2);
        end
        if S(k,2) <= R(k)
            S(k,2) = R(k);
            V0(k,2) = -V0(k,2);
        end
        if S(k,3) >= Z0 - R(k)
            S(k,3) = Z0 - R(k);
            V0(k,3) = -V0(k,3);
        end
        if S(k,3) <= R(k)
            S(k,3) = R(k);
            V0(k,3) = -V0(k,3);
        end
        
        %CODE TO DETERMINE COLLISION AND BOUNCE
        for k2 = 1:n
            if k ~= k2
                Pk=[S(k,1);S(k,2);S(k,3)];
                Pk2=[S(k2,1);S(k2,2);S(k2,3)];
                D=Pk-Pk2;
                dist=norm(D);
                if dist <= R(k)+R(k2)
                    m1=M(k);m2=M(k2);
                    P1=Pk;P2=Pk2;
                    Vb1=[V0(k,1);V0(k,2);V0(k,3)];Vb2=[V0(k2,1);V0(k2,2);V0(k2,3)];
                    [Va1,Va2,N] = ElasticCollisionF(m1,P1,Vb1,m2,P2,Vb2);
                    V0(k,1)=Va1(1);V0(k,2)=Va1(2);V0(k,3)=Va1(3);
                    V0(k2,1)=Va2(1);V0(k2,2)=Va2(2);V0(k2,3)=Va2(3);
                    deltaN=R(k)+R(k2)-norm(Pk-Pk2);
                    S(k,:)=S(k,:)+deltaN*N';

                end
            end
        end

        
        
        
    end
    
    clf
    set(gca,'xtick',[],'ytick',[],'ztick',[]);
    plotcube([X0 Y0 Z0],[0 0 0],.1,[0 0 0]);
    hold on;
    for i=1:length(R)
        hSurface=surf(XS*R(i)+S(i,1), YS*R(i)+S(i,2), ZS*R(i)+S(i,3))
        hold on
        set(hSurface,'FaceColor',C(i,:), ...
            'FaceAlpha',0.7,'FaceLighting','gouraud','EdgeColor','none')
    end
    axis([0  X0    0  Y0    0  Z0])
    view([-20  20])
    drawnow
end
end