%%
close all
clear all
clc
%% add path

addpath ./patient5/Processed_data
addpath ./toolbox/3D_2D_Registration
addpath ./toolbox/Codes
addpath ./toolbox/visualization
addpath ./toolbox

%% TVUS data after affine Registration
endo_land=[];
load('TVUS.mat')
figure_number=1;

if isempty(endo_land)==1
    visualize_2D_images_with_contour(figure_number,uint8(M),M_land1)
else
    visualize_2D_images_with_contour(figure_number,uint8(M),M_land1,endo_land);
end
%% Read MRI slices (R1,R2,R3,R4,R5) and generated MRI volume (R)
% R(:,:,41)= R1  R(:,:,45)= R2  R(:,:,49)= R3 
% R(:,:,53)= R4  R(:,:,45)= R5

load('MRI.mat')

%% 3D Organ Model (faces and vertices)

load('organ_model.mat')

figure_number=2;
visualize_MR_organ_model(figure_number,R,faces11,vertices11)

%% uncomment this section to generate volume and surface

% load('MRI.mat')
% load('MR_Landmark_with_arclength.mat')
% [faces11,vertices11,R_l_order] = volume_faces_vertices(R1_land,R2_land,R3_land,R4_land,R5_land);
% figure_number=5;
% visualize_MR_organ_model(figure_number,R,faces11,vertices11)


%% Distance map (D_R3) and gradients (Dx,Dy,Dz) from MRI organ model

 [D_R3,Dx3,Dy3,Dz3] = Distance_map_and_gradients(R1,R_l_order);


%% Non-linear registration

[M_l_registered,endo_reg,X,Y,Z,TVUS] = registration_demo(M,M_land1,endo_land,faces11,vertices11,D_R3,Dx3,Dy3,Dz3);

figure_number=200;
visualize_MR_organ_model(figure_number,R,faces11,vertices11)
hold on
surface(X,Y,Z,TVUS,...
'FaceColor','texturemap',...
'EdgeColor','none',...
'CDataMapping','direct');hold on;
plot3(M_l_registered(:,1),M_l_registered(:,2),(M_l_registered(:,3)),'r--','LineWidth',3);
if isempty(endo_reg)==0
    hold on
    plot3(endo_reg(:,1),endo_reg(:,2),(endo_reg(:,3)),'y--','LineWidth',3);
end
hold off
