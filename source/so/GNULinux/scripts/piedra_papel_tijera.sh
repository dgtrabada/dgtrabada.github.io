#!/bin/bash

opcion=( "piedra" "papel" "tijera" )

contador_gana1=0
contador_gana2=0
contador_empate=0
n_turnos=${1:-10}

for  (( i=1; i<=n_turnos; i++ ))
do
  jugador1=${opcion[$(($RANDOM % 3))]}
  jugador2=${opcion[$(($RANDOM % 3))]}
  #echo "$jugador1, $jugador2"


  #Empates
  if [ $jugador1 == $jugador2 ]
  then
    contador_empate=$(($contador_empate+1))
  fi


  #Gana 1
  if [ $jugador1 == "piedra" ] && [ $jugador2 == "tijera" ]
  then
    contador_gana1=$(($contador_gana1+1))
  fi
  if [ $jugador1 == "papel" ] && [ $jugador2 == "piedra" ]
  then
    contador_gana1=$(($contador_gana1+1))
  fi
  if [ $jugador1 == "tijera" ] && [ $jugador2 == "papel" ]
  then
    contador_gana1=$(($contador_gana1+1))
  fi

  #Gana 2
  if [ $jugador2 == "piedra" ] && [ $jugador1 == "tijera" ]
  then
    contador_gana2=$(($contador_gana2+1))
  fi
  if [ $jugador2 == "papel" ] && [ $jugador1 == "piedra" ]
  then
    contador_gana2=$(($contador_gana2+1))
  fi
  if [ $jugador2 == "tijera" ] && [ $jugador1 == "papel" ]
  then
    contador_gana2=$(($contador_gana2+1))
  fi
done

#echo "$contador_empate, $contador_gana1, $contador_gana2"
port_empate=$(echo "scale=2 ; $contador_empate*100/$n_turnos" | bc -l)
port_gana1=$(echo "scale=2 ; $contador_gana1*100/$n_turnos" | bc -l)
port_gana2=$(echo "scale=2 ; $contador_gana2*100/$n_turnos" | bc -l)

echo "Empate = $port_empate %,  Gana 1 = $port_gana1 %, Gana 2 = $port_gana2"
