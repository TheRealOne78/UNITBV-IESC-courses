L = 100;                % Lățimea impulsului triunghiular
c = 150;                % Centrul impulsului
t = 0:1:300;            % Vector de timp (exemplu: 0 la 300 eșantioane)

Lambda = zeros(size(t)); % Semnalul este inițial zero

for i = 1:length(t)
    if t(i) >= c - L/2 && t(i) <= c + L/2
        Lambda(i) = 1 - (2 * abs(t(i) - c) / L);
    end
end

plot(t, Lambda, 'b', 'LineWidth', 2);
grid on;
