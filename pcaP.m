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
## @deftypefn {Function File} {@var{retval} =} pca (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: JN <JN@JNMARCOS>
## Created: 2016-10-08

function [d2] = pcaP(base)
  base2 = base;
  base2(:,end) = [];
  base2(:,end) = [];
  
  base2;
  #número de atributos
  #means = zeros(1, size(base, 2));
  
  #tira a média de cada um dos atributos da base
  #for i=1:size(base,2);
   #means(1, i) = mean(base(:, i));
  #end;

  #base_auxiliar = base(:, 1) - means(1, 1) / std(base(:, 1)); 
  
  #for j=2:size(base,2);
   # base_auxiliar = horzcat(base_auxiliar, base(:, j) - means(1, j) / std(base(:, j)));
  #end;
  
  
  #calcula a covariância
  c = cov(base2, 0);
  
  [v, a] = eig(c);
  b = zeros(size(a,1) + 2, 2);
  for i = 1:size(a,1);
    b(i,1) = a(i,i);
    b(i,2) = i;
  endfor;

  b = sortrows(b, 1);
  b2 = b(71:-1:1);
  
  #só se quer os quatro maiores
  vetor_org = v(:,69);
  valor = b2(1,1) #antes b2
  t = 1;
  u = 68;
  while valor < 0.90 && t < 69
    vetor_org = horzcat(vetor_org, v(:,u));
    valor = valor + b2(t + 1) #antes b2
    u = u - 1;
    t = t + 1;
  end;
  
  for i = 1:size(vetor_org, 1);
    maximo = max(vetor_org(i,:));
    minimo = min(vetor_org(i,:));
    for j = 1:size(vetor_org,2);
    if vetor_org(i,j) < 0;
      vetor_org(i, j) = -1 * vetor_org(i,j);
    endif;
      vetor_org(i,j) = vetor_org(i,j) - maximo/ (maximo - minimo);
    endfor;
  endfor;
  d2 = vetor_org'*base2';
  d2 = d2';
  hold on

  #faz desenho em dois d
  scatter(d2(1, :), d2(2, :), 'r', '*');

endfunction
