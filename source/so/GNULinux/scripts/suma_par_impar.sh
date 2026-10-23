#!/bin/bash
ayuda(){
  echo "Uso: ./suma_par_impar.sh <N>"
  echo "Muestra los números del 1 al N (N entre 1 y 20) indicando si son pares o impares"
}
if [ $# -eq 0 ] || [ "$1" == "--help" ]
then
  ayuda
  exit
fi
if [ $1 -lt 1 ] || [ $1 -gt 20 ]
then
  echo "Error: N tiene que estar entre 1 y 20"
  exit
fi
pares=0
impares=0
for((i=1;i<=$1;i++))
do
  if [ $((i%2)) -eq 0 ]
  then
    echo "$i par"
    pares=$((pares+i))
  else
    echo "$i impar"
    impares=$((impares+i))
  fi
done
echo "Suma de pares: $pares, suma de impares: $impares"
