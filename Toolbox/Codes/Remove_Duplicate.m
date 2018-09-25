function [ M_l] = Remove_Duplicate( M_l)
c=0;
x3=size(M_l,1);
for i=1:x3-1
if (M_l(i,1)==M_l(i+1,1) && M_l(i,2)==M_l(i+1,2))
c=c+1;
ind(c)=[i+1];
end
end
if c>0
M_l(ind',:)=[];
end
end

