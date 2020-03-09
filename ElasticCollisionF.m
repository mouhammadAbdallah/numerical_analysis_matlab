function [Va1,Va2,N] = ElasticCollisionF(m1,P1,Vb1,m2,P2,Vb2)

D=P1-P2;
d=norm(D);
N=D./d;
k=(2/( (1/m1)+(1/m2) )) * dot(N,Vb1 - Vb2);

Va1=Vb1 - (k/m1)*N;
Va2=Vb2 + (k/m2)*N;

end

