#!/bin/bash

awk '{
  sum_min += $2
  sum_max += $3
  sum_hum += $4

  if ($3 > t_caluroso) { t_caluroso = $3 ; dia_caluroso = $1 }
  if (NR == 1 || $2 < t_frio) { t_frio = $2 ; dia_frio = $1 }
  if ($3 - $2 > amplitud_max) { amplitud_max = $3 - $2 ; dia_amplitud = $1 }
}
END {
  printf "Temperatura mínima media : %.1f ºC\n", sum_min/NR
  printf "Temperatura máxima media : %.1f ºC\n", sum_max/NR
  printf "Humedad media            : %.1f %%\n", sum_hum/NR
  print  "Día más caluroso         : " dia_caluroso " (" t_caluroso " ºC)"
  print  "Día más frío             : " dia_frio " (" t_frio " ºC)"
  print  "Día con mayor amplitud   : " dia_amplitud " (" amplitud_max " ºC)"
}' meteo.dat
