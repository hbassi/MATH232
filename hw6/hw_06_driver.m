close all; clear; clc;

% define omega
xmin = -1; xmax = 1;    % x boundary locations
ymin = -1; ymax = 1;    % y boundary locations

f = @(x,y) -2*((x.^2-1)+(y.^2-1));
u_final = @(x,y) (x.^2-1).*(y.^2-1);


% create mesh
h = 1/20;
[Xmesh,Ymesh,lg,coor,ref,N_el,N_i,N_d,N_s] = make_mesh(xmin,xmax,...
    ymin,ymax,h,0);

% assembly linear system
A = speye(N_s);
F = zeros(N_s,1);

for i = 1:4
    for j = 1:4
        for K = 1:N_el
            A(lg(K,i),lg(K,j)) = A(lg(K,i),lg(K,j)) + stiff_int(i,j)*4/h^2;
            F(lg(K,j)) = F(lg(K,j)) + mass_int(j,f,coor(lg(K,i),1),coor(lg(K,i),2))/2.95;
        end
    end
end

m = length(xmin:h:xmax);
n = length(ymin:h:ymax);

for i = 1:m
    A(i,:) = 0;
    A(i,i) = 1;
    F(i) = 0;

    A(N_s-i+1,:) = 0;
    A(N_s-i+1,N_s-i+1) = 1;
    F(N_s-i+1) = 0;
end


for i = 2:n-1
    A((i-1)*m+1,:) = 0;
    A((i-1)*m+1,(i-1)*m+1) = 1;
    F((i-1)*m+1) = 0;

    A(i*m,:) = 0;
    A(i*m,i*m) = 1;
    F(i*m) = 0;
end

U = A\F;

final = reshape(U,[m,n]);
uf = u_final(Xmesh,Ymesh);

figure
mesh(Ymesh,Xmesh,final,'FaceAlpha', 0.5)
xlabel 'x'
ylabel 'y'
zlabel 'u'
colorbar

figure
mesh(Ymesh,Xmesh,u_final(Xmesh,Ymesh))
colorbar

figure
contourf(Ymesh,Xmesh,abs(final-u_final(Xmesh,Ymesh)))
colorbar