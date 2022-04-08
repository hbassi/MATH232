close all
loglog([100 200 400 800 1600],[1.00443e0 1.34983e0 4.07863e-1 1.033773e-1 2.6e-2])
hold on
loglog([100 200 400 800 1600],1e3*[1/100^2 1/200^2 1/400^2 1/800^2 1/1600^2])

legend 'Leapfrog' '2^{nd} Order'
xlabel 'number of grid points'
ylabel 'max error'
grid minor

