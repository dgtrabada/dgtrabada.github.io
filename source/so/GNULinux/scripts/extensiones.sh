#!/bin/bash
ayuda(){
  echo "Uso:"
  echo "  ./extensiones.sh -generar <N1> <N2> <N3> <N4>   genera N1 txt, N2 pdf, N3 png y N4 jpg"
  echo "  ./extensiones.sh -analisis                      muestra cuántos archivos hay de cada extensión"
}
if [ "$1" == "-generar" ]
then
  if [ $# -ne 5 ]
  then
    ayuda
    exit
  fi
  rm -rf archivos
  mkdir archivos
  for((i=0;i<$2;i++)); do touch archivos/a_$RANDOM.txt; done
  for((i=0;i<$3;i++)); do touch archivos/a_$RANDOM.pdf; done
  for((i=0;i<$4;i++)); do touch archivos/a_$RANDOM.png; done
  for((i=0;i<$5;i++)); do touch archivos/a_$RANDOM.jpg; done
elif [ "$1" == "-analisis" ]
then
  ls archivos | cut -d. -f2 | sort | uniq -c | sort -nr
else
  ayuda
fi
