function [xe,ue] = extend(x,u,h,m,BCl,ul,BCr,ur)
xl = min(x); xr = max(x); N = length(u);
xe = zeros(N+2*m,1); ue = zeros(N+2*m,1); q = [1:m];

xe(m-q+1) = xl - q*h; xe(N+m+q) = xr + q*h; xe((m+1):(N+m)) = x(1:N);

if (BCl=='P') | (BCr=='P')
    ue(m-q+1) = u(N-q); ue(N+m+q) = u(q+1); ue((m+1):(N+m)) = u(1:N);
    return;
end;