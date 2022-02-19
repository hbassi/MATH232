%
% -------------------------
% MATLAB: SpectralMethod1.m
% -------------------------
%
% This matlab code computes the solution to the Dirichlet, two-point
% boundary value problem of the form
% 
% u'' = exp(x) on [0,3], u(0) = -5, u(3) = 3
% 
% using a spectral collocation method on a uniform grid.
%

clear all;

% set the values of the Dirichlet boundary conditions

alpha = 3;
beta  =  -5;

% set the number of interior grid points

m = 40;

% compute the mesh width

h = 1 / ( m + 1.0 );

% compute the grid
z = zeros(m+2,1);
x = zeros(m+2,1);
for i=1:length(z)
    z(i) = i/(m+1);
end
for i=1:length(x)
    x(i) = 0 + 0.5*(1)*(1+cos(pi*(1-(i-1)*h)));
end 
%x = 0 : h : 3.0;

% compute the spectral collocation matrix

A = zeros( m + 2 );

% set the Dirichlet BC at x = 0

A(1,1) = 1;

% compute the interior rows

for j = 2 : m + 1
    
    A(j,:) = fdcoeffF( 2, x(j), x );
    
end

% set the Dirichlet BC at x = 3

A(m+2,:) =  fdcoeffF( 1, x(m+2), x );

% compute the right-hand side

f      = zeros( m + 2, 1 );
f      = exp( x' );
f(1)   = alpha;
f(m+2) = beta;

% solve the linear system of equations

u = A \ f';

% compute the exact solution

C0 = alpha - 1.0;
C1 = ( beta - alpha + 1.0 - exp( 3.0 ) ) / 3.0;

uexact = @(t) exp(t) - (5+exp(1))*t + 2;
uexact = uexact(x);

error_inf = max( abs( uexact - u ) )
error_one = h * sum( abs( uexact - u ) )
error_two = sqrt( h * sum( abs( uexact - u ).^2 ) )

% plot the solution

plot( x, u, 'ko-', x, uexact, 'r--' );
xlabel( 'x' );
ylabel( 'u(x)' );
title( 'Spectral Collocation Method on a Uniform Grid' );
legend( 'Spectral Collocation', 'Exact' )