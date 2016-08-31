function [a] = roc()
  s = [0.32 0.43 0.12 0.32 0.45 0.67 0.31 0.39 0.48 0.12 0.2 0.78 0.46 0.11 0.37 0.49 0.55 0.53 0.41];
  y = [0 1 0 0 0 1 0 0 1 0 0 1 1 0 0 1 1 1 1];
  
  N = 10;
  P = 9;
  
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
endfunction