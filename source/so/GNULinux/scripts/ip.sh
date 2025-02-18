#!/bin/bash

function show_help() {
    echo -e "\033[32m-help                         : muestra la ayuda\033[0m"
    echo -e "\033[32m-file <archivo> <número_ips>  : Crea un archivo llamado <archivo> con <número_ips>  \033[0m"
    echo -e "\033[32m-find <archivo> <ip>          : Muestra cuantas veces aparece la <ip>  \033[0m"
    echo -e "\033[32m-read <archivo>               : Muestra de forma ordenada las IPs por número de conexiones  \033[0m"
}


if [[ $1 == '-help' ]]
then
  show_help
fi

if [[ $# -eq 0 ]]
then
  show_help
fi

if [[ $1 == '-file' ]]
then
  tiradas=${3:-50}
  outfile=${2:-ip.dat}
  for((i=0;i<$tiradas;i++))
  do
    echo 192.168.2.$((RANDOM % 14 + 1))
  done > $outfile
fi

if [[ $1 == '-find' ]]
then
  readfile=$2
  ip=$3
  if test -z $3
  then
      echo -e "\033[31m Proporcionar ip\033[0m"
  else
    if test -f $readfile
    then
      echo -e "\033[32m Leemos el archivo $readfile \033[0m"
      grep -c $ip $readfile
    else
      echo -e "\033[31m El archivo $readfile no existe\033[0m"
    fi
  fi
fi
if [[ $1 == '-read' ]]
then
  readfile=$2
  if test -f $readfile
  then
    echo -e "\033[32m Leemos el archivo $readfile \033[0m"
    cat $readfile | sort | uniq -c | sort -rn
  else
    echo -e "\033[31m El archivo $readfile no existe\033[0m"
  fi
fi

