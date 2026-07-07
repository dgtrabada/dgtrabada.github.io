#!/bin/bash

archivo="meteo.dat"

n=0
sum_min=0
sum_max=0
sum_hum=0

dia_caluroso=""
t_caluroso=-100
dia_frio=""
t_frio=100
dia_amplitud=""
amplitud_max=0

while read dia tmin tmax hum
do
  n=$((n+1))
  sum_min=$(echo "$sum_min + $tmin" | bc -l)
  sum_max=$(echo "$sum_max + $tmax" | bc -l)
  sum_hum=$(echo "$sum_hum + $hum" | bc -l)

  # con decimales no podemos usar -gt o -lt, comparamos con bc
  if [ $(echo "$tmax > $t_caluroso" | bc -l) -eq 1 ]
  then
    t_caluroso=$tmax
    dia_caluroso=$dia
  fi

  if [ $(echo "$tmin < $t_frio" | bc -l) -eq 1 ]
  then
    t_frio=$tmin
    dia_frio=$dia
  fi

  amplitud=$(echo "$tmax - $tmin" | bc -l)
  if [ $(echo "$amplitud > $amplitud_max" | bc -l) -eq 1 ]
  then
    amplitud_max=$amplitud
    dia_amplitud=$dia
  fi
done < $archivo

echo "Temperatura mínima media : $(echo "scale=1; $sum_min / $n" | bc) ºC"
echo "Temperatura máxima media : $(echo "scale=1; $sum_max / $n" | bc) ºC"
echo "Humedad media            : $(echo "scale=1; $sum_hum / $n" | bc) %"
echo "Día más caluroso         : $dia_caluroso ($t_caluroso ºC)"
echo "Día más frío             : $dia_frio ($t_frio ºC)"
echo "Día con mayor amplitud   : $dia_amplitud ($amplitud_max ºC)"
