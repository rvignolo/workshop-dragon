#!/bin/bash

#------------+--------------+-------+------+-----++----+++---++++--+++++
# Workshop
# Learning DRAGON V5 as a production code for XSs
# Argentinean Group of Calculation and Reactor Analysis
# III Annual Meeting
#
# File desc.: Macroscopic XS reading with DRAGON V5
# Ramiro Vignolo    <ramirovignolo@gmail.com>
#
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