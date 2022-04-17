close all; clc; clear all
ax = 0;
bx = 1;
tfinal = 1;
m = 1000;
h = (bx-ax)/(m+1);
k = 0.4*h;
x = linspace(ax,bx,m+2)';
u = sin(2*pi*x);

[u] = burgers(x,u,h,k, tfinal);