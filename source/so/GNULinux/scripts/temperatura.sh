#!/bin/bash

nlineas=$(wc -l temperatura.dat | cut -d' ' -f1)
T=0.00
for((i=1;i<=$nlineas;i++))
do 
  T=$(echo "scale=2; $T+$(head -$i temperatura.dat | tail -1)" | bc -l)
done
T_media=$(echo "scale=2; $T/$nlineas" | bc -l)
echo "Tenemos $nlineas temperaturas, de media T = $T_media"
