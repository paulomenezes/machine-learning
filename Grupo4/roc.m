function [a] = roc(s, y, N, P)
  FP = 0;
  TP = 0;
  
  m = vertcat(s, y);
  m = m';
  m = sortrows(m, 1);
  
  R = [];
  Fprev = -10000;
  i = size(m, 1);
  
  while (i > 0)
    if (m(i, 1) != Fprev)
      R = vertcat(R, [ FP/N TP/P m(i, 1) ]);
      Fprev = m(i, 1);
    endif
    if (m(i, 2) == 1)
      TP = TP + 1;
    else
      FP = FP + 1;
    endif
    
    i = i - 1;
  endwhile
  
  R = vertcat(R, [ FP/N TP/P 0 ]);
  
  dists = zeros(size(R, 1));
  for i = 1: size(R, 1)
    dists(i) = sqrt(sum((R(i, 1:2) - [0 1]) .^ 2));
  endfor
  
  [M, I] = min(dists);
  a = R(I(1), 3); 
  
  plot(R(:, 1), R(:, 2));
  
  % area2 = trapz(R(:, 1), R(:, 2));
  % area2
  
  area = area_roc(s, y, N, P);
  area
  
endfunction

function [A] = area_roc(s, y, N, P)
  FP = 0;
  FPprev = 0;
  TPprev = 0;
  TP = 0;
  
  m = vertcat(s, y);
  m = m';
  m = sortrows(m, 1);
  
  A = 0;
  Fprev = -10000;
  i = size(m, 1);
  
  while (i > 0)
    if (m(i, 1) != Fprev)
      A = A + trapezoid_area(FP, FPprev, TP, TPprev);
      % R = vertcat(R, [ FP/N TP/P m(i, 1) ]);
      Fprev = m(i, 1);
      FPprev = FP;
      TPprev = TP;
    endif
    if (m(i, 2) == 1)
      TP = TP + 1;
    else
      FP = FP + 1;
    endif
    
    i = i - 1;
  endwhile
  
  A = A + trapezoid_area(N, FPprev, N, TPprev);
  A = A / (P * N);
  % R = vertcat(R, [ FP/N TP/P 0 ]);
  
endfunction

function [A] = trapezoid_area(X1, X2, Y1, Y2)
  base = abs(X1 - X2);
  height = (Y1 + Y2) / 2;
  
  A = base * height;
endfunction