clientes='compute-0-1 compute-0-2'

for cpu in $clientes
do
  rsync  -av --delete /etc/passwd $cpu:/etc/passwd
  rsync  -av --delete /etc/shadow $cpu:/etc/shadow
  rsync  -av --delete /etc/group $cpu:/etc/group
done


u=usuario_GD_04
g=GD

for u in $(cat /etc/passwd | grep usuari | cut -d':' -f1)
do
  g=$(groups $u | cut -d':' -f2 | cut -d' ' -f2)
  if test -d /home/$u
  then
    echo no creamos la carpeta /home/$u ya que existe
  else
    cp -r home_usuario_server  /home/$u
    sed -i "s/usuario_X/$u/" /home/$u/.ssh/id_ed25519.pub
    chown -R $u:$g /home/$u
    for cpu in $clientes
    do
      cp -r home_usuario_cliente $u
      sed -i "s/usuario_X/$u/" $u/.ssh/authorized_keys
      scp -r $u $cpu:/home/
      ssh $cpu chown  -R $u:$g /home/$u
      rm -fr $u
    done
  fi
done

#rm -fr /home/usuario* ; ssh compute-0-1 rm -fr  /home/usu* ;  ssh compute-0-2 rm


