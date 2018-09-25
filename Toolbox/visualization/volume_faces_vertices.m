function [faces,vertices,R_l_order] = volume_faces_vertices(R1_land,R2_land,R3_land,R4_land,R5_land)

[curve,volume]= volume_surface_81_win(R1_land,R2_land,R3_land,R4_land,R5_land);

R_lnew=curve(1:end,:,:);
for i=1:size(R_lnew,3)
    R_l_amir=R_lnew(:,1:2,i);
    R_l_amir(end+1,:)=R_l_amir(1,:);
    [null,R_l_para]=arc_length_parameterization(R_l_amir,100);
    R_l_para(end,:)=[];
    R_lnew1(:,1:2,i)=R_l_para;
    R_lnew1(:,3,i)=R_lnew(1,3,i);
end

for i=1:size(R_lnew,3)
    if R_lnew1(1,3,i)<45
        hold on; plot3(R_lnew1(:,1,i),R_lnew1(:,2,i),R_lnew1(:,3,i),'c--','LineWidth',0.05);
        %hold on; plot3(R_lnew1(1:5,1,i),R_lnew1(1:5,2,i),R_lnew1(1:5,3,i),'y','LineWidth',1);
    elseif R_lnew1(1,3,i)<49
        hold on; plot3(R_lnew1(:,1,i),R_lnew1(:,2,i),R_lnew1(:,3,i),'k--','LineWidth',0.05);
        %hold on; plot3(R_lnew1(1:5,1,i),R_lnew1(1:5,2,i),R_lnew1(1:5,3,i),'y','LineWidth',1);
    elseif R_lnew1(1,3,i)<53
        hold on; plot3(R_lnew1(:,1,i),R_lnew1(:,2,i),R_lnew1(:,3,i),'g--','LineWidth',0.05);
        %hold on; plot3(R_lnew1(1:5,1,i),R_lnew1(1:5,2,i),R_lnew1(1:5,3,i),'y','LineWidth',1);
    elseif R_lnew1(1,3,i)<57
        hold on; plot3(R_lnew1(:,1,i),R_lnew1(:,2,i),R_lnew1(:,3,i),'b--','LineWidth',0.05);
        %hold on; plot3(R_lnew1(1:5,1,i),R_lnew1(1:5,2,i),R_lnew1(1:5,3,i),'y','LineWidth',1);
    else
        hold on; plot3(R_lnew1(:,1,i),R_lnew1(:,2,i),R_lnew1(:,3,i),'r--','LineWidth',0.05);
        %hold on; plot3(R_lnew1(1:5,1,i),R_lnew1(1:5,2,i),R_lnew1(1:5,3,i),'y','LineWidth',1);
    end
end
view([0, 180,45]);

figure

R_l_order = Order_curves (R_lnew1);

exx=zeros(201,81);
exx(:,:)=R_l_order(:,1,:);
eyy=zeros(201,81);
eyy(:,:)=R_l_order(:,2,:);
ezz=zeros(201,81);
ezz(:,:)=R_l_order(:,3,:);
fv1 = surf2patch(exx,eyy,ezz,'triangles');
faces=fv1.faces;
vertices=fv1.vertices;
end