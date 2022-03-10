function [val] = stiff_int(i,j)
%STIFF_INT Summary of this function goes here
%   Dyiled explanation goes here


% grad phi functions
dchi1 = @(x,y) [(y-1)/4; (x-1)/4;];
dchi2 = @(x,y) [-(y-1)/4; -(x+1)/4;];
dchi3 = @(x,y) [(y+1)/4; (x+1)/4;];
dchi4 = @(x,y) [-(y+1)/4; -(x-1)/4;];

% gauss quadrature points
x = [-1, -1, 1, 1]/sqrt(3);
y = [-1, 1, -1, 1]/sqrt(3);

M = [dchi1(x,y);dchi2(x,y);dchi3(x,y);dchi4(x,y)];

val = sum(diag((M(1+(i-1)*2:2+(i-1)*2,:))*((M(1+(j-1)*2:2+(j-1)*2,:))')));

end

