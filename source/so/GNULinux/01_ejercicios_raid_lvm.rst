*************************
Ejercicios RAID y LVM
*************************

Ejercicio 1: RAID 0
===================

Vídeo de ayuda: `RAID 0 <https://mediateca.educa.madrid.org/video/e6i7h1y9rpbmsgd8>`__.

* Crea cinco discos duros virtuales e inicia drbl-live para crear un RAID 0.

  .. image:: imagenes/raid_ej01_discos.png

* Crea un RAID 0 como vimos en :ref:`Caso práctico: Crear un RAID 0`. Ten en cuenta que en los apuntes solo utilizamos dos discos duros, ``/dev/sda`` y ``/dev/sdb``; ahora tienes que hacerlo con cinco.

* Cuando termines sube un **pantallazo**\ :sup:`1` en el que se vean los discos duros en gparted con la etiqueta **tunombre** y la salida del comando ``cat /proc/mdstat``:

  .. image:: imagenes/raid_ej01_mdstat.png

Ejercicio 2: RAID 5
===================

Vídeo de ayuda: `RAID 5 <https://mediateca.educa.madrid.org/video/49jooqeigvolxbtn>`__.

* Crea otra máquina y haz un RAID 5 con otros cinco discos virtuales. Cuando termines sube un **pantallazo**\ :sup:`2` como el siguiente:

  .. image:: imagenes/raid_ej02_raid5.png

* Abre una terminal y ejecuta los siguientes comandos para montar la partición y crear una carpeta llamada **tuapellido**:

  .. code-block:: bash

     sudo su
     cd /
     mount /dev/md0 /media
     mkdir /media/tuapellido

* Sube un **pantallazo**\ :sup:`3` donde se vea la carpeta que has creado, como se muestra a continuación:

  .. image:: imagenes/raid_ej02_carpeta.png

* Apaga la máquina virtual y borra un disco duro, por ejemplo ``raid_3.vdi``:

  .. image:: imagenes/raid_ej02_borrar.png

* Arranca la máquina virtual y sube un **pantallazo**\ :sup:`4` de gparted.

* Crea un disco nuevo con la misma capacidad llamado **tuapellido**:

  .. image:: imagenes/raid_ej02_nuevo.png

* Inicia la máquina virtual; verás algo parecido a esto:

  .. image:: imagenes/raid_ej02_inicio.png

* Uno de los discos duros es el nuevo:

  .. image:: imagenes/raid_ej02_disco_nuevo.png

* Recupera el RAID 5 y sube un **pantallazo**\ :sup:`5` en el que se vea:

  * La salida del comando ``cat /proc/mdstat``. Si hay mucha información, puedes seguir el proceso de recuperación con ``watch cat /proc/mdstat``.
  * La partición montada, en la que se muestra la carpeta **tuapellido**.
  * El disco duro **tuapellido.vdi**.

  Ejemplo de pantallazo:

  .. image:: imagenes/raid_ej02_recuperado.png

Ejercicio 3: LVM
================

Inicia drbl-live con cuatro discos duros y crea un volumen lógico como vimos en :ref:`Caso práctico: Crear LVM`:

.. code-block:: bash

   fdisk /dev/sda  # preparamos el disco duro; si pones +1G luego puedes agrandar la partición con gparted
   n
   p
   1
   2048
   +1G
   t
   L
   8e
   w
   # hacemos lo mismo para /dev/sdb, /dev/sdc y /dev/sdd
   pvcreate /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1  # crea los volúmenes físicos
   pvdisplay  # comprueba que se crean correctamente
   vgcreate GrupoLVM /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1  # crea el grupo de volúmenes (VG) GrupoLVM con los volúmenes físicos anteriores
   vgdisplay  # comprueba que se crean correctamente
   vgscan
   vgrename GrupoLVM DatosLVM  # renombra el grupo de volúmenes a DatosLVM
   lvcreate --name imagenes --size 3.9G DatosLVM  # crea el volumen lógico
   vgdisplay
   #lvextend -L1G /dev/DatosLVM/imagenes  # en el caso de que queramos extenderlo
   mkfs.ext4 /dev/DatosLVM/imagenes  # formateamos
   mount /dev/DatosLVM/imagenes /mnt  # montamos en /mnt
   df -h  # comprobamos que está todo bien

Sube un **pantallazo**\ :sup:`6` del comando ``df -h``. Ejemplo de salida:

.. image:: imagenes/lvm_ej03_df.png
