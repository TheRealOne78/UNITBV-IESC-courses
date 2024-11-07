N = 100;
t = 1:N;
A = 4;
omega = 0.1;
phi = 0;

x = A * (mod(t * omega + phi, 2 * pi) / pi - 1);

L = 2;
xu = zeros(1, L*N);

for n = 1:L:(L*N)

end

figure;
stem(x);
