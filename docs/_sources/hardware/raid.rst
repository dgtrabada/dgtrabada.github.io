****
RAID
****

La tecnología RAID (sigla que significa Redundant Array of Inexpensive Disks, conjunto redundante de discos de bajo costo, o en algunos casos Redundant Array of Independent Disks, conjunto redundante de discos independientes) permite al usuario formar una unidad de almacenamiento a partir de varios discos rígidos
Esta tecnología fue desarrollada en 1987 por tres investigadores (Patterson, Gibson y Katz) en la Universidad de California (Berkeley). Desde 1992, la junta consultiva para el uso de sistemas RAID (RAID Advisory Board) ha administrado estas especificaciones. Estas consisten en la formación de una unidad con gran capacidad (y por lo tanto costosa) a partir de unidades más pequeñas y económicas (es decir, unidades en las que el MTBF, Mean Time Between Failure [tiempo medio entre fallos], sea corto).

Con la tecnología RAID, los discos unidos pueden utilizarse de maneras diferentes, denominadas niveles RAID

.. image:: imagenes/RAID/server.jpeg
    :width: 400


.. image:: imagenes/RAID/server1.jpeg
    :width: 400


.. image:: imagenes/RAID/server2.jpeg
    :width: 400


Nivel 0
=======

Denominado configuración en bandas (striping). Consiste en almacenar datos distribuyéndolos en todas las unidades. Es utilizado para fusionar todos los discos duros en un sólo disco para aumentar la capacidad de almacenamiento y el rendimiento. Disminuye la fiabilidad.

.. image:: imagenes/RAID/raid0.png
    :width: 150

Por ejemplo, cuatro unidades de disco duro 120 GB en una matriz RAID 0 aparecerá como una sola unidad de disco duro 480 GB para el Sistema operativo.

Nivel 1
=======

Denominado réplica (mirroring), crea una copia exacta (o espejo) de un conjunto de datos en dos o más discos. Es utilizado para garantizar la integridad de los datos.

.. image:: imagenes/RAID/raid1.png
    :width: 150
    
Por ejemplo, dos unidades de disco duro 120 GB en una matriz RAID 1 aparecerá como una sola unidad de disco duro 120 GB para el Sistema operativo

Nivel 2
=======

(Obsoleto) Es como el RAID 0 pero hace Striping con bits y utiliza un código de corrección Hamming.

Nivel 3
=======

(Striping + paridad). Denominado conjunto de discos con datos entrelazados en bits. Divide los datos a nivel de bytes en lugar de a nivel de bloques . Los discos son sincronizados por la controladora para funcionar al unísono. Éste es el único nivel RAID original que actualmente no se usa. Permite tasas de transferencias extremadamente altas.

.. image:: imagenes/RAID/raid3.png
    :width: 250
    
Nivel 4
=======

El RAID 4 es parecido al RAID 3 excepto porque divide a nivel de bloques en lugar de a nivel de bytes (bloques ~ 512 KB

Nivel 5
=======

(Strinping + Paridad distribuida) Denominado conjunto de discos con paridad distribuida de entrelazado de bloques. Es una división de datos a nivel de bloques distribuyendo la información de paridad entre todos los discos miembros del conjunto. El RAID 5 ha logrado popularidad gracias a su bajo coste de redundancia. Generalmente, el RAID 5 se implementa con soporte hardware para el cálculo de la paridad. RAID 5 necesitará un mínimo de 3 discos para ser implementado.

.. image:: imagenes/RAID/raid5.png
    :width: 250
    
Por ejemplo, cuatro unidades de disco duro 120 GB en una matriz RAID 5 apariencia similar a una unidad de disco duro 360GB para el Sistema operativo.

Nivel 6
=======

Se trata de una evolución del Raid 5, donde se busca ampliar la tolerancia frente a fallos, este aumento de tolerancia se consigue usando una doble banda de paridad (que también se distribuye entre todos los discos) y aumentando a 4 el número mínimo de discos necesarios para un Raid.

.. image:: imagenes/RAID/raid6.png
    :width: 300
    
Como resultado de las modificaciones introducidas los Raid 6, toleran el fallo de dos discos (incluso durante la reconstrucción de uno de ellos), sin pérdida de datos.

Niveles RAID anidados
=====================

.. image:: imagenes/RAID/raid01.png
    :width: 300


.. image:: imagenes/RAID/raid10.png
    :width: 300
    



.. image:: imagenes/RAID/raid50.png
    :width: 300



.. image:: imagenes/RAID/raid51.png
    :width: 300


RAID 100
========

.. image:: imagenes/RAID/raid100.png
    :width: 500
    
RAID 50
=======

.. image:: imagenes/RAID/raid50_3.png
    :width: 500

Caso práctico: Crear un RAID 0
==============================

Antes de crear la RAID 0 podemos ver en el fichero /proc/mdstat por si al algún otro raid:

.. code-block:: bash

  cat /proc/mdstat

Proseguimos a la creación del md en el que crearemos la RAID. Para ello utilizaremos el comando mknod :

.. code-block:: bash

  mknod /dev/md0 b 9 0
  
Si ya tuviéramos algún otro raid llamado md0, podemos crear un md diferente: md1, md2, ...
Procedemos ahora a crear finalmente la RAID 0.

.. code-block:: bash

  mdadm --create /dev/md0 --level=raid0 --raid-devices=2 /dev/sda /dev/sdb

Para formatear la RAID utilizaremos el comando 

.. code-block:: bash

  mkfs.ext4 /dev/md0
  
Podemos montarla en /mnt : mount /dev/md0 /mnt/

Para montar la RAID de forma automática cuando se inicia el ordenador, añadimos la siguiente línea al fichero /etc/fstab :

.. code-block:: bash

  /dev/md0 /punto_de_montaje sistema_de_archivos defaults,user 0

Para cambiar un disco duro defectuoso:

.. code-block:: bash

  sudo mdadm --remove /dev/md0 /dev/sda1

En el caso de que ya no este conectado, desde drbl se vería en cat /proc/mdstat como removed

usar sfdisk para clonar el esquema de partición. Para ello usaremos la opción -d de sfdisk

.. code-block:: bash

 sfdisk -d /dev/sdc | sfdisk /dev/sda
 mdadm --stop /dev/md127
 rm /etc/mdadm/mdadm.conf
 mdadm --assemble --scan
 mdadm --add /dev/md0 /dev/sda1 # añadimos el nuevo
 watch cat /proc/mdstat # podemos ver como se recuperan

En el caso de quere borrar el raid

.. code-block:: bash

  # desmontamos el raid
  umount /dev/mdX  
  
  # lo paramos
  mdadm --stop /dev/mdX
  
  # detener el conjunto raid
  mdadm --stop /dev/mdX
  
  # finalmente borrarlo
  mdadm --remove /dev/mdX
  

LVM
===

LVM es una implementación de un administrador de volúmenes lógicos para sistemas GNU/Linux

.. image:: imagenes/RAID/lvm.png
    :width: 400
    

* **PV** (Phisical Volume): son los volúmenes físicos, es decir, discos duros o particiones de un equipo.
* **VG** (Volume Group): grupo volumen, es el área donde se juntan los PVs y VLs.
* **LV** (Logical Volume): volúmenes lógicos o dispositivos donde se pueden crear sistemas de ficheros o FS


Caso práctico: Crear LVM
========================

.. code-block:: bash
 
 pvcreate /dev/sdb2 # Crear volumen físico
 pvremove /dev/sdc1 # Borrado de volúmen físico
 pvdisplay # Mostrar información
 vgcreate DatosLVM /dev/sdb2 /dev/sda1 # Crear grupo de volúmenes
 vgremove DatosLVM # Borrado de grupo de volúmenes
 vgdisplay # Mostrar información
 lvcreate --name ruta --size 500M DatosLVM # Crear volumen lógico
 lvremove /dev/DatosLVM/ruta # Borrado de grupo de volúmenes
 lvdisplay # Mostrar información

NAS
===

Un "NAS" (Network Attached Storage,es un dispositivo de almacenamiento conectado a una red que permite a varios usuarios acceder a los datos almacenados en él. Estos dispositivos suelen ser fáciles de configurar y administrar, y son ideales para su uso en pequeñas redes. El NAS se utiliza generalmente para compartir archivos, copias de seguridad, almacenamiento multimedia y otros datos.

.. image:: imagenes/RAID/nas.png

SAN
===

Una red de área de almacenamiento, en inglés SAN (Storage Area Network), es una red de almacenamiento dedicada que conecta varios servidores y dispositivos de almacenamiento en una sola red. El SAN se utiliza principalmente para aplicaciones empresariales que requieren un alto rendimiento y una gran capacidad de almacenamiento. A diferencia de los NAS, los SAN suelen ser más complejos de configurar y administrar y están diseñados para satisfacer las necesidades de almacenamiento de grandes empresas.

.. image:: imagenes/RAID/san.png

En resumen, un NAS es una solución de almacenamiento en red simple y económica, ideal para pequeñas y medianas empresas, mientras que un SAN es una solución de almacenamiento de alto rendimiento y escalable diseñada para satisfacer las necesidades de grandes empresas.