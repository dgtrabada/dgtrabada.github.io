************************
Cuestionario particiones
************************

Particiones (I)
===============

En los apartados (I) y (II), las preguntas se refieren a discos con tabla de particiones **msdos (MBR)**. Las de GPT están en el apartado (III).

.. cuestionario::

   1. **Ejercicio 01**: con GParted crea una tabla de particiones msdos y en ella las siguientes particiones primarias.
      imagen: imagenes/quiz_part_4primarias.png 569
      texto: Intenta hacer otra partición que sea primaria, lógica y extendida. Completa las siguientes frases:
      - 1. Si en un disco duro con 4 particiones primarias creamos una partición primaria más obtenemos que...
        ( ) Sí podemos crearla
        (x) No podemos crearla
      - 2. Si en un disco duro con 4 particiones primarias creamos una partición lógica más obtenemos que...
        ( ) Sí podemos crearla
        (x) No podemos crearla
      - 3. Si en un disco duro con 4 particiones primarias creamos una partición extendida más obtenemos que...
        ( ) Sí podemos crearla
        (x) No podemos crearla

   2. **Ejercicio 02**: realiza las siguientes particiones, 2 primarias y 1 extendida (utiliza ~7% del disco para cada una).
      imagen: imagenes/quiz_part_2prim_1ext.png 568
      texto: Intenta hacer otra partición que sea primaria, lógica y extendida. Completa las siguientes frases:
      - 1. Si en un disco duro con 2 particiones primarias y una extendida creamos una partición primaria más obtenemos que...
        (x) Sí podemos crearla
        ( ) No podemos crearla
      - 2. Si en un disco duro con 2 particiones primarias y una extendida creamos una partición lógica más fuera de la extendida obtenemos que...
        ( ) Sí podemos crearla
        (x) No podemos crearla
      - 3. Si en un disco duro con 2 particiones primarias y una extendida creamos una partición lógica más dentro de la extendida obtenemos que...
        (x) Sí podemos crearla
        ( ) No podemos crearla
      - 4. Si en un disco duro con 2 particiones primarias y una extendida creamos una partición extendida más obtenemos que...
        ( ) Sí podemos crearla
        (x) No podemos crearla

   3. **Ejercicio 03**: mira el siguiente pantallazo y di cuántas particiones primarias, extendidas y lógicas puedes ver.
      imagen: imagenes/quiz_part_gparted.jpeg 567
      - 1. Primarias:
        [3|tres]
      - 2. Extendidas:
        [1|una]
      - 3. Lógicas:
        [7|siete]
      - 4. ¿Qué sistema de archivos utiliza la 2ª partición primaria?
        [ext4]
      - 5. ¿Qué sistema de archivos utiliza la 2ª partición lógica?
        [fat32]
      - 6. ¿Cuántas particiones primarias puedo hacer?
        [0|cero|ninguna]

   4. **Ejercicio 04**: responde a las siguientes preguntas.
      - 1. ¿Cuál es el formato del sistema de archivos que utiliza Windows en la actualidad?
        (x) NTFS
        ( ) EXT4
        ( ) FAT32
      - 2. ¿Cuál es el tamaño máximo de archivo (en GB) para la partición FAT32?
        [4|4GB|4 GB]
      - 3. ¿Guarda FAT32 permisos para distintos usuarios?
        ( ) Sí
        (x) No
      - 4. ¿Guarda NTFS permisos para distintos usuarios?
        (x) Sí
        ( ) No
      - 5. ¿Cuál es el formato del sistema de archivos que utiliza Linux en la actualidad?
        ( ) NTFS
        (x) EXT4
        ( ) FAT32
      - 6. ¿Para qué sirve la partición swap?
        (x) Es el área de intercambio
        ( ) Para la instalación, luego se borra
      - 7. ¿Cuántas particiones primarias puedes hacer como máximo en una tabla msdos?
        [4|cuatro]
      - 8. ¿Cuántas particiones extendidas puedes hacer como máximo?
        [1|una]
      - 9. Si tienes dos particiones primarias, ¿cuántas particiones primarias más puedes hacer?
        [2|dos]
      - 10. Si tienes dos particiones primarias, ¿cuántas particiones extendidas puedes hacer?
        [1|una]
      - 11. Si tienes dos particiones primarias, ¿cuántas particiones lógicas puedes hacer sin crear antes una extendida?
        [0|cero|ninguna]
      - 12. Si tienes tres particiones primarias, ¿cuántas particiones extendidas puedes hacer?
        [1|una]
      - 13. Si tienes cuatro particiones primarias, ¿cuántas particiones extendidas puedes hacer?
        [0|cero|ninguna]
      - 14. ¿Cuántas particiones primarias puedes hacer dentro de la extendida?
        [0|cero|ninguna]
      - 15. ¿De dónde venía el límite clásico de 23 particiones lógicas?
        (x) De las letras de unidad de MS-DOS (de D: a Z:)
        ( ) Del tamaño del EBR
        ( ) Del número de entradas de la tabla del MBR
      - 16. ¿Cuántas particiones extendidas puedes hacer dentro de una primaria?
        [0|cero|ninguna]

Particiones (II)
================

.. cuestionario::

   1. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema1.png 607
      - 1. ¿A qué sistema operativo crees que pertenece la primera partición primaria?
        (x) Windows
        ( ) Linux

   2. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema2.png 610
      - 1. La partición de arranque es:
        [/dev/sda2|sda2]
      - 2. ¿Cuántas particiones lógicas tiene el disco duro?
        [0|cero|ninguna]

   3. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema3.png 608
      - 1. Podemos crear:
        (x) Dos particiones lógicas más dentro de la extendida
        ( ) Dos particiones primarias más dentro de la extendida
        ( ) Una extendida más

   4. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema4.png 609
      - 1. Podemos crear:
        (x) Una partición primaria más
        ( ) Dos particiones primarias más dentro de la extendida
        ( ) Una extendida más

   5. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema1.png 607
      - 1. ¿Cuántas particiones primarias hay?
        [4|cuatro]
      - 2. ¿Cuántas particiones lógicas hay?
        [0|cero|ninguna]
      - 3. ¿Cuántas particiones extendidas hay?
        [0|cero|ninguna]
      - 4. ¿Cuántos MiB de la 4ª partición están utilizados?
        [467.57|467.57mib]

   6. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema5.png 607
      - 1. ¿Cuántas particiones extendidas hay?
        [1|una]

   7. Fíjate en el siguiente esquema de particiones:
      imagen: imagenes/quiz_part_esquema6.png 610
      - 1. ¿Cuántas particiones lógicas hay?
        [2|dos]
      - 2. ¿Cuántos discos duros hay?
        [4|cuatro]

Particiones (III)
=================

.. cuestionario::

   1. MBR y GPT:
      - 1. ¿Hasta qué tamaño de disco puede manejar una tabla MBR? (en TiB)
        [2|2tib|2tb]
      - 2. ¿Cuántas particiones admite por defecto una tabla GPT?
        [128|cientoveintiocho]
      - 3. ¿Qué tabla de particiones necesita Windows 11?
        (x) GPT, porque Windows 11 exige UEFI
        ( ) msdos (MBR)
        ( ) Cualquiera de las dos
      - 4. ¿Dónde guarda GPT la copia de seguridad de su cabecera y de su tabla?
        (x) Al final del disco
        ( ) En el MBR de protección
        ( ) En la partición ESP
      - 5. ¿Con qué sistema de archivos se formatea la partición ESP?
        (x) FAT32
        ( ) NTFS
        ( ) ext4
      - 6. ¿Cómo se llama la partición de 16 MiB, sin sistema de archivos, que crea Windows en un disco GPT?
        [msr]
      - 7. ¿Qué contiene la partición ESP?
        (x) Los cargadores de arranque de los sistemas operativos
        ( ) Los archivos del sistema operativo Windows
        ( ) La copia de seguridad de la tabla GPT
      - 8. En un equipo con arranque dual Windows y Ubuntu en el mismo disco, ¿cuántas particiones ESP hay?
        (x) Una, la comparten los dos sistemas
        ( ) Dos, una para cada sistema
        ( ) Ninguna
      - 9. Un equipo que arranca con BIOS y tabla MBR, ¿tiene partición ESP?
        ( ) Sí
        (x) No, el código de arranque está en el propio MBR
      - 10. En un disco GPT con Windows y GNU/Linux (ESP, MSR, C:, D:, /, swap y /home), ¿cuántas particiones extendidas hacen falta?
        [0|cero|ninguna]

   2. Particiones lógicas y nombres:
      - 1. ¿Qué es el EBR?
        (x) Un registro delante de cada partición lógica que indica dónde está esa partición y dónde está el siguiente EBR
        ( ) La copia de seguridad del MBR
        ( ) La partición donde se guardan los cargadores de arranque
      - 2. En GNU/Linux, ¿en qué número empiezan las particiones lógicas?
        [5|cinco]
      - 3. ¿Cómo se llama en GNU/Linux la segunda partición del primer disco NVMe?
        [/dev/nvme0n1p2|nvme0n1p2]

   3. Velocidad:
      - 1. En un disco duro mecánico, ¿qué particiones tienen mayor velocidad de transferencia?
        (x) Las del principio del disco (pistas exteriores)
        ( ) Las del final del disco (pistas interiores)
        ( ) Todas son igual de rápidas
      - 2. ¿Y en un SSD?
        ( ) Las del principio del disco
        ( ) Las del final del disco
        (x) Todas son igual de rápidas
