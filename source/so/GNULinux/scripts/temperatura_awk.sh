#!/bin/bash


media=$(awk '{ suma += $1 } END { print suma/NR }' temperatura.dat )
ntemperaturas=$(awk 'END { print NR }' temperatura.dat)

echo "Tenemos $ntemperaturas temperaturas, de media T = $media"
