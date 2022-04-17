nodes = [10,20,30,40,50,60,70,80,90,100];
errs = 1.0e-03 * [0.1184    0.0327    0.0150    0.0086    0.0056    0.0039    0.0029    0.0022    0.0017    0.0014];
loglog(nodes,errs)
hold on 
sl2 = @(x) x.^(-2);
ys2 = sl2(nodes);
loglog(nodes,ys2)
hold off
xlabel('nodes')
ylabel('error')
title('loglog of error vs mesh width')
legend('FD method', 'slope -2')
saveas(gcf,'refine.png')