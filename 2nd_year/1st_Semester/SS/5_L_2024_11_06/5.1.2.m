N = 100;
x = rand(1,N);
x(N/2) = 1;

y(1) = x(1);
for n = 2:N
  y(n) = y(n-1) + x(n);
end

figure;
stem(y);
