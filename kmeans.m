function [a] = kmeans()

  k = 3;

  base1 = rand(20, 2);
  base2 = rand(20, 2) + 2;
  base3 = rand(20, 2) - 1;
  
  baseTotal = vertcat(base1, base2, base3);
  
  % scatter(baseTotal(:, 1), baseTotal(:, 2));
  
  distances = zeros(size(baseTotal, 1), k + 1);
    
  c1 = rand(1, 2); % [rand * size(baseTotal, 1), rand * size(baseTotal, 2)];
  c2 = rand(1, 2);
  c3 = rand(1, 2);

  while(1)
  
    for i = 1: size(baseTotal, 1)
      distances(i, 1) = euclidianDistance(c1, baseTotal(i, :));
      distances(i, 2) = euclidianDistance(c2, baseTotal(i, :));
      distances(i, 3) = euclidianDistance(c3, baseTotal(i, :));

      s = min(distances(i, 1:3));
      distances(i, 4) = find(distances(i, 1:3) == s);
    endfor
    
    nnsC1 = find(distances(:, 4) == 1);
    nnsC2 = find(distances(:, 4) == 2);
    nnsC3 = find(distances(:, 4) == 3);
    
    c1Old = c1;
    c2Old = c2;
    c3Old = c3;
    
    c1 = mean(baseTotal(nnsC1, :));
    c2 = mean(baseTotal(nnsC2, :));
    c3 = mean(baseTotal(nnsC3, :));
    
    if (c1 == c1Old && c2 == c2Old && c3 == c3Old)
      break;
    endif
  endwhile
  
  scatter(baseTotal(:, 1), baseTotal(:, 2));
  hold on;
  
  cs = vertcat(c1, c2, c3);
  scatter(cs(:, 1), cs(:, 2), 'r');
  
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