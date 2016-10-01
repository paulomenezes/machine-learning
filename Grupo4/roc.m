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
      R = vertcat(R, [ FP/N TP/P ]);
      Fprev = m(i, 1);
    endif
    if (m(i, 2) == 1)
      TP = TP + 1;
    else
      FP = FP + 1;
    endif
    
    i = i - 1;
  endwhile
  
  R = vertcat(R, [ FP/N TP/P ]);
  
  plot(R(:, 1), R(:, 2));
  
  area = trapz(R(:, 1), R(:, 2));
  area
  
endfunction