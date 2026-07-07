#!/bin/bash

PS3="Escoge una opción: "

select opcion in "Disco" "Memoria" "Usuarios conectados" "Salir"
do
  case $opcion in
    "Disco")
      df -h | grep -v tmpfs
      ;;
    "Memoria")
      free -m | grep Mem
      ;;
    "Usuarios conectados")
      who
      ;;
    "Salir")
      echo "¡Hasta luego!"
      break
      ;;
    *)
      echo "Opción no válida"
      ;;
  esac
done
