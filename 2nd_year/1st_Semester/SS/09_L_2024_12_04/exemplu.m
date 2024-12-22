pkg load signal;

% Parametri semnal
fs = 44100; % Frecvența de eșantionare (Hz) - standard audio
duration = 10;
f = 440; % Frecvența semnalului (Hz) - La (A4) standard
A = 0.5; % Amplitudinea semnalului

% Timp discret
t = 0:1/fs:duration;

% Semnal sinusoidal
x = A * sin(2 * pi * f * t);

y = A * sawtooth(2 * pi * f * t); % Semnal de tip dinte de fierăstrău (perioadă completă)

% Redare audio
sound(x, fs);

sound(y, fs);
