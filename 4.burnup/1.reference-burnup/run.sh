#!/bin/bash

#------------+--------------+-------+------+-----++----+++---++++--+++++
# TALLER
# Aprendiendo a utilizar DRAGON V5 como código de producción de XSs
# Grupo Argentino de Cálculo y Análisis de Reactores
# III Reunión Anual
#
# File desc.: Geometry definition and Ray tracing
# Ramiro Vignolo    <rvignolo@tecna.com>
#                   <ramirovignolo@gmail.com>
#------------+--------------+-------+------+-----++----+++---++++--+++++

# clean directory
./clean.sh

# add any option
plot=0
for opt in $*; do
  case $opt in
    -g) 
        plot=1
        ;;
  esac
done

# lets find the dragon input
input=`ls -la | grep *.x2m | awk '{print $9}'`

# and the library
ln -sf ../../1.materials/2.microscopic/WLUP

# and generate an output file name
output=`basename $input .x2m`
output=${output}.result

# if dragon is seen globally
dragon <${input} > ${output}

# te imprimo un poquito asi ves
tail -5 ${output}; tput setaf 3; echo "    check out the ${output} file"; tput sgr0
echo

# en este caso, dibujamos
if [ $plot = 1 ]; then
  tput setaf 4; echo "GhostView Graphics are on"; tput sgr0
  for i in *.ps; do
    gv $i &
  done
fi

# compilamos rutina de C usando GanLib
./compile.sh

# generamos las XS
./ref-burnup Database.dat

# y las dibujamos
./xs-plot.sh