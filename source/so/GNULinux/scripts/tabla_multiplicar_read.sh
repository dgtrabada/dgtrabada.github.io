#!/bin/bash

echo "Introduce un número para mostrar su tabla de multiplicar: "
read numero

for ((i=1;i<11;i++))
do
    resultado=$((numero * i))
    echo "$numero x $i = $resultado"
done
