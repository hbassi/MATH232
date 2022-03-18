close all
x = [0.1, 0.05, 0.033, 0.025, 0.02, 0.016666666666667];
y = [0.004276119684525, 8.316315341074798e-04, 2.632708207738477e-04, 1.571087816480202e-04, 9.709087164484764e-05,7.020216074245939e-05];

loglog(1./x,y)
hold on
loglog([10,60],[1/10^2,1/60^2])
legend '||u_{exact}-u_{CN}||_2' '2^{nd} Order'
xlabel 'grid spacing (h)'
ylabel 'Error'
title 'loglog error at T = 1'
grid minor
