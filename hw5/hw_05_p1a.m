close all; clear; clc;

a = 0; 
b = 1; 
c = 0;
d = 2;
m = 30;
n = 61;
f = @(x,y) 1.25*exp(x+y/2);

err = fish(a,b,c,d,m,n,f)

for k = 1:100
    m = k*2;
    n = m*2+1;

    err(k) = fish(a,b,c,d,m,n,f);

end

%delta x = delta y
figure
loglog(4*(1:100),err)
hold on
loglog([4,400],[.4 (.004)^2])
legend '\Delta y \eq \Delta x' '2^{nd} Order'
grid minor
ylabel '||u_{approx}-u_{true}||'
xlabel 'grid points (m*n)'

for k = 1:100
    m = k*2;
    n = m*2;

    err(k) = fish(a,b,c,d,m,n,f);

end

%delta x \neq delta y
figure
loglog(4*(1:100),err)
hold on
loglog([4,400],[.4 .004])
legend '\Delta y \neq \Delta x' '1^{st} Order'
grid minor