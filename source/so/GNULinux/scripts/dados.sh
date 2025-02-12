#!/bin/bash

tiradas=${1:-1000}

for ((i = 2; i <= 12; i++)); do
  frecuencias[$i]=0
done

for ((i = 1; i <= tiradas; i++)); do
  dado1=$((RANDOM % 6 + 1))
  dado2=$((RANDOM % 6 + 1))
  suma=$((dado1 + dado2))
  frecuencias[$suma]=$((frecuencias[$suma]+1))
done

echo "De $tiradas tiradas:"
output=""
for ((i = 2; i <= 12; i++)); do
  porcentaje=$((frecuencias[$i] * 100 / tiradas))
  output+="$i(${porcentaje}%) "
done

echo "$output"
