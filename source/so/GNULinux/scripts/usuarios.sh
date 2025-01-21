#!/bin/bash

function show_help() {
    echo "Uso del script:"
    echo "./usuarios.sh -addgroup <grupo>         : Crea un grupo si no existe"
    echo "./usuarios.sh -delgroup <grupo>         : Elimina un grupo si existe"
    echo "./usuarios.sh -adduser <usuario> [grupo]: Crea un usuario en el grupo especificado (o en uno con su mismo nombre)"
    echo "./usuarios.sh -deluser <usuario>        : Elimina un usuario si existe"
    echo "./usuarios.sh -lista                    : Lista todos los grupos y sus usuarios"
}

if [[ $# -gt 0 ]]
then
  if [[ $1 == "-addgroup" ]]
  then
    if [[ $(grep -c $2 /etc/group) -gt 0 ]]
    then
      echo "No se crea el grupo, el grupo $2 existe."
    else
      echo "Creamos el grupo $2"
      groupadd $2
    fi
  fi
  if [[ $1 == "-delgroup" ]]
  then
    groupdel $2
  fi

  if [[ $1 == "-adduser" ]]
  then
    usuario=$2
    grupo=${3:-$usuario}

    if [[ $(grep -c $usuario /etc/passwd) -gt 0 ]]
    then
      echo "No se crea el usuario, el usuario $usuario ya existe."
    else
      if [[ $(grep -c $grupo /etc/group) -eq 0 ]]
      then
        groupadd $grupo
        echo "Creamos el grupo $grupo"
      fi
      useradd -g $grupo -d /home/$usuario -m -s /bin/bash -p $( mkpasswd -m sha-512 -s cambiame) $usuario
      echo "Usuario $usuario creado en el grupo $grupo con contraseña por defecto 'cambiame'."
    fi
  fi
  if [[ $1 == "-deluser" ]]
  then
    if [[ $(grep -c $usuario /etc/passwd) -gt 0 ]]
    then
      userdel -r $2
      echo "Usuario $2 eliminado."
    else
      echo "No se borra el usuario, el usuario $2 no existe."
    fi
  fi
  if [[ "$1" == "-lista" ]]
  then
    cat /etc/group | cut -d':' -f1,4 | grep -v ':$'
  fi

else
  show_help
fi