function [flux] = burgers_up(u,v,maxvel)

flux = (u.^2 + v.^2)/2 - maxvel*(v-u);

end