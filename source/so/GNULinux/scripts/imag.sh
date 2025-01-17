#!/bin/bash


for i in imag_* 
do 
  mv $i $(echo $i | cut -d'.' -f1).png
done



