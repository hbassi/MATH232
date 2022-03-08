close all; clear; clc;

% define omega
xmin = -1; xmax = 1;    % x boundary locations
ymin = -1; ymax = 1;    % y boundary locations

% create mesh
h = 1/2;
[Xmesh,Ymesh,lg,coor,ref,N_el,N_i,N_d,N_s] = make_mesh(xmin,xmax,...
    ymin,ymax,h,1);