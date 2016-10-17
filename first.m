function [] = first()
  #base padronizada
  arquivo = fopen('BasePadronizadaAudiology.txt', 'r');
   
  #número total de exemplos na base
  nLinhas = 200;
  
  #número de atributos (69) + id + classe
  nColunas = 71;
  
  #iterador
  nLinha = 1;
  
  #atributos que não possuem como resposta verdadeiro ou falso
  atributosNaoVF = [2, 4, 5, 6, 8, 59, 60, 64, 66];
  
  #diz os tipos dos atributosNaoVF, pois dependo do atributo, ele possui
  #particularidades
  nRespostasAtributo = [5, 3, 3, 4, 2, 3, 3, 6, 5];
  
  #indica que já se passou pela transformção
  jaFez = 0; #false
  
  #carrega os atributos, é -1 devido que o id não está na matriz de classificao
  base = zeros(nLinhas, nColunas);  
    
  while ~feof(arquivo)
    linha = fgetl(arquivo);
    if isempty(linha);
      continue
    endif;
  
    #separa os atributos a partir da vírgula presente no documento
    linhaSeparador = strsplit(linha, ',');
    
     
    #TRANSFORMAÇÃO E NORMALIZAÇÃO
    for i = 1:nColunas; #a última coluna é a classe
     if i == nColunas;
     #a classe 1 não existe para evitar possível erros no uso do find
      if strcmp(linhaSeparador(i), "cochlear_unknown"); base(nLinha, nColunas) = 25;
      elseif strcmp(linhaSeparador(i), "mixed_cochlear_age_fixation"); base(nLinha, nColunas) = 2;
      elseif strcmp(linhaSeparador(i), "poss_central"); base(nLinha, nColunas) = 3;
      elseif strcmp(linhaSeparador(i), "mixed_cochlear_age_otitis_media"); base(nLinha, nColunas) = 4;
      elseif strcmp(linhaSeparador(i), "mixed_poss_noise_om"); base(nLinha, nColunas) = 5;
      elseif strcmp(linhaSeparador(i), "cochlear_age"); base(nLinha, nColunas) = 6;
      elseif strcmp(linhaSeparador(i), "normal_ear"); base(nLinha, nColunas) = 7;
      elseif strcmp(linhaSeparador(i), "cochlear_poss_noise"); base(nLinha, nColunas) = 8;
      elseif strcmp(linhaSeparador(i), "cochlear_age_and_noise"); base(nLinha, nColunas) = 9;
      elseif strcmp(linhaSeparador(i), "acoustic_neuroma"); base(nLinha, nColunas) = 10;
      elseif strcmp(linhaSeparador(i), "mixed_cochlear_unk_ser_om"); base(nLinha, nColunas) = 11;
      elseif strcmp(linhaSeparador(i), "conductive_discontinuity"); base(nLinha, nColunas) = 12;
      elseif strcmp(linhaSeparador(i), "retrocochlear_unknown"); base(nLinha, nColunas) = 13;
      elseif strcmp(linhaSeparador(i), "bells_palsy"); base(nLinha, nColunas) = 14;
      elseif strcmp(linhaSeparador(i), "cochlear_noise_and_heredity"); base(nLinha, nColunas) = 15;
      elseif strcmp(linhaSeparador(i), "mixed_cochlear_unk_fixation"); base(nLinha, nColunas) = 16;
      elseif strcmp(linhaSeparador(i), "otitis_media"); base(nLinha, nColunas) = 17;
      elseif strcmp(linhaSeparador(i), "possible_menieres"); base(nLinha, nColunas) = 18;
      elseif strcmp(linhaSeparador(i), "possible_brainstem_disorder"); base(nLinha, nColunas) = 19;
      elseif strcmp(linhaSeparador(i), "cochlear_age_plus_poss_menieres"); base(nLinha, nColunas) = 20;
      elseif strcmp(linhaSeparador(i), "mixed_cochlear_age_s_om"); base(nLinha, nColunas) = 21;
      elseif strcmp(linhaSeparador(i), "mixed_cochlear_unk_discontinuity"); base(nLinha, nColunas) = 22;
      elseif strcmp(linhaSeparador(i), "mixed_poss_central_om"); base(nLinha, nColunas) = 23;
      else  base(nLinha, nColunas) = 24;
      endif;
     elseif i == nColunas - 1;
          base(nLinha, i) = nLinha;
     else
      if strcmp(linhaSeparador(i), "?");
              linhaSeparador(i) = "-1.00"; #transforma o missing values de ? para -1
      else        
        for j = 1:length(atributosNaoVF);
          if i == atributosNaoVF(j);
            qtdRespostas = nRespostasAtributo(j);
            if qtdRespostas == 2;
                if strcmp(linhaSeparador(i), "degraded");
                   base(nLinha, i) = 0.00;
                elseif strcmp(linhaSeparador(i), "normal");
                   base(nLinha, i) = 1.00;
                endif;
            elseif qtdRespostas == 3;
                if strcmp(linhaSeparador(i), "absent");
                   base(nLinha, i) = 1.00; #estranho os valores mas foi assim que pediu
                elseif strcmp(linhaSeparador(i), "normal");
                   base(nLinha, i) = 0.00;
                elseif strcmp(linhaSeparador(i), "elevated");
                  base(nLinha, i) = .50;
                endif;
            elseif qtdRespostas == 4;
                if strcmp(linhaSeparador(i), "mild");
                    base(nLinha, i) = 0.00;
                elseif strcmp(linhaSeparador(i), "moderate");
                    base(nLinha, i) = 0.33;
                elseif strcmp(linhaSeparador(i), "normal");
                    base(nLinha, i) = 0.66;
                else #unmeasured
                    base(nLinha, i) = 1.00;
                endif;
            elseif qtdRespostas == 5;
                if strcmp(linhaSeparador(i), "mild");
                    base(nLinha, i) = 0.00;
                elseif strcmp(linhaSeparador(i), "moderate");
                    base(nLinha, i) = 0.25;
                elseif strcmp(linhaSeparador(i), "normal");
                    base(nLinha, i) = 0.50;
                elseif strcmp(linhaSeparador(i), "severe");
                    base(nLinha, i) = 0.75;
                elseif strcmp(linhaSeparador(i), "profund");
                    base(nLinha, i) = 1.00; 
                elseif strcmp(linhaSeparador(i), "a");
                    base(nLinha, i) = 0.00;
                elseif strcmp(linhaSeparador(i), "as");
                    base(nLinha, i) = 0.25;
                elseif strcmp(linhaSeparador(i), "b");
                    base(nLinha, i) = 0.50;
                elseif strcmp(linhaSeparador(i), "ad");
                    base(nLinha, i) = 0.75;
                elseif strcmp(linhaSeparador(i), "c");
                    base(nLinha, i) = 1.00;    
                endif;
             elseif qtdRespostas == 6;
                if strcmp(linhaSeparador(i), "very_poor");
                    base(nLinha, i) = 0.20;
                elseif strcmp(linhaSeparador(i), "poor");
                    base(nLinha, i) = 0.40;
                elseif strcmp(linhaSeparador(i), "normal");
                    base(nLinha, i) = 0.60;
                elseif strcmp(linhaSeparador(i), "good");
                    base(nLinha, i) = 0.80;
                elseif strcmp(linhaSeparador(i), "very_good");
                    base(nLinha, i) = 1.00; 
                else #unmeasured
                    base(nLinha, i) = 0.00;
                endif;
            endif;
            jaFez = 1;
            break; #sai do laço for, pois não precisa mais procurar
          endif;  
        end;
        
        if jaFez == 0; #só entra aqui se não entrou no if acima
           if strcmp(linhaSeparador(i), "f");
                base(nLinha, i) = 0.00;
           elseif strcmp(linhaSeparador(i), "t");
                base(nLinha, i) = 1.00;
           endif
        endif
      endif;
     endif;
     
     jaFez = 0;
    end;
    
    nLinha = nLinha + 1;
  endwhile

  #base após o missing
  #são três bases sem missing (três dimensões)
  baseSemMissing = zeros(nLinhas, nColunas, 2); #média classe e moda
  baseSemMissing_elementosRemovidos = base; #remover exemplos
  
  #MISSING VALUES
  #REMOVER EXEMPLOS 
  [x, y] = find (base == -1);
  for i = 1:length(x);
    baseSemMissing_elementosRemovidos(x(i),:) = []; #x(i) retorna a linha que contém o -1
  end;
  
  
  baseSemMissing(:,:,1) = base;
  #MÉDIA CLASSE
  [x, y] = find(base == -1);
  x1 = 0;
  for i = 1:size(x, 1);
      if x1 ~= x(i);
        #seta a classe missing value
        classe = base(x(i), nColunas);
      
        #acha os elementos da base que sejam da classe
        [z] = find(base == classe);
      
        #pega a quantidade de elementos que existe na base daquela classe
        nElementosDaClasse = length(z); #SE NÃO CONTAR COM O DO ELEMENTO TEM DE SUBTRAIR 1
        
        #seta o valor da linha do elemento
         x1 = x(i);
      endif;
         
        #recebe a coluna do elemento em questão 
         coluna = y(i);
         
         #soma/media dos atributos dos elementos que pertencem à classe
         soma = 0;
         media = 0;
         
       for j = 1:nElementosDaClasse;
          if isreal(base(z(j), coluna)) == true; #TEM DE VERIFICAR SE FUNCIONA
            soma = soma + base(z(j), coluna);
          endif;
        end;
        
        media = soma/nElementosDaClasse;
        
        baseSemMissing(i,coluna,1) = media;
  end;
  
  #MÉDIA DOS K5
  #TÁ ERRADO, PONDO SÓ PARA EVITAR ERR LOGO ABAIXO PÕE ZERO
  baseSemMissing(:,:,2) = base;
  [x, y] = find (base == -1);
  for i = 1:length(x);
    baseSemMissing(x(i),:,2) = 5.0; #x(i) retorna a linha que contém o -1
  end;
  
  #cria-se uma nova base, que simplificará no uso do fold abaixo
  baseFold = zeros(2,2); #apenas para inicializá-la
  
  #FAZER O 10fold cv
  #números de bases
  n_divisoes = 10;
  
  k_knn = 3;
  
  acuracia = zeros(1,3); #acurácia dos três modelos
  
  base_apos_tudo = ones(2,2);
  for i = 1:3; #pois é a quantidade de bases sem missing
    if i == 3; 
      baseFold = baseSemMissing_elementosRemovidos;
    else baseFold = baseSemMissing(:,:,i); 
    endif;
  
    #pega o tamanho da base sem missing values
    [n_linhas, n_colunas]  = size(baseFold);
    
    #determina o tamanho mínimo de um folder   
    tamanho_folder = ceil(n_linhas/n_divisoes);

    
    #início e fim de elementos (índice)
    inicio = 1;
    fim = tamanho_folder;
    
    #criação dos folderes
    if i == 1;
      base_fold_cv_media_classe = zeros(tamanho_folder, n_colunas, n_divisoes);
    elseif i == 2; 
      base_fold_cv_k5 = zeros(tamanho_folder, n_colunas, n_divisoes);
    elseif i == 3;
      base_fold_cv_remover_missing = zeros(tamanho_folder, n_colunas, n_divisoes);
    endif;
    
    #não fica o mais próximo possível, mas outras implementações seriam muito
    #complicadas
    for l = 1:n_divisoes;
      if l ~= n_divisoes;
        if i == 1;
          base_fold_cv_media_classe(:,:,l) = baseFold(inicio:fim, :);
        elseif i == 2; 
          base_fold_cv_k5(:,:,l) = baseFold(inicio:fim, :);
        elseif i == 3;
          base_fold_cv_remover_missing(:,:,l) = baseFold(inicio:fim, :);
        endif;
        inicio = inicio + tamanho_folder;
        fim = fim + tamanho_folder;
      else    
        #desse jeito evita erros, pois não se pode ter arrays com tamanhos distintos
       # no octave 
       vv = 1; #indica a linha que vai pôr
        for b = inicio:size(baseFold, 1);
          if i == 1;
            base_fold_cv_media_classe(vv,:,n_divisoes) = baseFold(b, :);
          elseif i == 2; 
             base_fold_cv_k5(vv,:,n_divisoes) = baseFold(b, :);
          elseif i == 3;
            base_fold_cv_remover_missing(vv,:,n_divisoes) = baseFold(b, :);
          endif;
          vv = vv + 1;
        end;
      endif;
    end;
    
    #tem a base no for finalizada, pode passar para o knn
    
    if i == 1;
      classe_knn_media_classe = knnP(k_knn, base_fold_cv_media_classe);
      for index = 1:size(classe_knn_media_classe)
        if classe_knn_media_classe(i,1) == base(i, nColunas)
          acuracia(1,1) = acuracia(1,1) + 1;
        endif;
      endfor;
      acuracia(1,1) = acuracia(1,1)/size(classe_knn_media_classe, 1)
    elseif i == 2;
      classe_knn_k5 = knnP(k_knn, base_fold_cv_k5);
      for index = 1:size(classe_knn_media_classe)
        if classe_knn_k5(i,1) == base(i, nColunas)
          acuracia(1,2) = acuracia(1,2) + 1;
        endif;
      endfor;
      acuracia(1,2) = acuracia(1,2)/size(classe_knn_k5, 1)
    elseif i == 3;
      classe_knn_remover_missing = knnP(k_knn, base_fold_cv_remover_missing);
      for index = 1:size(classe_knn_remover_missing)
        if classe_knn_k5(i,1) == base_fold_cv_remover_missing(i, nColunas)
          acuracia(1,3) = acuracia(1,3) + 1;
        endif;
      endfor;
      acuracia(1,3) = acuracia(1,3)/size(classe_knn_remover_missing, 1)
    endif;
    
    if i == 3;
      if acuracia(1,1) >= acuracia(1,2) && acuracia(1,1) >= acuracia(1,3);
        base_apos_tudo = base_fold_cv_media_classe;
      elseif acuracia(1,2) >= acuracia(1,1) && acuracia(1,2) >= acuracia(1,3);
        base_apos_tudo = base_fold_cv_k5;
      elseif acuracia(1,3) >= acuracia(1,1) && acuracia(1,3) >= acuracia(1,2);
        base_apos_tudo = base_fold_cv_remover_missing;
      endif;
    endif;
  end;
  

    
endfunction