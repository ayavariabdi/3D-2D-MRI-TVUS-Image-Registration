function [X,X1,Y1,Z1,x0, a, Plane, normd] = lsplane(X,size_R)

% calculate centroid
  x0 = mean(X)';
%
% form matrix A of translated points
  A = [(X(:, 1) - x0(1)) (X(:, 2) - x0(2)) (X(:, 3) - x0(3))];
%
% calculate the SVD of A
  [U, S, V] = svd(A, 0);
%
% find the smallest singular value in S and extract from V the
% corresponding right singular vector
  [s, i] = min(diag(S));
  a = V(:, i);
%
% calculate residual distances, if required  
  if nargout > 2
    d = U(:, i)*s;
    normd = norm(d);
  end
Plane(1) = a(1);
Plane(2) = a(2);
Plane(3) = a(3);
Plane(4) = -a(1)*x0(1)-a(2)*x0(2)-a(3)*x0(3);

x=1:size_R;
[X1,Y1] = meshgrid(x);
Z1=(-Plane(4)- Plane(1) * X1 - Plane(2) * Y1)/Plane(3);
%X=round(X(:,1:2));
Z2=(-Plane(4)- Plane(1) * X(:,1) - Plane(2) * X(:,2))/Plane(3);
X(:,3)=Z2;
figure(110)
clf
surf(X1,Y1,Z1)
hold on;
plot3(X(:,1),X(:,2),X(:,3),'r+','LineWidth',4)
end