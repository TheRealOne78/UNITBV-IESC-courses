% 1. Parametri
N = 100;             % Numărul de puncte
omega = 0.05;        % Frecvența dorită

% 2. Generarea semnalelor de intrare
% Impuls Dirac
impuls_dirac = zeros(1, N);
impuls_dirac(1) = 1;

% Semnal dinte de fierăstrău
t = linspace(0, 2*pi, N);
sawtooth_signal = sawtooth(omega * t);

% 3. Definirea filtrului
% Filtru Butterworth trece-jos de ordin 2, cu frecvența de tăiere 0.1 (arbitrar ales)
[b, a] = butter(2, 0.1);

% 4. Aplicarea filtrului în domeniul frecvenței
% a) Filtrare pentru impuls Dirac
filtered_impulse = filter(b, a, impuls_dirac);

% b) Filtrare pentru semnalul dinte de fierăstrău
filtered_sawtooth = filter(b, a, sawtooth_signal);

% 5. Vizualizarea rezultatelor
figure;
subplot(2, 2, 1);
stem(impuls_dirac);
title('Impuls Dirac - Intrare');
xlabel('Samples');
ylabel('Amplitude');

subplot(2, 2, 2);
plot(filtered_impulse);
title('Impuls Dirac - După Filtrare');
xlabel('Samples');
ylabel('Amplitude');

subplot(2, 2, 3);
plot(t, sawtooth_signal);
title('Dinte de Fierăstrău - Intrare');
xlabel('Time');
ylabel('Amplitude');

subplot(2, 2, 4);
plot(t, filtered_sawtooth);
title('Dinte de Fierăstrău - După Filtrare');
xlabel('Time');
ylabel('Amplitude');
