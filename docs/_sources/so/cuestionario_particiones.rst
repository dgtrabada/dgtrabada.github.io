************************
Cuestionario particiones
************************

Particiones (I)
===============

.. cuestionario::

   1. **Ejercicio 01**: con GParted crea la siguiente tabla de particiones primarias.
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
      - 3. ¿Puede tener diferentes usuarios la partición FAT32?
        ( ) Sí
        (x) No
      - 4. ¿Puede tener diferentes usuarios la partición NTFS?
        (x) Sí
        ( ) No
      - 5. ¿Cuál es el formato del sistema de archivos que utiliza Linux en la actualidad?
        ( ) NTFS
        (x) EXT4
        ( ) FAT32
      - 6. ¿Para qué sirve la partición swap?
        (x) Es el área de intercambio
        ( ) Para la instalación, luego se borra
      - 7. ¿Cuántas particiones primarias puedes hacer como máximo?
        [4|cuatro]
      - 8. ¿Cuántas particiones extendidas puedes hacer como máximo?
        [1|una]
      - 9. Si tienes dos particiones primarias, ¿cuántas particiones primarias más puedes hacer?
        [2|dos]
      - 10. Si tienes dos particiones primarias, ¿cuántas particiones extendidas puedes hacer?
        [1|una]
      - 11. Si tienes dos particiones primarias, ¿cuántas particiones lógicas puedes hacer?
        [0|cero|ninguna]
      - 12. Si tienes tres particiones primarias, ¿cuántas particiones extendidas puedes hacer?
        [1|una]
      - 13. Si tienes cuatro particiones primarias, ¿cuántas particiones extendidas puedes hacer?
        [0|cero|ninguna]
      - 14. ¿Cuántas particiones primarias puedes hacer dentro de la extendida?
        [0|cero|ninguna]
      - 15. ¿Cuántas particiones lógicas puedes hacer dentro de la extendida?
        [23|veintitrés|veintitres]
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
        [467.57]

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
