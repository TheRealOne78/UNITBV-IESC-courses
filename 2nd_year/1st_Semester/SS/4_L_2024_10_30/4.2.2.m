for i = 1:N
  s = 0;
  for k = 1:length( t_es )
    s = s + x_es(k) * sinc((3*omega*(i-t_es(k)))/pi);
  end;
  x_rec(i) = s;
end;
plot( t, x_rec, ’r-’ );
