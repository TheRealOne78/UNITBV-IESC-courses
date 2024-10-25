N = 300;
t = 1:N;
x = zeros(1, N);
x(20:80) = 1;
X = fft(x);
w = -pi : (2*pi)/N : pi - (2*pi)/N;
figure;
plot(t, x);
#plot(w, abs(fftshift(X)));
