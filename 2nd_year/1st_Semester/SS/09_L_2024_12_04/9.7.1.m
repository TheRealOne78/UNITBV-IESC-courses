% Parametri
A = 4; % amplitudinea
omega = 0.05; % frecvența unghiulară
phi = 0; % faza
N = 1000; % număr de eșantioane
p_values = [1, 2, 3, 5]; % valori pentru parametrul p

% Timp discret
t = linspace(0, 100, N);

% Semnal sinusoidal
x = A * sin(omega * t + phi);

% Adăugare zgomot
noise = 0.5 * randn(1, N); % zgomot gaussian
x_noisy = x + noise;

% Reprezentare spațiu al stărilor pentru diferite p
figure;
for i = 1:length(p_values)
    p = p_values(i);
    subplot(2, 2, i);
    plot(x_noisy(1:end-p), x_noisy(p+1:end), '.');
    title(['Diagrama în spațiul stărilor pentru p = ', num2str(p)]);
    xlabel(['x(t)']);
    ylabel(['x(t + p)']);
end

% Calcul funcție de autocorelație înainte și după zgomot
autocorr_original = xcorr(x, 'biased');
autocorr_noisy = xcorr(x_noisy, 'biased');

% Afișare grafic autocorelație
figure;
subplot(2, 1, 1);
plot(-N+1:N-1, autocorr_original);
title('Funcția de autocorelație - Semnal original');
xlabel('Lag');
ylabel('Autocorelație');

subplot(2, 1, 2);
plot(-N+1:N-1, autocorr_noisy);
title('Funcția de autocorelație - Semnal cu zgomot');
xlabel('Lag');
ylabel('Autocorelație');
