N = 100;
x = ones(1, N);
X = fft(x);
w = -pi : (2*pi)/N : pi - (2*pi)/N;
figure;
plot(w, abs(fftshift(X)));
