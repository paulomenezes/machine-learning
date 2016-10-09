function [] = series()
  fid = fopen('energia.csv','r');
  N = 0;
  
  year = zeros(1, 141);
  month = zeros(1, 141);
  energy = zeros(1, 141);
  
  lastYear = 1900;
  
  first = 0;
  
  max = 0;
  min = 999999;
  
  while ~feof(fid)
    line = fgetl(fid);
    if isempty(line) || strncmp(line,'%',1) || ~ischar(line)
        continue
    end
    
    data = strsplit(line, ';');
    
    if (first > 0)
      N = N + 1;
      
      if isnan(str2double(data(1, 1)))
        year(1, N) = lastYear;
      else
        year(1, N) = str2double(data(1, 1));
        lastYear = str2double(data(1, 1));
      endif
      
      month(1, N) = str2double(data(1, 2));
      energy(1, N) = str2double(data(1, 3));
      
      if energy(1, N) > max
        max = energy(1, N);
      endif
      
      if energy(1, N) < min
        min = energy(1, N);
      endif
    else
      first = 1;
    endif
  end
    
  fclose(fid);
  
  energy = energy';
  
  for i = 1: 141
    energy(i) = (energy(i) - min) / (max - min);
  endfor
  
  j = 1;
  energyStandardized = zeros(141, 1);
  for i = 2: 141
    energyStandardized(i) = energy(i) - energy(j);
    j++;
  endfor
  
  #plot(energy, 'r+');
  
  #validate = energy(1,1:56);
  #train = energy(1,57:113);
  #test = energy(1,114:141);
  
  year = year';
   
  plot(energyStandardized); 
 
  data = horzcat(year, month');
  dataSet = horzcat(data, energyStandardized);
  
  csvwrite("energy.normalized.csv", dataSet);
  
endfunction