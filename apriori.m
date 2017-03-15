## Copyright (C) 2017 JN
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} apriori (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: JN <JN@JNMARCOS-PC>
## Created: 2017-03-08

function [retval] = apriori ()
arquivo = fopen('baseApriori.arff', 'r');

#definição da base
nLinhas = 68;
nColunas = 15;

#definição dos parâmetros
confianca = 0.80;
suporte = 0.20;
TAMANHO_MAX_ITEMSETS = 4; # 4 é o máximo possível do tamanho dos itemsets, 2 o mínimo

#saída
TAMANHO_RESULTADO = 200;
nome_arquivo_saida = "resultadoApriori.txt";


#verificação do tamanho
if TAMANHO_MAX_ITEMSETS < 2
  TAMANHO_MAX_ITEMSETS = 2
elseif TAMANHO_MAX_ITEMSETS > 4
  TAMANHO_MAX_ITEMSETS = 4
endif;

numLinha = 1;
d = zeros(nLinhas, nColunas);

#transferência da base para a matriz
 while ~feof(arquivo)
    linha = fgetl(arquivo);
    
    if isempty(linha);
      continue
    endif;

    #linhaSeparador = strsplit(linha, ',');
    linhaSeparador = str2num(linha);
    
    for i= 1:nColunas;
      d(numLinha, i) = linhaSeparador(i);
    endfor;  
    numLinha = numLinha + 1;    
endwhile;

fclose(arquivo);

##ter um WHILE/FOR AQUI PARA CADA RODADA
#matriz dos itemsets frequentes

#armazena os mais frequentes
array_l = cell(2,TAMANHO_MAX_ITEMSETS);
#armazena os candidatos
array_c = cell(2,TAMANHO_MAX_ITEMSETS);
#amazena os candidados finais ()
candidatos_confirmados = [];

for k=1:4;
vetor_item= "";
vetor_frequencia_item = [];
frequencia = [];
vetor_itemsets_a_eliminar = []; #pois fica abaixo do suporte

if k == 1
  frequencia = sum(d);
  frequencia = frequencia / rows(d)

  for i=1:nColunas
    if frequencia(i) >= suporte
      vetor_item = strcat(vetor_item, num2str(i));
      if i ~= nColunas
        vetor_item = strcat(vetor_item, "-");
      endif;
      vetor_frequencia_item = horzcat(vetor_frequencia_item, frequencia(i));
    endif;
  endfor;

  #adiciona os resultados obtidos
  array_c{1,k} = linspace(1,nColunas,nColunas);
  array_c{2,k} = frequencia;
  array_l{1,k} = strsplit(vetor_item, "-");
  array_l{2,k} = vetor_frequencia_item;
  
 elseif k == 2
    x = array_l{1, k-1};
    tam = size(x, 2); #tamanho do array_l{k}
    for i=1:tam;
        for j=(i+1):tam;
          itemset =  strcat(x{i},"-");
          itemset = strcat(itemset, x{j});
          vetor_item = strcat(vetor_item, itemset);
          vetor_item = strcat(vetor_item, "/");
        endfor;
    endfor;

    array_c{1,k} = strsplit(vetor_item, "/");
    array_c{1,k}(end) = [];
    y = array_c{1,k};
 
    for it=1:size(y,2)
      itens = y{it};
      item_partido = strsplit(itens,"-");
      freq = 0;
      for it2=1:nLinhas
        if d(it2, str2num(item_partido{1})) == 1 && d(it2, str2num(item_partido{2})) == 1;
            freq = freq + 1;
        endif;
      endfor;
      frequencia = horzcat(frequencia, freq);
    endfor;
    
    frequencia = frequencia / rows(d);

    for i=1:size(frequencia,2)
      if frequencia(i) >= suporte
        vetor_frequencia_item = horzcat(vetor_frequencia_item, frequencia(i));
      else
        vetor_itemsets_a_eliminar = horzcat(vetor_itemsets_a_eliminar, i);
      endif;
    endfor;
    
    array_c{2,k} = frequencia;
    array_l{1,k} = strsplit(vetor_item, "/");
    array_l{1,k}(end) = [];
    
    if isnull(vetor_itemsets_a_eliminar) == false
      array_l{1,k}(vetor_itemsets_a_eliminar) = [];
    endif;
    
    array_l{2,k} = vetor_frequencia_item;
 elseif k == 3
    x = array_l{1, k-1};
    tam = size(x, 2); #tamanho do array_l{k}
    if tam >=3
      for i=1:tam;
          for j=(i+1):tam;
          aux1 = strsplit(x{i}, "-");
          aux2 = strsplit(x{j}, "-");
          if aux1{1} == aux2{1}
              itemset =  strcat(x{i},"-");
              itemset = strcat(itemset, aux2{2});
              vetor_item = strcat(vetor_item, itemset);
              vetor_item = strcat(vetor_item, "/");
          endif;
          endfor;
      endfor;
    endif;
    
    array_c{1,k} = strsplit(vetor_item, "/");
    array_c{1,k}(end) = [];
    y = array_c{1,k};
    
    for it=1:size(y,2)
      itens = y{it};
      item_partido = strsplit(itens,"-");
      freq = 0;
      for it2=1:nLinhas
        if (d(it2, str2num(item_partido{1})) == 1 
          && d(it2, str2num(item_partido{2})) == 1
          && d(it2, str2num(item_partido{3})) == 1);
            freq = freq + 1;
        endif;
      endfor;
      frequencia = horzcat(frequencia, freq);
    endfor;
    
    frequencia = frequencia / rows(d);
 
    for i=1:size(frequencia,2)
      if frequencia(i) >= suporte
        vetor_frequencia_item = horzcat(vetor_frequencia_item, frequencia(i));
       else
          vetor_itemsets_a_eliminar = horzcat(vetor_itemsets_a_eliminar, i);
      endif;
    endfor;
    
    array_c{2,k} = frequencia;
    array_l{1,k} = strsplit(vetor_item, "/");
    array_l{1,k}(end) = [];
    
    if isnull(vetor_itemsets_a_eliminar) == false
      array_l{1,k}(vetor_itemsets_a_eliminar) = [];
    endif;
    
    array_l{2,k} = vetor_frequencia_item;
    
 elseif k == 4
    x = array_l{1, k-1};
    tam = size(x, 2); #tamanho do array_l{k}
    if tam >=4
      for i=1:tam;
          for j=(i+1):tam;
            aux1 = strsplit(x{i}, "-");
            aux2 = strsplit(x{j}, "-");
            if aux1{1} == aux2{1} && aux1{2} == aux2{2}
              itemset =  strcat(x{i},"-");
              itemset = strcat(itemset, aux2{3});
              vetor_item = strcat(vetor_item, itemset);
              vetor_item = strcat(vetor_item, "/");
            endif;
          endfor;
      endfor;
    endif;

    array_c{1,k} = strsplit(vetor_item, "/");
    array_c{1,k}(end) = [];
    y = array_c{1,k};
 
    for it=1:size(y,2)
      itens = y{it};
      item_partido = strsplit(itens,"-");
      freq = 0;
      for it2=1:nLinhas
        if (d(it2, str2num(item_partido{1})) == 1 
          && d(it2, str2num(item_partido{2})) == 1
          && d(it2, str2num(item_partido{3})) == 1
          && d(it2, str2num(item_partido{4})) == 1);
            freq = freq + 1;
        endif;
      endfor;
      frequencia = horzcat(frequencia, freq);
    endfor;
    frequencia = frequencia / rows(d);

    for i=1:size(frequencia,2)
      if frequencia(i) >= suporte
        vetor_frequencia_item = horzcat(vetor_frequencia_item, frequencia(i));
      else
        vetor_itemsets_a_eliminar = horzcat(vetor_itemsets_a_eliminar, i);
      endif;
    endfor;
    
  array_c{2,k} = frequencia;
  array_l{1,k} = strsplit(vetor_item, "/");
  array_l{1,k}(end) = [];

  if isnull(vetor_itemsets_a_eliminar) == false
    array_l{1,k}(vetor_itemsets_a_eliminar) = [];
  endif;
  
  array_l{2,k} = vetor_frequencia_item;
 endif;
endfor;

array_l;
array_c;

suporte_I = 0; #suporte do itemset
suporte_s = 0; #suporte do subsconjunto do itemset
freq_candidatos_confirmados = [];

for i=2:TAMANHO_MAX_ITEMSETS
  x = array_l{1,i}; #fornece o conjunto de itemsets de tamanho i
  for j=1:columns(x); #fornece um novo candidato a cada iteração
    candidato = x{j}
    suporte_I = array_l{2,i}(j)
    particao_candidato = strsplit(candidato, "-") #candidato particionado
    for tamanho_antecedente=1:i-1 #para tam_antec de 1 até i - 1 (subconjuntos)
      if tamanho_antecedente == 1
        for k=1:i #índice do 1º caractere
          regra = "";
          antecedente = "";
          antecedente = strcat(antecedente, particao_candidato{k});
          
          
          
    
          aux = particao_candidato;
          aux(k) = [];
          particao_candidato_s =  transformar_regra_p_texto(aux);
          consequente = strjoin(particao_candidato_s,".");
          
          #consequente  = strjoin(aux, "-") ;
          
          cel_suporte_s = array_l{1,1};
          suporte_s = 0;
          for v=1:columns(cel_suporte_s)
            a = cel_suporte_s{v};
            if strcmp(a, antecedente)
              suporte_s = array_l{2,1}(v);
            endif;
          endfor;
          
          particao_candidato_s =  transformar_regra_p_texto(particao_candidato);
          antecedente = "";
          antecedente = strcat(antecedente, particao_candidato_s{k})
          
          if suporte_I/suporte_s >= confianca
              regra = strcat(antecedente, " ->");
              regra = strcat(regra, consequente);
              regra = strcat(regra, "/");
              candidatos_confirmados = horzcat(candidatos_confirmados, regra);
              freq_candidatos_confirmados = horzcat(freq_candidatos_confirmados,
                (suporte_I/suporte_s));
          endif;
        endfor;
      elseif tamanho_antecedente == 2
        for k=1:i #índice do 1º caractere
          for l=(k+1):i #índice do 2º caracteres
            regra = "";
            
            vetor_nao_consequente = []; #armazena ind dos antecedentes
            vetor_nao_consequente = horzcat(vetor_nao_consequente, k);
            vetor_nao_consequente = horzcat(vetor_nao_consequente, l);
            
            antecedente = ""; 
            antecedente = strcat(antecedente, particao_candidato{k});
            antecedente = strcat(antecedente, "-");
            antecedente = strcat(antecedente, particao_candidato{l});
            
            aux = particao_candidato;
            aux(vetor_nao_consequente) = [];
            
            particao_candidato_s =  transformar_regra_p_texto(aux);
            consequente = strjoin(particao_candidato_s,".");
            #consequente = strjoin(aux,"-");
            
            cel_suporte_s = array_l{1,2};
            suporte_s = 0;
            for v=1:columns(cel_suporte_s)
              a = cel_suporte_s{v};
              if strcmp(a, antecedente)
                suporte_s = array_l{2,2}(v);
              endif;
            endfor;
            
            particao_candidato_s =  transformar_regra_p_texto(particao_candidato);
            antecedente = "";
            antecedente = strcat(antecedente, particao_candidato_s{k});
            antecedente = strcat(antecedente, ".");
            antecedente = strcat(antecedente, particao_candidato_s{l})
            
             if suporte_I/suporte_s >= confianca
                regra = strcat(antecedente, " ->");
                consequente = strcat(" ", consequente);
                regra = strcat(regra, consequente);
                regra = strcat(regra, "/");
                candidatos_confirmados = horzcat(candidatos_confirmados, regra);
                freq_candidatos_confirmados = horzcat(freq_candidatos_confirmados,
                (suporte_I/suporte_s));
             endif;
            endfor;
        endfor;
      else
        for k=1:i #índice do 1º caractere
         for l=(k+1):i #índice do 2º caracteres
          for m=(l+1):i #índice do 3º caractere
            regra = "";
            
            vetor_nao_consequente = []; #armazena ind dos antecedentes
            vetor_nao_consequente = horzcat(vetor_nao_consequente, k);
            vetor_nao_consequente = horzcat(vetor_nao_consequente, l);
            vetor_nao_consequente = horzcat(vetor_nao_consequente, m);
            
            
            antecedente = "";
            antecedente = strcat(antecedente, particao_candidato{k});
            antecedente = strcat(antecedente, "-");
            antecedente = strcat(antecedente, particao_candidato{l});
            antecedente = strcat(antecedente, "-");
            antecedente = strcat(antecedente, particao_candidato{m});       
            
            
            aux = particao_candidato;
            aux(vetor_nao_consequente) = [];
            
            particao_candidato_s =  transformar_regra_p_texto(aux);
            consequente = strjoin(particao_candidato_s,".");
              
            #consequente = strjoin(aux,"-");
            
            cel_suporte_s = array_l{1,3};
            suporte_s = 0;
            for v=1:columns(cel_suporte_s)
              a = cel_suporte_s{v};
              if strcmp(a, antecedente)
                suporte_s = array_l{2,3}(v)
              endif;
            endfor;
            
            particao_candidato_s =  transformar_regra_p_texto(particao_candidato);
            antecedente = "";
            antecedente = strcat(antecedente, particao_candidato_s{k});
            antecedente = strcat(antecedente, ".");
            antecedente = strcat(antecedente, particao_candidato_s{l});
            antecedente = strcat(antecedente, ".");
            antecedente = strcat(antecedente, particao_candidato_s{m})
            
            if suporte_I/suporte_s >= confianca
                regra = strcat(antecedente, " ->");
                consequente = strcat(" ", consequente);
                regra = strcat(regra, consequente);
                regra = strcat(regra, "/");
                candidatos_confirmados = horzcat(candidatos_confirmados, regra);
                freq_candidatos_confirmados = horzcat(freq_candidatos_confirmados,
                (suporte_I/suporte_s));
            endif;
           endfor;
         endfor;
        endfor;
      endif;   
    endfor;
  endfor;
endfor;

cand_finais = strsplit(candidatos_confirmados,"/");
cand_finais(end) = [];

freq_candidatos_confirmados_organizado = unique(freq_candidatos_confirmados,"first");
freq_candidatos_confirmados_organizado = sort(freq_candidatos_confirmados_organizado, 2, "descend")
array_l

tamanho_candidatos = 0;

fid = fopen(nome_arquivo_saida, "w");
for i=1:columns(freq_candidatos_confirmados_organizado)
  if tamanho_candidatos < TAMANHO_RESULTADO
    a = freq_candidatos_confirmados_organizado(i);
    x = find(freq_candidatos_confirmados == a);
    for j=1:columns(x)
      candidato_a_ser_escrito = cand_finais{x(j)};
      concat = strcat(" (", num2str(a));
      concat = strcat(concat, ") ");
      fputs(fid, candidato_a_ser_escrito); fdisp(fid,concat);
      tamanho_candidatos = tamanho_candidatos + 1;
    endfor;
  else
    break;
  endif;
endfor;
fclose(fid);
endfunction;
