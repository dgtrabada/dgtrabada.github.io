#!/bin/bash

function show_help() {
    echo -e "\033[32m -help\033[0m"
    echo -e "\033[32m -n <tiradas> <archivo> \033[0m"
    echo -e "\033[32m -read <archivo> \033[0m"
}


if [[ $1 == '-help' ]]
then
  show_help
fi

if [[ $1 == '-n' ]]
then
  tiradas=${2:-100}
  outfile=${3:-monedas.dat}
  for((i=0;i<$tiradas;i++))
  do
    echo $((RANDOM % 2)) $((RANDOM % 2)) $((RANDOM % 2))
  done > $outfile
fi

if [[ $1 == '-read' ]]
then
  readfile=${2:-monedas.dat}
  if test -f $readfile
  then
    echo -e "\033[32m Leemos el archivo $readfile \033[0m"
    tres_caras=$(grep -c '1 1 1' $readfile)
    n_total=$(wc -l $readfile | cut -d ' ' -f1)
    echo -e "\033[33m Tenemos $((tres_caras * 100 / n_total))%  de tiradas con tres caras \033[0m"
  else
    echo -e "\033[31m El archivo $readfile no existe\033[0m"
  fi
fi





