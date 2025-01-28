#!/bin/bash

#Vamos a crear los usuarios que aparecen en la lista.dat
#$cat listda.dat
# usuario1 Grupo1
# usuario2 Grupo2
# usuario3 Grupo1

archivo=${1:-lista.dat}

for usuario in $(cat $archivo | cut -d' ' -f1 )
do
  grupo=$(grep $usuario $archivo | cut -d' ' -f2)
  if [[ $(grep -c $usuario /etc/passwd) -gt 0 ]]
  then
    echo -e "\033[31m No se crea el usuario, el usuario $usuario ya existe. \033[0m"
  else
    if [[ $(grep -c $grupo /etc/group) -eq 0 ]]
    then
      groupadd $grupo
      echo -e "\033[34m Creamos el grupo $grupo \033[0m"
    fi
    useradd -g $grupo -d /home/$usuario -m -s /bin/bash -p $( mkpasswd -m sha-512 -s cambiame) $usuario
    echo -e "\033[34m Creamos el usuario $usuario en el grupo $grupo con contraseña por defecto 'cambiame'.\033[0m"
  fi
done

