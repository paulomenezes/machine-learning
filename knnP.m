function [classe_final] = knnP(k, base)

  classes = zeros(k, 1);
  num_classes = 23;
  num_elementos = size(base, 1) * size(base, 3);
  classes_elementos = zeros(size(base,3), num_elementos);
  classe_final = zeros(num_elementos, 1);
  
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
    
   
    distances = zeros(size(base_treinamento, 1), 2);

    for j = 1:size(base_classificacao, 1)
        for l = 1:size(base_treinamento, 1)
          distances(l, 1) = euclidianDistance(base_treinamento(l, :), base_classificacao(j, :));
          distances(l, 2) = base_treinamento(l, size(base_treinamento, 2) - 1)
        endfor;
        
        distances = sortrows(distances, 1); #ordena em ordem crescente
        distances = distances(1:k); #pega os k-melhores
        
        n_col  = size(base_treinamento, 2)
        
        for g = 1:k;
          classes(g, 1) = base_treinamento(distances(g, 2), n_col);
        endfor;
        
        a = 0;
        for v = 1:num_classes;
          qtd = sum(classes == v + 1);
          if  qtd > a;
            a = qtd;
          endif;
        endfor;
        
        classes_elementos(i, base_classificacao(j,size(base_classificacao, 2) - 1)) = a; #recebe a classe   
    endfor;
  endfor; 
  
  
  for t = 1:num_elementos;
    media = 0;
    for s = 2:num_classes;
      qtd = sum(classes_elementos(:,t) == s);
      if qtd > media && qtd ~= 0;
        media = qtd;
      endif;
    endfor;
    classe_final(t,1) = media;
  endfor; 
  
endfunction