***********
Particiones
***********

Particionar un disco es dividir su espacio de almacenamiento en secciones independientes llamadas **particiones**. Para ello se crea una **tabla de particiones**: un índice, situado al principio del disco, que indica dónde empieza y termina cada partición y da ciertas características de cada una, como por ejemplo el sistema de archivos que usa o si la partición es arrancable, de solo lectura,...

Sobre cada partición, al formatearla, se crea un sistema de archivos. Existen muchos tipos de sistemas de archivos, en la siguiente tabla vemos algunos de los más famosos:

+----------+--------------+---------------+-------------+----------+
| Sistema  | archivo      | partición     | SO          | Soporta  |
| archivos | (máx.)       | (máx.)        | Utilizado   | Usuarios |
+==========+==============+===============+=============+==========+
|  FAT16   |      2GB     |     2GB       | Windows     |    NO    |
+----------+--------------+---------------+-------------+----------+
|**FAT32** |    **4GB**   |     2TB       |**Windows**  |  **NO**  |
+----------+--------------+---------------+-------------+----------+
|**NTFS**  |   **~ TB**   |    ~ EB       |**Windows**  |  **SI**  |
+----------+--------------+---------------+-------------+----------+
|  EXT3    |     2 TB     |    32TB       | GNU/Linux   |    SI    |
+----------+--------------+---------------+-------------+----------+
|**EXT4**  |   **~ TB**   |    ~ EB       |**GNU/Linux**|  **SI**  |
+----------+--------------+---------------+-------------+----------+

Hay dos alternativas para definir la tabla de particiones:

* La tabla de particiones en el **MBR**, también llamada tabla de particiones DOS. Usada en los IBM PC y compatibles con sistemas BIOS.
* **GUID Partition Table (GPT)**, propuesta por la especificación EFI, puede usarse en equipos con BIOS y con UEFI.

Tabla de particiones en el MBR
==============================

El **MBR "Master Boot Record"** es el primer sector ("sector cero") de un dispositivo de almacenamiento de datos, es decir, sus primeros 512 bytes:

* Los primeros **446 bytes** contienen el código de arranque.
* Los **64 bytes** siguientes contienen la tabla de particiones: 4 entradas de 16 bytes, una por partición.
* Los **2 bytes** finales contienen la firma de arranque ``0x55AA``, que indica que el sector es válido.

Como cada entrada de la tabla direcciona los sectores con números de 32 bits y los sectores son de 512 bytes, el MBR solo puede manejar discos de hasta **2 TiB** (2\ :sup:`32` × 512 bytes). Esta es su principal limitación hoy en día.

.. image:: imagenes/MBR.png

Al tener la tabla solo 4 entradas, existen 3 tipos diferentes de particiones:

* **Partición primaria**: Son las divisiones crudas o primarias del disco, solo puede haber 4 de éstas o 3 primarias y una extendida.
* **Partición extendida**: También conocida como partición secundaria, actúa como una partición primaria y sirve para contener múltiples unidades lógicas en su interior. Fue ideada para romper la limitación de 4 particiones primarias en un solo disco físico. Solo puede existir una partición de este tipo por disco, y solo sirve para contener particiones lógicas. Por lo tanto, es el único tipo de partición que no soporta un sistema de archivos directamente.
* **Partición lógica**: Ocupa una porción de la partición extendida o la totalidad de la misma, la cual se ha formateado con un tipo específico de sistema de archivos (FAT32, NTFS, ext4,...) y se le ha asignado una unidad, así el sistema operativo reconoce las particiones lógicas o su sistema de archivos. Puede haber un máximo de 23 particiones lógicas en una partición extendida.

.. image:: imagenes/particiones1.png

Ejemplos de particionados:

* Sistema GNU/Linux en un disco de 500 GB.

  * 1ª Partición primaria de 80 GB con formato ext4 y punto de montaje / (en esta partición estarán los archivos del SO)
  * 2ª Partición primaria igual que la memoria RAM (4 GB) que tenga el equipo con formato swap (se usa para la memoria virtual)
  * 3ª Partición primaria de 415 GB con formato ext4 y punto de montaje /home (contiene la configuración y datos de los usuarios)

* Sistema Windows en un disco de 500 GB

  * 1ª Partición primaria de 80 GB con formato ntfs (en esta partición estarán los archivos del SO)
  * 2ª Partición primaria de 420 GB con formato ntfs (contiene la configuración y datos de los usuarios)

* Sistema GNU/Linux y Windows en un disco de 600 GB.

  * 1ª Partición primaria de 80 GB con formato ntfs
  * 2ª Partición primaria de 220 GB con formato ntfs
  * 3ª Partición extendida

    * 1ª Partición lógica de 76 GB con formato ext4 y punto de montaje /
    * 2ª Partición lógica igual que la memoria RAM (4 GB) que tenga el equipo con formato swap
    * 3ª Partición lógica de 220 GB con formato ext4 y punto de montaje /home

GUID Partition Table (GPT)
==========================

Es parte del estándar Extensible Firmware Interface (EFI) propuesto por Intel para reemplazar la vieja BIOS del PC, heredada del IBM PC original. GPT surge para superar las limitaciones del MBR: permite discos de más de 2 TiB y no está limitada a 4 particiones primarias.

.. image:: imagenes/guid.png

Sus características principales son:

* Cada bloque lógico (LBA) tiene un tamaño de 512 bytes. Las direcciones LBA negativas indican una posición a partir del final del volumen, siendo −1 el último bloque direccionable.
* La tabla reserva por defecto espacio para **128 particiones**, todas "primarias": con GPT ya no existen las particiones extendidas ni las lógicas.
* Guarda una **copia de seguridad** de la cabecera y de la tabla de particiones al final del disco, y usa códigos CRC para detectar errores: es mucho más robusta que la tabla del MBR.
* En el sector cero (LBA 0) mantiene un **MBR de protección**, para que las herramientas antiguas que no entienden GPT no crean que el disco está vacío.
* Los sistemas UEFI arrancan desde una partición especial, la **ESP (EFI System Partition)**, con formato FAT32, donde se guardan los cargadores de arranque.

.. image:: imagenes/particiones2.png

Independientemente de cómo se cree la tabla de particiones, dejaremos una partición para el sistema operativo, otra para los datos y, en el caso de instalar un GNU/Linux, otra para la swap. Para el SO reservaremos ~80 GB en Windows y ~50 GB en GNU/Linux.

**swap**: espacio de swap (o de intercambio). El swapping es el proceso por el que una página de memoria se copia en un espacio del disco configurado previamente para ello, para liberar esa memoria RAM.

Organización para GNU/Linux
===========================

Los sistemas GNU/Linux identifican las particiones empleando una combinación de letras y números: **/dev/xxyN**.

* **/dev/** nombre del directorio donde residirán todos los archivos de dispositivo.
* **xx** las dos primeras letras indican el tipo de dispositivo en el que residirá la partición.

  * **hd** para discos IDE/PATA
  * **sd** discos SATA y SCSI (también los pendrives y discos USB)

* **y** letra que indica el número de disco duro (a,b,c...)
* **N** número de partición. En discos con tabla MBR los números 1 a 4 se reservan para las particiones primarias y la extendida; las **particiones lógicas se numeran a partir del 5**, aunque haya menos de 4 primarias.

Los discos **NVMe** actuales (los SSD conectados por PCIe) usan otra nomenclatura: **/dev/nvme0n1p1** es la primera partición (p1) del primer disco NVMe (nvme0n1).

Ejemplos :

* /dev/hda1 primera partición del primer disco duro IDE/PATA
* /dev/sdb2 segunda partición del segundo disco duro SCSI y SATA
* /dev/sda5 primera partición lógica del primer disco duro SATA
* /dev/nvme0n1p2 segunda partición del primer disco NVMe

.. toctree::
   :hidden:

   cuestionario_particiones.rst
