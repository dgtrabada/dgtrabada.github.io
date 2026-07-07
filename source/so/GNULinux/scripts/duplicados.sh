#!/bin/bash

dir=${1:-.} # directorio a analizar, por defecto el actual
hashes=/tmp/hashes.$$ # $$ es el PID, evita pisar el archivo de otra ejecución

find $dir -type f -exec md5sum {} \; | sort > $hashes

for hash in $(cut -d' ' -f1 $hashes | uniq -d)
do
  echo "Duplicados:"
  grep "^$hash" $hashes | tr -s ' ' | cut -d' ' -f2
done

rm $hashes
