#!/bin/bash

tiradas=${1:-10000}
ganadas=0
gastadas=0

for ((i=1; i<=tiradas; i++)); do
  gastadas=$((gastadas+1))
  
  #generamos cada rodillo
  r1=$((RANDOM % 10))
  r2=$((RANDOM % 10))
  r3=$((RANDOM % 10))

  if [[ $r1 -eq $r2 && $r2 -eq $r3 ]]; then
    if [[ $r1 -eq 7 ]]; then #caso de 777
      ganadas=$((ganadas+10))
    else                     #caso 3 iguales sin contar el 777
      ganadas=$((ganadas+3))
    fi
  elif [[ $r1 -eq $r2 || $r1 -eq $r3 || $r2 -eq $r3 ]]; then #caso 2 iguales sin contar 3 iguales
    ganadas=$((ganadas+2))
  fi
done

echo "Tiradas realizadas: $tiradas"
echo "Monedas gastadas:   $gastadas"
echo "Monedas ganadas:    $ganadas"

balance=$((ganadas - gastadas))
echo "Balance final:      $balance"

if ((balance > 0)); then
  echo "Esta tragaperras ES rentable para el jugador."
else
  echo "Esta tragaperras NO es rentable para el jugador."
fi
