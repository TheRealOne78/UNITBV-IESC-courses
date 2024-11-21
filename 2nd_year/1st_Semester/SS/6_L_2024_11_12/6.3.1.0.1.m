N = 512;
omega = 0.1;
t = 1 : N;
x = 0.25*sin(omega*t) + 0.5*sin(2*omega*t+10)...
+ 1*sin(4*omega*t) + 1.5*sin(5*omega*t+25);
%figure;
%plot(t, x);

X = fftshift(fft(x));
%figure;
%subplot(3,1,1),bar(abs(X));

H = zeros(1,N);
P = 20;
H(N/2 + 1 - P : N/2 + 1 + P) = 1;
%subplot(3,1,2),bar(abs(H));

Y = H.*X;
%subplot(3,1,3),bar(abs(Y));
%ylim([0 max(abs(X))]);

y = ifft(fftshift(Y));
% figure;
% plot(t, y);

H = zeros(1,N);
P = 20;
H(N/2 + 1 - P : N/2 + 1 + P) = 1;

h = fftshift(ifft(fftshift(H)));
figure;
plot(t, h);

L = 7;
t_es = (N/2 + 1 - L) : (N/2 + 1 + L);
h_es = h(t_es);
hold on;
stem(t_es, h_es);
hold off;
h_es = (1/sum(h_es)).*h_es;

y = filter(h_es,1,x);
figure;
plot(t, y);

X = fftshift(fft(x));
figure;
subplot(3,1,1),bar(abs(X));
H_es = fftshift(fft(h_es,N));
subplot(3,1,2),bar(abs(H_es));
Y = fftshift(fft(y));
subplot(3,1,3),bar(abs(Y));
ylim([0 max(abs(X))]);
