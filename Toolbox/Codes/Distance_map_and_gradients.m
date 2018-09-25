function [D,Dx,Dy,Dz] = Distance_map_and_gradients(R1,R_l )
% R1  --> one of the MR slices
% R_l --> the set of contours used for constructing organ model
% D   --> Distance map
% Dx   --> dD/dx
% Dy   --> dD/dy
% Dz   --> dD/dz

R_new=zeros(size(R1,1),size(R1,2),51+120);
c=41;
for i=1:size(R_l,3)
    R_l1=R_l(:,1:2,i);
    [R_n,R_boundary]=BW_image(R1,R_l1);
    R_new(:,:,c)=im2bw(R_n);
    c=c+1;
end
 D=bwdist(R_new);
[Dx,Dy,Dz] = gradient(D,1,1,1);
end

