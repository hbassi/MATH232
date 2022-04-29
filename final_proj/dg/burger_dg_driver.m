% Driver script for 1D scalar advection with DG
clear all
close all

% Order of method (m), number of elements (N)
m=2; N=64;

% Set problem parameters
xmin = 0.0; xmax = 1.0;
FinalTime = 0.22; CFL = 0.01;

% Generate mesh
VX = (xmax-xmin)*(0:N)/N + xmin; r = LegendreGL(m);
x = ones(m+1,1)*VX(1:N) + 0.5*(r+1)*(VX(2:N+1)-VX(1:N));
h = (xmax-xmin)/N;

% Define initial conditions
%u = sin(2*pi*x)+0.8; bcl = 'P'; bclv = 0; bcr = 'P'; bcrv = 0;
u = (1-sign(x-0.2))/2+1; bcl = 'D'; bclv = 2; bcr = 'D'; bcrv = 1;
u_true = (1-sign(x-0.86))/2+1;

% --- Main Solver --- % 
% Initialize operators at GLL ref element
r = LegendreGL(m); V  = VandermondeDG(m, r); D = DmatrixDG(m, r, V);
Ma = inv(V*V'); S = Ma*D; iV = inv(V);

% Initialize extraction vector
VtoE = zeros(2,N);
for j=1:N
  VtoE(1,j) = (j-1)*(m+1)+1; VtoE(2,j) = j*(m+1);
end

% Compute smallest spatial scale timestep
rLGLmin = min(abs(r(1)-r(2))); 
time = 0; tstep = 0;

% Initialize parameters for nonlinear viscosity
nu = zeros(m+1,N); nu0 = 2; kappa = -6; c2 = 1;

% integrate scheme
while (time<FinalTime)
  
  maxvel = 2*max(max(abs(u))); k = CFL*rLGLmin*h/maxvel; 
  if (time+k>FinalTime) k = FinalTime-time; end  

  rhsu  = compute_rhs(x,u,h,k,m,N,Ma,S,VtoE,maxvel,bcl,bclv,bcr,bcrv); 
  u1 = u + k*rhsu;
  
  rhsu  = compute_rhs(x,u1,h,k,m,N,Ma,S,VtoE,maxvel,bcl,bclv,bcr,bcrv);
  u2 = (3*u + u1 + k*rhsu)/4;

  rhsu  = compute_rhs(x,u2,h,k,m,N,Ma,S,VtoE,maxvel,bcl,bclv,bcr,bcrv); 
  u = (u + 2*u2 + 2*k*rhsu)/3;

  time = time+k; tstep = tstep+1;
end

% plot results
plot(linspace(0,FinalTime,length(u_true(end,:))),u_true(end,:))
hold on
plot(linspace(0,FinalTime,length(u(end,:))),u(end,:))
xlabel 'x'
ylabel 'u(x)'
legend 'u_{true}' 'u_h'
grid minor

% compute norm
%norm(u-u_true)
h*norm(u-u_true,1)

function [u] = compute_rhs(x,u,h,k,m,N,Ma,S,VtoE,maxvel,bcl,bclv,bcr,bcrv)
    Imat = eye(m+1); ue = zeros(N+2,2);

    % Extend u for boundary conditions
    [ue] = extendDG(u(VtoE),bcl,bclv,bcr,bcrv);
    
    % Compute numerical fluxes at interfaces
    fluxr = LF_flux(ue(2,2:N+1),ue(1,3:N+2),maxvel); 
    fluxl = LF_flux(ue(2,1:N),ue(1,2:N+1),maxvel);
    
    % Compute right hand side
    ru = S'*(u.^2) - (Imat(:,m+1)*fluxr(1,:) - Imat(:,1)*fluxl(1,:));
    u = (h/2*Ma)\ru;
end

function [f] = LF_flux(u,v,maxvel)
    fu = u.^2; fv = v.^2;
    f = (fu+fv)/2 - maxvel/2*(v-u);    
end
