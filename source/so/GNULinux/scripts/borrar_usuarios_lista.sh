#!/bin/bash

#Vamos a crear los usuarios que aparecen en la lista.dat

archivo=${1:-lista.dat}


for usuario in $(cat $archivo | cut -d' ' -f1 )
do
  if [[ $(grep -c $usuario /etc/passwd) -gt 0 ]]
  then
    echo -e "\033[34m Borramos el $usuario \033[0m"
    userdel -r $usuario
  else
    echo -e "\033[31m El usuario $usuario no existe \033[0m"
  fi
done

