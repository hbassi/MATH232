function [val] = mass_int(j,f,a,b)
%MASS_INT Summary of this function goes here
%   Detailed explanation goes here

% phi functions
chi1 = @(x,y) (x-1).*(y-1)/4;
chi2 = @(x,y) -(x+1).*(y-1)/4;
chi3 = @(x,y) (x+1).*(y+1)/4;
chi4 = @(x,y) -(x-1).*(y+1)/4;

% gauss quadrature points
x = [-1, -1, 1, 1]/sqrt(3);
y = [-1, 1, -1, 1]/sqrt(3);

M = [chi1(x,y);chi2(x,y);chi3(x,y);chi4(x,y)];
F = f(x+a,y+b);

z = zeros(4,1);
z(j) = 1;

val = F*M'*z;

end

