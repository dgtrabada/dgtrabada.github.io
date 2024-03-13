***************
Comandos ms-dos
***************

Desde el directorio raíz se accede al archivo mediante una ruta de acceso absoluta
Si se accede al archivo desde el directorio actual, la ruta es una ruta de acceso relativa

* **cd, chdir**  cambia el directorio actual.

  * **cd ..**  sube un directorio
  * **cd** indica el path en el que te encuetras
  * **cd <Nombre directorio>** cambia al directorio especificado
  * **cd <letra unidad>:** para cambiar de unidad
  
* **cls** limpia la pantalla

* **dir** lista los directorios y archivos de la unidad o directorio actual.

  * **dir /ah** archivos ocultos
  * **dir /as** archivos de sistema
  * **dir /ad** directorios
  * **dir /aa** archivos con indicador de lectura/escritura
  * **dir /ar** archivos de sólo lectura
  * **dir /an** orden alfabético por nombre
  * **dir /ae** orden alfabético por extensión
  * **dir /ad** fecha y hora (más antiguo)
  * **dir /as** tamaño (más pequeño)
  * **dir /ag** directorios agrupados antes de los archivos
  * **dir /a-h** el guión “-“ seguido de un indicador hace justamente lo contrario.


* **md, mkdir** crea directorios

  .. code-block:: shell

    C:\> mkdir TEST
    C:\TEST> cd TEST
    C:\TEST>mkdir A B C
    C:\TEST>dir
    15/03/2023  10:14    <DIR>          .
    15/03/2023  10:14    <DIR>          ..
    15/03/2023  10:14    <DIR>          A
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
                   0 archivos              0 bytes
                   5 dirs  607.204.921.344 bytes libres

* **attrib**  visualiza y cambia los atributos de directorios y archivos

  * attrib ±r ±h ... <archivo> /s ...
  * **attrib +r** solo lectura
  * **attrib +h** hacerlo oculto
  * **/s** directorio actual y en todos los subdirectorio
 
  .. code-block:: shell
    
    C:\TEST>attrib +h A
    C:\>dir
    15/03/2023  10:14    <DIR>          .
    15/03/2023  10:14    <DIR>          ..
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
                   0 archivos              0 bytes
                   4 dirs  607.209.717.760 bytes libres

    C:\TEST>dir /ah
    15/03/2023  10:14    <DIR>          A
                   0 archivos              0 bytes
                   1 dirs  607.209.672.704 bytes libres


* **rd, rmdir** - (rd /Q /S) Elimina un directorio.

  * **/q** modo silencioso
  * **/S** elimina subdirectorios
  
  .. code-block:: shell
  
    C:\TEST>dir
    15/03/2023  10:27    <DIR>          .
    15/03/2023  10:27    <DIR>          ..
    15/03/2023  10:27    <DIR>          A
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
    
    C:\TEST>rd A 

    C:\TEST>dir
    15/03/2023  10:27    <DIR>          .
    15/03/2023  10:27    <DIR>          ..
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
               0 archivos              0 bytes
               4 dirs  607.204.515.840 bytes libres
               
* **move** mueve o renombra un directorio o archivos. **/Y** sustituye los archivos sin pedir confirmación

  .. code-block:: shell
  
    C:\TEST>move B G
    Se ha(n) movido         1 directorio(s).

    C:\TEST>dir
    15/03/2023  10:30    <DIR>          .
    15/03/2023  10:30    <DIR>          ..
    15/03/2023  10:14    <DIR>          C
    15/03/2023  10:14    <DIR>          G
               0 archivos              0 bytes
               4 dirs  607.208.816.640 bytes libres

* **ren** cambia el nombre de uno o más ficheros

  .. code-block:: shell
  
    C:\TEST>ren G A
    
    C:\TEST>dir
    15/03/2023  10:32    <DIR>          .
    15/03/2023  10:32    <DIR>          ..
    15/03/2023  10:14    <DIR>          A
    15/03/2023  10:14    <DIR>          C
                   0 archivos              0 bytes
                   4 dirs  607.208.062.976 bytes libres


* **tree/deltree** lista/Borra un directorio con todos sus contenidos.

  .. code-block:: shell

    C:\TEST>tree
    Listado de rutas de carpetas
    El número de serie del volumen es 203A-19E6
    C:.
    └───A
        ├───A1
        │   ├───A2
        │   │   ├───A4
        │   │   └───A5
        │   └───A3
        └───A2
        

* **xcopy** Copiar archivos y directorios

  * XCOPY <origen> <destino> /E /H /C /K
  
    * /E: Copia todas las subcarpetas y archivos, incluso si están vacíos.
    * /H: Copia los archivos ocultos y los archivos de sistema.
    * /C: Continúa copiando, incluso si ocurren errores.
    * /K: Copia los atributos de los archivos, como la fecha y hora de creación y modificación.

  .. code-block:: shell

    C:\TEST>xcopy A B /E /H /C /K
    ¿B especifica un archivo
    o un directorio como destino
    (F = archivo, D = directorio)? D
    0 archivo(s) copiado(s)

    C:\TEST>tree
    C:.
    ├───A
    │   ├───A1
    │   │   ├───A2
    │   │   │   ├───A4
    │   │   │   └───A5
    │   │   └───A3
    │   └───A2
    └───B
        ├───A1
        │   ├───A2
        │   │   ├───A4
        │   │   └───A5
        │   └───A3
        └───A2

* **echo** - mostrar mensajes (eco) por pantalla, también puede activar o desactivar la presentación de comandos por pantalla

  * **%APPDATA%** ruta de los programas del usuario.
  * **%CMDCMDLINE%** comando al intérprete de comandos (cmd.exe).
  * **%CD%** muestra el directorio actual.
  * **%COMPUTERNAME%** nombre del equipo.
  * **%DATE%** fecha actual
  * **%HOMEDRIVE%** unidad en la que está ubicado el directorio actual del usuario.
  * **%HOMEPATH%** directorio actual del usuario.
  * **%OS%** sistema operativo instalado.
  * **%PATH%** archivos ejecutables más importantes del sistema.
  * **%PATHEXT%** extensiones que el sistema considera ejecutables.
  * **%RANDOM%** Muestra un número entero entre 0 y 32167 elegido al azar.
  * **%SYSTEMDRIVE%** unidad en la que se ubica el sistema
  * **%SYSTEMROOT%** directorio raíz del sistema.
  * **%TEMP%** directorio temporal para las aplicaciones.
  * **%TMP%** directorio temporal para las aplicaciones.
  * **%TIME%** Muestra la fecha del día.
  * **%USERDOMAIN%** dominio al que pertenece la cuenta actual.
  * **%USERNAME%** nombre de usuario que corresponde a la cuenta actual.
  * **%USERPROFILE%** ubicación del perfil de usuario de la cuenta actual.
  * **%WINDIR%** directorio del sistema
  
* **set** - Muestra, establece o quita variables de entorno
 
  .. code-block:: shell
  
    set a=1
    set b=3
    set /a sum=a+b
    echo %sum%
    
    set str=%a%+%b%
    echo %str%


* **Redireccionamiento** Envía la salida a un archivo o dispositivo (si no existe lo crea)

  .. code-block:: shell

    C:\TEST>echo hola > salida.txt
    
    C:\TEST>echo adios >> salida.txt

* **type** - Muestra el contenido de un fichero.

  .. code-block:: shell

    C:\TEST>type salida.txt
    hola
    adios

* **more** presenta información de salida pantalla por pantalla

* **copy** copiar un archivos, **/Y** sustituye los archivos sin pedir confirmación
  
  .. code-block:: shell

    C:\TEST>copy salida.txt salida2.txt
    
    
* **fc** compara archivos.

  .. code-block:: shell
  
    C:\TEST>echo 1 >> salida2.txt
    
    C:\TEST>fc salida.txt salida2.txt
    Comparando archivos salida.txt y SALIDA2.TXT
    ***** salida.txt
    ***** SALIDA2.TXT
    1
    *****

* **find** - Busca una cadena de texto específica en un archivo o en varios archivos

  .. code-block:: shell
    
   C:\TEST>find /?
   Busca una cadena de texto en uno o más archivos.
   
   FIND [/V] [/C] [/N] [/I] [/OFF[LINE]] "cadena" [[unidad:][ruta]archivo[ ...]]
   
     /V          Muestra todas las líneas que no tengan la cadena especificada.
     /C          Muestra solo el número de líneas que contienen la cadena.
     /N          Muestra el número de línea de cada línea.
     /I          Omite mayúsculas/minúsculas al buscar una cadena.
     /OFF[LINE]  No omite archivos con el atributo "sin conexión" establecido.
     "cadena"    Especifica el texto que se desea buscar.
     [unidad:][ruta]archivo
                 Especifica el o los archivos a buscar.
    Si no se especifica una ruta, FIND busca el texto que se escriba en el símbolo
   del sistema o que se canalice desde otro comando.
 
   C:\TEST>find "hola" salida.txt  
 
   ---------- SALIDA.TXT
   hola
    C:\TEST>find /V "hola" salida.txt
 
   ---------- SALIDA.TXT
   adios
   
   C:\TEST>find /N "hola" salida.txt
   
   ---------- SALIDA.TXT
   [1]hola
 
* **del** elimina archivos

  .. code-block:: shell

    C:\TEST>del salida2.txt


* **ping** se utiliza para medir la latencia o tiempo que tardan en comunicarse dos puntos remotos

  .. code-block:: shell
  
   C:\TEST>ping 8.8.8.8
   
   Haciendo ping a 8.8.8.8 con 32 bytes de datos:
   Respuesta desde 8.8.8.8: bytes=32 tiempo=4ms TTL=115
   Respuesta desde 8.8.8.8: bytes=32 tiempo=4ms TTL=115
   Respuesta desde 8.8.8.8: bytes=32 tiempo=7ms TTL=115
   Respuesta desde 8.8.8.8: bytes=32 tiempo=9ms TTL=115
   
   Estadísticas de ping para 8.8.8.8:
       Paquetes: enviados = 4, recibidos = 4, perdidos = 0
       (0% perdidos),
   Tiempos aproximados de ida y vuelta en milisegundos:
       Mínimo = 4ms, Máximo = 9ms, Media = 6ms

* **ipconfig** muestra los valores de configuración de red de TCP/IP

  .. code-block:: shell
  
   C:\TEST>ipconfig
   
   Configuración IP de Windows
   
   Adaptador de Ethernet vEthernet (WSL):
   
      Sufijo DNS específico para la conexión. . :
      Vínculo: dirección IPv6 local. . . : fe80::a32:a5ec:1b5a:7617%40
      Dirección IPv4. . . . . . . . . . . . . . : 192.168.0.1
      Máscara de subred . . . . . . . . . . . . : 255.255.240.0
      Puerta de enlace predeterminada . . . . . :

* **sort** (Ordenar): Lee información de entrada, ordena datos y escribe los resultados en la pantalla, en un archivo o en otro dispositivo.

  .. code-block:: shell
  
   C:\TEST>sort salida.txt
   adios
   hola
  
* **ver** - Muestra la versión del Sistema Operativo.

  .. code-block:: shell

   C:\TEST>ver
  
   Microsoft Windows [Versión 10.0.19044.2486]
  
 
* **vol** - Muestra la etiqueta del disco duro y su volumen (si lo tiene).

  .. code-block:: shell

   C:\TEST>vol
    El volumen de la unidad C no tiene etiqueta.
    El número de serie del volumen es: 203A-19E6
    