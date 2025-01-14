#!/bin/bash
for i in $(cat /etc/passwd | grep bash | grep -v root | cut -d':' -f1)
do 
  groups $i
done

