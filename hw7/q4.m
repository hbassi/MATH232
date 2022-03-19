errs = [];
hs = [];
for i=10:10:100
    [h,k,error] = heat_FE(i);
    errs = [errs error];
    hs = [hs h];
end
clf
figure
loglog(1./hs,errs)
hold on
loglog([10,100],[1/10^2,1/100^2])
legend 'FE' '2^{nd} Order'
xlabel 'grid spacing (h)'
ylabel 'Error'
title 'loglog error at T = 1'
grid minor
saveas(gcf, '4.png')
