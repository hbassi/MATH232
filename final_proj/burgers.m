function [u] = burgers(x,u,h,k,tfinal,m)
t = 0; tstep = 0;
while(t < tfinal)
    if (t+k>tfinal) 
        k = tfinal-t;
    end
    u = u + k*burgers_rhs(x,u,h,k);
    t = t+k;
    tstep = tstep + 1;
end
return