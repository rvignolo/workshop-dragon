#!/bin/bash

# take 11 because I count from 0
nxs=11
xsnames=(D1 D2 Sa1 Ss12 Ss21 Sa2 nuSf1 nuSf2 eSf1 eSf2 Sf1 Sf2)
xsnamestex=(\$D_{1}\$~[cm] \
            \$D_{2}\$~[cm] \
            \$\\Sigma_{a1}\$~[cm\$^{-1}\$] \
            \$\\Sigma_{12}\$~[cm\$^{-1}\$] \
            \$\\Sigma_{21}\$~[cm\$^{-1}\$] \
            \$\\Sigma_{a2}\$~[cm\$^{-1}\$] \
            \$\\nu\\Sigma_{f1}\$~[cm\$^{-1}\$] \
            \$\\nu\\Sigma_{f2}\$~[cm\$^{-1}\$] \
            \$e\\Sigma_{f1}\$~[J\$\\cdot\$cm\$^{-1}\$] \
            \$e\\Sigma_{f2}\$~[J\$\\cdot\$cm\$^{-1}\$] \
            \$\\Sigma_{f1}\$~[cm\$^{-1}\$] \
            \$\\Sigma_{f2}\$~[cm\$^{-1}\$])

# if you have pyxplot, do something nicer
if [ "`which pyxplot`" = "" ]; then
  j=1
  for i in ${xsnames[@]}; do
    j=$((j+1))
   gnuplot -p -e "set xlabel 'burnup'; set ylabel '${i}'; plot 'xs.dat' u 1:${j} w lp pt ${j} ti '${i}'"
  done
else
  for i in `seq 0 ${nxs}`; do
    m4 -Dfile=${xsnames[$i]} \
       -Dcoef=${xsnamestex[$i]} \
       -Dindex=`echo "$i + 2" |bc` \
       -Dstyle1=`echo "$i + 2" |bc` xs-burn-ppl.m4 > pyxplot.ppl

    printf "  plotting ${xsnames[$i]}..."
    pyxplot pyxplot.ppl
    printf "ok!\n"
  done
  rm pyxplot.ppl
  echo "joining pdfs"
  for i in `seq 1 ${nxs}`; do
    pdfjoin --rotateoversize 'false' ${xsnames[$i-1]}.pdf ${xsnames[$i]}.pdf 2> /dev/null
    rm ${xsnames[$i-1]}.pdf
    mv ${xsnames[$i]}-joined.pdf ${xsnames[$i]}.pdf
  done
  mv ${xsnames[$i]}.pdf xs-vs-burn.pdf

  okular xs-vs-burn.pdf &
fi