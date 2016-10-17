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

function [] = pcaP(base)
  means = zeros(1, size(base, 2));
  
  #tira a média de cada um dos atributos da base
  for i=1:length(base);
    means(1, i) = mean(base(:, i));
  end;

  base_auxiliar = base(:, 1) - means(1, 1) / std(base(:, 1);
  
  for j=2:length(base);
    base_auxiliar = horzcat(base_auxiliar, base(:, j) - means(1, j) / std(base(:, j))
  end;
  
  
  #faz desenho em dois d
  scatter(base_auxiliar(:, 1), base_auxiliar(:, 2));
  #calcula a covariância
  c = cov(base_auxiliar);
  
  [v, a] = eig(c);

  v = horzcat(v(:, 2), v(:, 1));

  d2 = v'*base_auxiliar';
  hold on

  #faz desenho em dois d
  scatter(d2(1, :), d2(2, :), 'r', '*');

endfunction
