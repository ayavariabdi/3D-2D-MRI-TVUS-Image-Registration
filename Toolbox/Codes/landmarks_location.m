%% Q_l: Original Moving image's landmarks
%  Mx: size of image in x direction
%  My: size of image in y direction
%  z: zeros(My,Mx)
function [ z ] = landmarks_location(Q_l,z)
for i=1:length(Q_l(:,1))
z(Q_l(i,2),Q_l(i,1))=1;
end
end

