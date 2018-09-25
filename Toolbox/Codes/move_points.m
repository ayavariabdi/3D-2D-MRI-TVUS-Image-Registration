function [ M_l5 ] = move_points( u_new,v_new,w_new,M_l1,M)
[My Mx] = size (M);
Mz=250;
M_l5=round(M_l1);
Q_l=M_l5;
z=zeros(My,Mx,Mz); % use for landmark's locations
z  = landmarks_location1(Q_l,z);
for ij=1:Mz
    for i=1:My
        for j=1:Mx
            if z(i,j,ij)==1
                ind=find(Q_l(:,1)==j & Q_l(:,2)==i & Q_l(:,3)==ij);
                M_l5(ind,1)=M_l5(ind,1)+u_new(i,j);
                M_l5(ind,2)=M_l5(ind,2)+v_new(i,j);
                M_l5(ind,3)=M_l5(ind,3)+w_new(i,j);
            end
        end
    end
end
end
