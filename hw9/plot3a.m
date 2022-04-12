close all
loglog([100 200 400 800 1600],[5.97008e-02 1.67125e-02 4.27121e-03 1.07177e-03 2.68415e-04])
hold on
loglog([100 200 400 800 1600],1e3*[1/100^2 1/200^2 1/400^2 1/800^2 1/1600^2])

legend 'LW' '2^{nd} Order'
xlabel 'number of grid points'
ylabel 'max error'
grid minor

