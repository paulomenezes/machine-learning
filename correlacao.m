function [] = correlacao()
  x = rand(1, 100);
  y = rand(1, 100);
  
  % scatter(x, y);
  
  c = sum(x.*y)-((1/size(x,2)) * sum(x) * sum(y));
  c = c / size(x, 2);
  
  mx = mean(x);
  my = mean(y);
  
  vx = x - mx;
  vx = vx.*vx;
  
  vy = y - my;
  vy = vy.*vy;
  
  dx = sqrt(sum(vx)/size(x, 2));
  dy = sqrt(sum(vy)/size(y, 2));
  
  cor = c / (dx * dy);
  cor
endfunction