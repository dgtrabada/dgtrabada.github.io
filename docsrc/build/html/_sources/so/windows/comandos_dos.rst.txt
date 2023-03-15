************
Comandos DOS
************

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

  .. code-block:: msdos

    C:\Users\dani> mkdir TEST
    C:\Users\dani\TEST> cd TEST
    C:\Users\dani\TEST>mkdir A B C
    C:\Users\dani\TEST>dir
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
 
  .. code-block:: msdos
    
    C:\Users\dani\TEST>attrib +h A
    C:\Users\dani\TEST>dir
    15/03/2023  10:14    <DIR>          .
    15/03/2023  10:14    <DIR>          ..
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
                   0 archivos              0 bytes
                   4 dirs  607.209.717.760 bytes libres

    C:\Users\dani\TEST>dir /ah
    15/03/2023  10:14    <DIR>          A
                   0 archivos              0 bytes
                   1 dirs  607.209.672.704 bytes libres


* **rd, rmdir** - (rd /Q /S) Elimina un directorio.

  * **/q** modo silencioso
  * **/S** elimina subdirectorios
  
  .. code-block:: msdos
  
    C:\Users\dani\TEST>dir
    15/03/2023  10:27    <DIR>          .
    15/03/2023  10:27    <DIR>          ..
    15/03/2023  10:27    <DIR>          A
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
    
    C:\Users\dani\TEST>rd A 

    C:\Users\dani\TEST>dir
    15/03/2023  10:27    <DIR>          .
    15/03/2023  10:27    <DIR>          ..
    15/03/2023  10:14    <DIR>          B
    15/03/2023  10:14    <DIR>          C
               0 archivos              0 bytes
               4 dirs  607.204.515.840 bytes libres
               
* **move** mueve o renombra un directorio o archivos. **/Y** sustituye los archivos sin pedir confirmación

  .. code-block:: msdos
  
    C:\Users\dani\TEST>move B G
    Se ha(n) movido         1 directorio(s).

    C:\Users\dani\TEST>dir
    15/03/2023  10:30    <DIR>          .
    15/03/2023  10:30    <DIR>          ..
    15/03/2023  10:14    <DIR>          C
    15/03/2023  10:14    <DIR>          G
               0 archivos              0 bytes
               4 dirs  607.208.816.640 bytes libres

* **ren** cambia el nombre de uno o más ficheros

  .. code-block:: msdos
  
    C:\Users\dani\TEST>ren G A
    
    C:\Users\dani\TEST>dir
    15/03/2023  10:32    <DIR>          .
    15/03/2023  10:32    <DIR>          ..
    15/03/2023  10:14    <DIR>          A
    15/03/2023  10:14    <DIR>          C
                   0 archivos              0 bytes
                   4 dirs  607.208.062.976 bytes libres


* **tree/deltree** lista/Borra un directorio con todos sus contenidos.

  .. code-block:: msdos

    C:\Users\dani\TEST>tree
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

  .. code-block:: msdos

    C:\Users\dani\TEST>xcopy A B /E /H /C /K
    ¿B especifica un archivo
    o un directorio como destino
    (F = archivo, D = directorio)? D
    0 archivo(s) copiado(s)

    C:\Users\dani\TEST>tree
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

* **Redireccionamiento** Envía la salida a un archivo o dispositivo (si no existe lo crea)

  .. code-block:: msdos

    C:\Users\dani\TEST>echo hola > salida.txt
    
    C:\Users\dani\TEST>echo adios >> salida.txt

* **type** - Muestra el contenido de un fichero.

  .. code-block:: msdos

    C:\Users\dani\TEST>type salida.txt
    hola
    adios
  
* **copy** copiar un archivos, **/Y** sustituye los archivos sin pedir confirmación
  
  .. code-block:: msdos

    C:\Users\dani\TEST>copy salida.txt salida2.txt
    
    
* **del** elimina archivos

  * **del /f** permite eliminar archivos con el atributo solo de lectura
  * **del /q** modo silencioso
  

  
* **fc** compara archivos.

  .. code-block:: msdos
  
    C:\Users\dani\PAPELERA>type a1.dat
    1
    2
    3
    
    C:\Users\dani\PAPELERA>copy a1.dat a2.dat /Y
            1 archivo(s) copiado(s).
    
    C:\Users\dani\PAPELERA>fc  a1.dat a2.dat
    Comparando archivos a1.dat y A2.DAT
    FC: no se han encontrado diferencias
    
    
    C:\Users\dani\PAPELERA>echo 4 >> a2.dat

    C:\Users\dani\PAPELERA>fc  a1.dat a2.dat
    Comparando archivos a1.dat y A2.DAT
    ***** a1.dat
    ***** A2.DAT
    4
    *****

* **find** - Busca una cadena de texto específica en un archivo o en varios archivos

  * FIND [/V] [/C] [/N] [/I] "cadena" [[unidad:][ruta]nombrearchivo[...]]
  * [/V]: Presenta todas las líneas que no contengan la cadena especificada.
  * [/C]: Solamente presenta un número que indica cuántas líneas contienen la cadena especificada.
  * [/N]: Precede cada línea con el número de línea del archivo.
  * [/I]: Especifica que no se haga la distinción entre mayúsculas y minúsculas en la búsqueda.
  * “cadena”: Especifica el grupo de caracteres que se buscarán.
  * nombe_archivo: Especifica el nombre del archivo en el cual se realizará la búsqueda.
  


* **more** presenta información de salida pantalla por pantalla

* **ping** se utiliza para medir la latencia o tiempo que tardan en comunicarse dos puntos remotos

* **ipconfig** muestra los valores de configuración de red de TCP/IP
  

* **start** - iniciar aplicación, podemos ejecutarlos sin abrir la consola

  * cmd /K ipfongig /all  (deja abierta la ventana del cmd)
  * cmd /C start http://google.com (cierra la ventana)
  
* **set** - Muestra, establece o quita variables de entorno
  set n1=2
  set n2=3
  set /A s = %n1% + %n2%
  echo %s%
  operadores (+ - * / %)
  
* **sort** (Ordenar): Lee información de entrada, ordena datos y escribe los resultados en la pantalla, en un archivo o en otro dispositivo.

  * sort [/R] [/+n] [<] [unidad1:][ruta1] nombre_archivo1 [>]
  * [[unidad2:][ruta2] nombre_archivo2] ó también[comando |] SORT [/R] [/+n] [> [unidad2:][ruta2] nombre_archivo2]
  * [/R]: Invierte el orden de clasificación, es decir, ordena de Z a A y de 9 a 0.
  * [/+n]: Ordena el contenido del archivo de acuerdo al carácter de la columna ‘n’. Si se omite este
  



  * /A Indica al comando TREE que utilice caracteres de texto en lugar de caracteres gráficos
  * /Y No confirma la eliminación del directorio.
  
* **ver** - Muestra la versión del Sistema Operativo.

* **vol** - Muestra la etiqueta del disco duro y su volumen (si lo tiene).


