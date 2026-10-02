#!/bin/bash

mostrar_ayuda() {
    echo "Uso: ./alerta_disco.sh [umbral] [tiempo]
Revisa cada [tiempo] segundos la ocupación de las particiones montadas y
escribe una alerta por pantalla y en alertas.log si alguna llega al [umbral] %.
  Sin argumentos:   umbral 80 % y tiempo 1 s.
  Un argumento:     cambia el umbral, el tiempo es 1 s.
  Dos argumentos:   cambia el umbral y el tiempo.
Para pararlo crea un archivo llamado stop en la misma carpeta: touch stop
Opciones:
  --help   Muestra este mensaje de ayuda.

Ejemplos:
  ./alerta_disco.sh 50 10   Alerta si alguna partición llega al 50 %, revisando cada 10 s."
}

if [[ $1 == "--help" ]]
then
  mostrar_ayuda
  exit 0
fi

umbral=${1:-80} # umbral en %, por defecto 80
tiempo=${2:-1}  # tiempo de espera en segundos, por defecto 1

while ! test -e stop
do
  for particion in $(df | grep dev | grep -v tmpfs | cut -d' ' -f1)
  do
    ocupado=$(df $particion | tail -1 | tr -s ' ' | cut -d' ' -f5 | cut -d'%' -f1)
    if [ $ocupado -ge $umbral ]
    then
      echo "$(date '+%F %H:%M:%S') $particion está al $ocupado% (umbral $umbral%)" | tee -a alertas.log
    fi
  done
  sleep $tiempo
done

rm stop
echo "$(date '+%F %H:%M:%S') alerta_disco.sh parado"
