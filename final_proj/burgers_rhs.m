function [u] = burgers_rhs(x,u,h,k)
%BC
m = 1;
xl = min(x); xr = max(x); N = length(u);
xb = zeros(N+2*m,1); ub = zeros(N+2*m,1); q = [1:m];

xb(m-q+1) = xl-q*h; xb(N+m+q) = xr + q*h; xb((m+1):N+m) = x(1:N);
ub(m-q+1) = u(N-q); ub(N+m+q) = u(q+1); ub((m+1):(N+m)) = u(1:N);

u = -(burgers_LF(ub(2:N+1),ub(3:N+2))) - burgers_LF(ub(1:N),ub(2:N+1))/h;
return