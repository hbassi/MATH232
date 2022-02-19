function [u,x] = solve_p1f(u0,du1,rhs_fun,x0,xf,m)
%SOLVE_P1A Summary of this function goes here
%   Detailed explanation goes here

% construct grid
h = 1/(m+1);
x = zeros(m+2,1);

for i = 1 : m+2
    %x(i) = .5*(1+cos(pi*(1-(i-1)*h)));
    x(i) = x0 + 0.5*(xf-x0)*(1+cos(pi*(1-(i-1)*h)));
end

% construct matrix
A = zeros(m+2);

A(1,1) = 1;

for j = 2 : m + 1
    A(j,:) = fdcoeffF( 2, x(j), x );
end

A(m+2,:) = fdcoeffF( 1, x(m+2), x );

% compute rhs
F = zeros(m+2,1);
F(1) = u0;

for i = 2:m+1
    F(i) = rhs_fun(x(i));
end

F(m+2) = du1;

u = A\F;

end

