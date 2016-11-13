#Tamanyo A4 apaisado.
set width 22*unit(cm)
set papersize a4
set preamble "\usepackage{amsmath}"
set axis x arrow nomirrored
set axis y arrow nomirrored
set xformat "%.0f"%(x)

set grid

set key top right
load "styles.ppl"

set xrange [* : *]
set yrange [* : *]
#set title ''


set terminal pdf
set output 'file.pdf'
set ylabel 'coef'
set xlabel 'BU [MWd/TnU]'
plot "./xs.dat" u 1:index w lp style style1 ti 'coef'
     
