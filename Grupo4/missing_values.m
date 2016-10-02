function [] = missing_values()
  fid = fopen('audiologyCl.txt','r');
  count = 0;
  while ~feof(fid)
    line = fgetl(fid);
    if isempty(line) || strncmp(line,'%',1) || ~ischar(line)
        continue
    end
    
    line
    
    count = count + 1;
  end
  count
  fclose(fid);
  
endfunction