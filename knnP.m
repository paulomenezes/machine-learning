function [classe_final] = knnP(k, base)

  #classes = zeros(k, 1);
  num_classes = 25;
  num_elementos = size(base, 1) * size(base, 3);
  classes_elementos = zeros(size(base,3), num_elementos); #n° de divisões x n° de elementos
  classe_final = zeros(num_elementos, 1);
  
  
  a = 0;
  for i = 1:size(base,3)  
    #base de treinamento
    base_treinamento = base(:,:, i);
    
    #base de classificacao
    base_temporaria = base;
    base_temporaria(:,:,i) = [];
    
    base_classificacao = base_temporaria(:,:,1);
    for w = 2:size(base, 3) - 2; #-2 pq um treinamento e outro já colocado
      base_classificacao = vertcat(base_classificacao, base_temporaria(:,:,w));
    endfor;   
    
    for j = 1:size(base_classificacao, 1)
        distances = zeros(size(base_treinamento, 1), 2);
        for l = 1:size(base_treinamento, 1)
          distances(l, 1) = euclidianDistance(base_treinamento(l, :), base_classificacao(j, :));
          distances(l, 2) = base_treinamento(l, end);
        endfor;
        
        distances = sortrows(distances, 1); #ordena em ordem crescente
        distances = distances(1:k); #pega os k-melhores
        
        
        #define-se a classe que mais aparece
        a = 0;
        for v = 2:num_classes
          qtd = sum(distances(:,2) == v);
          if  qtd > a
            a = qtd;
            classes_elementos(i, base_classificacao(j,end - 1)) = v #recebe a classe
          endif;
        endfor;
    endfor;
  endfor; 
  
  
  for t = 1:num_elementos;
    media = 0;
    b = 0;
    for s = 2:num_classes;
      qtd = sum(classes_elementos(:,t) == s);
      if qtd > b;
        b = qtd;
        media = s;
      endif;
    endfor;
    classe_final(t,1) = media;
  endfor; 
  
  classe_final
  
endfunction