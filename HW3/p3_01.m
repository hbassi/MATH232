close all
clear
clc

% define grid
t0 = 0;
tf = 2*pi;
m = 1e4;
h = (tf-t0)/(m+1);
t = (1:1:m)*h;
t=t';

% define init conditions
alpha = 0.7;
beta = 0.7; 

% initialize G, J, theta, theta_0
G = zeros(m,1);
delta = zeros(m,1);


% generate initial guess
theta = 0.7*cos(t);

% start iterations
k_lim = 100;
err = zeros(k_lim,1);
err_tol = 1e-12;

for k = 1:k_lim

    % update G
    for i = 1:m
        if i == 1
            G(1) = (alpha-2*theta(i)+theta(i+1))/h^2+sin(theta(i));
        elseif i == m
            G(m) = (beta-2*theta(i)+theta(i-1))/h^2+sin(theta(i));
        else
            G(i) = (theta(i+1)-2*theta(i)+theta(i-1))/h^2+sin(theta(i));
        end
    end

    % update J
    J_diag = -2+h^2*cos(theta);
    J = spdiags([ones(m,1) J_diag ones(m,1)], -1:1, m, m)/h^2;

    % solve linear system
    delta = -J\G;
    err(k) = norm(delta,inf);
    theta = theta + delta;

    if err(k) < err_tol
        k_lim = k;
        break
    end
end

figure
semilogy(1:k_lim,err(1:k_lim))
xlabel 'iteration'
ylabel '||\theta^{k+1}-\theta^k||'
grid

figure
plot(t,theta)
xlabel 't'
ylabel '\theta'
grid minor

