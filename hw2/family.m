f = @(x) cos(x);
g = @(x) 2*cos(x);
h = @(x) 1/2 *cos(x);
a = @(x) 3 * cos(x);
b = @(x) -cos(x);

xs = linspace(0,pi);
hold on
plot(xs, f(xs))
plot(xs, g(xs))
plot(xs, h(xs))
plot(xs, a(xs))
plot(xs, b(xs))
hold off
legend('$\alpha$ = 1, $\beta$ = -1', '$\alpha$ = 2, $\beta$ = -2','$\alpha$ = $\frac{1}{2}$, $\beta$ = -$\frac{1}{2}$','$\alpha$ = 3, $\beta$ = -3','$\alpha$ = -1, $\beta$ = 1','Interpreter', 'latex')
xlabel('x')
ylabel('y')
xlim([0,pi])
title('Family of cosine solutions')
saveas(gcf,'family.png')