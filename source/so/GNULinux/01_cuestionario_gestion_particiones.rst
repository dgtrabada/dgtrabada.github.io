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
