#!/bin/bash
x1=0
x2=0
x3=0
x4=0
x5=0
x6=0
x7=0
x8=0
x9=0
total=0

for((i=0;i<1000;i++))
do
  x=$(head -$i monedas.dat | tail -1 )
  total=$((total+x))

  if [[ $x -eq 1 ]]; then x1=$((x1+1)); fi
  if [[ $x -eq 2 ]]; then x2=$((x2+1)); fi
  if [[ $x -eq 3 ]]; then x3=$((x3+1)); fi
  if [[ $x -eq 4 ]]; then x4=$((x4+1)); fi
  if [[ $x -eq 5 ]]; then x5=$((x5+1)); fi
  if [[ $x -eq 6 ]]; then x6=$((x6+1)); fi
  if [[ $x -eq 7 ]]; then x7=$((x7+1)); fi
  if [[ $x -eq 8 ]]; then x8=$((x8+1)); fi
  if [[ $x -eq 9 ]]; then x9=$((x9+1)); fi

done
echo hay $x1 con 1 euros
echo hay $x2 con 2 euros
echo hay $x3 con 3 euros
echo hay $x4 con 4 euros
echo hay $x5 con 5 euros
echo hay $x6 con 6 euros
echo hay $x7 con 7 euros
echo hay $x8 con 8 euros
echo hay $x9 con 9 euros

echo hay $total de dinero

