#!/bin/bash

umbral=${1:-80} # umbral en %, por defecto 80
log="alertas.log"

df | tail -n +2 | tr -s ' ' | while read particion bloques usado disponible pcent montaje
do
  ocupado=$(echo $pcent | tr -d '%')
  if [ $ocupado -ge $umbral ]
  then
    echo "$(date '+%F %H:%M') $montaje está al $ocupado% (umbral $umbral%)" | tee -a $log
  fi
done
