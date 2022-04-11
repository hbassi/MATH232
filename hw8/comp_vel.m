close all
clear
clc

a = 2;
beta = 100;
xi = 100;
h = 0.0050;
nu = 0.8000;

dw = (a*cos(xi*h))/sqrt(1-nu*(sin(xi*h)^2))

