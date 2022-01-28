hvals = logspace(-1, -4, 13);
u = @(x) sin(2*x);
exact = -4*sin(2);
errs = [];
disp(' ')
disp('       h                 err                 pred err')
for i=1:length(hvals)
    approx = (-8.333333333333333e-02*u(1-2*hvals(i)) + 1.333333333333333e+00*u(1-hvals(i)) + -2.500000000000000e+00*u(1) +  1.333333333333333e+00 * u(1+hvals(i)) +   -8.333333333333333e-02 * u(1+2*hvals(i)))/(hvals(i)^2);
    err = abs(approx-exact);
    errs = [errs err];
    fprintf('%13.4e   %13.4e   %13.4e\n', hvals(i) ,err, -0.0111111 * hvals(i)^4*-64*sin(2))
end

loglog(hvals, errs)
hold on 
sl4 = @(x) x.^(4);
ys4 = sl4(hvals);
loglog(hvals, ys4);
xlabel('h')
ylabel('error')
title('loglog error vs h')
legend('FD error', 'slope -4')
saveas(gcf,'2c.png')