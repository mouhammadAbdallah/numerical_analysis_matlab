function FF = F(ti,Si,k,m,g)
%Si is a vector of (xi,xi',yi,yi',zi,zi')

FF=zeros(6,1);
FF(1)=Si(2);
FF(2)=(-k/m)*Si(2);
FF(3)=Si(4);
FF(4)=(-k/m)*Si(4);
FF(5)=Si(6);
FF(6)=-g-(k/m)*Si(6);

end

