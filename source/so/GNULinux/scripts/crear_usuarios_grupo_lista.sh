#!/bin/bash

#Vamos a crear los usuarios que aparecen en el archvio grupo.dat

if [[ $# == 0 ]]
then
  echo -e  "\033[31m El primer argumento es el archivo con el nombre del grupo.dat \033[0m"
else
  if test -e $1
  then
    archivo=$1
    echo -e "\033[33m Leemos el archivo $archivo \033[0m"
    grupo=$(echo $archivo | sed 's/.dat//')
    for usuario in $(cat $archivo | cut -d' ' -f1 )
    do
      if [[ $(grep -c $usuario /etc/passwd) -gt 0 ]]
      then
        echo -e "\033[31m No se crea el usuario, el usuario $usuario ya existe.\033[0m"
      else
        if [[ $(grep -c $grupo /etc/group) -eq 0 ]]
        then
          groupadd $grupo
          echo -e "\033[34m Creamos el grupo $grupo \033[0m"
        fi
        echo  -e "\033[34m Creamos el usuario $usuario en el grupo $grupo \033[0m"
        useradd -g $grupo -d /home/$usuario -m -s /bin/bash -p $( mkpasswd -m sha-512 -s cambiame) $usuario
        echo -e "\033[34m Usuario $usuario creado en el grupo $grupo con contraseña por defecto 'cambiame'.\033[0m"
      fi
    done
  else
    echo -e "\033[31m El archivo $1 no existe \033[0m"
  fi
fi
