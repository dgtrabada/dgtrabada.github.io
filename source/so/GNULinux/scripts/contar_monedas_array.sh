#!/bin/bash

for((i=0;i<10;i++))
do
  x[$i]=0
done

total=0

for((i=0;i<$(wc -l monedas.dat | cut -d' ' -f1);i++))
do
  monedas=$(head -$i monedas.dat | tail -1 )
  total=$((total+monedas))

  for((j=0;j<10;j++))
  do
    if [[ $monedas -eq $j ]]
    then
      x[$j]=$((x[$j]+1))
    fi
  done
done

for((i=0;i<10;i++))
do
  echo hay ${x[$i]} con $i euros
done

echo hay $total de dinero

