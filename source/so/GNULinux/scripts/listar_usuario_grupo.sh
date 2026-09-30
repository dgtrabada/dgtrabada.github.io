#!/bin/bash

# Archivos generados en la máquina con:
#   cat /etc/passwd > etc_passwd.log
#   cat /etc/group > etc_group.log
#   sudo du -sh /home/* > du_home.log

for usuario in $(grep '/bin/bash' etc_passwd.log | grep -v root | cut -d':' -f1)
do
  gid=$(grep "^$usuario:" etc_passwd.log | cut -d':' -f4)
  grupo=$(grep ":x:$gid:" etc_group.log | cut -d':' -f1)
  espacio=$(grep "/home/$usuario$" du_home.log | cut -f1)
  echo "$usuario : $grupo : $espacio"
done
