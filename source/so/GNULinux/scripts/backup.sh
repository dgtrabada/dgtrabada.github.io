#!/bin/bash

backup_dir="backups"

function show_help() {
    echo -e "\033[32m-help                : muestra la ayuda\033[0m"
    echo -e "\033[32m<directorio>         : Crea backups/backup_<directorio>_<fecha>.tar.gz\033[0m"
    echo -e "\033[32m-lista               : Muestra los backups con su tamaño\033[0m"
    echo -e "\033[32m-limpiar <días>      : Borra los backups con más de <días> días, por defecto 7\033[0m"
    echo -e "\033[32m-restaurar <archivo> : Extrae el backup en el directorio restaurado\033[0m"
}

if [[ $1 == '-help' ]] || [[ $# -eq 0 ]]
then
  show_help
fi

if [[ $1 == '-lista' ]]
then
  if test -d $backup_dir
  then
    du -h $backup_dir/*.tar.gz
  else
    echo -e "\033[31m No hay backups\033[0m"
  fi
fi

if [[ $1 == '-limpiar' ]]
then
  dias=${2:-7}
  antiguos=$(find $backup_dir -name "*.tar.gz" -mtime +$dias 2>/dev/null)
  if test -z "$antiguos"
  then
    echo -e "\033[31m No hay backups con más de $dias días\033[0m"
  else
    echo "$antiguos"
    find $backup_dir -name "*.tar.gz" -mtime +$dias -delete
    echo -e "\033[32m Borrados \033[0m"
  fi
fi

if [[ $1 == '-restaurar' ]]
then
  if test -f "$2"
  then
    mkdir -p restaurado
    tar -xzf $2 -C restaurado
    echo -e "\033[32m Restaurado $2 en restaurado/ \033[0m"
  else
    echo -e "\033[31m El archivo $2 no existe\033[0m"
  fi
fi

if [[ $# -ge 1 && $1 != -* ]] # si no empieza por - es el directorio a copiar
then
  if test -d $1
  then
    mkdir -p $backup_dir
    nombre=$backup_dir/backup_$(basename $1)_$(date +%F_%H%M).tar.gz
    tar -czf $nombre $1
    echo -e "\033[32m Creado $nombre \033[0m"
  else
    echo -e "\033[31m El directorio $1 no existe\033[0m"
  fi
fi
