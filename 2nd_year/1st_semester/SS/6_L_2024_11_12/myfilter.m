function [c] = myfilter(a, b)
  A = length(a);
  B = length(b);

  c = zeros(1, max(A, B));

  for i = A + 1 : B,
    for k = 1 : A,
      c(i) += a(k) * b(i - k);
    endfor
  endfor

end
