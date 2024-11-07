N = 100;

x = zeros(1, N);
x(N/2:N) = 1;

for n = 2:N
  y(n) = x(n) - x(n-1);
end

figure;
stem(x);

figure;
stem(y);
title('Y');
