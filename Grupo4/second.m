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
  scores = [];
  
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
  
    newpoint = Test(idxTest, :);
    
    for idx = 1 : N
      dists(idx) = sqrt(sum((x(idx, :) - newpoint) .^ 2));
    endfor
    
    [d, ind] = sort(dists);
    
    neg = find(class == 0);
    a = sort(dists(neg));
    idxNegative = a(1) + 1;
    
    pos = find(class == 1);
    b = sort(dists(pos));
    idxPositive = b(1) + 1;
    
    score = double(idxNegative / idxPositive);
    
    scores = [scores; score classTest(idxTest)];
    
    ind_closest = ind(1:k);
    
    %x_closest = x(ind_closest, :)
    
    % mode(class(ind_closest))
    % mode(classTest(ind_closest))
    
    if (classTest(idxTest) == 1)
      p += 1;
    endif
    
    if (classTest(idxTest) == 0)
      n += 1;
    endif
    
    if (mode(class(ind_closest)) == classTest(idxTest))
      acertos += 1;
    endif 
  endfor
  
  th = roc(scores(:,1)', scores(:,2)', n, p);
  th
  
  for idxTest = 1 : NTest  
    if (scores(idxTest, 1) < th)
      if (scores(idxTest, 2) == 0)
        tn++;
      else
        fn++;
      end
    end
    
    if (scores(idxTest, 1) >= th)
      if (scores(idxTest, 2) == 1)
        tp++;
      else
        fp++;
      end
    end
  endfor
  
  accuracy = (tp + tn) / (tp + tn + fp + fn);
  accuracy
  
  matrizConfusao = [tp fn;fp tn];
  matrizConfusao
  
  MCC = (tp * tn - fp * fn) / sqrt((tp + fp) * (tp + fn) * (tn + fp) * (tn * fn));
  MCC
  
  sensibilidade = tp / (tp + fn);
  sensibilidade
  
  sensitividade = tn / (tn + fp);
  sensitividade 
endfunction
