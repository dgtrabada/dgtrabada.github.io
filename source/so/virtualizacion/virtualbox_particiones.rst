************************
Ejercicio de particiones
************************

En este ejercicio vamos a crear una máquina virtual con DRBL Live, como en la :ref:`Introducción a VirtualBox`, y usarla para hacer tablas de particiones con **GParted**.

ayuda: :ref:`Particiones`

Ejercicio 01
============

* Crea una nueva máquina virtual en Máquina -> Nueva, con las siguientes opciones:

  * Nombre: **Particiones**
  * Tipo: Linux, versión Other Linux (64-bit)
  * Memoria: 2048 MB
  * Disco duro virtual nuevo: VDI reservado dinámicamente con un tamaño de **1 GiB**

* Una vez creada la máquina virtual, ve a Configuración y cambia las siguientes preferencias:

  * Pantalla -> Memoria de vídeo: 128 MB
  * Almacenamiento: dentro del controlador IDE aparecerá un disco (Vacío); carga la ISO de DRBL Live (por ejemplo, ``drbl-live-xfce-2.5.1-16-amd64.iso``)

* Arranca DRBL Live y abre **GParted** (desde el menú Applications o con ``sudo gparted`` en una terminal)

* El disco es nuevo y no tiene tabla de particiones: créala en Dispositivo -> Crear tabla de particiones -> **msdos**. Solo con msdos existen las particiones extendidas y lógicas

* Crea la siguiente tabla de particiones:

  =========  ======================  ============
  Tipo       Tamaño                  Formato
  =========  ======================  ============
  Primaria   ~7 % (70 MiB)           ext4
  Primaria   ~7 % (70 MiB)           ext4
  Primaria   ~7 % (70 MiB)           ntfs
  Extendida  ~80 % (800 MiB)
  Lógica     ~7 % (70 MiB)           ext4
  Lógica     ~7 % (70 MiB)           fat32
  Lógica     ~7 % (70 MiB)           fat32
  Lógica     ~7 % (70 MiB)           ntfs
  Lógica     ~7 % (70 MiB)           linux-swap
  Lógica     ~7 % (70 MiB)           reiser4
  Lógica     ~7 % (70 MiB)           fat16
  =========  ======================  ============

  Los porcentajes son del disco duro (1 GiB = 1024 MiB). El disco tiene que verse algo parecido a lo que vemos en el siguiente esquema:

  .. image:: imagenes/particiones_ej1_gparted.png

  reiser4 es un sistema de archivos abandonado (nunca llegó a entrar en el núcleo Linux); lo usamos solo para ver que GParted permite formatear con muchos sistemas de archivos distintos.

* Cuando termines, cambia la etiqueta de la primera partición por tu nombre y sube un pantallazo de la ventana de GParted en el que se vean todas las particiones con su sistema de archivos, su etiqueta y su tamaño

Ejercicio 02
============

Antes de hacer el ejercicio 03, responde en el texto de la entrega a estas preguntas. Puedes buscar la información en los apuntes (:ref:`Organización para GNU/Linux`) o en Internet:

* ¿Cuánto espacio necesitas para la partición del sistema operativo Ubuntu 26.04? ¿Con qué sistema de archivos la formatearemos?

* ¿Cuánto espacio necesitas para la partición del sistema operativo Windows 11? ¿Con qué sistema de archivos la formatearemos?

* Queremos hacer una partición de 200 GB para los datos de los usuarios de GNU/Linux (``/home``). ¿Con qué sistema de archivos la formatearemos?

* El equipo tiene 4 GB de RAM. ¿Qué tamaño le darías a la partición de intercambio (swap) y con qué sistema de archivos la formatearemos?

* ¿Cuántas particiones primarias puede tener como máximo una tabla msdos? ¿Qué hacemos si necesitamos más?

* ¿Qué tipo de tabla de particiones necesita Windows 11 y por qué? ¿Qué es la partición **ESP** y con qué sistema de archivos se formatea?

Ejercicio 03
============

Queremos instalar en un ordenador con un disco duro de 1 TB y 4 GB de RAM dos sistemas operativos, Windows 11 y Ubuntu 26.04. Cada sistema tendrá su propia partición de datos para los usuarios: **D:** en Windows y ``/home`` en Ubuntu.

* Apaga la máquina virtual **Particiones** y añádele un segundo disco duro VDI reservado dinámicamente de **1 TB**. Como es dinámico, no ocupa 1 TB de verdad en tu equipo: solo crece con lo que se escribe en él

* Arranca de nuevo DRBL Live, abre GParted y selecciona el disco de 1 TB (arriba a la derecha, normalmente ``/dev/sdb``)

* Usa los tamaños que has respondido en el ejercicio 02 y, en la **etiqueta** de cada partición, pon su punto de montaje: en Windows la letra de unidad (C:, D:), en Ubuntu ``/`` y ``/home``, y ``swap`` en la de intercambio

a) Tabla msdos
--------------

* Crea una tabla de particiones **msdos** y haz en ella las particiones de los dos sistemas: C:, D:, ``/``, ``/home`` y swap

* Como son 5 particiones y msdos solo admite 4 primarias, tendrás que usar una **partición extendida** con particiones lógicas dentro

* Marca como **arrancable** (``boot``) la partición de Windows (C:)

* Sube un pantallazo de la ventana de GParted en el que se vean todas las particiones con su sistema de archivos, su etiqueta y su tamaño, el espacio que has utilizado y la partición de arranque (columna Flags)

.. note::

   Este primer reparto sirve para practicar las particiones primarias, extendidas y lógicas, pero **en un equipo real no podríamos instalar así Windows 11**: Windows 11 necesita un equipo con UEFI y, con UEFI, Windows solo arranca desde un disco con tabla **GPT**. Lo hacemos en el siguiente apartado.

b) Tabla GPT
------------

* En el mismo disco de 1 TB, crea una tabla de particiones nueva de tipo **gpt** (se borrarán las particiones del apartado anterior)

* Haz el mismo reparto, pero añadiendo al principio del disco la **partición ESP**, de unos 300 MiB, formateada en **fat32**, con la etiqueta ``EFI`` y los indicadores ``boot`` y ``esp``

* Con GPT todas las particiones son primarias: ya no hace falta la partición extendida

* Sube un pantallazo como el del apartado anterior

* Responde en el texto de la entrega: ¿qué diferencias ves entre las dos tablas de particiones?
