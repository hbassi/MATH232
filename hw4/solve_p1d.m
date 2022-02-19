function [u] = solve_p1d(u0,du1,rhs_fun,x0,xf,m)
%SOLVE_P1A Summary of this function goes here
%   Detailed explanation goes here

h = (xf-x0)/(m);

F = zeros(m+1,1);

A = spdiags([ones(m+1,1) -2*ones(m+1,1) ones(m+1,1)], -1:1, m+1, m+1); 
A(1,:) = 0;
A(1,1) = h^2;
A(m+1,:) = 0;
A(m+1,m-1) = h/2;
A(m+1,m) = -2*h;
A(m+1,m+1) = 3*h/2;

A = A/h^2;

for i = 2:m
    F(i) = rhs_fun((i-1)*h+x0)+h^2*rhs_fun((i-1)*h+x0)/12;
end
F(1) = u0;
F(m+1) = du1 - h^2*rhs_fun(xf)/3 + h^3*rhs_fun(xf)/4;
u = A\F;

end

