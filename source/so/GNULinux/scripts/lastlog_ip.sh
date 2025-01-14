#!/bin/bash

for i in $(last -w | tr -s ' '  | cut -d' ' -f3 | sort |  grep '\.' | uniq); 
do 
  echo $(last -w| grep -c $i) $i 
done | sort -rn 
