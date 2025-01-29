#!/bin/bash

function show_help() {
    echo "Uso : analizar [OPCION]"
    echo "Options:"
    echo "- mes <mes> muestra el numero de citas que hay en un mes"
    echo "- d <dia> muestra el numero de citas que hay para ese dia para todos los meses"
}
archivo=calendario.dat

if [[ $# -gt 0 ]]
then
  if [[ $1 == "--help" ]]
  then
    show_help
  fi

  if [[ $1 == "-mes" ]]
  then
    grep -c $2 $archivo 
  fi

  if [[ $1 == "-d" ]]
  then
    cat $archivo  | grep -c " $2 "         
  fi

  if [[ $1 == "-resumen" ]]
  then
    if [[ $2 == citas ]]
    then
      cat $archivo | tr -s ' ' | cut -d' ' -f4- | sort | uniq  -c | sort -r
    fi
    if [[ $2 == horas ]]
    then
      hora=$(cat $archivo | tr -s ' ' | cut -d' ' -f3 | cut -d':' -f1 | sort | uniq -c | tr -s ' '| cut -d' ' -f3)
      c=0
      for i in $hora
      do
        c=$((c+1))
        cita=$(cat $archivo | tr -s ' ' | cut -d' ' -f3 | cut -d':' -f1 | sort | uniq -c | tr -s ' '| grep $i | cut -d' ' -f2 | head -$c | tail -1)
        echo De $i:00-10:59 hay $cita citas
      done
    fi
  fi
else
 show_help
fi

