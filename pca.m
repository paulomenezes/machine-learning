function [] = pca()
  d = zeros(100, 2);
  
  for i = 1:100
    d(i, 1) = randn/10 + i/10;
    d(i, 2) = randn/10 + i/10;
  endfor
  
  m1 = mean(d(:, 1));
  m2 = mean(d(:, 2));
  
  d = horzcat((d(:, 1) - m1) / std(d(:, 1)), (d(:, 2) - m2) / std(d(:, 2)));
  
  scatter(d(:, 1), d(:, 2));
  
  c = cov(d);
  
  [v, a] = eig(c);
  v
  a
  
  v = horzcat(v(:, 2), v(:, 1));
  d2 = v'*d';
  
  hold on
  scatter(d2(1, :), d2(2, :), 'r', '*');
endfunction
