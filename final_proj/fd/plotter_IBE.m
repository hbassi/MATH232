close all
loglog([128 512 2048 8192],[0.0110  0.0027 6.9318e-04 1.6856e-04])
hold on
loglog([128 512 2048 8192],[0.0072 0.0011 4.1909e-04 7.4202e-05])
loglog([128 512 2048 8192],[0.0055 0.0013 3.5274e-04 8.4549e-05])
%loglog([1000 2000 4000 8000],[3.06470e-01 1.94113e-01 1.12615e-01 6.13476e-02])
loglog([128 512 2048 8192],1e2*[1/128 1/512 1/2048 1/8192])
%loglog([1000 2000 4000 8000],1e3*[1/1000^2 1/2000^2 1/4000^2 1/8000^2])

legend 'LF' 'LW' 'UP' '1^{st} Order' 
xlabel 'number of grid points'
ylabel '||.||'
title 'Inviscid Burgers Equation Errors'
grid minor

