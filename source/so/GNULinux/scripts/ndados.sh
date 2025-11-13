#!/bin/bash

function mostrar_ayuda() {
    echo -e "\033[32m -help\033[0m"
    echo -e "\033[32m -tiradas <nº tiradas> \033[0m"
    echo -e "\033[32m -ndados <nº dados> \033[0m"
}

function tirar_ndados_ntiradas(){

    for ((i = $ndados; i <= $((ndados*6)); i++)); do
      frecuencias[$i]=0
    done

    for ((i = 1; i <= tiradas; i++)); do
      suma=0
      for (( j = 1; j <= ndados; j++)); do 
        dado[$j]=$((RANDOM % 6 + 1))       
        suma=$((suma + ${dado[$j]}))
      done
      frecuencias[$suma]=$((frecuencias[$suma]+1))
    done

    echo "De $tiradas tiradas para $ndados dados:"
    for ((i = $ndados; i <= $((ndados))*6; i++)); do
      porcentaje=$(echo "scale=2; ${frecuencias[$i]} * 100 / $tiradas" | bc -l)
      echo "$i (${porcentaje}%)"
    done
}



if [[ $# -eq 0 ]]
then
    # Sin argumentos: mostrar ayuda
    mostrar_ayuda
elif [[ $1 == "-help" ]]
  then
    mostrar_ayuda
else
    tiradas=1000
    ndados=2
    for j in $@
    do       
      shift 
      if [ $j == "-tiradas" ]
      then
        tiradas=$1 
      fi
      if [ $j == "-ndados" ]
      then
        ndados=$1 
      fi
    done
    tirar_ndados_ntiradas 
fi



