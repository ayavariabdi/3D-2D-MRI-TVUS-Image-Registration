function [M_l_registered,endo_reg,X,Y,Z,RGB] = registration_demo(M,M_land,endo_land,faces,vertices,D,Dx,Dy,Dz)
%% Input
% M        --> TVUS moving image
% M_land   --> TVUS parametrized curve
% faces    --> Faces from MR organ model
% vertices --> Vertices from MR organ model
%% Output
% M_l_registered --> TVUS curve after non-linear registration
% X,Y,Z          --> Deformed mesh
% RGB            --> TVUS in RGB for visualization
%% Define the location of moving points (MR slices are located at: 41,45,49,53,57)
M_l1=M_land;
M_l1(:,3)=50; % in original scale (41 41.2 41.4 ... 56.8 57)
if isempty(endo_land)==0
    endo_land(:,3)=M_l1(1,3);
end
Zn_old=M_l1(1,3);
a_n(:,1)=((M_l1(:,3)-41).*5)+41; % convert to distance map sapce (41.2 --> 42 ...)
M_l1(:,3)=a_n;
%% Initial displacement
u=zeros(size(M));
v=zeros(size(M));
w=zeros(size(M));
%close all
%% nonlinear registration
nbiteration=10; %7
M_ln=M_l1;
c=1;
lambda1=0.09;
RGB=zeros(size(M,1),size(M,2),3);
RGB(:,:,1)=M;
RGB(:,:,2)=M;
RGB(:,:,3)=M;
RGB=uint8(RGB);
[Xs,Ys] = meshgrid(1:size(M,1));
for i=1:nbiteration
    if i<2
        if i==1
            lambda=0.009;
        end
        lambda=lambda+0.009; %0.04 0.09
    elseif i<3
        if i==2
            lambda=0.001;
        end
        lambda=lambda+0.01;
    else
        if i==3
            lambda=0.01;
        end
        lambda=lambda+0.01;%0.05
        if lambda>=0.1;
            lambda=lambda1+0.001;
        end
    end
    if i<2
        [M_ln] = Remove_Duplicate(round(M_ln));
        [u,v,w,w_v,M_ln,M_lv] = Distance_demo_3D(D,Dx,Dy,Dz,M,M_ln,lambda,1000,10^-5);
        [M_ln,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(M_ln,420);
        close
        [M_lv,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(M_lv,420);
        Xn=Xs+u;
        Yn=Ys+v;
        Zn=(-Plane(4)- Plane(1) * Xn - Plane(2) * Yn)/Plane(3);
        w_v_new=Zn-Zn_old;
        Zn=[];
        Zn=Zn_old+w_v_new;
        Zn_old=Zn;
    elseif i<3 && i>1
        [M_ln] = Remove_Duplicate(round(M_ln));
        [u,v,w,w_v,M_ln,M_lv] = Distance_demo_3D(D,Dx,Dy,Dz,M,M_ln,lambda,1000,10^-5);
        [M_ln,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(M_ln,420);
        close
        [M_lv,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(M_lv,420);
        Xn=Xn+u;
        Yn=Yn+v;
        Zn=(-Plane(4)- Plane(1) * Xn - Plane(2) * Yn)/Plane(3);
        w_v_new=Zn-Zn_old;
        Zn=[];
        Zn=Zn_old+w_v_new;
        Zn_old=Zn;
    elseif i>=3 && i<=nbiteration-1
        [M_ln] = Remove_Duplicate(round(M_ln));
        [u,v,w,w_v,M_ln,M_lv] = Distance_demo_3D(D,Dx,Dy,Dz,M,M_ln,lambda,1000,10^-5);
        [M_ln,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(M_ln,420);
        close
        [M_lv,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(M_lv,420);
        Xn=Xn+u;
        Yn=Yn+v;
        Zn=(-Plane(4)- Plane(1) * Xn - Plane(2) * Yn)/Plane(3);
        w_v_new=Zn-Zn_old;
        Zn=[];
        Zn=Zn_old+w_v_new;
        Zn_old=Zn;
    elseif i==nbiteration
        [M_ln] = Remove_Duplicate(round(M_ln));
        %Dz(:,:,:)=0;
        lambda=0.15;
        [u,v,w,w_v,M_ln,M_lv] = Distance_demo_3D(D,Dx,Dy,Dz,M,M_ln,lambda,1000,10^-5);
        
        Xn=Xn+u;
        Yn=Yn+v;
        
        Zn=Zn_old+w_v;
        Zn_old=Zn;
    end
   fprintf('Iteration count i =%5d \t\t\t Regularization weight lambda =%12f\n',i,lambda);
    M_l_v1=[];
    [~,M_l_v1] = arc_length_parameterization_3D(M_lv,70);
    
    figure(20)
    
    trisurf(faces,vertices(:,1),vertices(:,2),vertices(:,3),...
        'FaceColor',[0.9100    0.4100    0.1700],'EdgeColor','none','FaceAlpha',0.7)
    axis off
    camlight('headlight')
    lighting phong
    hold on;
    
    
    hold on;
    surface(Xn,Yn,Zn,RGB,...
        'FaceColor','texturemap',...
        'EdgeColor','none',...
        'CDataMapping','direct');hold on;
    plot3(M_l_v1(:,1),M_l_v1(:,2),(M_l_v1(:,3)),'r--','LineWidth',3);
    hold off
    
    M_l11=[];
    [M_larcn,M_l11] = arc_length_parameterization_3D(M_ln,80+i);
    M_ln=[];
    M_ln=M_l11;
    [Xq,Yq,Zq] = meshgrid(1:1:size(M,1),1:1:size(M,2),50);
    ubb=Xn-Xq;
    vbb=Yn-Yq;
    wbb=Zn-Zq;
    if isempty(endo_land)==0
         endo_reg  = move_points(ubb,vbb,wbb,endo_land,M);
        figure(20)
        hold on
        plot3(endo_reg(:,1),endo_reg(:,2),(endo_reg(:,3)),'y--','LineWidth',3);
        hold off
    else
        endo_reg=[];
    end
    %[ endo_reg ] = move_points(ubb,vbb,wbb,endo_land,M);
    % figure(16)
    % hold on
    % plot3(endo_reg(:,1),endo_reg(:,2),(endo_reg(:,3)),'y-','LineWidth',20,'MarkerSize',5);
    % hold off
    figure(21)
    clf
    quiver3(Xq(1:30:end,1:30:end),Yq(1:30:end,1:30:end),Zq(1:30:end,1:30:end),ubb(1:30:end,1:30:end),...
        vbb(1:30:end,1:30:end),wbb(1:30:end,1:30:end)*4, 1,'LineWidth',4,'Color',[1,0,0]) ;
    
    pause(0.5)
end
M_l_registered=M_l_v1;
X=Xn;
Y=Yn;
Z=Zn;
end

