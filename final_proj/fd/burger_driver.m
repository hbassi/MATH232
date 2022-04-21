close all; clc; clear all
ax = 0;
bx = 1;
tfinal = 0.2;
m = 2048;
h = (bx-ax)/(m);
CFL = 0.9;
x = [0:h:1]';
u = (1-sign(x-0.2))/2+1;
which = 'UP';
rhs = 0;
[u_sol_up] = burgers(x,u,h,CFL,tfinal,'UP',rhs);
[u_sol_lf] = burgers(x,u,h,CFL,tfinal,'LF',rhs);
[u_sol_lw] = burgers(x,u,h,CFL,tfinal,'LW',rhs);
plot(linspace(0,0.2,length(u_sol_up)),u_sol_up, '--')

u_true = (1-sign(x-0.8))/2 + 1;
hold on
plot(linspace(0,0.2,length(u_true)),u_true)
plot(linspace(0,0.2,length(u_sol_lf)),u_sol_lf, '--')
plot(linspace(0,0.2,length(u_sol_lw)),u_sol_lw, '--')
legend 'Upwinding' 'Exact Solution' 'LF' 'LW' 
xlabel 'x'
ylabel 'u(x,t)'
title 't = 0.2, 2048 grid points'
grid minor
