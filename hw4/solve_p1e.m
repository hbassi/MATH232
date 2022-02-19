function [u] = solve_p1e(u0,du1,rhs_fun,x0,xf,m)
%SOLVE_P1A Summary of this function goes here
%   Detailed explanation goes here

h = (xf-x0)/(m);

F = zeros(m+1,1);

A = spdiags([(-1/12)*ones(m+1,1) (4/3)*ones(m+1,1) (-5/2)*ones(m+1,1) (4/3)*ones(m+1,1) (-1/12)*ones(m+1,1)], -2:2, m+1, m+1); 
A(1,:) = 0;
A(1,1) = h^2;

A(2,:) = 0;
A(2,2) = 15/4;
A(2,3) = -77/6;
A(2,4) = 107/6;
A(2,5) = -13;
A(2,6) = 61/12;
A(2,7) = -5/6;

A(m,:) = 0;
A(m,m) = 15/4;
A(m,m-1) = -77/6;
A(m,m-2) = 107/6;
A(m,m-3) = -13;
A(m,m-4) = 61/12;
A(m,m-5) = -5/6;

A(m+1,:) = 0;
A(m+1,m+1) = 25*h/12;
A(m+1,m) = -4*h;
A(m+1,m-1) = 3*h;
A(m+1,m-2) = -4*h/3;
A(m+1,m-3) = h/4;

A = A/h^2;

for i = 2:m
    F(i) = rhs_fun((i-1)*h+x0);
end
F(1) = u0;
F(m+1) = du1;
u = A\F;

end

