function [flux] = burgers_LF(u,v)

flux = (u.^2 + v.^2) / 2;

end