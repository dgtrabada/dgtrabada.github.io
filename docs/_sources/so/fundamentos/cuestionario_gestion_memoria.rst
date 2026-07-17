********************************
Cuestionario gestión de memoria
********************************

.. cuestionario::

   1. Responde:
      - 1. ¿Un 1GB de memoria RAM es más caro que 1GB de disco duro?
        (x) Sí
        ( ) No
      - 2. ¿Qué sistema de particiones favorece más la fragmentación interna, las fijas o las dinámicas?
        (x) Fijas
        ( ) Dinámicas
      - 3. Fíjate en la siguiente tabla de páginas: un proceso quiere acceder a la dirección D0000, ¿está en la memoria principal o en la memoria secundaria?
        tabla: Tabla de páginas
           | Bit de presencia | Dir. virtual | Dir. física |
           | 1 | 10000 | 10000 |
           | 0 | 20000 | 10000 |
           | 1 | 30000 | 40000 |
           | 1 | 80000 | 60000 |
           | 0 | D0000 | 60000 |
        (x) En la memoria secundaria
        ( ) En la memoria principal
      - 4. Fíjate en la tabla de páginas anterior: un proceso quiere acceder a la dirección 30000, ¿está en la memoria principal o en la memoria secundaria?
        ( ) En la memoria secundaria
        (x) En la memoria principal
      - 5. Fíjate en la siguiente memoria virtual y rellena la tabla de páginas:
        imagen: imagenes/memoria_virtual_quiz.png 340
        tabla:
           | Bit de presencia | Dir. virtual | Dir. física |
           | 0 | 10000 | [10000] |
           | 0 | 20000 | [20000] |
           | [1] | 30000 | 40000 |
           | 1 | [80000] | [10000] |
           | [0] | [D0000] | [50000] |

   2. En una cola ordenada se han almacenado las siguientes peticiones de pistas: **20,32,50,2,120**. Inicialmente la cabeza de lectura/escritura está en la **pista 49**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,...
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [20,32,50,2,120] Total de pistas recorridas: [225]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [50,32,20,2,120] Total de pistas recorridas: [167]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero sube"
        [50,120,32,20,2] Total de pistas recorridas: [189]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero sube y va leyendo"
        [50,120,2,20,32] Total de pistas recorridas: [219]

   3. En una cola ordenada se han almacenado las siguientes peticiones de pistas: **20,8,5,18,13**. Inicialmente la cabeza de lectura/escritura está en la **pista 17**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,...
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [20,8,5,18,13] Total de pistas recorridas: [36]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [18,20,13,8,5] Total de pistas recorridas: [18]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero baja"
        [13,8,5,18,20] Total de pistas recorridas: [27]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero baja y va leyendo"
        [13,8,5,20,18] Total de pistas recorridas: [29]
      - 5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)?
        [SSTF]

   4. En una cola ordenada se han almacenado las siguientes peticiones de pistas: **10,70,45,90,25**. Inicialmente la cabeza de lectura/escritura está en la **pista 40**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,...
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [10,70,45,90,25] Total de pistas recorridas: [225]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [45,25,10,70,90] Total de pistas recorridas: [120]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero sube"
        [45,70,90,25,10] Total de pistas recorridas: [130]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero sube y va leyendo"
        [45,70,90,10,25] Total de pistas recorridas: [145]
      - 5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)?
        [SSTF]

   5. En una cola ordenada se han almacenado las siguientes peticiones de pistas: **20,35,8,28,4**. Inicialmente la cabeza de lectura/escritura está en la **pista 18**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,...
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [20,35,8,28,4] Total de pistas recorridas: [88]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [20,28,35,8,4] Total de pistas recorridas: [48]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero baja"
        [8,4,20,28,35] Total de pistas recorridas: [45]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero baja y va leyendo"
        [8,4,35,28,20] Total de pistas recorridas: [60]
      - 5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)?
        [SCAN]
