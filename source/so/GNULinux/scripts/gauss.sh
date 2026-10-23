#!/bin/bash

if [ $# -eq 0 ]
then
  echo "Uso: ./gauss.sh <N>"
  exit
fi

N=$1
suma=0
for((i=1;i<=$N;i++))
do
  suma=$((suma+i))
done
gauss=$((N*(N+1)/2))

echo "Sumando con un bucle del 1 al $N: $suma"
echo "Con la fórmula de Gauss N*(N+1)/2: $gauss"
if [ $suma -eq $gauss ]
then
  echo "Coinciden"
else
  echo "No coinciden"
fi
