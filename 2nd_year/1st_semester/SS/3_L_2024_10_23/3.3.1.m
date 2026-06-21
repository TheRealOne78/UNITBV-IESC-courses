N = 100;
k = N/2;
x = zeros(1, N);
x(k) = 1;
X = fft(x);
w = -pi : (2*pi)/N : pi - (2*pi)/N;
figure;
plot(w, abs(fftshift(X)));
