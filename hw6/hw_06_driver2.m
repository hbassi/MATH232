close all; clear; clc;

% define omega
xmin = -1; xmax = 1;    % x boundary locations
ymin = -1; ymax = 1;    % y boundary locations
k1 = 1;
k2 = 1; 
rhs = @(x,y) -2*((x.^2-1)+(y.^2-1));
u_e = @(x,y) (x.^2-1).*(y.^2-1);


% create mesh
h = 1/20;

[lg,coor,coor_el,ref,N_el,N_i,N_d,N_s] = make_mesh2(xmin,xmax,...
    ymin,ymax,h,k1,k2,0);

detJ = 1/(h^2/4);

m = length(xmin:h:xmax);

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
            %f(k,j) = mass_int2(rhs,j,coor(lg(k,j),1),coor(lg(k,j),2),h);
        end
    end
end

% assembly linear system
K = sparse(N_i,N_i);
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


U = K\F;
U = reshape(U,[m-2,m-2]);
U_complete = zeros(m,m);
U_complete(2:end-1,2:end-1) = U;

[XX,YY] = meshgrid(xmin:h:xmax,ymin:h:ymax);
u_exact = u_e(XX,YY);

surf(XX,YY,U_complete)



figure
contourf(abs(U_complete-u_exact))
colorbar

err = reshape(abs(U_complete-u_exact),[m*m,1]);
norm(err)
