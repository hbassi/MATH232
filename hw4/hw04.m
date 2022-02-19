close all; clear; clc;

% define grid
x0 = 0;
xf = 1;
m = 6;

% define init conditions
u0 = 3;
du1 = -5; 
rhs_fun = @(x) exp(x);

% solve
u1 = solve_p1a(u0,du1,rhs_fun,x0,xf,m);
u2 = solve_p1a(u0,du1,rhs_fun,x0,xf,2*m);
ur = (1/3)*(4*u2(1:2:end)-u1);
ud = solve_p1d(u0,du1,rhs_fun,x0,xf,m);
u4 = solve_p1e(u0,du1,rhs_fun,x0,xf,m);
[us,xs] = solve_p1f(u0,du1,rhs_fun,x0,xf,m);

% compute exact solution
u_exact = @(t) exp(t) - (5+exp(1))*t + 2;

% plot sols
plot(linspace(x0,xf,m),u_exact(linspace(x0,xf,m)))
hold on
plot(linspace(x0,xf,length(u1)),u1)
plot(linspace(x0,xf,length(ur)),ur)
plot(linspace(x0,xf,length(ud)),ud)
plot(linspace(x0,xf,length(u4)),u4)
plot(xs,us)
xlabel 'x'
ylabel 'u'
title 'Approximated solutions of u(x)'
legend 'u_{exact}' 'u_{2nd}' 'u_{ext}' 'u_d' 'u_4' 'u_s'

% plot errors
for j = 1:10
    m = j*10;

    % solve
    u1 = solve_p1a(u0,du1,rhs_fun,x0,xf,m);
    u2 = solve_p1a(u0,du1,rhs_fun,x0,xf,2*m);
    ur = (1/3)*(4*u2(1:2:end)-u1);
    ud = solve_p1d(u0,du1,rhs_fun,x0,xf,m);
    u4 = solve_p1e(u0,du1,rhs_fun,x0,xf,m);
    [us,xs] = solve_p1f(u0,du1,rhs_fun,x0,xf,m);

    e1(j) = norm(u1(end)-u_exact(xf));
    er(j) = norm(ur(end)-u_exact(xf));
    ed(j) = norm(ud(end)-u_exact(xf));
    e4(j) = norm(u4(end)-u_exact(xf));
    es(j) = norm(us(end)-u_exact(xf));
end
ms = [10 20 30 40 50 60 70 80 90 100];

figure
loglog(e1)
hold on
sl4 = @(x) x.^(-4);
ys4 = sl4(ms);
loglog(ys4, '--')
sl2 = @(x) x.^(-2);
ys2 = sl2(ms);
loglog(ys2, '--')
loglog(er)
loglog(ed)
loglog(e4)
loglog(es)
xlabel '# of nodes'
ylabel 'error'
title 'loglog error vs number of nodes'
legend 'e1' 'slope -4' 'slope -2' 'er' 'ed' 'e4' 'es'