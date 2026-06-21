m = 3;
sigma = 2;
N = 1000;

eta = rand(1,N);
xi = rand(1,N);

u = m + sigma*sqrt(3)*(2*xi-1);
g = m + sigma*sqrt(-2*log(xi)).*cos(2*pi*eta);
r = m + sigma*sqrt(-2*log(xi));

mean(u)
mean(g)
mean(r)
