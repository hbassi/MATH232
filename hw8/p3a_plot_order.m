close all
loglog([100 200 400 800 1600],[4.11536e-1 1.72731e-1 4.46889e-2 1.08753e-2 2.69569e-3])
hold on
loglog([100 200 400 800 1600],1e3*[1/100^2 1/200^2 1/400^2 1/800^2 1/1600^2])

legend 'Leapfrog' '2^{nd} Order'
xlabel 'number of grid points'
ylabel 'max error'
grid minor

