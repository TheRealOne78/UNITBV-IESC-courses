N = 100;
t = 1:N;
A = 4;
omega = 0.1;
phi = 0;

x = A * sin(omega * t + phi);

x = x + rand(1, N);

figure;
stem(x);
