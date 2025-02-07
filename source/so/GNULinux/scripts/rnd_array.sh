#!/bin/bash

n=${1:-5}

for (( i = 0 ; i < n ; i++ ))
  do
  x=$((RANDOM % 10 + 1))' '
  A[$i]=$x' '
  for (( j=0 ; j<x ; j++ ))
  do
    A[$i]=${A[$i]}A
  done
done


for (( i = 0 ; i < n ; i++ ))
do
  echo ${A[$i]}
done 
