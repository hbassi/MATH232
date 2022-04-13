close all
clear

loglog([0.001 0.025 0.05 0.1 0.2 0.4],[3.25376e-1 3.20917e-1 3.16176e-1 3.06389e-1 2.85483e-1 2.37417e-1])

xlabel 'k/h'
ylabel 'max error'
grid minor
legend 'Upwinding' '1^{Order}'