#!/bin/bash

for((i=0;i<10;i++)
do
  x[$i]=0
done

total=0

for((i=0;i<$(wc -l monedas.dat | cut -d' ' -f);i++))
do
  x=$(head -$i monedas.dat | tail -1 )
  total=$((total+x))

  if [[ ${x[$i]} -eq $i ]]
  then 
    x[$i]=$((x[$i]+1))
  fi

done

for((i=0;i<10;i++)
do
  echo hay ${x[$i]} con $i euros
done

echo hay $total de dinero

