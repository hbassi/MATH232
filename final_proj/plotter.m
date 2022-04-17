close all
loglog([1000 2000 4000 8000],[2.37417e-01 1.42473e-01 7.94077e-02 4.21726e-02])
hold on
loglog([1000 2000 4000 8000],[6.90751e-03 1.72228e-03 4.30219e-04 1.07557e-04])
loglog([1000 2000 4000 8000],[3.06470e-01 1.94113e-01 1.12615e-01 6.13476e-02])
loglog([1000 2000 4000 8000],1e3*[1/1000 1/2000 1/4000 1/8000])
loglog([1000 2000 4000 8000],1e3*[1/1000^2 1/2000^2 1/4000^2 1/8000^2])

legend 'Upwinding' 'LW' 'LF' '1^{st} Order' '2^{nd} Order'
xlabel 'number of grid points'
ylabel 'max error'
title 'Scalar Advection Equation Errors'
grid minor

