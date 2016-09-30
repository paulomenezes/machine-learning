function [a] = knn()

  k = 5;

  base1 = rand(20, 2);
  base2 = rand(20, 2) + 2;
  
  baseTotal = vertcat(base1, base2);
  
  baseTotal
  
  scatter(baseTotal(:, 1), baseTotal(:, 2));
  
  z = [0.4 0.7];
  distances = zeros(size(baseTotal, 1), 2);

  for i = 1: size(baseTotal, 1)
    distances(i, 1) = euclidianDistance(z, baseTotal(i, :));
    distances(i, 2) = i;
  endfor
  
  distances = sortrows(distances, 1);
  
  baseTotal(distances(1:k, 2), :)
endfunction

function [d] = euclidianDistance(a, b)
  d = 0;
  
  % size(a, 1) número de linhas
  % size(a, 2) número de colunas
  for i = 1:size(a, 2)
    d = d + (a(1, i) - b(1, i)) ^2;
  endfor
  
  d = sqrt(d);
  
endfunction