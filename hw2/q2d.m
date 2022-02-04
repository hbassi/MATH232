close all

% run bvp_2_p2d fist to generate the A1 - A5 matrices.
eig_A1 = eig(full(A1));
eig_A2 = eig(full(A2));
eig_A3 = eig(full(A3));
eig_A4 = eig(full(A4));
eig_A5 = eig(full(A5));

% compute min eig(As)
eA_vec = [min(abs(eig_A1)),min(abs(eig_A2)),min(abs(eig_A3)),min(abs(eig_A4)),min(abs(eig_A5))];

figure 
semilogy(1./m1vals,eA_vec)
xlabel 'h'
ylabel 'min(|\lambda_A|)'
grid minor

% compute norm(As)
nA_vec = [norm(inv(full(A1))),norm(inv(full(A2))),norm(inv(full(A3))),norm(inv(full(A4))),norm(inv(full(A5)))];

figure 
semilogy(1./m1vals,nA_vec)
xlabel 'h'
ylabel '||(A)^{-1}||_2'
grid minor