close all
clear all
clc

%% Load Data
% TVUS data after affine Registration
load('TVUS.mat')

% TVUS after nonlinear Registration
load('Results.mat')

% MRI Data
load('MRI.mat')

% Organ 3D Model
load('organ_model.mat')

%% Visualization

% TVUS
figure(1)
imshow(uint8(M))
hold on;
plot(M_land1(:,1),M_land1(:,2),'b','LineWidth',2)

% MRI
figure(2);
trisurf(faces11,vertices11(:,1),vertices11(:,2),vertices11(:,3),...
'FaceColor',[0.9100    0.4100    0.1700],'EdgeColor','none','FaceAlpha',1)
axis off
camlight('headlight')
lighting phong
hold on
[x,y]=meshgrid(40:380);
z=ones(size(x)).*41;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)
%
hold on
[x,y]=meshgrid(40:380);
z=ones(size(x)).*45;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
[x,y]=meshgrid(40:380);
z=ones(size(x)).*49;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
[x,y]=meshgrid(40:380);
z=ones(size(x)).*53;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
[x,y]=meshgrid(40:380);
z=ones(size(x)).*57;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)
%
 %set(gcf,'Color','black')
 axis([0 500, 0 500,41 57])


%% registration Results

figure(2)
hold on
surface(Xn,Yn,Zn,RGB,...
'FaceColor','texturemap',...
'EdgeColor','none',...
'CDataMapping','direct');hold on;
plot3(M_l_v1(:,1),M_l_v1(:,2),(M_l_v1(:,3)),'r','LineWidth',3);
hold off

figure(3)
surface(Xn,Yn,Zn,RGB,...
'FaceColor','texturemap',...
'EdgeColor','none',...
'CDataMapping','direct');hold on;
plot3(M_l_v1(:,1),M_l_v1(:,2),(M_l_v1(:,3)),'r','LineWidth',3);
hold off


