pkg load signal;

N = 80;
omega = 2 * pi;
t = 1:N;
%x = sin(omega*t) + 0.5*sin(2*omega*t+10) + 0.25*sin(3*omega*t+30);
x = sawtooth(t);

% Te = floor( 2*pi / (6*omega) );
Te = 2*pi / omega_e;
t_es = 1:Te:N;
x_es = x( t_es );
hold on;
stem( t_es, x_es );

for i = 1:N
  s = 0;
  for k = 1:length( t_es )
    s = s + x_es(k) * sinc(((omega_e / 2) * (i-t_es(k)))/pi);
  end;
  x_rec(i) = s;
end;
plot( t, x_rec, 'r-' );
