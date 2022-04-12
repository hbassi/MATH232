close all
loglog([100 200 400 800 1600 3200],[5.83047e-01 4.56845e-01 3.25414e-01 2.09275e-01  1.22889e-01 6.74727e-02])
hold on
loglog([100 200 400 800 1600 3200],1e3*[1/100 1/200 1/400 1/800 1/1600 1/3200])

legend 'Upwinding' '1^{st} Order'
xlabel 'number of grid points'
ylabel 'max error'
grid minor

