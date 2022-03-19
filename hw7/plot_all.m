errscn = [];
hscn = [];
errsfe = [];
hsfe = [];
errstr = [];
hstr = [];
for i=10:10:100
    [hfe,k,errorfe] = heat_FE(i);
    [hcn,k,errorcn] = heat_CN(i);
    [htr,k,errortr] = heat_trbdf2(i);
    errstr = [errstr errortr];
    hstr = [hstr htr];
    errscn = [errscn errorcn];
    hscn = [hscn hcn];
    errsfe = [errsfe errorfe];
    hsfe = [hsfe hfe];
end
clf
figure
loglog(1./hscn,errscn)
hold on
loglog(1./hsfe,errsfe)
loglog(1./hstr,errstr)
loglog([10,100],[1/10^2,1/100^2])
legend 'CN' 'FE' 'TRBDF-2' '2^{nd} Order'
xlabel 'grid spacing (h)'
ylabel 'Error'
title 'loglog error at T = 1'
grid minor
saveas(gcf, 'comp.png')

