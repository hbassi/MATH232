function [lg,coor,coor_el,ref,N_el,N_i,N_d,N_s] = make_mesh2(xmin,...
    xmax,ymin,ymax,h,k1,k2,show)
%MAKE_MESH Summary of this function goes here
%   Detailed explanation goes here

[Xmesh,Ymesh] = meshgrid(xmin:h:xmax,ymin:h:ymax);

xgrid = xmin:h:xmax;    xint = xgrid(2:end-1);
ygrid = ymin:h:ymax;    yint = ygrid(2:end-1);

m = length(xgrid);
n = length(ygrid);

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
        
        lg(i+(j-1)*(m-1),1) = i+(j-2)*(m-2)-1;
        lg(i+(j-1)*(m-1),2) = i+(j-2)*(m-2);
        lg(i+(j-1)*(m-1),3) = i+(j-1)*(m-2);
        lg(i+(j-1)*(m-1),4) = i+(j-1)*(m-2)-1;
            
        if (xgrid(i) == xmin)
            lg(i+(j-1)*(m-1),1) = 0;
            lg(i+(j-1)*(m-1),4) = 0;
        end
        
        if (xgrid(i+1) == xmax)
            lg(i+(j-1)*(m-1),2) = 0;
            lg(i+(j-1)*(m-1),3) = 0;
        end
        
        if (ygrid(j) == ymin)
            lg(i+(j-1)*(m-1),1) = 0;
            lg(i+(j-1)*(m-1),2) = 0;
        end
        
        if (ygrid(j+1) == ymax)
            lg(i+(j-1)*(m-1),3) = 0;
            lg(i+(j-1)*(m-1),4) = 0;
        end
    end
end

% create coordinate matrix
coor = zeros(N_i,2);
for j = 1:n-2
    for i = 1:m-2
        coor(i+(j-1)*(m-2),1) = xint(i);
        coor(i+(j-1)*(m-2),2) = yint(j);

    end
end

% create coordinate element matrix
coor_el = zeros(N_el,2);
for j = 1:n-1
    for i = 1:m-1
        coor_el(i+(j-1)*(m-1),1) = xgrid(i)+h/2;
        coor_el(i+(j-1)*(m-1),2) = ygrid(j)+h/2;
    end
end


% create ref matrix
ref = k1*ones(N_el,1);

for i = round(N_el/2)+1:N_el
    ref(i) = k2;
end

