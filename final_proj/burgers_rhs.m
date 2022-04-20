function [du] = burgers_rhs(x,u,h, maxvel,which)
%BC
N = length(u);
[xb,ub] = extend(x,u,h,1,'D',2,'N',0);
if which == 'LF'
    du = -(burgers_LF(ub(2:N+1),ub(3:N+2),maxvel) - burgers_LF(ub(1:N),ub(2:N+1), maxvel))/h;
end
if which == 'LW'
    du = -(burgers_LW(ub(2:N+1),ub(3:N+2),0.2) - burgers_LW(ub(1:N),ub(2:N+1),0.2))/h;
end

if which == 'UW'
    du = -(burgers_UW(ub(2:N+1),ub(3:N+2),maxvel) - burgers_UW(ub(1:N),ub(2:N+1), maxvel))/h;
end
return