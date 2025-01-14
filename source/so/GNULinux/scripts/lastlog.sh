#!/bin/bash

for i in $(last -w | sort | cut -d' ' -f1 | uniq | egrep -v reboot | egrep -v  wtmp)
do 
  echo $(last -w| grep -c $i) $i  $(groups $i | cut -d':' -f2)
done | sort -rn
