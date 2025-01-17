#!/bin/bash

n=${1:-5}

for (( i = 0 ; i < n ; i++ ))
  do
  x=$((RANDOM % 10 + 1))' '
  out=$x' '
  for (( j=0 ; j<x ; j++ ))
    do
      out=${out}A
    done
  echo $out
done
