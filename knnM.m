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
## @deftypefn {Function File} {@var{retval} =} knn (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: JN <JN@JNMARCOS>
## Created: 2016-10-21

function [baseFinal] = knnM (k, base)
  for i = 1:size(base,1);
    [x] = find (base(i,:) == -1); #obtém as colunas da linha i que tem -1
    if size(x,2) >= 1;
      mediaDistancia = 0;
      distancias = zeros(size(base, 1), 2); 
        for j = 1:size(distancias, 1);
          #passa a linha do exemplo, e a linha da base que será usada para 
          if j ~= i;
          distancias(j, 1) = euclidianDistance(base(i,:), base(j, :));
            if distancias(j,1) < 0; #correção normalização
              distancias(j,1) = 0.0;
            endif;
          endif;
          distancias(j, 2) = j;
        endfor;
        distancias = sortrows(distancias, 1);#organiza em ordem crescente a 1ª col
        distancias = distancias(1:k,1:2); #pega os k-melhores
        
        for l = 1:size(x,2);
          c = x(l); #c de coluna
          #mediaDistancia = base(distancias(1,2), c) + base(distancias(2,2), c);
          #mediaDistancia = mediaDistancia + base(distancias(3,2), c);
          #mediaDistancia = mediaDistancia + base(distancias(4,2), c);
          #mediaDistancia = mediaDistancia + base(distancias(5,2), c);
          mediaDistancia = sum(base(distancias(:,2), c));
          mediaDistancia = mediaDistancia/k;
          if mediaDistancia < 0;
            mediaDistancia = -1 * mediaDistancia;
          endif;
          base(i, c) = mediaDistancia;
        endfor;
      else
        
      endif;
  endfor; 
  baseFinal = base;
endfunction;