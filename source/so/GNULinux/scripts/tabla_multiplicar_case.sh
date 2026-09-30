#!/bin/bash

mostrar_ayuda() {
    echo "Uso: ./tabla_multiplicar_case.sh [número]
Este script muestra la tabla de multiplicar del número que se le pase como argumento.
Opciones:
  --help   Muestra este mensaje de ayuda.

Ejemplos:
  ./tabla_multiplicar_case.sh 4   Muestra la tabla de multiplicar del 4."
}

if [[ $# -gt 1 ]]
then
    echo "No se puede dar más de un argumento"
    exit 1
fi

case $1 in
    ""|--help)
        mostrar_ayuda
        ;;
    [1-9]|10)
        numero=$1
        for ((i=1;i<11;i++))
        do
          resultado=$((numero * i))
          echo "$numero x $i = $resultado"
        done
        ;;
    *)
        echo "$1 no es un número del 1 al 10"
        mostrar_ayuda
        ;;
esac
