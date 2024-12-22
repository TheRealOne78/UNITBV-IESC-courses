%dreapta de regresie
N = 200;
x = rand(1, N);
y = 2*x + (1/3)*rand(1, N);
figure, plot(x, y, '.');
Sx = sum(x)/N;
Sy = sum(y)/N;
Sxx = sum(x.*x)/N;
Syy = sum(y.*y)/N;
Sxy = sum(x.*y)/N;
%panta dreptei de regresie
a = (Sxy-Sx*Sy)/(Sxx-Sx*Sx);
b = Sy-a*Sx;
%calculam punctele dreptei
xd = sort(x); yd = a*xd+b;
%trasam dreapta de regresie
hold on; plot(xd, yd, 'r'), hold off;
%eroarea de aproximare
corcoef = (Sxy-Sx*Sy) / sqrt((Sxx-Sx*Sx)*(Syy-Sy*Sy));
e = (Syy-Sy*Sy)*(1-corcoef^2);
fprintf('coeficientul de corelatie este=%d ', corcoef);
fprintf(' erorea este= %d', e);
