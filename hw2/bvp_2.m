clear all
%
% bvp_2.m 
% second order finite difference method for the bvp
%   u''(x) = f(x),   u'(ax)=sigma,   u(bx)=beta
% Using 3-pt differences on an arbitrary nonuniform grid.
% Should be 2nd order accurate if grid points vary smoothly, but may
% degenerate to "first order" on random or nonsmooth grids. 
%
% Different BCs can be specified by changing the first and/or last rows of 
% A and F.
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/  (2007)

ax = 0;
bx = pi;
sigma = 1;   % Neumann boundary condition at ax
beta = -1;     % Dirichlet boundary condtion at bx

f = @(x) 0;  % right hand side function
%utrue = @(x) 2*cos(x) + (3-2*cos(1))/(sin(1)) * sin(x);   % true soln
utrue = @(x) cos(x);

% true solution on fine grid for plotting:
xfine = linspace(ax,bx,201);
ufine = utrue(xfine);

% Solve the problem for ntest different grid sizes to test convergence:
m1vals = [20 40 80 160 320];
ntest = length(m1vals);
hvals = zeros(ntest,1);  % to hold h values
E = zeros(ntest,1);      % to hold errors

for jtest=1:ntest
  m1 = m1vals(jtest);
  m2 = m1 + 1;
  m = m1 - 1;                 % number of interior grid points
  hvals(jtest) = (bx-ax)/m1;  % average grid spacing, for convergence tests

  % set grid points:  
  gridchoice = 'uniform';          % see xgrid.m for other choices
  x = xgrid(ax,bx,m,gridchoice);   

  % set up matrix A (using sparse matrix storage):
  A = spalloc(m2,m2,3*m2);   % initialize to zero matrix

  % first row for Neumann BC at ax:
  A(1,1) = fdcoeffF(0, x(1), x(1:1)); 

  % interior rows:
  for i=2:m1
     A(i,i-1:i+1) = fdcoeffF(2, x(i), x((i-1):(i+1))) + fdcoeffF(0, x(i), x((i-1):(i+1)));
  end

  % last row for Dirichlet BC at bx:
  A(m2,m:m2) = fdcoeffF(0,x(m2),x(m:m2)); 
  
  % Right hand side:
  F = f(x); 
  F(1) = sigma;  
  F(m2) = beta;
  F = transpose(F);
  
  % solve linear system:
  U = A\F;

  if jtest==1
     U_save1=U;
     uhat1 = utrue(x);
  elseif  jtest==2
     U_save2=U;
     V = (1/3)*(4*U_save2(1:2:end) - U_save1);
     uhat2 = utrue(x);
     err2 = V - uhat1;
  elseif  jtest==3
     U_save3=U;
     V = (1/3)*(4*U_save3(1:2:end) - U_save2);
     uhat3 = utrue(x);
     err2 = V - uhat2;
  elseif  jtest==4
     U_save4=U;
     V = (1/3)*(4*U_save4(1:2:end) - U_save3);
     uhat4 = utrue(x);
     err2 = V - uhat3;
     elseif  jtest==5
     U_save5=U;
     V = (1/3)*(4*U_save5(1:2:end) - U_save4);
     uhat5 = utrue(x);
     err2 = V - uhat4;
  end   
      
  % compute error at grid points:
  uhat = utrue(x);
  err = U - uhat;
  
  E(jtest) = max(abs(err));  
  if jtest >=2     
        E2(jtest-1) = max(abs(err2));  
  end
  disp(' ')
  disp(sprintf('Error with %i points is %9.5e',m2,E(jtest)))

  clf
  plot(x,U,'o')  % plot computed solution
  title(sprintf('Computed solution with %i grid points',m2));
  hold on
  plot(xfine,ufine)  % plot true solution
  hold off
  
  % pause to see this plot:  
  drawnow
  input('Hit <return> to continue ');
  
  end

error_table(hvals, E);   % print tables of errors and ratios
error_loglog(hvals, E);  % produce log-log plot of errors and least squares fit

error_table(hvals(1:end-1), E2);   % print tables of errors and ratios
error_loglog(hvals(1:end-1), E2);  % produce log-log plot of errors and least squares fit