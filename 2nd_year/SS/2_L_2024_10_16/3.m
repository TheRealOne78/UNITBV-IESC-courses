t = 1:2000;

A_x = 1;
omega_x = 0.01;
phi_x = 0;
x = A_x * sin(omega_x * t + phi_x);

A_y = 1;
omega_y = 0.1;
phi_y = 0;
y = A_y * cos(omega_y * t + phi_y);

k = 2

z = (1 + k * x) .* y

figure;
subplot(3, 1, 1)
plot(t, x);

subplot(3, 1, 2)
plot(t, y);

subplot(3, 1, 3)
plot(t, z);
