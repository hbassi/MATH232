close all; clc; clear all
ax = 0;
bx = 1;
tfinal = 0.2;
m = 8192;
h = (bx-ax)/(m);
CFL = 0.9;
x = [0:h:1]';
u = (1-sign(x-0.2))/2+1;
which = 'LW';

[u_sol] = burgers(x,u,h,CFL,tfinal,which);
plot(linspace(0,0.2,length(u_sol)),u_sol)

u_true = (1-sign(x-0.8))/2 + 1;
hold on
plot(linspace(0,0.2,length(u_true)),u_true)
legend 'LW' 'exact solution' 
xlabel 'x'
ylabel '$u(x,t)$'
title 't = 0.2'
grid minor
