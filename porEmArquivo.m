## Copyright (C) 2016 JN
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
## @deftypefn {Function File} {@var{retval} =} tempor�rio (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: JN <JN@JNMARCOS>
## Created: 2016-10-17

function [] = porEmArquivo (base, i)
#base é a base que será passada para o arquivo
#i é o iterador
  
  #caminho .aff
  caminhoAFF = "base_weka";
  caminhoAFF = strcat(caminhoAFF, num2str(i));
  adicionarPreAFF = "@relation\t";
  adicionarPreAFF = strcat(adicionarPreAFF, caminhoAFF);
  adicionarPreAFF = strcat(adicionarPreAFF, "\n\n");
  caminhoAFF = strcat(caminhoAFF,".arff");
  arquivoAFF = fopen(caminhoAFF, 'w+');
  
  #caminho .txt
  caminhoTXT = "base_weka";
  caminhoTXT = strcat(caminhoTXT, num2str(i));
  caminhoTXT = strcat(caminhoTXT, ".txt");
  arquivoTXT = fopen(caminhoTXT, 'w+');
  
  #pré-formatando o aff
  fprintf(arquivoAFF, adicionarPreAFF);
  adicionarAtributo = "@attribute\t";
  atributo = "atr ";
  
  
  for k = 1:size(base,2);
    if k == size(base,2) && i~=5;
      adicionarPreAFF = strcat(adicionarAtributo,"class\t{2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25}\n");
    else;
      adicionarPreAFF = strcat(adicionarAtributo,atributo);
      adicionarPreAFF = strcat(adicionarPreAFF,num2str(k));
      adicionarPreAFF = strcat(adicionarPreAFF,"\treal\n");
    endif;
    fprintf(arquivoAFF, adicionarPreAFF);
  endfor;
  
  adicionarPreAFF = "\n@data\n";
  fprintf(arquivoAFF, adicionarPreAFF);
  
  adicionarElemento = "qualquer_coisa";
  #para a base dada, pega os valores
  for i=1:size(base,1);
    for j=1:size(base,2);
        adicionarElemento = num2str(base(i, j));
        adicionarElemento = strcat(adicionarElemento, "\t");
        fprintf(arquivoAFF, adicionarElemento);
        fprintf(arquivoTXT, adicionarElemento);
     endfor;
     fprintf(arquivoAFF, "\n");
     fprintf(arquivoTXT, "\n");
  endfor;
  fclose(arquivoAFF);
  fclose(arquivoTXT);
endfunction
