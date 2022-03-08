function [Xmesh,Ymesh,lg,coor,ref,N_el,N_i,N_d,N_s] = make_mesh(xmin,...
    xmax,ymin,ymax,h,show)
%MAKE_MESH Summary of this function goes here
%   Detailed explanation goes here

[Xmesh,Ymesh] = meshgrid(xmin:h:xmax,ymin:h:ymax);
m = length(xmin:h:xmax);
n = length(ymin:h:ymax);

N_el = (n-1)*(m-1);
N_i = (n-2)*(m-2);
N_d = 2*n+2*(m-2);
N_s = n*m;

% --- show mesh ---
if show == 1

    mesh(Xmesh,Ymesh,zeros(n,m),...
        'FaceAlpha', 0.1);
    xlabel 'x'
    ylabel 'y'
    zlabel 'u'

end


% create connectivity matrix
% --- Note: lg(i,j) // ith element, jth dof 
lg = zeros(N_el,4);
for j = 1:n-1
    for i = 1:m-1
        lg(i+m*(j-1)-(j-1),1) = i+m*(j-1);
        lg(i+m*(j-1)-(j-1),2) = i+1+m*(j-1);
        lg(i+m*(j-1)-(j-1),3) = i+m*j;
        lg(i+m*(j-1)-(j-1),4) = i+1+m*j;
    end
end

% create coordinate matrix
coor = zeros(N_s,2);
for j = 1:n
    for i = 1:m
        coor(i+m*(j-1),1) = Ymesh(i,j);
        coor(i+m*(j-1),2) = Xmesh(i,j);

    end
end

% create ref matrix
ref = ones(N_el,1);

for i = round(N_el/2):N_el
    ref(i) = 2;
end

