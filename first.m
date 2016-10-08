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
  
  #carrega os atributos, é -2 devido que a classe não está na matriz classificacao + id
  base = zeros(nLinhas, nColunas - 2);
  
  #para cada exemplo (linha da matriz) há uma classificação
  classificacao = zeros(nLinhas, 1);
  
    
  while ~feof(arquivo)
    linha = fgetl(arquivo);
    if isempty(linha);
      continue
    endif;
  
    #separa os atributos a partir da vírgula presente no documento
    linhaSeparador = strsplit(linha, ',');
    
    #remove a coluna de id da string
    #pois o índice do array já serve para isso
    linhaSeparador(:, nColunas - 1) = [];
    
    #TRANSFORMAÇÃO E NORMALIZAÇÃO
    for i = 1:nColunas - 1; #a última coluna é a classe
     if i == nColunas - 1;
      switch linhaSeparador(i) 
        case "cochlear_unknown", classificacao(nLinha, 1) = 1;
        case "mixed_cochlear_age_fixation", classificacao(nLinha, 1) = 2;
        case "poss_central", classificacao(nLinha, 1) = 3;
        case "mixed_cochlear_age_otitis_media", classificacao(nLinha, 1) = 4;
        case "mixed_poss_noise_om", classificacao(nLinha, 1) = 5;
        case "cochlear_age", classificacao(nLinha, 1) = 6;
        case "normal_ear", classificacao(nLinha, 1) = 7;
        case "cochlear_poss_noise", classificacao(nLinha, 1) = 8;
        case "cochlear_age_and_noise", classificacao(nLinha, 1) = 9;
        case "acoustic_neuroma", classificacao(nLinha, 1) = 10;
        case "mixed_cochlear_unk_ser_om", classificacao(nLinha, 1) = 11;
        case "conductive_discontinuity", classificacao(nLinha, 1) = 12;
        case "retrocochlear_unknown", classificacao(nLinha, 1) = 13;
        case "bells_palsy", classificacao(nLinha, 1) = 14;
        case "cochlear_noise_and_heredity", classificacao(nLinha, 1) = 15;
        case "mixed_cochlear_unk_fixation", classificacao(nLinha, 1) = 16;
        case "otitis_media", classificacao(nLinha, 1) = 17;
        case "possible_menieres", classificacao(nLinha, 1) = 18;
        case "possible_brainstem_disorder", classificacao(nLinha, 1) = 19;
        case "cochlear_age_plus_poss_menieres", classificacao(nLinha, 1) = 20;
        case "mixed_cochlear_age_s_om", classificacao(nLinha, 1) = 21;
        case "mixed_cochlear_unk_discontinuity", classificacao(nLinha, 1) = 22;
        case "mixed_poss_central_om", classificacao(nLinha, 1) = 23;
        otherwise classificacao(nLinha, 1) = 100; #caso contrário classe fantasma
      endswitch;
     else
      for j = 1:length(atributosNaoVF);
        if i == atributosNaoVF(j);
          qtdRespostas = nRespostasAtributo(j);
          if qtdRespostas == 2;
              switch linhaSeparador(1, i)
                case "degraded", linhaSeparador(i) = "0.00"
                case "normal", linhaSeparador(i) = "1.00"
              endswitch;
              #if strcmp(linhaSeparador(i), "degraded");
               #   linhaSeparador(i) = "0.00";
              #elseif strcmp(linhaSeparador(i), "normal");
               #   linhaSeparador(i) = "1.00";
              #endif;
          elseif qtdRespostas == 3
            switch linhaSeparador(i)
                case "absent", linhaSeparador(i) = "0.00"
                case "normal", linhaSeparador(i) = "0.50"
                case "elevated", linhaSeparador(i) = "1.00"
            endswitch;
              #if strcmp(linhaSeparador(i), "absent");
               #   linhaSeparador(i) = "0.00";
              #elseif strcmp(linhaSeparador(i), "normal");
               #   linhaSeparador(i) = "0.50";
              #elseif strcmp(linhaSeparador(i), "elevated");
               #   linhaSeparador(i) = "1.00";
              #endif;
          elseif qtdRespostas == 4;
              if strcmp(linhaSeparador(i), "mild");
                  linhaSeparador(i) = "0.00";
              elseif strcmp(linhaSeparador(i), "moderate");
                  linhaSeparador(i) = "0.33";
              elseif strcmp(linhaSeparador(i), "normal");
                  linhaSeparador(i) = "0.66";
              else #unmeasured
                  linhaSeparador(i) = "1.00";
              endif;
          elseif qtdRespostas == 5;
              if strcmp(linhaSeparador(i), "mild");
                  linhaSeparador(i) = "0.0";
              elseif strcmp(linhaSeparador(i), "moderate");
                  linhaSeparador(i) = "0.25";
              elseif strcmp(linhaSeparador(i), "normal");
                  linhaSeparador(i) = "0.50";
              elseif strcmp(linhaSeparador(i), "severe");
                  linhaSeparador(i) = "0.75";
              elseif strcmp(linhaSeparador(i), "profund");
                  linhaSeparador(i) = "1.00"; 
              elseif strcmp(linhaSeparador(i), "a");
                  linhaSeparador(i) = "0.00";
              elseif strcmp(linhaSeparador(i), "as");
                  linhaSeparador(i) = "0.25";
              elseif strcmp(linhaSeparador(i), "b");
                  linhaSeparador(i) = "0.50";
              elseif strcmp(linhaSeparador(i), "ad");
                  linhaSeparador(i) = "0.75";
              elseif strcmp(linhaSeparador(i), "c");
                  linhaSeparador(i) = "1.00";    
              endif;
           elseif qtdRespostas == 6;
              if strcmp(linhaSeparador(i), "very_poor");
                  linhaSeparador(i) = "0.20";
              elseif strcmp(linhaSeparador(i), "poor");
                  linhaSeparador(i) = "0.40";
              elseif strcmp(linhaSeparador(i), "normal");
                  linhaSeparador(i) = "0.60";
              elseif strcmp(linhaSeparador(i), "good");
                  linhaSeparador(i) = "0.80";
              elseif strcmp(linhaSeparador(i), "very_good");
                  linhaSeparador(i) = "1.00"; 
              else #unmeasured
                  linhaSeparador(i) = "0.00";
              endif;
          endif;
          jaFez = 1;
          break; #sai do laço for, pois não precisa mais procurar
        endif;  
      end;
      
      if jaFez == 0; #só entra aqui se não entrou no if acima
         if strcmp(linhaSeparador(i), " ?");
              linhaSeparador(i) = "-1.00"; #transforma o missing values de ? para -1
         elseif strcmp(linhaSeparador(i), "f");
              linhaSeparador = "0.00";
         elseif strcmp(linhaSeparador(i), " f");
              linhaSeparador = "0.00";
         elseif strcmp(linhaSeparador(i), "t");
              linhaSeparador = "1.00";
         elseif strcmp(linhaSeparador(i), " t");
              linhaSeparador = "1.00"
         endif
      endif
     endif;
     
     jaFez = 0;
    end;
   
    #transforma a string dos atributos em double
    vetorDouble = str2double(linhaSeparador);
    
    #atribui os valores à base
    base(nLinha, :) = vetorDouble;
    
    nLinha = nLinha + 1;
  endwhile
  
  clear i j;
  
  #base após o missing
  baseSemMissing = ones(nLinhas, nColunas - 1);
  
  #MISSING VALUES
  #REMOVER EXEMPLOS 
  [x, y] = find (base == -1);
  for i = 1:length(x);
  baseSemMissing = base(x(i), :);
  end;
  
  #MÉDIA CLASSE
  [x, y] = find(base == -1);
  x1 = 0;
  for i = 1:length(x);
      if x1 ~= x(i);
        #seta a classe missing value
        classe = classificao(x(i));
      
        #acha os elementos da base que sejam da classe
        [z] = find(classificao == classe);
      
        #pega a quantidade de elementos que existe na base daquela classe
        nElementosDaClasse = length(z); #SE NÃO CONTAR COM O DO ELEMENTO TEM DE SUBTRAIR 1
        
        #seta o valor da linha do elemento
         x1 = x(i);
       endif;
         
        #recebe a coluna do elemento em questão 
         coluna = y(i);
         
         #soma/media dos atributos dos elementos que pertencem à clasee
         soma = 0;
         media = 0;
         
       for j = 1:nElementosDaClasse;
          if isreal(base(z(j), coluna)) == true; #TEM DE VERIFICAR SE FUNCIONA
            soma = soma + base(z(j), coluna);
          endif;
        end;
        
        media = soma/nElementosDaClasse;
        
        baseSemMissing = base; #FUNCIONA?
        baseSemMissing(i, coluna)  = media;
    end;
endfunction