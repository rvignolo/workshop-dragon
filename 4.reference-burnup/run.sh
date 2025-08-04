#!/bin/bash

#------------+--------------+-------+------+-----++----+++---++++--+++++
# Workshop
# Learning DRAGON V5 as a production code for XSs
# Argentinean Group of Calculation and Reactor Analysis
# III Annual Meeting
#
# File desc.: Geometry definition and Ray tracing
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

# let's find the dragon input
input=`ls -la | grep *.x2m | awk '{print $9}'`

# and the library
ln -sf ../1.materials/2.microscopic/WLUP

# and generate an output file name
output=`basename $input .x2m`
output=${output}.result

# if dragon is seen globally
dragon <${input} > ${output}

# print a little bit so you can see
tail -5 ${output}; tput setaf 3; echo "    check out the ${output} file"; tput sgr0
echo

# in this case, we draw
if [ $plot = 1 ]; then
  tput setaf 4; echo "GhostView Graphics are on"; tput sgr0
  for i in *.ps; do
    gv $i &
  done
fi

# compile the C routine using GanLib
./compile.sh

# generate the XSs
./ref-burnup Database.dat

# and draw them
./xs-plot.sh