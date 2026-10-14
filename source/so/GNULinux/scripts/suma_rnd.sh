#!/bin/bash

NL=$(wc -l R.dat | cut -d' ' -f1)
suma=0
for((i=0;i<$NL;i++))
do
  n=$(head -$((i+1)) R.dat | tail -1)
  suma=$((suma+n))
done

echo "El archivo R.dat tiene $NL números, la suma es $suma"
