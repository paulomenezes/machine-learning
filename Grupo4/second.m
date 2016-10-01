function [] = second()
  fid = fopen('BinariaTr.txt','r');
  N = 0;
  
  x = zeros(9, 230);
  class = zeros(1, 230);
  
  while ~feof(fid)
    line = fgetl(fid);
    if isempty(line) || strncmp(line,'%',1) || ~ischar(line)
        continue
    end
    
    line2 = strsplit(line, '\t');
    line3 = str2double(line2);
    
    N = N + 1;
    for i = 1: 9
      x(i, N) = line3(i);
    endfor
    
    class(N) = line3(10);
  end
  
  fclose(fid);

  x = x';
  
  k = 5;
  
  dists = zeros(size(x, 1), 1);
  scores = zeros(size(x, 1), 2);
  
  NTest = 0;
  fidTe = fopen('BinariaTe.txt','r');
  
  Test = zeros(9, 231);
  classTest = zeros(1, 231);
  
  while ~feof(fidTe)
    line = fgetl(fidTe);
    if isempty(line) || strncmp(line,'%',1) || ~ischar(line)
        continue
    end
    
    line2 = strsplit(line, '\t');
    line3 = str2double(line2);
    
    NTest = NTest + 1;
    for i = 1: 9
      Test(i, NTest) = line3(i);
    endfor
    
    classTest(NTest) = line3(10);
  end
  
  fclose(fidTe);
  
  Test = Test';
  
  acertos = 0;
  tp = 0;
  fn = 0;
  fp = 0;
  tn = 0;
  
  n = 0;
  p = 0;
  
  for idxTest = 1 : NTest
  
    # newpoint = [1.0	0.3333333333333333	0.2222222222222222	0.0	0.2222222222222222	0.2222222222222222	0.5555555555555556	0.4444444444444444	0.1111111111111111];
    newpoint = Test(idxTest, :);
    
    for idx = 1 : N
      dists(idx) = sqrt(sum((x(idx, :) - newpoint) .^ 2));
    endfor
    
    [d, ind] = sort(dists);
    
    idxPositive = -1;
    idxNegative = -1;
    
    idxFind = 1;
    
    while (idxPositive == -1 || idxNegative == -1)
      classFind = uint8(class(ind(idxFind)));
            
      if (idxNegative == -1 && classFind == 0)
        idxNegative = idxFind;
      endif
      
      if (idxPositive == -1 && classFind == 1)
        idxPositive = idxFind;
      endif
      
      idxFind += 1;
    endwhile
    
    scores = [scores; dists(idxPositive, 1) / dists(idxNegative, 1) classTest(idxTest)];
    
    ind_closest = ind(1:k);
    
    # x_closest = x(ind_closest, :)
    
    # mode(class(ind_closest))
    # mode(classTest(ind_closest))
    
    if (classTest(idxTest) == 1)
      p += 1;
    endif
    
    if (classTest(idxTest) == 0)
      n += 1;
    endif
    
    if (mode(class(ind_closest)) == classTest(idxTest))
      acertos += 1;
    endif 
    
    if (mode(class(ind_closest)) == 1 && classTest(idxTest) == 1)
      tp += 1;
    endif 
    
    if (mode(class(ind_closest)) == 1 && classTest(idxTest) == 0)
      fn += 1;
    endif 
    
    if (mode(class(ind_closest)) == 0 && classTest(idxTest) == 1)
      fp += 1;
    endif 
    
    if (mode(class(ind_closest)) == 0 && classTest(idxTest) == 0)
      tn += 1;
    endif 
 
    # disp([mode(class(ind_closest)) classTest(idxTest)])
  
  endfor
  
  accuracy = acertos / NTest;
  accuracy
  
  matrizConfusao = [tp fn;fp tn];
  matrizConfusao
  
  MCC = (tp * tn - fp * fn) / sqrt((tp + fp) * (tp + fn) * (tn + fp) * (tn * fn));
  MCC
  
  sensibilidade = tp / (tp + fn);
  sensibilidade
  
  sensitividade = tn / (tn + fp);
  sensitividade
  
  # scores(:,1)
  
  #n
  #p

  roc(scores(:,1)', scores(:,2)', n, p);
  
endfunction
