#!/bin/bash

if [[ $# == 0 ]]
then
  echo -e  "\033[31m El primer argumento es el archivo con el nombre del grupo.dat \033[0m"
else
  if test -e $1
  then
    archivo=$1
    echo -e "\033[33m Leemos el archivo $archivo \033[0m"
    grupo=$(echo $archivo | sed 's/.dat//')
    idg=$(grep $grupo /etc/group | cut -d':' -f3)
    for usuario in $(cat $archivo | cut -d' ' -f1 )
    do
      if [[ $(grep -c $usuario /etc/passwd) -gt 0 ]]
      then
        userdel -r $usuario
        echo  -e "\033[34m Borramos el usuario $usuario $grupo \033[0m"
      else
        echo -e "\033[31m No se borra el usuario, el usuario $usuario no existe.\033[0m"
      fi
    done
    n_usuarios_grupo=$(cat /etc/passwd | cut -d':' -f4 | sort | uniq -c | grep $idg | tr -s ' ' | cut -d' ' -f2)
    if [[ $n_usuarios_grupo -eq 0 ]]
    then
      echo -e  "\033[34m Borramos el $grupo ya que no tiene usuarios \033[0m"
      groupdel $grupo
    else
      echo -e  "\033[31m No se borra el  $grupo ya que tiene $n_usuarios_grupo  usuarios \033[0m"
    fi
  else
    echo -e "\033[31m El archivo $1 no existe \033[0m"
  fi
fi

