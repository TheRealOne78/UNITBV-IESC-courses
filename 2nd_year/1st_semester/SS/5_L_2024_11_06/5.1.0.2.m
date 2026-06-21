N = 100;
y = zeros(1,N);
for n = 1:N
  for k = 1:n
    y(n) = y(n) + x(k);
  end
end

figure;
stem(y);
