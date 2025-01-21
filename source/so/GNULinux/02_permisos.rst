*********************
Permisos en GNU/Linux
*********************

El sistema de permisos en Linux se basa en un esquema de usuarios/grupos. A estos usuarios y grupos se les asignan distintos derechos sobre los archivos y directorios. Todos los archivos y directorios en Linux tienen permisos que verifican quien puede hacer o no alguna acción con él. Copia en tu cuaderno el siguiente esquema de permisos:

* Existen **tres tipos** diferentes de **permisos**:

  * **r**: read (lectura)
  * **w**: write (escritura)
  * **x**: execute (ejecución)

* Existen **tres tipos** diferentes de **identidades**:

  * **u**: usuario propietarios del archivo
  * **g**: grupo al que pertenece
  * **o**: otros usuarios
  * **a**: todos los usuarios

.. code-block:: bash
   
 $ ls -la fecha.sh
 
 - rw- rw- r-- 1 alumno GA     5 ene 4 19:02 fecha.sh
 ↑ ↑   ↑   ↑   ↑ ↑      ↑      ↑ ↑           ↑
 1 2   3   4   5 6      7      8 9           10
 1 : Tipo de archivo = - es un archivo regular [d = directorio; l = enlace simbólico; ...]
 2 : Permisos = los permisos para el propietario son de lectura y escritura
 3 : Permisos = el grupo tiene permiso de sólo lectura
 4 : Permisos = los otros usuarios tienen el permiso de sólo lectura
 5 : Enlace Físico = tiene un enlace físico
 6 : Propietario = el usuario alumno es el propietario de este archivo
 7 : Grupo = este archivo pertenece al grupo alumno
 8 : Tamaño = su tamaño es de 246417 bytes
 9 : Fecha = fecha en el que fue creado
 10 : Nombre = el archivo se llama fecha.sh

* **chmod** cambia los permisos de lectura, escritura y ejecución del archivo o directorio

  .. code-block:: bash

   chmod a+x fecha.dat    # damos permisos de ejecución a todos
   chmod u+rw fecha.dat   # damos permisos de lectura y escritura a usuarios propietario
   chmod o-r fecha.dat    # quitamos permisos de lectura a otros usuarios
   chmod o+w fecha.dat    # damos permisos de escritura a los usuarios del grupo
   chmod -R a+rwx carpeta # -R cambiar los permisos de forma recursiva
   
* **Notación binaria**

  .. code-block:: bash
   
   Octal Binario Permisos efectivos
     0    0 0 0    - - -
     1    0 0 1    - - x
     2    0 1 0    - w -
     3    0 1 1    - w x
     4    1 0 0    r - -
     5    1 0 1    r - x
     6    1 1 0    r w -
     7    1 1 1    r w x
     
    r  : read = 4 = 100
    w  : write = 2 = 010
    x  : execute = 1 = 001
    
    rwx = 100 + 010 + 001 = 111 = 4+2+1 = 7
    r-x = 100 + 001 = 101 = 4+1 = 5
    
    chmod a+rwx = chmod 777
    chmod a-rwx = chmod 000
    chmod a+rw = chmod 666
    
    rwxr-x--- (750)
    r–x r--r-- (544)
    
* **chown** cambia el propietario y el grupo del archivo o directorio
  
  .. code-block:: bash
   
   chown alumno2:GB foto.jpg
   
* **chgrp** cambia el grupo del archivo o directorio

  .. code-block:: bash
   
   chgrp smr2 foto.jpg   
    
* **umask** cambia el valor por defecto de los permisos que se definen para un nuevo archivo.

      



Permisos especiales (setuid, setgid, sticky bit)
================================================

| Bit setuid --> 4000
| Bit setgid --> 2000
| Sticky bit --> 1000

* **setuid** permite que un fichero ejecutable se ejecute con los permisos del propietario del fichero

  .. code-block:: bash
  
   $ chmod u+s /bin/su
   $ ls -l /bin/su
    -rwsr-xr-x 1 root root 40128 mar 29 11:25 /bin/su
    
   $ ls -la /usr/bin/passwd
    -rwsr-xr-x 1 root root 54256 mar 29 11:25 /usr/bin/passwd

* **setgid** permite que un fichero ejecutable se ejecute con los permisos del grupo al que pertenece el fichero, por ejemplo asignamos el bit setgid la carpeta /compartido, le asignamos permisos totales para el propietario y el grupo (770) y el bit segid (2):

  .. code-block:: bash
  
   $ ls -la
   drwxrwx---  6 usuario1 GA      4096 sep 18 09:37 carpetaGA
   
   $ chmod g+s carpetaGA/
   drwxrws---  2 usuario1 GA      4096 sep 18 09:46 carpetaGA
   
   $ su
   $ cd carpetaGA/
   $ touch test
   $ ls -la
   -rw-r--r-- 1 root     GA      0 sep 18 09:47 test
   
   $ whoami
   root

* **sticky** permite que cualquier usuario pueda modificar un archivo o directorio, pero solo su propietario pueda borrarlo, este bit se asigna siempre en /tmp y /var/tmp

  /tmp tiene permisos 777, el bit sticky se asignaría del siguiente modo:

  .. code-block:: bash
      
    chmod 1777 /tmp
    
    #otra forma:
    chmod o+t /tmp
    
    #Si hacemos un ls veremos la “t” asignada:
    $ls -la / | grep tmp
    drwxrwxrwt  13 root root  4096 2011-04-24 20:55 tmp
