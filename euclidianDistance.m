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
## @deftypefn {Function File} {@var{retval} =} euclidianDistance (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: JN <JN@JNMARCOS>
## Created: 2016-10-16

function [d] = euclidianDistance(a, b)
  d = 0;
  
  % size(a, 1) número de linhas
  % size(a, 2) número de colunas
  for i = 1:size(a, 2) - 2;
    d = d + (a(1, i) - b(1, i)) ^2;
  endfor
  
  d = sqrt(d);
  
endfunction