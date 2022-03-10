close all
clear
clc

f = @(x,y) -2*((x.^2-1)+(y.^2-1));

% gauss quadrature points
x = [-1, -1, 1, 1]/sqrt(3);
y = [-1, 1, -1, 1]/sqrt(3);

a = 1; 
b = 1;
f(a,b)

F = f(x+a,y+b)

sum(F)