#!/bin/bash
ayuda(){
  echo "Uso:"
  echo "  ./puertos.sh -file <archivo> <N>  crea <archivo> con N conexiones a puertos aleatorios"
  echo "  ./puertos.sh -read <archivo>      muestra los puertos ordenados por número de conexiones"
}
if [ "$1" == "-file" ]
then
  archivo=${2:-conexiones.dat}
  n=${3:-50}
  puertos=(22 80 443 3306 3389 8080)
  for((i=0;i<$n;i++))
  do
    echo "10.0.1.$((RANDOM % 30 + 1)) ${puertos[$((RANDOM % 6))]} tcp"
  done > $archivo
elif [ "$1" == "-read" ]
then
  if [ ! -f "$2" ]
  then
    echo "Error: el archivo no existe"
  else
    cut -d' ' -f2 $2 | sort | uniq -c | sort -nr
  fi
else
  ayuda
fi
