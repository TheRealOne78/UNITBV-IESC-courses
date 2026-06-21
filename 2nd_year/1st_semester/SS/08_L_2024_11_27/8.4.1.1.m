N = 1000;
t = 1 : N;
omega = 0.01;
xi = sin(omega*t);
%figure;
%plot(xi);

L = 8;
Delta = (max(xi) - min (xi))/ L;

x(1) = min(xi);
x(L+1) = max(xi);

i = 2:L;
x(2:L) = min(xi) + (i-1) * Delta;

for i=1:L
  y(i) = (x(i) + x(i+1))/2;
end

for j = 1 : N
  for i = 1 : L
    if xi(j) >= x(i) && xi(j) <= x(i+1)
      eta(j) = y(i);
    end
  end
end

figure;
plot(eta);

figure;
plot (xi, eta, '*');
