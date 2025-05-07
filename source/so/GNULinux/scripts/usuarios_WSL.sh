#!/bin/bash

function show_help() {
echo '
  -help               Mostrar esta ayuda.
  -crear <N>          Crear N usuarios de forma aleatoria dentro de los grupos X, Y o Z.
  -borrar             Borrar todos los usuarios creados por este script.
  -listar             Mostrar los usuarios creados por este script.
'
}

grupos=(X Y Z)

if [[ $# -gt 0 ]]
then
  if [[ $1 == "-help" ]]
  then
    show_help
  fi
  if [[ $1 == "-crear" ]]
  then
    num_usuarios=${2:-10}
    for ((i=1; i<=num_usuarios; i++)); do
      grupo=${grupos[$RANDOM % ${#grupos[@]}]}
      sufijo=$(printf "%02d" $((RANDOM % 99 )))
      usuario="u${grupo}${sufijo}"
      useradd -g $grupo -d /home/$usuario -m -s /bin/bash -p $( mkpasswd -m sha-512 -s cambiame) $usuario
      echo "Usuario $usuario creado en el grupo $grupo con contraseña por defecto 'cambiame'."
    done
  fi
  if [[ $1 == "-borrar" ]]
  then
    for g in ${grupos[@]};
    do
      echo Borro usuarios del grupo $g
      for u in $(cat /etc/passwd | cut -d':' -f1 | grep u$g);
      do
        echo Borramos el usuario $u
        userdel -r $u
      done
    done
  fi
else
  show_help
fi
