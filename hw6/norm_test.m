close all
x = [1/4, 1/8, 1/16, 1/32, 1/64, 1/128];
y = [2.7856e-02, 6.8991e-03, 1.7206e-03, 4.2989e-04, 1.0746e-04, 2.6863e-05];

loglog(1./x,y)
hold on
loglog([4,128],[1/4^2,1/128^2])
legend '||u_{exact}-u_{FEM}||_2' '2^{nd} Order'
xlabel 'grid spacing (h)'
ylabel 'Error'
grid minor