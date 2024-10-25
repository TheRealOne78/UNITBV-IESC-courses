A = 2;
A_y = 2;
omega_1 = 0.02;
omega_2 = 0.04;
phi = 0;
t = 1:600;
x = A*sin(omega_1*t+phi);
y = A_y*sin(omega_2*t+phi);
z = x + y
figure;

subplot(3, 1, 1);
plot(t, x);
subplot(3, 1, 2);
plot(t, y);
subplot(3, 1, 3);
plot(t, z);
