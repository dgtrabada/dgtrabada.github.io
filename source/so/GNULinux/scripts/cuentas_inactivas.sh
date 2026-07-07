#!/bin/bash

# cuentas_inactivas.sh - detecta (y opcionalmente bloquea) cuentas sin uso
# Ejecutar como root

dias=${1:-90}     # días de inactividad, por defecto 90
bloquear=$2       # si es "-bloquear" además de listar, bloquea las cuentas

echo -e "\033[34m=== Usuarios sin acceso en los últimos $dias días ===\033[0m"

# lastlog -b N lista los usuarios que no entran desde hace más de N días
# quitamos la cabecera y los que nunca han entrado (**Never logged in**)
lastlog -b $dias 2>/dev/null | tail -n +2 | grep -v "Never logged in" | tr -s ' ' | cut -d' ' -f1 |
while read usuario
do
  # solo cuentas de usuario real (UID >= 1000), no las del sistema
  uid=$(id -u "$usuario" 2>/dev/null)
  if [ -n "$uid" ] && [ "$uid" -ge 1000 ]; then
    if [ "$bloquear" == "-bloquear" ]; then
      usermod -L "$usuario"
      echo -e "\033[31m$usuario bloqueado\033[0m"
    else
      echo "$usuario (inactivo, usa -bloquear para bloquearlo)"
    fi
  fi
done
