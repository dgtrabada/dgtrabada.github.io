#!/bin/bash

n_max_adivinar=20
numero_secreto=$((RANDOM % $n_max_adivinar + 1))
intento=0
comparar=-1

maximo=$n_max_adivinar
minimo=0

while [[ $comparar != 0 ]]
do
  intento=$((intento+1))
  numero_elegido=$((RANDOM % $((maximo-minimo)) + 1 + $minimo))
  repetido=1
  while [[ $repetido -eq 1 ]]
  do
    repetido=0
    for((i=0;i<=${#I[@]};i++))
    do
      if [[  ${I[$i]} -eq $numero_elegido ]]
      then
        repetido=1
      fi
    done

    if [[ $repetido -eq 1 ]]
    then
       numero_elegido=$((RANDOM % $((maximo-minimo)) + 1 + $minimo))
    fi
  done

  if [[ $numero_elegido -lt $numero_secreto ]]
  then
    comparar=-1
    minimo=$numero_elegido
  fi
  if [[ $numero_elegido -gt $numero_secreto ]]
  then
    comparar=1
    maximo=$numero_elegido
  fi

  if [[ $numero_elegido -eq $numero_secreto ]]
  then
    comparar=0
  fi
  #echo $intento $numero_secreto  $numero_elegido  $comparar $maximo $minimo $repetido
  I[$intento]=$numero_elegido
done
#sacamos el número de intentos que ha hecho hasta adividnar el resultado
echo $intento
