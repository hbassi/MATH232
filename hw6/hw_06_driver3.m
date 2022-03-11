close all; clear; clc;

% define omega
xmin = -1; xmax = 1;    % x boundary locations
ymin = -1; ymax = 1;    % y boundary locations
k1 = .1; k2 = 1; 

% define rhs and u_exact
rhs = @(x,y) -2*((x.^2-1)+(y.^2-1));
u_e = @(x,y) (x.^2-1).*(y.^2-1);


% create mesh
h = 1/32; detJ = 1/(h^2/4); m = length(xmin:h:xmax); 
[lg,coor,coor_el,ref,N_el,N_i,N_d,N_s] = make_mesh2(xmin,xmax,...
    ymin,ymax,h,k1,k2,1);

% evaluate the local element stiffness and mass matrices
A = zeros(N_el,4,4);
f = zeros(N_el,4);
for k = 1:N_el
    for j = 1:4
        for i = 1:4
            if lg(k,i) ~= 0 && lg(k,j) ~= 0
                A(k,i,j) = abs(detJ)*ref(k)*stiff_int(i,j);
            end  
        end
        if lg(k,j) ~= 0
            f(k,j) = rhs(coor(lg(k,j),1),coor(lg(k,j),2));
        end
    end
end

% assembly linear system
K = spalloc(N_i,N_i,5*N_i);
F = zeros(N_i,1);
for k = 1:N_el
    for i = 1:4
        for j = 1:4
            if lg(k,i) ~= 0 && lg(k,j) ~= 0
                K(lg(k,i),lg(k,j)) = K(lg(k,i),lg(k,j)) + A(k,i,j);
            end
        end
        if lg(k,j) ~= 0
            F(lg(k,j)) = F(lg(k,j)) + f(k,j);
        end
    end
end

% compute sol to our linear system
U = K\F; U = reshape(U,[m-2,m-2]);

% add in boundary nodes
U_complete = zeros(m,m);
U_complete(2:end-1,2:end-1) = U;

% compute exact sol
[XX,YY] = meshgrid(xmin:h:xmax,ymin:h:ymax);
u_exact = u_e(XX,YY);

% % plot exact solution
% figure
% subplot(1,3,1)
% surf(XX,YY,u_exact)
% axis([-1 1 -1 1 0 1.1])
% xlabel 'x'; ylabel 'y'; zlabel 'u'
% title 'Solution: u_{exact}'
% colormap(turbo)

% plot fem solution
% subplot(1,3,2)
surf(XX,YY,U_complete)
axis([-1 1 -1 1 0 1.1])
xlabel 'x'; ylabel 'y'; zlabel 'u'
title 'Solution: k1=10, k2=1'
colormap(turbo)

% % plot error contour
% subplot(1,3,3)
% contourf(XX,YY,abs(U_complete-u_exact))
% colorbar
% xlabel 'x'; ylabel 'y'; 
% title 'Error at Nodes: abs((u_{exact}-u_{FEM}))'
% colormap(turbo)
% 
% % compute discrete L^2 norm
% err = norm(reshape(abs(U_complete-u_exact)*h,[m*m,1]));
