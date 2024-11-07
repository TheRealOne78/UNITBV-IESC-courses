t=1:1000;
A=3;
omega=0.01;
phi=0;
x = A * sin(omega*t + phi);

E = sum(x .^ 2);

figure;
plot(t, E);
