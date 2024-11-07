N = 100;

x = zeros(1, N);
x(N/2:N) = 1;

tic;
for n = 2:N
  y(n) = x(n) - x(n-1);
end
toc

figure;
stem(x);

figure;
stem(y);
title('Y');
