function [flux] = burgers_LF(u,v,maxvel)

flux = (u.^2 + v.^2) / 2;
flux = flux - maxvel*(v-u);

end