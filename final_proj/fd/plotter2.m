close all
loglog([1000 2000 4000 8000],[2.37417e-01 1.42473e-01 7.94077e-02 4.21726e-02])
hold on
%loglog([100 200 400 800 1600],[3.39881e-01 1.53083e-01 4.32736e-02 1.08134e-02 2.69265e-03])
%loglog([100 200 400 800 1600],[7.07732e-01 6.04128e-01 4.79774e-01 3.47477e-01 2.27245e-01])
loglog([1000 2000 4000 8000],1e3*[1/1000 1/2000 1/4000 1/8000])
%loglog([100 200 400 800 1600],1e3*[1/100^2 1/200^2 1/400^2 1/800^2 1/1600^2])

legend 'Upwinding' 'LW' 'LF' '1^{st} Order' '2^{nd} Order'
xlabel 'number of grid points'
ylabel 'max error'
title 'Scalar Advection Equation Errors'
grid minor

