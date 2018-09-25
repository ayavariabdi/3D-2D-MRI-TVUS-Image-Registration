%% arc-length parameterization

% Inputs:
         %data_points: landmarks positions [x1 y1;x2 y2;...;xn yn]
         %n: number of sample points
% Output:
         %arclength: arc-length
         %data_point_new: landmarks from the curve
%%
function [arclength,data_point_new] = arc_length_parameterization_3D(data_point,n)
n=round(n);
arclength =cumsum(sqrt([0,diff(data_point(:,1)')].^2 + [0,diff(data_point(:,2)')].^2 + [0,diff(data_point(:,3)')].^2));
arclength_sample = linspace(arclength(1),arclength(end),n);
xi = interp1(arclength,data_point(:,1)',arclength_sample,'pchip');
yi = interp1(arclength,data_point(:,2)',arclength_sample,'pchip');
zi = interp1(arclength,data_point(:,3)',arclength_sample,'pchip');
data_point_new=[xi' yi' zi'];
end