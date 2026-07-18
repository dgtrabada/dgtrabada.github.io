************************************
Cuestionario gestión de particiones
************************************

.. cuestionario::

   1. Conceptos de montaje:
      - 1. ¿Qué es un punto de montaje?
        ( ) Un lugar donde se almacenan archivos temporales
        ( ) Una ubicación donde se guarda la información de inicio del sistema
        (x) Una ubicación en el sistema de archivos donde se adjunta otro sistema de archivos
        ( ) Una carpeta oculta en el directorio raíz del sistema
      - 2. ¿Qué es el punto de montaje raíz en Linux?
        ( ) Un punto de montaje donde se almacenan archivos de arranque
        ( ) Una ubicación temporal para guardar archivos temporales
        ( ) Una carpeta donde se montan dispositivos USB
        (x) El punto de inicio del sistema de archivos, marcado como /
      - 3. ¿Cuál es el propósito del directorio /mnt?
        ( ) Almacenar archivos temporales del sistema
        (x) Servir de lugar para montar temporalmente sistemas de archivos adicionales
        ( ) Almacenar archivos multimedia
        ( ) Guardar copias de seguridad del sistema
      - 4. ¿Qué sucede si intentas desmontar un punto de montaje que está en uso?
        ( ) El proceso se completa sin problemas
        (x) Recibirás un mensaje de error indicando que el dispositivo está ocupado
        ( ) El sistema se reiniciará automáticamente
        ( ) El punto de montaje se desmontará automáticamente
      - 5. ¿Cuál es el propósito del directorio /lost+found?
        ( ) Almacenar archivos que se han perdido en el sistema
        ( ) Almacenar copias de seguridad del sistema
        ( ) Guardar archivos temporales de la shell
        (x) Almacenar archivos recuperados después de un fallo del sistema de archivos

   2. Nombres de particiones:
      - 1. ¿Cómo se llama la primera partición del primer disco duro SATA?
        (x) /dev/sda1
        ( ) /part/1
        ( ) No tiene nombre hasta que se monta
      - 2. ¿Cómo se llama la primera partición del segundo disco duro SATA?
        (x) /dev/sdb1
        ( ) /part/2
        ( ) No tiene nombre hasta que se monta
      - 3. ¿Cómo averiguarías si se encuentra montada en estos momentos?
        (x) df -h
        ( ) cat /etc/fstab
        ( ) du

   3. Fíjate en el siguiente pantallazo de GParted:
      imagen: imagenes/quiz_gparted_home.png 600
      - 1. ¿Dónde está montado el sistema operativo?
        [/]
      - 2. ¿Qué sistema de archivos tiene?
        [ext4]

   4. Fíjate en el siguiente pantallazo de GParted:
      imagen: imagenes/quiz_gparted_ntfs.png 600
      - 1. ¿Qué comando utilizarías para montar la 2ª partición en /media?
        (x) sudo mount /dev/sda2 /media
        ( ) sudo mount nfs /media
        ( ) sudo mount 2par /media

   5. Ejecutamos el comando **df -h** y obtenemos:
      imagen: imagenes/quiz_df_servidor.png
      - 1. Si quisiéramos desmontar la 1ª partición del 2º disco duro, ¿qué comando ejecutaríamos? (escríbelo con sudo)
        = sudo umount /boot | sudo umount /dev/sdb1
      - 2. Queremos montar la 2ª partición del 2º disco duro en /media/a, ¿qué comando ejecutamos? (escríbelo con sudo)
        = sudo mount /dev/sdb2 /media/a

   6. Montar y desmontar a mano:
      - 1. ¿Cómo montarías la 1ª partición del 1º disco duro en /mnt?
        (x) sudo mount /dev/sda1 /mnt
        ( ) sudo mount /dev/sda1
        ( ) sudo mount /mnt /dev/sda1
      - 2. ¿Cómo la desmontarías? (escríbelo con sudo)
        = sudo umount /mnt | sudo umount /dev/sda1

   7. Ejecutamos el siguiente comando:
      imagen: imagenes/quiz_df_usb.png
      - 1. ¿Cuántas particiones están montadas?
        [3|tres]
      - 2. Si quisiéramos desmontar la memoria USB que está montada en /media/dani/5638-6DD4, ¿qué comando ejecutaríamos? (escríbelo con sudo)
        = sudo umount /media/dani/5638-6DD4 | sudo umount /dev/sdb1

   8. Ejecutamos los siguientes comandos:
      imagen: imagenes/quiz_fdisk_df.png 500
      - 1. ¿Cuántas particiones están desmontadas?
        [4|cuatro]
      - 2. ¿Cuántos discos duros reconoce el sistema?
        [2|dos]
      - 3. Queremos desmontar la primera partición del disco sdf, ¿qué comando ejecutaríamos? (escríbelo con sudo)
        = sudo umount /media/DANI | sudo umount /dev/sdf1

   9. Formatear y swap:
      - 1. ¿Qué comando da formato ext4 a la partición /dev/sdb1?
        = mkfs.ext4 /dev/sdb1 | sudo mkfs.ext4 /dev/sdb1
      - 2. ¿Qué comando convierte la partición /dev/sdb2 al formato swap?
        = mkswap /dev/sdb2 | sudo mkswap /dev/sdb2
      - 3. ¿Cómo activamos esa partición de swap?
        = swapon /dev/sdb2 | sudo swapon /dev/sdb2
      - 4. ¿Y cómo la desactivamos?
        = swapoff /dev/sdb2 | sudo swapoff /dev/sdb2
      - 5. ¿Qué utilidad detecta, verifica y corrige los errores del sistema de archivos?
        [fsck]

   10. fdisk y otras utilidades:
      - 1. ¿Qué comando muestra los discos y particiones que hay en el sistema?
        (x) fdisk -l
        ( ) fdisk --show
        ( ) ls /dev/discos
      - 2. Dentro de fdisk, ¿qué tecla crea una partición nueva?
        [n]
      - 3. ¿Y cuál escribe los cambios en el disco?
        [w]
      - 4. ¿Qué comando muestra información de todos los dispositivos de bloque?
        = lsblk -a | lsblk
      - 5. ¿Qué comando sirve para determinar el tipo de un archivo?
        [file]
      - 6. ¿Qué hace dd if=/dev/zero of=/dev/sda bs=512 count=1?
        (x) Borra el MBR y su tabla de particiones (escribe ceros en el primer sector)
        ( ) Borra todo el contenido del disco
        ( ) Crea una copia de seguridad del primer disco
      - 7. ¿Qué comando muestra lo que ocupa un directorio?
        (x) du -sh
        ( ) df -h
        ( ) free

   11. El archivo /etc/fstab. Fíjate en esta línea:
      fichero: /etc/fstab
         /dev/sdb1   /datos   ext4   defaults   0   2
      - 1. ¿Qué indica la segunda columna (/datos)?
        (x) El punto de montaje
        ( ) El dispositivo
        ( ) La etiqueta del disco
      - 2. ¿Qué indica la tercera columna (ext4)?
        (x) El sistema de archivos
        ( ) Las opciones de montaje
        ( ) El tipo de disco
      - 3. ¿A qué equivale la opción defaults?
        (x) rw, suid, dev, exec, auto, nouser y async
        ( ) Solo lectura y sin ejecución
        ( ) A no usar ninguna opción
      - 4. ¿Qué opción monta el dispositivo en solo lectura?
        [ro]
      - 5. ¿Qué opción impide ejecutar los binarios almacenados en el dispositivo?
        [noexec]
      - 6. ¿Qué indica el último campo (el 2)?
        (x) El orden en que fsck revisará la partición durante el arranque
        ( ) El número de copias de seguridad
        ( ) La prioridad de montaje
      - 7. Si ese campo es 0...
        (x) La partición no se revisa
        ( ) La partición se revisa la primera
        ( ) No se monta
      - 8. ¿Qué comando monta todo lo que está pendiente en el fstab (útil para probarlo sin reiniciar)?
        = mount -a | sudo mount -a
