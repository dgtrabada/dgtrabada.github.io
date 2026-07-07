#!/bin/bash

function show_help() {
    echo -e "\033[32m-help                                        : muestra la ayuda\033[0m"
    echo -e "\033[32m-crear <archivo> <N>                         : Crea un csv con N equipos\033[0m"
    echo -e "\033[32m-add <archivo> <hostname> <ip> <ram> <estado>: Añade un equipo al csv\033[0m"
    echo -e "\033[32m-find <archivo> <hostname>                   : Muestra la información del equipo\033[0m"
    echo -e "\033[32m-del <archivo> <hostname>                    : Borra el equipo del csv\033[0m"
    echo -e "\033[32m-read <archivo>                              : Muestra el inventario en forma de tabla\033[0m"
    echo -e "\033[32m-resumen <archivo>                           : Muestra un resumen del inventario\033[0m"
}

if [[ $1 == '-help' ]]
then
  show_help
fi

if [[ $# -eq 0 ]]
then
  show_help
fi

if [[ $1 == '-crear' ]]
then
  outfile=${2:-inventario.csv}
  n=${3:-20}
  ram=(4 8 16 32 64)
  estado=(activo apagado mantenimiento)
  echo "hostname,ip,ram_gb,estado" > $outfile
  for((i=1;i<=$n;i++))
  do
    printf "pc-%02d,192.168.1.%d,%d,%s\n" $i $((RANDOM % 254 + 1)) ${ram[$((RANDOM % 5))]} ${estado[$((RANDOM % 3))]}
  done >> $outfile
  echo -e "\033[32m Creado $outfile con $n equipos \033[0m"
fi

if [[ $1 == '-add' ]]
then
  readfile=$2
  if test -f $readfile
  then
    if [[ $# -lt 6 ]]
    then
      echo -e "\033[31m Faltan campos: -add <archivo> <hostname> <ip> <ram> <estado>\033[0m"
    else
      echo "$3,$4,$5,$6" >> $readfile
      echo -e "\033[32m Añadido $3 a $readfile \033[0m"
    fi
  else
    echo -e "\033[31m El archivo $readfile no existe\033[0m"
  fi
fi

if [[ $1 == '-find' ]]
then
  readfile=$2
  if test -z $3
  then
    echo -e "\033[31m Proporcionar hostname\033[0m"
  else
    if test -f $readfile
    then
      linea=$(grep "^$3," $readfile)
      if test -z $linea
      then
        echo -e "\033[31m No se encuentra el equipo $3\033[0m"
      else
        echo $linea | while IFS=',' read hostname ip ram estado
        do
          echo -e "\033[32m hostname: $hostname\033[0m"
          echo -e "\033[32m ip      : $ip\033[0m"
          echo -e "\033[32m ram     : $ram GB\033[0m"
          echo -e "\033[32m estado  : $estado\033[0m"
        done
      fi
    else
      echo -e "\033[31m El archivo $readfile no existe\033[0m"
    fi
  fi
fi

if [[ $1 == '-del' ]]
then
  readfile=$2
  if test -z $3
  then
    echo -e "\033[31m Proporcionar hostname\033[0m"
  else
    if test -f $readfile
    then
      if grep -q "^$3," $readfile
      then
        sed -i "/^$3,/d" $readfile
        echo -e "\033[32m Borrado $3 de $readfile \033[0m"
      else
        echo -e "\033[31m No se encuentra el equipo $3\033[0m"
      fi
    else
      echo -e "\033[31m El archivo $readfile no existe\033[0m"
    fi
  fi
fi

if [[ $1 == '-read' ]]
then
  readfile=$2
  if test -f $readfile
  then
    echo -e "\033[32m Leemos el archivo $readfile \033[0m"
    column -t -s',' $readfile
  else
    echo -e "\033[31m El archivo $readfile no existe\033[0m"
  fi
fi

if [[ $1 == '-resumen' ]]
then
  readfile=$2
  if test -f $readfile
  then
    awk -F',' 'NR>1 {
      n++
      ram+=$3
      estado[$4]++
    }
    END {
      print "Equipos   :", n
      print "RAM total :", ram, "GB"
      for (e in estado) print e, ":", estado[e]
    }' $readfile
  else
    echo -e "\033[31m El archivo $readfile no existe\033[0m"
  fi
fi
