close all 
clear
clc


% A = [1 0 0 0 -1; -1 1 0 0 0; 0 -1 1 0 0; 0 0 -1 1 0; 0 0 0 -1 1;];
% 
% eig(A)
% 
% A1 = [1 0 0 0 -2; -1 1 0 0 0; 0 -1 1 0 0; 0 0 -1 1 0; 0 0 0 -1 1;];
% 
% eig(A1)

n = 50;
e = ones(n,1);
A3 = spdiags([-e e], -1:0, n, n);
A3(1,n) = -1;
eig(full(A3))