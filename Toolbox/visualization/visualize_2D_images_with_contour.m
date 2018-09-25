function visualize_2D_images_with_contour(figure_number,image,contour1,contour2,contour3)

figure(figure_number)
imshow(image)
switch nargin
    case 3
hold on
plot(contour1(:,1),contour1(:,2),'rx')

    case 4
hold on
plot(contour1(:,1),contour1(:,2),'rx')
hold on
plot(contour2(:,1),contour2(:,2),'yx')

    case 5
hold on
plot(contour1(:,1),contour1(:,2),'rx')
hold on
plot(contour2(:,1),contour2(:,2),'bx')
hold on
plot(contour3(:,1),contour3(:,2),'yx')

end

