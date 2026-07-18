****************************************
Cuestionario permisos, usuarios y grupos
****************************************

.. cuestionario::

   1. Comandos de permisos:
      - 1. ¿Cuál es el propósito del comando chmod?
        ( ) Cambiar el nombre de un archivo o directorio
        (x) Cambiar los permisos de un archivo o directorio
        ( ) Mostrar el contenido de un archivo
        ( ) Copiar archivos y directorios
      - 2. ¿Qué opción se utiliza con el comando chmod para agregar permisos de ejecución a un archivo?
        (x) +x
        ( ) -x
        ( ) e
        ( ) execute
      - 3. ¿Qué opción se utiliza con el comando chmod para cambiar los permisos de forma recursiva?
        ( ) -r
        ( ) -f
        (x) -R
        ( ) -d
      - 4. ¿Cuál es el propósito del comando chown?
        ( ) Cambiar los permisos de un archivo o directorio
        (x) Cambiar el propietario de un archivo o directorio
        ( ) Cambiar la contraseña de un usuario
        ( ) Copiar archivos y directorios
      - 5. Para cambiar el propietario y el grupo del archivo o directorio usamos:
        (x) chown
        ( ) chgrp
        ( ) chmod
      - 6. ¿Cuál es el propósito del comando umask?
        ( ) Cambiar los permisos de un archivo o directorio
        (x) Establecer los permisos predeterminados para nuevos archivos y directorios
        ( ) Copiar archivos y directorios
        ( ) Cambiar el propietario de un archivo o directorio

   2. Usuarios y grupos:
      - 1. ¿Cuál es el propósito del comando passwd?
        ( ) Cambiar el propietario de un archivo o directorio
        (x) Cambiar la contraseña de un usuario
        ( ) Cambiar los permisos de un archivo o directorio
        ( ) Copiar archivos y directorios
      - 2. ¿Cuál es el propósito del archivo /etc/passwd?
        ( ) Almacenar contraseñas de usuarios
        ( ) Almacenar información sobre los permisos de los archivos
        (x) Almacenar información sobre los usuarios del sistema
        ( ) Almacenar información sobre los grupos del sistema
      - 3. Podemos encontrar la información de las contraseñas encriptadas en:
        (x) /etc/shadow
        ( ) /proc/group
        ( ) /etc/passwd
      - 4. ¿Cuál es el propósito del archivo /etc/group?
        ( ) Almacenar contraseñas de usuarios
        (x) Almacenar información sobre los grupos del sistema
        ( ) Almacenar información sobre los permisos de los archivos
        ( ) Almacenar información sobre los usuarios del sistema
      - 5. ¿Dónde está la plantilla de ficheros iniciales que se copian en el $HOME del nuevo usuario cuando se crea?
        (x) /etc/skel
        ( ) /etc/default
        ( ) /etc/template
      - 6. ¿Qué hace el comando **useradd -g alumnos -d /home/alumno -m -s /bin/bash alumno**?
        (x) Crea el usuario alumno con el home en /home/alumno y en el grupo alumnos
        ( ) El comando es adduser
        ( ) Ninguna es correcta
      - 7. Queremos añadir el grupo smr1 con ID = 501, ¿qué comando utilizamos?
        (x) groupadd -g 501 smr1
        ( ) groupadd -g smr1 -n 501
        ( ) groupadd -g smr1 -uid 501
      - 8. ¿Qué opción se utiliza con el comando groupadd para especificar el GID (Group ID) de un nuevo grupo?
        (x) -g
        ( ) -n
        ( ) -d
        ( ) -id
      - 9. ¿Qué opción se utiliza con el comando useradd para establecer el directorio de inicio de un nuevo usuario?
        ( ) -h
        (x) -d
        ( ) -m
        ( ) -u

   3. Interpretando los permisos:
      - 1. Ejecutamos ls -la y obtenemos:
        texto: -rw-rw-r-- 1 alumno alumno 5 ene 4 19:02 fecha.sh
        (x) Todos pueden leer el archivo
        ( ) Sólo el propietario puede leer el archivo
        ( ) Los usuarios del grupo pueden ejecutar el archivo
      - 2. Quiero dar permisos de ejecución al archivo run.sh solo a los miembros de mi grupo:
        (x) chmod g+x run.sh
        ( ) chmod a+x run.sh
        ( ) chmod 777 run.sh
      - 3. Ejecutar **chmod a-rwx test**, después **chmod a+r test** y después **chmod u+x test** es igual que:
        (x) chmod 544 test
        ( ) chmod 744 test
        ( ) chmod 577 test
      - 4. Ejecutamos ls -la /usr/bin/passwd y obtenemos -rw\ **s**\ r-xr-x 1 root root 54256 mar 29 11:25 /usr/bin/passwd. ¿Qué es la s que vemos en -rw\ **s**\ r-xr-x?
        (x) Es el bit setuid
        ( ) Es un error, debería ser x
        ( ) Es un error, debería ser r

   4. Práctica: crea una carpeta llamada carpeta y dentro un archivo fecha.sh que contenga la línea date (puedes usar vi, nano...). Con ls -la tienes que obtener:
      texto: -rw-rw-r-- 1 alumno alumno 5 ene 4 19:02 fecha.sh
      texto: Quítate todos los permisos del directorio carpeta; con ls -la obtendrás: d--------- 2 alumno alumno 4096 ene 4 19:02 carpeta
      - 1. ¿Qué comando has utilizado para quitarte todos los permisos?
        = chmod a-rwx carpeta | chmod 000 carpeta | chmod 0 carpeta
      - 2. Intenta entrar en el directorio carpeta, ¿se puede?
        ( ) Sí
        (x) No
      - 3. Dale solo permisos de ejecución al usuario del directorio carpeta. ¿Qué comando has utilizado?
        = chmod u+x carpeta | chmod u=x carpeta | chmod 100 carpeta
      - 4. Intenta entrar en el directorio carpeta, ¿se puede?
        (x) Sí
        ( ) No
      - 5. Intenta listar los archivos del directorio carpeta, ¿se puede?
        ( ) Sí
        (x) No
      - 6. Intenta crear un archivo o directorio dentro del directorio carpeta, ¿se puede?
        ( ) Sí
        (x) No
      - 7. Dale solo permisos de escritura y ejecución al usuario del directorio carpeta. ¿Qué comando has utilizado?
        = chmod u+wx carpeta | chmod u=wx carpeta | chmod 300 carpeta
      - 8. Intenta entrar en el directorio carpeta, ¿se puede?
        (x) Sí
        ( ) No
      - 9. Intenta listar los archivos del directorio carpeta, ¿se puede?
        ( ) Sí
        (x) No
      - 10. Intenta crear un archivo o directorio dentro del directorio carpeta, ¿se puede?
        (x) Sí
        ( ) No
      - 11. Dale permisos de lectura, escritura y ejecución al usuario del directorio carpeta. ¿Qué comando has utilizado?
        = chmod u+rwx carpeta | chmod u=rwx carpeta | chmod 700 carpeta
      - 12. Intenta entrar en el directorio carpeta, ¿se puede?
        (x) Sí
        ( ) No
      - 13. Intenta listar los archivos del directorio carpeta, ¿se puede?
        (x) Sí
        ( ) No
      - 14. Intenta crear un archivo o directorio dentro del directorio carpeta, ¿se puede?
        (x) Sí
        ( ) No
      - 15. Haz pruebas similares con el archivo fecha.sh, teniendo en cuenta que se ejecuta escribiendo ./fecha.sh en la terminal. ¿Qué comando ejecutas para darle permisos de ejecución? (cuando lo ejecutes deberías obtener la fecha actual)
        = chmod +x fecha.sh | chmod u+x fecha.sh | chmod a+x fecha.sh

   5. Rellena los espacios:
      - 1. r read (lectura): cuando el permiso de lectura está activo sobre un **directorio** significa que se podrá...
        (x) listar
        ( ) ver
        ( ) crear
        ( ) escribir
        ( ) entrar
        ( ) ejecutar
      - los recursos almacenados en él; si está asignado a un **archivo** se podrá...
        ( ) listar
        (x) ver
        ( ) crear
        ( ) escribir
        ( ) entrar
        ( ) ejecutar
      - 2. w write (escritura): cuando el permiso de escritura está activo sobre un **directorio** significa que se podrá...
        ( ) listar
        ( ) ver
        (x) crear
        ( ) escribir
        ( ) entrar
        ( ) ejecutar
      - archivos en su interior; si está activado para un **archivo** significa que se podrá...
        ( ) listar
        ( ) ver
        ( ) crear
        (x) escribir
        ( ) entrar
        ( ) ejecutar
      - 3. x execute (ejecución): si el permiso de ejecución está activo sobre un **directorio** significa que el usuario podrá...
        ( ) listar
        ( ) ver
        ( ) crear
        ( ) escribir
        (x) entrar
        ( ) ejecutar
      - en él; y si está activo sobre un **archivo** se podrá...
        ( ) listar
        ( ) ver
        ( ) crear
        ( ) escribir
        ( ) entrar
        (x) ejecutar
