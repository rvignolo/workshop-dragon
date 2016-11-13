#!/bin/bash

xsnames=(D1 D2 Sa1 Ss12 Ss21 Sa2 nuSf1 nuSf2 eSf1 eSf2 Sf1 Sf2)

j=2
for i in ${xsnames[@]}; do
  j=$((j+1))
 gnuplot -p -e "splot 'xs-local-perturbation.dat' u 1:2:${j} w lp ti '${i}'" 
done