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
      - 2. Escribe los bloques que ocupan cada archivo, sepáralos con comas y sin espacios, por ejemplo 1,2,20,EOF
        = 1,13,15,16,7,EOF
        = 10,9,4,EOF
      - 3. ¿Qué sistema de archivos utiliza Windows 10?
        [NTFS]
      - ¿Soporta usuarios?
        (x) Sí
        ( ) No
      - 4. ¿Qué sistema de archivos utiliza Ubuntu?
        (x) EXT
        ( ) NTFS
      - ¿Soporta usuarios?
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

   2. Responde:
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
      - 6. ¿En cuántas zonas se divide NTFS?
        ( ) 2
        (x) 4
        ( ) 8

   3. Tipos de sistemas de archivos:
      - 1. ¿Cuál es el tamaño máximo de un archivo en FAT32?
        ( ) 2 GB
        (x) 4 GB
        ( ) ~ TB
      - 2. ¿Puedes guardar una película de 6 GB en un pendrive con FAT32?
        ( ) Sí
        (x) No
      - 3. ¿FAT32 soporta usuarios?
        ( ) Sí
        (x) No
      - 4. ¿Cuál es el sistema de archivos habitual de GNU/Linux?
        ( ) NTFS
        ( ) FAT16
        (x) EXT4

   4. Extensiones:
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
      - 5. ¿Qué formato protege el estilo y evita modificaciones?
        (x) PDF
        ( ) RTF
        ( ) CSV
