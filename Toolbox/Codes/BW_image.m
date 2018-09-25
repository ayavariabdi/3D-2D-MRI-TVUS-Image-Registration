function [R_new,R_boundary] = BW_image(R,R_l)
R_mask = poly2mask(R_l(:,1)',R_l(:,2)',size(R,1),size(R,2));
R_boundaries = bwboundaries(R_mask);
for k = 1:length(R_boundaries)
R_boundary1= R_boundaries{k};
end
R_boundary=zeros(size(R_boundary1));
R_boundary(:,1)=R_boundary1(:,2);
R_boundary(:,2)=R_boundary1(:,1);
R_new=double(zeros(size(R)));
R_new= landmarks_location(R_boundary,R_new)*255;
end

