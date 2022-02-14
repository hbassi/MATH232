close all
clear
clc


h = 0.25;

A = (1/h^2)*[-h h 0 0 0;
    1 -2 1 0 0;
    0 1 -2 1 0;
    0 0 1 -2 1;
    0 0 0 0 h^2;];

B = zeros(5);

% compute inv(A)
for i = 1:5
    B(i,1) = ((i-1)/4-1);
end

for i = 1:5
    for j = 2:4
        if i < j
            B(i,j) = h*((j-1)/4-1);
        else
            B(i,j) = h*((i-1)/4-1);
        end
    end
end

for i = 1:5
    B(i,5) = 1;
end

A*B