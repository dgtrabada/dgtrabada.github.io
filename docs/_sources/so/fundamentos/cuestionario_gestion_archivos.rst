*********************************
Cuestionario gestión de archivos
*********************************

.. cuestionario::

   1. Fíjate en la siguiente tabla FAT y responde:
      tabla: Tabla FAT
         | Nº Bloque | Contenido |
         | 1 | 13 |
         | 2 |  |
         | 3 |  |
         | 4 | EOF |
         | 5 |  |
         | 6 |  |
         | 7 | EOF |
         | 8 |  |
         | 9 | 4 |
         | 10 | 9 |
         | 11 |  |
         | 12 |  |
         | 13 | 15 |
         | 14 |  |
         | 15 | 16 |
         | 16 | 7 |
      - 1. ¿Cuántos archivos ves?
        [2|dos]
      - 2. Escribe los bloques que ocupa cada archivo (uno en cada casilla, en el orden que quieras), sepáralos con comas y sin espacios, por ejemplo 1,2,20,EOF
        = 1,13,15,16,7,EOF | 10,9,4,EOF
        = 10,9,4,EOF | 1,13,15,16,7,EOF
      - 3. ¿Dónde se guarda el número del primer bloque de cada archivo?
        (x) En el directorio, junto al nombre del archivo
        ( ) En la última entrada de la tabla FAT
        ( ) En el bloque que contiene EOF

   2. Sistemas de archivos y fragmentación:
      - 1. ¿Qué sistema de archivos utiliza Windows?
        [NTFS]
      - 2. ¿NTFS permite permisos por usuario?
        (x) Sí
        ( ) No
      - 3. ¿Qué sistema de archivos utiliza Ubuntu?
        (x) EXT
        ( ) NTFS
      - 4. ¿EXT permite permisos por usuario?
        (x) Sí
        ( ) No
      - 5. En esta imagen encontramos:
        imagen: imagenes/frag_ext_quiz.png
        (x) Fragmentación externa
        ( ) Fragmentación interna
      - 6. En esta imagen encontramos:
        imagen: imagenes/frag_int_quiz.png
        ( ) Fragmentación externa
        (x) Fragmentación interna

   3. Responde:
      - 1. En la asignación mediante lista ligada, para leer el bloque i de un archivo, ¿hay que recorrer todos los bloques anteriores?
        (x) Sí
        ( ) No
      - 2. ¿Qué fragmentación aparece al almacenar los archivos de forma contigua?
        ( ) Interna
        (x) Externa
      - 3. ¿Qué fragmentación aparece al dividir la partición en bloques?
        (x) Interna
        ( ) Externa
      - 4. Cuanto menor sea el tamaño del bloque, ¿mejor será el aprovechamiento de la partición?
        (x) Sí
        ( ) No
      - 5. ¿Qué inconveniente tienen los bloques muy pequeños?
        ( ) Se desperdicia mucha capacidad del disco duro
        (x) Los archivos se expanden en múltiples bloques y la velocidad de lectura es menor
      - 6. ¿Qué contiene la MFT (Master File Table) de NTFS?
        (x) Una entrada por cada archivo o directorio, con su tamaño, fechas, permisos y nombre
        ( ) Los datos de los archivos del usuario
        ( ) El código básico para iniciar el sistema operativo
      - 7. Si se va la luz a mitad de una escritura, ¿qué ventaja tiene un sistema de archivos con journaling?
        (x) Al arrancar solo hay que revisar el diario para dejar el sistema de archivos en un estado consistente
        ( ) No se pierde nunca ningún dato, aunque no se haya terminado de escribir
        ( ) Hay que comprobar todo el disco, pero lo hace más rápido
      - 8. ¿Cuál de estos sistemas de archivos no tiene journaling?
        ( ) NTFS
        ( ) EXT4
        (x) FAT32

   4. Tipos de sistemas de archivos:
      - 1. ¿Cuál es el tamaño máximo de un archivo en FAT32?
        ( ) 2 GB
        (x) 4 GB
        ( ) ~ TB
      - 2. ¿Puedes guardar una película de 6 GB en un pendrive con FAT32?
        ( ) Sí
        (x) No
      - 3. ¿Qué sistema de archivos usarías en el pendrive para poder guardar esa película y usarlo en Windows, macOS y GNU/Linux?
        ( ) FAT32
        (x) exFAT
        ( ) EXT4
      - 4. ¿FAT32 permite permisos por usuario?
        ( ) Sí
        (x) No
      - 5. ¿Cuál es el sistema de archivos habitual de GNU/Linux?
        ( ) NTFS
        ( ) FAT16
        (x) EXT4

   5. Extensiones:
      - 1. ¿Qué extensión de un documento de Word permite ejecutar macros?
        ( ) DOCX
        (x) DOCM
        ( ) TXT
      - 2. ¿Qué formato de imagen tiene compresión sin pérdida y soporta transparencias?
        ( ) JPG
        (x) PNG
        ( ) BMP
      - 3. ¿Qué formato de audio es de alta fidelidad y sin pérdidas?
        ( ) MP3
        ( ) OGG
        (x) FLAC
      - 4. ¿Qué extensión corresponde a un archivo comprimido muy frecuente en Linux?
        (x) GZ
        ( ) AVI
        ( ) PSD
      - 5. ¿Qué formato mantiene el aspecto del documento en cualquier equipo y se usa para compartir documentos ya terminados?
        (x) PDF
        ( ) RTF
        ( ) CSV
