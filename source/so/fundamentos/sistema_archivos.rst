*******************
Sistema de archivos
*******************

La memoria secundaria
=====================

Una de las primeras formas de organizar la información en la memoria secundaria fue mediante la asignación en forma de lista ligada.

.. image:: imagenes/memoria_secundaria.png
  :width: 200

.. image:: imagenes/memoria_lista.png
  :width: 400

Cada bloque contiene la dirección del siguiente bloque o, si es el último, el valor EOF (*End Of File*, fin de archivo). Uno de los problemas que nos encontramos es que, si queremos leer el bloque i, tendremos que pasar por todos los anteriores, lo que puede ser muy ineficiente.

Una forma más eficiente de organizarlo es almacenar los archivos de forma contigua; sin embargo, cuando un archivo aumente de tamaño tendremos que cambiarlo de sitio, y de esta forma aparece la fragmentación externa:

.. image:: imagenes/frag_ext.png


Podemos evitar mover todo el archivo dividiendo la partición en bloques. Esto crea fragmentación interna: cuanto menor sea el tamaño del bloque, mejor será el aprovechamiento de la partición.


.. image:: imagenes/frag_int.png


FAT (File Allocation Table)
===========================

En el sistema FAT se genera una entrada por cada bloque del disco. Cada entrada indica cuál es el siguiente bloque del archivo, o EOF si es el último. El directorio guarda, junto al nombre de cada archivo, el número de su primer bloque; a partir de ahí se sigue la cadena en la tabla.

.. image:: imagenes/FAT.png
  :width: 200

En esta tabla podemos ver 2 archivos (el directorio indica que A empieza en el bloque 5 y B en el 3):

| A : [5] -> [4] -> [2]
| B : [3] -> [7]

En un disco duro de 160 GB con bloques de 16 KB tendríamos (160×2\ :sup:`30`\ ) / (16×2\ :sup:`10`\ ) = 10×2\ :sup:`20` bloques. En FAT32 cada entrada ocupa 32 bits (4 B), así que la tabla ocuparía 10×2\ :sup:`20` × 4 B = 40 MB.

El Sistema I-NODOS (ls -i) (ext)
================================


.. image:: imagenes/inodos.png
  :width: 400


Con bloques de 1KB y direcciones de 32 bits podemos apuntar a:

.. image:: imagenes/inodos1.png

(1×2\ :sup:`10`\ ×2\ :sup:`3`\ bit) / (2\ :sup:`5`\ bit) = 2\ :sup:`8` = 256 direcciones 
  
.. image:: imagenes/inodos2.png

(256)\ :sup:`2` = 2\ :sup:`16`

.. image:: imagenes/inodos3.png

(256)\ :sup:`3` = 2\ :sup:`24`

tendríamos en total: 10 + 2\ :sup:`8` + 2\ :sup:`16` + 2\ :sup:`24` ≈ 2\ :sup:`24` bloques, y como cada bloque es de 1 KB, el tamaño máximo de un archivo sería 2\ :sup:`24` × 2\ :sup:`10` B = 2\ :sup:`34` B = 16 GB.

NTFS 
====

NTFS se divide en 4 zonas

.. image:: imagenes/ntfs.png
  :width: 500

Journaling (sistemas transaccionales)
=====================================

Los sistemas de archivos transaccionales o con journaling (NTFS, EXT3, EXT4...) mantienen un diario (journal) donde anotan los cambios que van a realizar antes de escribirlos definitivamente en el disco. Si el equipo se apaga de golpe a mitad de una escritura, al arrancar solo hay que revisar el diario para dejar el sistema de archivos en un estado consistente, en lugar de comprobar todo el disco (como hacía chkdsk/scandisk con FAT).

Por eso, para el disco del sistema siempre elegiremos un sistema de archivos con journaling. FAT32 y exFAT, que no lo tienen, quedan para pendrives y tarjetas de memoria, donde prima la compatibilidad. Como FAT32 no admite archivos de más de 4 GB, en los pendrives y tarjetas actuales se usa sobre todo exFAT.

Tamaño Bloque
=============

* **Bloques grandes:** mucha fragmentación interna, lo que hace que se desperdicie capacidad del disco duro.
* **Bloques pequeños:** los archivos se reparten en muchos bloques y la velocidad de lectura es menor, porque hay que buscar y leer cada bloque por separado.

La siguiente gráfica, basada en el ejemplo del libro *Modern Operating Systems* de Tanenbaum, muestra los dos efectos para archivos de 4 KB (con una búsqueda media de 5 ms, una rotación de 8,33 ms y 1 MB por pista). Con bloques pequeños se aprovecha todo el espacio, pero la lectura es muy lenta; con bloques grandes la lectura es rápida, pero casi todo el espacio se desperdicia:

.. image:: imagenes/bloque.png

Tipos de sistemas de archivos
=============================

Existen muchos tipos de sistemas de archivos. En la siguiente tabla vemos algunos de los más famosos:

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
|**exFAT** |  **16 EB**   |   128 PB      |**Windows,** |  **NO**  |
|          |              |               |**macOS,**   |          |
|          |              |               |**GNU/Linux**|          |
+----------+--------------+---------------+-------------+----------+
|**EXT4**  |   **~ TB**   |    ~ EB       |**GNU/Linux**|  **SI**  |
+----------+--------------+---------------+-------------+----------+



En el sistema de archivos hay dos tipos fundamentales de objetos: los directorios y los archivos. Los archivos son los objetos encargados de contener los datos, mientras que los directorios o carpetas son los objetos cuya misión principal es permitir una mayor organización de los archivos dentro del disco.

Los archivos suelen estar formados por el nombre y la extensión, la extensión indica qué tipo de archivo es, fíjate en los siguientes ejemplos:

* Extensiones de Ofimática:

  * TXT: archivos de texto plano, sin formato.
  * DOC: documentos de Word. Este formato está obsoleto, ya que pertenece a las versiones antiguas de Office.
  * DOCX: formato por defecto de los documentos de Word. Este formato no permite ejecutar macros.
  * DOCM: igual que el DOCX, pero con macros habilitadas.
  * ODT: documento de texto en formato OpenDocument, ideal para usar con suites alternativas como LibreOffice.
  * PDF: formato creado por Adobe y hoy estándar abierto (ISO). Mantiene el aspecto del documento en cualquier equipo; se usa para compartir documentos ya terminados.
  * RTF: formato de texto enriquecido, perfecto para compartir entre distintos sistemas operativos.
  * CSV: formato abierto para representar cualquier tipo de datos en forma de tabla.
  * XLS: documentos de Excel. Este formato está obsoleto, ya que pertenece a las versiones antiguas de Office.
  * XLSX: formato por defecto de los documentos de Excel. Este formato no permite ejecutar macros.
  * XLSM: igual que XLSX, pero con macros habilitadas.
  * ODS: hoja de cálculo en formato OpenDocument, ideal para usar con suites ofimáticas alternativas como LibreOffice.
  * PPS: presentación de diapositivas de PowerPoint configurada para abrirse siempre en modo presentación. Este formato está obsoleto, ya que pertenece a las versiones antiguas de Office.
  * PPT: presentación de diapositivas de PowerPoint. Este formato está obsoleto, ya que pertenece a las versiones antiguas de Office.
  * PPSX: formato por defecto de PowerPoint para abrir el archivo en modo presentación. Este formato no permite ejecutar macros.
  * PPTX: formato por defecto de PowerPoint. Este formato no permite ejecutar macros.
  * PPSM: igual que el PPSX, pero con macros.
  * PPTM: igual que el PPTX, pero con macros.
  * POTX: plantilla de Microsoft PowerPoint.
  * ODP: formato OpenDocument para presentación de diapositivas, ideal para usar con suites ofimáticas alternativas como LibreOffice.

* Extensiones de audio

  * MP3: codec de música estándar con compresión.
  * WMA: formato de audio desarrollado por Microsoft con compresión y posible DRM.
  * WAV: formato de audio digital con o sin compresión.
  * FLAC: formato de audio digital de alta fidelidad y sin pérdidas.
  * MIDI: no contiene sonido grabado, sino instrucciones para instrumentos musicales (qué nota tocar, cuándo y con qué intensidad).
  * OGG: codec de audio libre, muy popular como alternativa al MP3.
  * M3U: lista de reproducción.
  
* Extensiones de video

  * AVI: contenedor de audio y vídeo que puede contener varios flujos de datos de audio y de vídeo.
  * DIVX: códec de vídeo con compresión, muy popular para películas en los años 2000.
  * MOV: formato utilizado por QuickTime.
  * MP4: formato capaz de almacenar contenido multimedia como audio, vídeo y subtítulos.
  * MPG: formato con compresión de baja pérdida de calidad.
  * MKV: formato contenedor de vídeo que guarda por separado el audio y el vídeo.
  * WMV: formato de vídeo desarrollado por Microsoft con compresión y posible DRM.
  * WPL: lista de reproducción de Windows Media Player.
  
* Extensiones de fotos

  * JPEG / JPG: formato más utilizado en imágenes digitales, con compresión y pérdida.
  * PNG: formato gráfico con compresión sin pérdida. Soporta transparencias.
  * BMP: imagen de mapa de bits.
  * ICO: archivo de icono.
  * SVG: imagen de gráficos vectoriales.
  * WEBP: formato de imagen con compresión desarrollado por Google para web.
  * GIF: imágenes sencillas o animadas, limitadas a 256 colores.
  * PSD: proyecto de Adobe Photoshop.
  * HEIC: formato de imagen utilizado por Apple en macOS y iOS.
  * NEF/CR2/CR3: formato de imagen RAW, en bruto, utilizado por cámaras Nikon (NEF) y Canon (CR2 y CR3).
  * AI: proyecto de Adobe Illustrator.
  * INDD: proyecto de InDesign de Adobe.

* Extensiones de archivos comprimidos

  * ZIP: formato creado por Phil Katz (PKWARE) en 1989; lo usan programas como WinZip o 7-Zip y lo abre directamente Windows.
  * RAR: formato de compresión desarrollado por WinRAR más eficiente que el ZIP.
  * RAR5: versión renovada de RAR con mejoras de seguridad y recuperación de datos.
  * 7Z: formato libre desarrollado por el creador de 7-Zip.
  * R00, R01, etc: archivo WinRAR dividido en partes.
  * GZ: archivo comprimido en GZIP, muy frecuente en Linux.
  * tar.bz2: otro formato de archivo comprimido de Linux.

Junto con el nombre del archivo, el sistema operativo almacena también unos atributos que califican al archivo. Entre otros pueden ser la hora y fecha de creación o su última modificación, su propietario, si es oculto, si pertenece al sistema, el tamaño, si está cifrado, si es solo para lectura, escritura o ejecución, si es un enlace simbólico, etc.

Los directorios son una división lógica de almacenamiento de archivos u otros subdirectorios, al igual que los archivos, tienen atributos que cambiarán según el sistema operativo que utilicemos y que veremos más adelante. Las operaciones más comunes sobre los directorios son:

* Crear
* Copiar
* Mover
* Renombrar
* Eliminar
* Listar archivos y carpetas
* Entrar y salir

.. toctree::
   :hidden:

   cuestionario_gestion_archivos.rst
