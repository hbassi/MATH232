function [u] = burgers(x,u,h,CFL,tfinal)
t = 0; tstep = 0;
while(t < tfinal)
    mv = max(2*abs(u)); k = CFL*h/mv;
    if (t+k>tfinal) 
        k = tfinal-t;
    end
    u = u + k*burgers_rhs(x,u,h,k,mv);
    t = t+k;
    tstep = tstep + 1;
end
return