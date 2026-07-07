#!/bin/bash

archivo="meteo.dat"

dia=()
tmin=()
tmax=()
hum=()

while read d min max h
do
  dia+=($d)
  tmin+=($min)
  tmax+=($max)
  hum+=($h)
done < $archivo

n=${#dia[@]}
sum_min=0
sum_max=0
sum_hum=0
imax=0 # índice del día más caluroso
imin=0 # índice del día más frío
iamp=0 # índice del día con mayor amplitud

for((i=0;i<$n;i++))
do
  sum_min=$(echo "$sum_min + ${tmin[$i]}" | bc -l)
  sum_max=$(echo "$sum_max + ${tmax[$i]}" | bc -l)
  sum_hum=$(echo "$sum_hum + ${hum[$i]}" | bc -l)

  # con decimales no podemos usar -gt o -lt, comparamos con bc
  if [ $(echo "${tmax[$i]} > ${tmax[$imax]}" | bc -l) -eq 1 ]; then imax=$i ; fi
  if [ $(echo "${tmin[$i]} < ${tmin[$imin]}" | bc -l) -eq 1 ]; then imin=$i ; fi

  amplitud=$(echo "${tmax[$i]} - ${tmin[$i]}" | bc -l)
  amplitud_max=$(echo "${tmax[$iamp]} - ${tmin[$iamp]}" | bc -l)
  if [ $(echo "$amplitud > $amplitud_max" | bc -l) -eq 1 ]; then iamp=$i ; fi
done

echo "Temperatura mínima media : $(echo "scale=1; $sum_min / $n" | bc) ºC"
echo "Temperatura máxima media : $(echo "scale=1; $sum_max / $n" | bc) ºC"
echo "Humedad media            : $(echo "scale=1; $sum_hum / $n" | bc) %"
echo "Día más caluroso         : ${dia[$imax]} (${tmax[$imax]} ºC)"
echo "Día más frío             : ${dia[$imin]} (${tmin[$imin]} ºC)"
echo "Día con mayor amplitud   : ${dia[$iamp]} ($(echo "${tmax[$iamp]} - ${tmin[$iamp]}" | bc) ºC)"
