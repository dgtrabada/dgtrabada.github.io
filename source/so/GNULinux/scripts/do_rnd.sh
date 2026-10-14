#!/bin/bash

N=${1:-4}

rm -fr R.dat

for((i=0;i<$N;i++))
do
  echo $RANDOM >> R.dat
done
