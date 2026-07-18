****
RAID
****

La tecnología RAID (sigla que significa Redundant Array of Inexpensive Disks, conjunto redundante de discos de bajo costo, o en algunos casos Redundant Array of Independent Disks, conjunto redundante de discos independientes) permite al usuario formar una unidad de almacenamiento a partir de varios discos duros.
Esta tecnología fue desarrollada en 1987 por tres investigadores (Patterson, Gibson y Katz) en la Universidad de California (Berkeley). Desde 1992, la junta consultiva para el uso de sistemas RAID (RAID Advisory Board) ha administrado estas especificaciones. Consisten en formar una unidad de gran capacidad (y por lo tanto costosa) a partir de unidades más pequeñas y económicas; aunque estas unidades tengan un MTBF (Mean Time Between Failures, tiempo medio entre fallos) más corto, la redundancia del conjunto compensa esa menor fiabilidad.

El RAID puede implementarse por **hardware**, con una controladora dedicada que gestiona los discos y presenta al sistema operativo una única unidad, o por **software**, siendo el propio sistema operativo quien lo gestiona (como ``mdadm`` en GNU/Linux, que usaremos en el caso práctico).

Con la tecnología RAID, los discos unidos pueden utilizarse de maneras diferentes, denominadas niveles RAID.

.. image:: imagenes/RAID/server.jpeg
    :width: 400


.. image:: imagenes/RAID/server1.jpeg
    :width: 400


.. image:: imagenes/RAID/server2.jpeg
    :width: 400


Nivel 0
=======

Denominado configuración en bandas (striping). Consiste en almacenar datos distribuyéndolos en todas las unidades. Es utilizado para fusionar todos los discos duros en un solo disco para aumentar la capacidad de almacenamiento y el rendimiento. Disminuye la fiabilidad: si falla un solo disco se pierden todos los datos.

.. image:: imagenes/RAID/raid0.png
    :width: 150

Por ejemplo, cuatro unidades de disco duro de 120 GB en una matriz RAID 0 aparecerán como una sola unidad de disco duro de 480 GB para el sistema operativo.

Nivel 1
=======

Denominado réplica (mirroring), crea una copia exacta (o espejo) de un conjunto de datos en dos o más discos. Es utilizado para garantizar la integridad de los datos: el conjunto sigue funcionando mientras quede un disco sano.

.. image:: imagenes/RAID/raid1.png
    :width: 150

Por ejemplo, dos unidades de disco duro de 120 GB en una matriz RAID 1 aparecerán como una sola unidad de disco duro de 120 GB para el sistema operativo.

Nivel 2
=======

(Obsoleto) Es como el RAID 0 pero hace striping con bits y utiliza un código de corrección Hamming.

Nivel 3
=======

(Striping + paridad dedicada). Divide los datos a nivel de bytes en lugar de a nivel de bloques y dedica un disco completo a guardar la paridad. Los discos son sincronizados por la controladora para funcionar al unísono. Permite tasas de transferencia muy altas, pero actualmente no se usa.

.. image:: imagenes/RAID/raid3.png
    :width: 250

Nivel 4
=======

El RAID 4 es parecido al RAID 3 excepto porque divide a nivel de bloques en lugar de a nivel de bytes, manteniendo un disco dedicado a la paridad. Ese disco de paridad recibe todas las escrituras de paridad y se convierte en el cuello de botella del conjunto.

Nivel 5
=======

(Striping + paridad distribuida) Denominado conjunto de discos con paridad distribuida de entrelazado de bloques. Es una división de datos a nivel de bloques distribuyendo la información de paridad entre todos los discos miembros del conjunto, con lo que desaparece el cuello de botella del RAID 4. El RAID 5 ha logrado popularidad gracias a su bajo coste de redundancia. Generalmente se implementa con soporte hardware para el cálculo de la paridad. Necesita un mínimo de 3 discos y tolera el fallo de un disco.

.. image:: imagenes/RAID/raid5.png
    :width: 250

Por ejemplo, cuatro unidades de disco duro de 120 GB en una matriz RAID 5 aparecerán como una sola unidad de 360 GB para el sistema operativo: la capacidad de un disco se dedica a la paridad.

Nivel 6
=======

Se trata de una evolución del RAID 5, donde se busca ampliar la tolerancia frente a fallos. Este aumento de tolerancia se consigue usando una doble banda de paridad (que también se distribuye entre todos los discos) y aumentando a 4 el número mínimo de discos necesarios.

.. image:: imagenes/RAID/raid6.png
    :width: 300

Como resultado de las modificaciones introducidas, los RAID 6 toleran el fallo de dos discos (incluso durante la reconstrucción de uno de ellos) sin pérdida de datos.

Resumen de los niveles más usados, para n discos de tamaño T:

+---------+-------------+----------------+--------------------------+
| Nivel   | Discos mín. | Capacidad útil | Tolerancia a fallos      |
+=========+=============+================+==========================+
| RAID 0  | 2           | n·T            | Ninguna                  |
+---------+-------------+----------------+--------------------------+
| RAID 1  | 2           | T              | n-1 discos               |
+---------+-------------+----------------+--------------------------+
| RAID 5  | 3           | (n-1)·T        | 1 disco                  |
+---------+-------------+----------------+--------------------------+
| RAID 6  | 4           | (n-2)·T        | 2 discos                 |
+---------+-------------+----------------+--------------------------+
| RAID 10 | 4           | (n/2)·T        | 1 disco por cada espejo  |
+---------+-------------+----------------+--------------------------+

Niveles RAID anidados
=====================

Los niveles anidados combinan dos niveles RAID. El nombre indica el orden: primero se construyen conjuntos con el nivel de la primera cifra y después se unen con el nivel de la segunda.

* **RAID 0+1**: se crean dos RAID 0 y se montan en espejo (RAID 1). Si falla un disco, se pierde toda su banda y el conjunto queda sin redundancia.

.. image:: imagenes/RAID/raid01.png
    :width: 300

* **RAID 1+0 (RAID 10)**: se crean espejos RAID 1 y los datos se reparten en bandas entre ellos (RAID 0). Tolera un fallo por cada espejo y es la combinación más utilizada.

.. image:: imagenes/RAID/raid10.png
    :width: 300

* **RAID 5+0 (RAID 50)**: varios RAID 5 unidos en bandas RAID 0.

.. image:: imagenes/RAID/raid50.png
    :width: 300

* **RAID 5+1 (RAID 51)**: un RAID 5 replicado en espejo.

.. image:: imagenes/RAID/raid51.png
    :width: 300


RAID 100
========

Un RAID 100 (RAID 10+0) reparte los datos en bandas sobre varios RAID 10:

.. image:: imagenes/RAID/raid100.png
    :width: 500

RAID 50
=======

Ejemplo del reparto de bloques y paridad en un RAID 50:

.. image:: imagenes/RAID/raid50_3.png
    :width: 500

Caso práctico: Crear un RAID 0
==============================

Antes de crear el RAID 0 podemos mirar en el fichero /proc/mdstat por si hay algún otro RAID:

.. code-block:: bash

  cat /proc/mdstat

Proseguimos a la creación del md en el que crearemos el RAID. Para ello utilizaremos el comando mknod (en los sistemas actuales este paso no es necesario, mdadm crea el dispositivo automáticamente):

.. code-block:: bash

  mknod /dev/md0 b 9 0

Si ya tuviéramos algún otro RAID llamado md0, podemos crear un md diferente: md1, md2, ...
Procedemos ahora a crear finalmente el RAID 0.

.. code-block:: bash

  mdadm --create /dev/md0 --level=raid0 --raid-devices=2 /dev/sda /dev/sdb

Para formatear el RAID utilizaremos el comando

.. code-block:: bash

  mkfs.ext4 /dev/md0

Podemos montarlo en /mnt

.. code-block:: bash

  mount /dev/md0 /mnt/

Si quisiéramos montar el RAID de forma automática cuando se inicia el ordenador, podríamos añadir algo parecido a ``/dev/md0 /punto_de_montaje ext4 defaults 0 0`` en el fichero **/etc/fstab**

Para cambiar un disco duro defectuoso, primero lo marcamos como fallido y después lo sacamos del conjunto:

.. code-block:: bash

  sudo mdadm --fail /dev/md0 /dev/sdb
  sudo mdadm --remove /dev/md0 /dev/sdb

En el caso de que el disco ya no esté conectado, en cat /proc/mdstat se vería como removed.

Para recuperar el RAID:

.. code-block:: bash

  mdadm --stop /dev/mdX #paramos todos los raid
  mdadm --assemble --scan
  mdadm --add /dev/mdX /dev/sdY # añadimos el nuevo
  watch cat /proc/mdstat # podemos ver como se recuperan

En el caso de que no funcione puedes probar a usar antes sfdisk para clonar el esquema de partición ``sfdisk -d /dev/sdc | sfdisk /dev/sda``

Para borrar el RAID

.. code-block:: bash

  # desmontamos el raid
  umount /dev/mdX

  # detenemos el conjunto
  mdadm --stop /dev/mdX

  # finalmente borramos la metainformación de cada disco
  # para que no se vuelva a montar al reiniciar
  mdadm --zero-superblock /dev/sdY


LVM
===

LVM es una implementación de un administrador de volúmenes lógicos para sistemas GNU/Linux.  Permite crear, redimensionar y administrar volúmenes lógicos de una manera más dinámica que las particiones tradicionales.

.. image:: imagenes/RAID/lvm.png
    :width: 400


* **PV** (Physical Volume): son los volúmenes físicos, es decir, discos duros o particiones de un equipo.
* **VG** (Volume Group): grupo de volúmenes, es el área que agrupa uno o varios PV y de la que se reparte el espacio entre los LV.
* **LV** (Logical Volume): volúmenes lógicos o dispositivos donde se pueden crear sistemas de ficheros o FS

LVM ofrece ventajas como la capacidad de agregar espacio de disco adicional a un sistema sin necesidad de apagarlo, mover datos en caliente entre discos, y crear instantáneas de volúmenes para respaldos.

Caso práctico: Crear LVM
========================

.. code-block:: bash

 pvcreate /dev/sdb2 # Crear volumen físico
 pvremove /dev/sdc1 # Borrado de volumen físico
 pvdisplay # Mostrar información
 vgcreate DatosLVM /dev/sdb2 /dev/sda1 # Crear grupo de volúmenes
 vgremove DatosLVM # Borrado de grupo de volúmenes
 vgdisplay # Mostrar información
 lvcreate --name ruta --size 500M DatosLVM # Crear volumen lógico
 lvremove /dev/DatosLVM/ruta # Borrado de volumen lógico
 lvdisplay # Mostrar información
 mkfs.ext4 /dev/DatosLVM/ruta # Formatear el volumen lógico
 mount /dev/DatosLVM/ruta /mnt # Montarlo
 lvextend -L +200M /dev/DatosLVM/ruta # Ampliar el volumen lógico
 resize2fs /dev/DatosLVM/ruta # Redimensionar el sistema de archivos al nuevo tamaño

NAS
===

Un **NAS** (Network Attached Storage) es un dispositivo de almacenamiento conectado a una red que permite a varios usuarios acceder a los datos almacenados en él. Estos dispositivos suelen ser fáciles de configurar y administrar, y son ideales para su uso en pequeñas redes. El NAS se utiliza generalmente para compartir archivos, copias de seguridad, almacenamiento multimedia y otros datos.

.. image:: imagenes/RAID/nas.png

SAN
===

Una red de área de almacenamiento, en inglés **SAN** (Storage Area Network), es una red de almacenamiento dedicada que conecta varios servidores y dispositivos de almacenamiento en una sola red. El SAN se utiliza principalmente para aplicaciones empresariales que requieren un alto rendimiento y una gran capacidad de almacenamiento. A diferencia de los NAS, los SAN suelen ser más complejos de configurar y administrar y están diseñados para satisfacer las necesidades de almacenamiento de grandes empresas.

.. image:: imagenes/RAID/san.png

Si los comparamos, un NAS es una solución de almacenamiento en red simple y económica, ideal para pequeñas y medianas empresas, mientras que un SAN es una solución de almacenamiento de alto rendimiento y escalable diseñada para satisfacer las necesidades de grandes empresas.

* NAS: Utiliza protocolos de nivel de archivo como SMB/CIFS, NFS y FTP.
* SAN: Utiliza protocolos de nivel de bloque como Fibre Channel (FC) y iSCSI.

.. toctree::
   :hidden:

   cuestionario_raid.rst
