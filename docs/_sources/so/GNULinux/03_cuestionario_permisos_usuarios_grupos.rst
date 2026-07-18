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
        fichero:
           $ ls -la
           -rw-rw-r-- 1 alumno alumno 5 ene 4 19:02 fecha.sh
        (x) Todos pueden leer el archivo
        ( ) Sólo el propietario puede leer el archivo
        ( ) Los usuarios del grupo pueden ejecutar el archivo
      - 2. Quiero dar permisos de ejecución al archivo run.sh solo a los miembros de mi grupo:
        (x) chmod g+x run.sh
        ( ) chmod a+x run.sh
        ( ) chmod 777 run.sh
      - 3. Ejecutar los siguientes comandos es igual que:
        fichero:
           $ chmod a-rwx test
           $ chmod a+r test
           $ chmod u+x test
        (x) chmod 544 test
        ( ) chmod 744 test
        ( ) chmod 577 test
      - 4. Ejecutamos ls -la /usr/bin/passwd, ¿qué es la **s** que vemos en los permisos?
        fichero:
           $ ls -la /usr/bin/passwd
           -rwsr-xr-x 1 root root 54256 mar 29 11:25 /usr/bin/passwd
        (x) Es el bit setuid
        ( ) Es un error, debería ser x
        ( ) Es un error, debería ser r

   4. Práctica: crea una carpeta llamada carpeta y dentro de ella un archivo fecha.sh que contenga la línea date (puedes escribirlo con vi, nano...). Al terminar tiene que quedar así:
      fichero:
         $ mkdir carpeta
         $ cd carpeta
         $ vi fecha.sh          # escribe dentro la línea: date
         $ ls -la
         -rw-rw-r-- 1 alumno alumno 5 ene 4 19:02 fecha.sh
         $ cd ..
      texto: Ahora quítate **todos** los permisos del directorio carpeta; al listarlo tienes que obtener:
      fichero:
         $ ls -la
         d--------- 2 alumno alumno 4096 ene 4 19:02 carpeta
      texto: A partir de aquí irás dando permisos al usuario (u) del directorio poco a poco, y después de cada cambio probarás tres cosas: **entrar** (cd carpeta), **listar** (ls carpeta) y **crear** algo dentro (touch carpeta/prueba). Responde qué comando usaste y qué se puede hacer en cada paso.
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

   5. Rellena los huecos con: listar, ver, crear, escribir, entrar o ejecutar.
      - 1. r read (lectura):
        Cuando el permiso de lectura está activo sobre un directorio significa que se podrá [listar] los recursos almacenados en él, si está asignado a un archivo se podrá [ver|leer] su contenido.
      - 2. w write (escritura):
        Cuando el permiso de escritura está activo sobre un directorio significa que se podrá [crear] archivos en su interior, si está activado para un archivo significa que se podrá [escribir|modificar] su contenido.
      - 3. x execute (ejecución):
        Si el permiso de ejecución está activo sobre un directorio significa que el usuario podrá [entrar] en él, y si está activo sobre un archivo se podrá [ejecutar|ejecutarlo].

   6. Notación octal y umask:
      - 1. chmod a+rwx equivale a chmod...
        [777]
      - 2. chmod a+rw equivale a chmod...
        [666]
      - 3. ¿Qué número corresponde a rwxr-x---?
        [750]
      - 4. ¿Qué permisos da chmod 640 a un archivo?
        (x) rw-r-----
        ( ) rw-r--r--
        ( ) rwxr-----
      - 5. Con umask 022, ¿con qué permisos se crean los directorios nuevos?
        [755]
      - 6. ¿Y los archivos nuevos?
        [644]
      - 7. ¿Qué comando cambia solo el grupo de un archivo o directorio?
        [chgrp]

   7. Permisos especiales:
      - 1. ¿Qué bit corresponde al valor octal 4000?
        (x) setuid
        ( ) setgid
        ( ) sticky
      - 2. En un directorio con el bit setgid, lo que se crea dentro...
        (x) Hereda el grupo del directorio
        ( ) Hereda el propietario del directorio
        ( ) No se puede borrar
      - 3. ¿Qué hace el sticky bit en un directorio como /tmp?
        (x) Impide borrar o renombrar los archivos de otros usuarios
        ( ) Impide leer los archivos de otros usuarios
        ( ) Hace que el directorio no se pueda borrar nunca
      - 4. /tmp tiene permisos 777, ¿cómo le asignamos además el sticky bit?
        = chmod 1777 /tmp | chmod o+t /tmp | sudo chmod 1777 /tmp | sudo chmod o+t /tmp

   8. Más gestión de usuarios y grupos:
      - 1. ¿Cómo añadimos el usuario al grupo admin sin sacarlo de sus otros grupos?
        = usermod -aG admin usuario | sudo usermod -aG admin usuario | gpasswd -a usuario admin | sudo gpasswd -a usuario admin
      - 2. ¿Cómo eliminamos un usuario borrando también su home?
        = userdel -r usuario | sudo userdel -r usuario
      - 3. ¿Qué comando muestra la información de caducidad de la contraseña de un usuario?
        = chage -l usuario | sudo chage -l usuario
      - 4. ¿Con qué comandos podemos consultar los grupos de un usuario?
        (x) groups usuario e id usuario
        ( ) lsgroups usuario
        ( ) cat /etc/usuarios
      - 5. ¿En qué archivo está definido el grupo principal de cada usuario?
        (x) /etc/passwd
        ( ) /etc/group
        ( ) /etc/shadow
      - 6. ¿Qué grupo predefinido permite leer los ficheros de log?
        [adm]
      - 7. ¿Con qué comando se edita de forma segura el archivo /etc/sudoers?
        [visudo|sudo visudo]
      - 8. En la regla usuario ALL=(ALL:ALL) ALL de sudoers, ¿qué indica el primer ALL?
        (x) Que la regla se aplica a todos los hosts
        ( ) Que puede ejecutar todos los comandos
        ( ) Que se aplica a todos los usuarios

   9. Sesiones y quotas:
      - 1. ¿Qué comando muestra quién está conectado y qué está ejecutando cada uno?
        (x) w
        ( ) whoami
        ( ) groups
      - 2. ¿Qué comando muestra el historial de los últimos accesos al sistema?
        [last]
      - 3. ¿Para qué sirve getent (por ejemplo getent passwd)?
        (x) Consultar las bases de datos del sistema usando NSS (usuarios locales, LDAP, NIS...)
        ( ) Generar usuarios nuevos
        ( ) Encriptar contraseñas
      - 4. Para activar las quotas en /home, ¿qué opciones añadimos a su línea del fstab?
        (x) usrquota,grpquota
        ( ) quotas=on
        ( ) userlimit,grouplimit
      - 5. ¿Qué comando edita la quota de un usuario?
        [edquota|edquota usuario|sudo edquota usuario]
      - 6. ¿Qué comando crea un informe del uso de disco y quotas?
        [repquota]
