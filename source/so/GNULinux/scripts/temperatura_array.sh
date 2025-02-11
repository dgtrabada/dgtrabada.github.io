#!/bin/bash

nlineas=$(wc -l temperatura.dat | cut -d' ' -f1)
for((i=1;i<=$nlineas;i++))
do
  T[$i]=$(head -$i temperatura.dat | tail -1) 
done

suma=0.00
for((i=1;i<=$nlineas;i++))
do
  suma=$(echo $suma+${T[$i]} | bc -l)
done
echo $suma 

T_media=$(echo "scale=2; $suma/$nlineas" | bc -l)
echo "Tenemos $nlineas temperaturas, de media T = $T_media"
