#!/bin/bash

NL=$(wc -l R.dat | cut -d' ' -f1)
suma=0
max=$(head -1 R.dat)
min=$(head -1 R.dat)
for((i=0;i<$NL;i++))
do
  n=$(head -$((i+1)) R.dat | tail -1)
  suma=$((suma+n))
  if [ $n -gt $max ]
  then
    max=$n
  fi
  if [ $n -lt $min ]
  then
    min=$n
  fi
done

echo "El archivo R.dat tiene $NL números, la suma es $suma"
echo "El valor máximo es $max y el mínimo es $min"
