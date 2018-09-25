function  visualize_MR_organ_model(figure_number,R,faces,vertices )

[x,y]=meshgrid(40:size(R,1)-40);

figure(figure_number);
trisurf(faces,vertices(:,1),vertices(:,2),vertices(:,3),...
    'FaceColor',[0.9100    0.4100    0.1700],'EdgeColor','none','FaceAlpha',1)
axis off
camlight('headlight')
lighting phong

hold on
z=ones(size(x)).*41;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
z=ones(size(x)).*45;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
z=ones(size(x)).*49;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
z=ones(size(x)).*53;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)

hold on
z=ones(size(x)).*57;
h=slice(R,x,y,z);
set(h,'edgecolor','none')
colormap(gray)
%
%set(gcf,'Color','black')
axis([0 500, 0 500,41 57])


end

