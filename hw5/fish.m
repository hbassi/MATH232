function [err] = fish(a,b,c,d,m,n,f)

hx = (b-a)/(m+1);
hy = (d-c)/(n+1);

x = linspace(a,b,m+2);
y = linspace(c,d,n+2);

[X,Y] = meshgrid(x,y);
X = X';
Y = Y';

Iint = 2:m+1;
Jint = 2:n+1;

Xint = X(Iint,Jint);
Yint = Y(Iint,Jint);

rhs = f(Xint,Yint);

utrue = exp(X+Y/2);
usoln = utrue;
                   
% adjust the rhs to include boundary terms:
rhs(:,1) = rhs(:,1) - usoln(Iint,1)/hx/hy;
rhs(:,n) = rhs(:,n) - usoln(Iint,n+2)/hx/hy;
rhs(1,:) = rhs(1,:) - usoln(1,Jint)/hx/hy;
rhs(m,:) = rhs(m,:) - usoln(m+2,Jint)/hx/hy;

F = reshape(rhs,m*n,1);

% form matrix A:
Ix = speye(m);
ex = ones(m,1);
T = spdiags([ex -4*ex ex],[-1 0 1],m,m);

Iy = speye(n);
ey = ones(n,1);
S = spdiags([ey ey],[-1 1],n,n);

A = (kron(Iy,T) + kron(S,Ix)) / (hx * hy);

% Solve the linear system:
uvec = A\F;  

usoln(Iint,Jint) = reshape(uvec,m,n);

% assuming true solution is known and stored in utrue:
err = max(max(abs(usoln-utrue)));

end

