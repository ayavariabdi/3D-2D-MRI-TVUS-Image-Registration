%% solver is 1, 2 or 3
%            1 is matlab backslash (A\b)
%            2 is SOR
%            3 is LU decomposition
% R_new  Reference contour image
% R           Reference image
% M          Moving image
% R_D     Distance image's landmarks
% M_L     Moving image's landmarks
function [u,v,w,w_v,M_l,M_lv] = Distance_demo_3D(D_R,Dx,Dy,Dz,M,M_l,lambda,max_iter,tol)

Q_l=M_l;

%% Initialization
[My Mx] = size (M);
Mz=size(D_R,3);
u=zeros(My,Mx);% total displacement in x axis
v=zeros(My,Mx);% total displacement in y axis
w=zeros(My,Mx);% total displacement in z axis
mu=lambda/(1-lambda);
%% Finding the original landmark's locations of moving image
z=zeros(My,Mx,Mz); % use for landmark's locations
z  = landmarks_location1(Q_l,z);
%% Coefficient Matrix and Force Matrices
[A,b] = coefficient_3Ddistance_matrix1(M,D_R,Dx,Dy,Dz,z,mu,My,Mx,Mz,M_l,lambda);
%% Solution of Linear Equations
%uvw=bicgstab(A,b,tol,max_iter);
%uvw=tfqmr(A,b,tol,max_iter);
uvw=A\b;
%uvw=pinv(A)*b;
%%
u=reshape(uvw(1:3:end),My,Mx);
v=reshape(uvw(2:3:end),My,Mx);
w=reshape(uvw(3:3:end),My,Mx);
w_v=w./5;
%  outDim=[size(M,2) size(M,1)];
%  imgH = size(M,1); % height
%  imgW  = size(M,2); % width
%  outH = outDim(2);
% outW = outDim(1);
%  interp.method = 'invdist'; %'nearest'; %'none' % interpolation method
%  interp.radius = 7; % radius or median filter dimension
%  interp.power =132; %power for inverse wwighting interpolation method
%   [X Y] = meshgrid(1:imgH,1:imgW); % HxW
%   IIx1=X+u;
%   IIy1=Y+v;
%   IIz1=;
%  [imgw,imgwr,map] = interp2d(Y(:), X(:), uint8(M), IIy1(:), IIx1(:), outH, outW, interp);   
% IIx1=reshape(IIx1,size(M));
% IIy1=reshape(IIy1,size(M));
c=0;

for ij=1:Mz
for i=1:My
    for j=1:Mx
        if z(i,j,ij)==1;
           c = c+1;
            ind=find(Q_l(:,1)==j & Q_l(:,2)==i & Q_l(:,3)==ij);
            M_l(ind,1)=M_l(ind,1)+u(i,j);
            M_l(ind,2)=M_l(ind,2)+v(i,j);
            M_l(ind,3)=M_l(ind,3)+w(i,j);
        end
    end
end
end
M_lv(:,1:2)=M_l(:,1:2);

a(:,1)=((M_l(:,3)-41)./5)+41;
M_lv(:,3)=a;
% figure(100)
% clf;
% Image = uint8(imgw);
% imshow(uint8(Image))
%  hold on;
%  plot(M_lv(:,1),M_lv(:,2),'yx')
%  hold off
% figure(22)
% imshow(uint8(Image))
% hold on;
% plot(M_l(:,1),M_l(:,2),'rx')
% figure(23)
% mesh(IIx1,IIy1,w,'EdgeColor', [1 0 0], 'FaceColor', 'none','LineWidth',.002)
end