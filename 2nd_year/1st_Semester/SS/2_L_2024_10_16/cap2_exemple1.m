omega = pi/40;
N = 80;
t = 0:N-1;
s1 = sin(omega * t);
subplot(3, 1, 1), plot(t, s1);
s2 = sin(2 * omega * t);
subplot(3, 1, 2), plot(t, s2);
s3 = sin(3 * omega * t);
subplot(3, 1, 3), plot(t, s3);

s1s1 = 0;
for i = 1 : N
  s1s1 = s1s1 + s1(i) * s1(i);
end
fprintf('<s1, s1> = %f\n', s1s1);

s1s2 = 0;
for i = 1 : N
  s1s2 = s1s2 + s1(i) * s2(i);
end
fprintf('<s1, s2> = %f\n', s1s2);
