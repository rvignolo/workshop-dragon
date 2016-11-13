#!/bin/bash

gcc -c -g ref-burnup.c -I$HOME/codigos/dragon/Version5_ev714/Ganlib/src/
gcc ref-burnup.o -o ref-burnup $HOME/codigos/dragon/Version5_ev714/Ganlib/lib/Linux_x86_64/libGanlib.a
