#!/bin/bash

gcc -c -g local-perturbation.c -I$HOME/codigos/dragon/Version5_ev714/Ganlib/src/
gcc local-perturbation.o -o local-perturbation $HOME/codigos/dragon/Version5_ev714/Ganlib/lib/Linux_x86_64/libGanlib.a
