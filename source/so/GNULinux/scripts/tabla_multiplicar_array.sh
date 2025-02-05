#!/bin/bash

mostrar_ayuda() {
    echo "Uso: ./tabla_multiplicar_array.sh [número]
    Este script muestra la tabla de multiplicar del número que se le pase como argumento.
    Opciones:
      --help   Muestra este mensaje de ayuda.

    Ejemplos:
    ./tabla_multiplicar.sh 4   Muestra la tabla de multiplicar del 4."
}


if [[ $# -eq 0 ]]
then
    # Sin argumentos: mostrar ayuda
    mostrar_ayuda
elif [[ $1 == "--help" ]]
  then
    mostrar_ayuda
else
    numero=$1
   for ((i=1;i<11;i++))
   do
     A[$i]=$i
   done
   longitud=${#A[@]}
   for((i=1;i<$longitud;i++))
   do
     echo "$numero x ${A[$i]} = $(($numero * ${A[$i]}))"
   done
fi

