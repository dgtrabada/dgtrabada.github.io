#!/bin/bash

mostrar_ayuda() {
    echo "Uso: ./allrnd.sh [opción]
Genera números aleatorios en un archivo y los analiza.
Opciones:
  -help                          Muestra este mensaje de ayuda.
  -generar [-n N] [-archivo <archivo>]
                                 Guarda N números aleatorios (por defecto 4)
                                 en <archivo> (por defecto R.dat).
  -analizar [-archivo <archivo>] Muestra cuántos números tiene <archivo> (por defecto R.dat),
                                 su suma, el valor máximo y el mínimo.

Ejemplos:
  ./allrnd.sh -generar -n 10 -archivo datos.dat
  ./allrnd.sh -analizar -archivo datos.dat"
}

generar() {
  # $1: cantidad de números, $2: archivo
  rm -fr $2
  for((i=0;i<$1;i++))
  do
    echo $RANDOM >> $2
  done
  echo "Se han guardado $1 números aleatorios en $2"
}

analizar() {
  # $1: archivo
  if [ ! -f $1 ]
  then
    echo "El archivo $1 no existe"
    exit 1
  fi
  NL=$(wc -l $1 | cut -d' ' -f1)
  suma=0
  max=$(head -1 $1)
  min=$(head -1 $1)
  for((i=0;i<$NL;i++))
  do
    n=$(head -$((i+1)) $1 | tail -1)
    suma=$((suma+n))
    if [ $n -gt $max ]
    then
      max=$n
    fi
    if [ $n -lt $min ]
    then
      min=$n
    fi
  done
  echo "El archivo $1 tiene $NL números, la suma es $suma"
  echo "El valor máximo es $max y el mínimo es $min"
}

case $1 in
  -generar)
    N=4
    archivo="R.dat"
    if [[ $2 == "-n" ]]            # primera pareja opción valor: $2 $3
    then
      N=$3
    elif [[ $2 == "-archivo" ]]
    then
      archivo=$3
    fi
    if [[ $4 == "-n" ]]            # segunda pareja opción valor: $4 $5
    then
      N=$5
    elif [[ $4 == "-archivo" ]]
    then
      archivo=$5
    fi
    generar $N $archivo
    ;;
  -analizar)
    archivo="R.dat"
    if [[ $2 == "-archivo" ]]
    then
      archivo=$3
    fi
    analizar $archivo
    ;;
  *)
    mostrar_ayuda
    ;;
esac
