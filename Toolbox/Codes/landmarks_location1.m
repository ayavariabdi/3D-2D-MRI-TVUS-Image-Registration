%% Q_l: Original Moving image's landmarks
%  Mx: size of image in x direction
%  My: size of image in y direction
%  Mz: size of image in z direction
%  z: zeros(My,Mx,Mz)
function [ z ] = landmarks_location1(Q_l,z)
for i=1:length(Q_l(:,1))
z(Q_l(i,2),Q_l(i,1),Q_l(i,3))=1;
end
end