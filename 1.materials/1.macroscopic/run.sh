#!/bin/bash

#------------+--------------+-------+------+-----++----+++---++++--+++++
# TALLER
# Aprendiendo a utilizar DRAGON V5 como código de producción de XSs
# Grupo Argentino de Cálculo y Análisis de Reactores
# III Reunión Anual
#
# File desc.: run macroscopic XS reading with DRAGON
# Ramiro Vignolo    <rvignolo@tecna.com>
#                   <ramirovignolo@gmail.com>
#------------+--------------+-------+------+-----++----+++---++++--+++++

# clean directory
./clean.sh

# lets find the dragon input
input=`ls -la | grep *.x2m | awk '{print $9}'`

# and generate an output file name
output=`basename $input .x2m`
output=${output}.result

# if dragon is seen globally
dragon <${input} > ${output}

# y te imprimo un poquito asi ves
tail -5 ${output}; tput setaf 3; echo "    check out the ${output} file"; tput sgr0
echo
