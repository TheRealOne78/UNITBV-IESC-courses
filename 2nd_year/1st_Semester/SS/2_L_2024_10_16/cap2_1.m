omega = pi/40;
N = 80;
t = 0:N-1;
s = 0.5 * sin(omega * t) + 0.4 * sin(2 * omega * t) + 0.1 * sin(3 * omega * t);

s1 = sin(1 * omega * t)
s2 = sin(2 * omega * t)
s3 = sin(3 * omega * t)
s4 = sin(4 * omega * t)
s5 = sin(5 * omega * t)

ss1 = ss2 = ss3 = ss4 = ss5 = 0;

for i = 1 : N
  ss1 = ss1 + s(i) * s1(i);
  ss2 = ss2 + s(i) * s2(i);
  ss3 = ss3 + s(i) * s3(i);
  ss4 = ss4 + s(i) * s4(i);
  ss5 = ss5 + s(i) * s5(i);
end

fprintf('<s1, s2> = %f\n', ss1);
fprintf('<s1, s2> = %f\n', ss2);
fprintf('<s1, s2> = %f\n', ss3);
fprintf('<s1, s2> = %f\n', ss4);
fprintf('<s1, s2> = %f\n', ss5);
