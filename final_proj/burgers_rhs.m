function [u] = burgers_rhs(x,u,h,k)
%BC
N = length(x)
u(1) = u(length(x));   % copy value from rightmost unknown to ghost cell on left
u(length(x)+1) = u(2);

u = -(burgers_LF(u(2:N+1),u(3:N+2))) - burger_LF(u(1:N),u(2:N+1))/h;
return