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
## @deftypefn {Function File} {@var{retval} =} transformar_regra_p_texto (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: JN <JN@JNMARCOS-PC>
## Created: 2017-03-14

function [particao_candidato_s] = transformar_regra_p_texto (particao_candidato)
particao_candidato_s = cell(1,columns(particao_candidato));
for its=1:columns(particao_candidato)        
    switch (particao_candidato{its})
                   case "1" 
                            particao_candidato_s{its} = "trabalha";
                   case "2" 
                            particao_candidato_s{its} = "e_fundamental";
                   case "3" 
                            particao_candidato_s{its} = "e_cientifico";
                   case "4" 
                            particao_candidato_s{its} = "e_graduacao";
                   case "5" 
                            particao_candidato_s{its} = "e_mestrado";
                   case "6"
                            particao_candidato_s{its} = "e_doutorado";
                   case "7" 
                            particao_candidato_s{its} = "e_masculino";
                   case "8"  
                            particao_candidato_s{its} = "e_branco";
                   case "9" 
                             particao_candidato_s{its} = "e_preto";
                   case "10" 
                            particao_candidato_s{its} = "e_pardo";
                   case "11" 
                            particao_candidato_s{its} = "e_amarelo";
                   case "12" 
                            particao_candidato_s{its} = "e_indigena";
                   case "13" 
                            particao_candidato_s{its} = "possui_auto";
                   case "14" 
                            particao_candidato_s{its} = "e_casado";
                   case "15"  
                            particao_candidato_s{its} = "peso_45_69";
                   case "16" 
                             particao_candidato_s{its} = "peso_70_89";
                   case "17" 
                            particao_candidato_s{its} = "peso_90_134";
                   case "18" 
                            particao_candidato_s{its} = "alt_160_169";
                   case "19" 
                            particao_candidato_s{its} = "alt_170_179";
                   case "20" 
                            particao_candidato_s{its} = "alt_180_189";
                   case "21" 
                            particao_candidato_s{its} = "id_19_23";
                   case "22" 
                            particao_candidato_s{its} = "id_24_28";
                   case "23" 
                            particao_candidato_s{its} = "id_29_33";
                   case "24" 
                            particao_candidato_s{its} = "id_34_38";
                   case "25" 
                            particao_candidato_s{its} = "id_39_44";
                   case "26" 
                            particao_candidato_s{its} = "qtd_livro_0_4";
                   case "27" 
                            particao_candidato_s{its} = "qtd_livro_5_9";
                   case "28" 
                            particao_candidato_s{its} = "qtd_livro_10_14";
                   case "29" 
                            particao_candidato_s{its} = "qtd_livro_15_19";
                   case "30" 
                            particao_candidato_s{its} = "qtd_livro_20_24";
                   case "31" 
                            particao_candidato_s{its} = "qtd_livro_25_30";
   endswitch;
endfor;
endfunction
