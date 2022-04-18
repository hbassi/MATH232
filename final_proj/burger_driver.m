close all; clc; clear all
ax = 0;
bx = 1;
tfinal = 1;
m = 100;
h = (bx-ax)/(m+1);
CFL = 0.9;
x = [0:h:1]';
u = sin(2*pi*x);

[u_sol] = burgers(x,u,h,CFL, tfinal);