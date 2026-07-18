*****************
Cuestionario RAID
*****************

En los esquemas, cada cilindro es un disco y las letras son los bloques que almacena: bloques distintos en cada disco indican bandas (striping), bloques repetidos indican espejo, y Ap o Bp son bloques de paridad. Los puntos son los niveles de agrupación: el nombre del RAID se lee desde los discos hacia arriba (por ejemplo, espejos unidos en bandas = RAID 10).

Cuando se pregunta *¿cuántos discos se pueden romper como máximo?* se refiere al mejor de los casos (con suerte en la posición); *sin importar la posición* se refiere a los que están garantizados, se rompan los que se rompan.

RAID (I)
========

Tenemos 6 discos duros de 1 TB.

.. cuestionario::

   1. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_i_1.png 500
      - 1. RAID:
        [0|RAID 0]
      - 2. ¿Cuál es la capacidad final en TB?
        [6]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [0|ninguno]

   2. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_i_2.png 500
      - 1. RAID:
        [5|RAID 5]
      - 2. ¿Cuál es la capacidad final en TB?
        [5]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   3. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_i_3.png 500
      - 1. RAID:
        [01|0+1|RAID 01]
      - 2. ¿Cuál es la capacidad final en TB?
        [2]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [2]

   4. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_i_4.png 500
      - 1. RAID:
        [10|1+0|RAID 10]
      - 2. ¿Cuál es la capacidad final en TB?
        [3]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [3]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   5. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_i_5.png 500
      - 1. RAID:
        [01|0+1|RAID 01]
      - 2. ¿Cuál es la capacidad final en TB?
        [3]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [3]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   6. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_i_6.png 500
      - 1. RAID:
        [10|1+0|RAID 10]
      - 2. ¿Cuál es la capacidad final en TB?
        [2]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [2]

RAID (II)
=========

Tenemos 8 discos duros de 1 TB.

.. cuestionario::

   1. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_ii_1.png 560
      - 1. RAID:
        [100|1+0+0|RAID 100]
      - 2. ¿Cuál es la capacidad final en TB?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   2. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_ii_2.png 560
      - 1. RAID:
        [110|1+1+0|RAID 110]
      - 2. ¿Cuál es la capacidad final en TB?
        [2]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [6]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [3]

   3. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_ii_3.png 560
      - 1. RAID:
        [001|0+0+1|RAID 001]
      - 2. ¿Cuál es la capacidad final en TB?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   4. ¿A qué RAID corresponde el siguiente esquema?
      imagen: imagenes/RAID/quiz_raid_ii_4.png 560
      - 1. RAID:
        [101|1+0+1|RAID 101]
      - 2. ¿Cuál es la capacidad final en TB?
        [2]
      - 3. ¿Cuántos discos se pueden romper como máximo?
        [6]
      - 4. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [3]

RAID (III)
==========

.. cuestionario::

   1. Tenemos 8 discos duros de 2 TB en RAID 0:
      - 1. ¿Cuál es la capacidad final en TB?
        [16]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [0|ninguno]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [0|ninguno]

   2. Tenemos 4 discos duros de 2 TB en RAID 1:
      - 1. ¿Cuál es la capacidad final en TB?
        [2]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [3]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [3]

   3. Tenemos 8 discos duros de 2 TB en RAID 5:
      - 1. ¿Cuál es la capacidad final en TB?
        [14]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [1|uno]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   4. Tenemos 6 discos duros de 2 TB agrupados de dos en dos en RAID 01:
      - 1. ¿Cuál es la capacidad final en TB?
        [4]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [2]

   5. Tenemos 6 discos duros de 2 TB agrupados de dos en dos en RAID 10:
      - 1. ¿Cuál es la capacidad final en TB?
        [6]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [3]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   6. Tenemos 9 discos duros de 2 TB agrupados de tres en tres en RAID 50:
      - 1. ¿Cuál es la capacidad final en TB?
        [12]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [3]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   7. Tenemos 12 discos duros de 2 TB agrupados de cuatro en cuatro en RAID 51:
      - 1. ¿Cuál es la capacidad final en TB?
        [6]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [9]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [5]

   8. Tenemos 10 discos duros de 4 TB agrupados de cinco en cinco en RAID 60:
      - 1. ¿Cuál es la capacidad final en TB?
        [24]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [2]

RAID (IV)
=========

.. cuestionario::

   1. Tenemos 8 discos duros de 2 TB en RAID 01 agrupados de 2 en 2:
      - 1. ¿Cuántos TB tenemos?
        [4]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [6]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [3]

   2. Tenemos 8 discos duros de 2 TB en RAID 01 agrupados de 4 en 4:
      - 1. ¿Cuántos TB tenemos?
        [8]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   3. Tenemos 8 discos duros de 2 TB en RAID 10 agrupados de 2 en 2:
      - 1. ¿Cuántos TB tenemos?
        [8]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   4. Tenemos 8 discos duros de 2 TB en RAID 10 agrupados de 4 en 4:
      - 1. ¿Cuántos TB tenemos?
        [4]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [6]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [3]

   5. Tenemos 8 discos duros de 2 TB en RAID 50 agrupados de 4 en 4:
      - 1. ¿Cuántos TB tenemos?
        [12]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [2]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   6. Tenemos 9 discos duros de 2 TB en RAID 50 agrupados de 3 en 3:
      - 1. ¿Cuántos TB tenemos?
        [12]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [3]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   7. Tenemos 8 discos duros de 2 TB en RAID 100 agrupados de 2 en 2:
      - 1. ¿Cuántos TB tenemos?
        [8]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [4]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [1|uno]

   8. Tenemos 8 discos duros de 2 TB en RAID 110 agrupados de 2 en 2:
      - 1. ¿Cuántos TB tenemos?
        [4]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [6]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [3]

   9. Tenemos 12 discos duros de 2 TB en RAID 60 agrupados de 4 en 4:
      - 1. ¿Cuántos TB tenemos?
        [12]
      - 2. ¿Cuántos discos se pueden romper como máximo?
        [6]
      - 3. ¿Cuántos discos se pueden romper como máximo sin importar la posición en la que se rompan?
        [2]
