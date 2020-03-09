%X0=100;Y0=100;Z0=100;

%n=6;
% R=3+3*rand(n,1);
% S=10.+ 80*rand(n,3);
% V0=-7 + 14*rand(n,3);
% if n>3
%     V0(1,:)=[5 0 0];
%     V0(n/2,:)=[0 7 0];
%     V0(n,:)=[0 0 10];
% end

R=minR+(maxR-minR)*rand(n,1);
S=10.+ 80*rand(n,3);
V0=-maxV + (2*maxV)*rand(n,3);
if n>3
    V0(1,:)=[3 0 0];
    V0(n/2,:)=[0 2 0];
    V0(n,:)=[0 0 4];
end

M=R;


deltat=1;

X0=1.2*max(max(S))+max(R);
Y0=1.2*max(max(S))+max(R);
Z0=1.2*max(max(S))+max(R);

%clean data
k=1;k2=1;
while (k<=n)
    while (k2<=n)
        if k~=k2
            Pk=[S(k,1);S(k,2);S(k,3)];
            Pk2=[S(k2,1);S(k2,2);S(k2,3)];
            D=Pk-Pk2;
            dist=norm(D);
            if dist <= R(k)+R(k2)
                S(k2,:)=[];
                R(k2)=[];
                M(k2)=[];
                V0(k2,:)=[];
                n=n-1;
            else
                k2=k2+1;
            end
            
        else
            k2=k2+1;
        end
    end
    k=k+1;
end



bounceFunc3(S,R,M,V0,deltat, X0, Y0, Z0)


