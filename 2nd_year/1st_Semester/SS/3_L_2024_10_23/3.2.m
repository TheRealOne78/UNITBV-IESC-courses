N = 300;
t = 1:N;
omega = 0.2;
x = cos(omega*t);
X = fft(x);
w = -pi : (2*pi)/N : pi - (2*pi)/N;
figure;
plot(w, abs(fftshift(X)));
