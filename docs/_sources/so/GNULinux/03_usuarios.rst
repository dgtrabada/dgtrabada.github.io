***************************
Usuarios y grupos GNU/Linux
***************************

**Tipos de usuarios:**

* Usuario **Normal**: alumno, juan, pepe, etc ..
* Usuarios de **Sistema**: mail, man, proxy, tty, etc
* **root**: administrador del sistema

Los usuarios están definidos en los siguientes archivos:

* **/etc/passwd** - Información básica de usuarios (ID, shell, directorio personal)
* **/etc/shadow** - Contraseñas encriptadas (acceso restringido)
* **/etc/group**  - Miembros de grupos secundarios, el grupo principal en /etc/passwd.
* **/etc/skel/**  - Plantilla para archivos iniciales del directorio personal ($HOME)
* **/etc/adduser.conf** - Configuración del comando ``adduser``
* **/etc/pam.d/** - Módulos de autenticación (PAM) (LDAP, Kerberos, biométrica)
* **~/.bashrc**   - Configuración personal de Bash por usuario (``/etc/bash.bashrc`` Configuración Bash global)

Gestión de grupos
=================

En Linux, los grupos permiten gestionar permisos de forma colectiva, asignando accesos a varios usuarios al mismo tiempo. Cada usuario tiene:

* **Grupo principal** se asigna al crear el usuario (normalmente un grupo con su mismo nombre).

* **Grupos secundarios** grupos adicionales a los que pertenece.

Podemos consultar los grupos con ``groups usuario`` y ``id usuario``

Algunos grupos predefinidos son:

* **adm**: permite leer ficheros de log y monitorizar tareas
* **cdrom**, floppy, audio, video: dan acceso a estos dispositivos
* **sudo**: sus miembros pueden ejecutar comandos como administrador con sudo (introduciendo su propia contraseña)
* **shadow**: permite acceso al fichero de contraseñas /etc/shadow
* **usuario**: cuando se crea un usuario es habitual que el sistema le asigne como grupo principal uno con el nombre del propio usuario

Para gestionar los grupos podemos utilizar los siguientes comandos:

* **groupadd** añade un grupo al sistema.
  
  .. code-block:: bash
    
   groupadd GA
   groupadd -g 1020 GA # crea el grupo con un GID específico

* **groupdel** para eliminar grupos del sistema

* **groupmod** permite modificar el nombre o GID de un grupo.
  
  .. code-block:: bash
    
   groupmod -g 1021 GA
   groupmod -n GA GB # cambia el nombre del grupo

* **gpasswd** permite administrar los grupos.
  
  .. code-block:: bash

   gpasswd -A usuario GA # señala como administrador del grupo GA al usuario
   gpasswd GA            # cambia la contraseña del grupo GA
   gpasswd -a usuario GA # añade el usuario al grupo GA
   gpasswd -d usuario GA # saca al usuario del grupo GA


Gestión de usuarios
===================

* **adduser / deluser** son los asistentes interactivos de Debian/Ubuntu para crear y borrar usuarios (piden la contraseña, crean el home a partir de /etc/skel...). Se configuran en /etc/adduser.conf.

* **useradd** añade nuevos usuarios al sistema (comando de bajo nivel, no pregunta nada).

  * -g Grupo principal que queremos tenga el usuario (debe existir previamente)
  * -d Carpeta home del usuario. Suele ser /home/nombre-usuario
  * -m Crear carpeta home si es que no existe.
  * -s Intérprete de comandos (shell) del usuario. Suele ser /bin/bash
  
  .. code-block:: bash
    
   sudo useradd -g grupo -d /home/usuario -m -s /bin/bash usuario
 
  * Para asignar una contraseña al usuario podemos ingresarla después de crearlo con ``sudo passwd usuario``, o durante la creación con la opción ``-p $(mkpasswd -m sha-512 cambiame)`` (la opción -p espera la contraseña ya cifrada). Podemos instalar mkpasswd con ``apt install whois``

* **passwd usuario** establecer la contraseña del usuario o cambiarla

  .. code-block:: bash
  
   passwd -d usuario # elimina la contraseña (la deja vacía)
   passwd -l usuario # bloquea la cuenta (añade ! a la contraseña en /etc/shadow)
   passwd -u usuario # desbloquea

* **userdel usuario** elimina el usuario. (-r elimina y borra su home)

* **usermod** modifica las propiedades de usuarios

  .. code-block:: bash
  
   usermod -s /bin/csh usuario       # cambia shell
   usermod -G cdrom,audio usuario    # establece los grupos secundarios (sustituye la lista actual)
   usermod -e 2010-1-1 usuario       # expira la cuenta en esa fecha
   usermod -g grupo usuario          # cambia el grupo principal
   usermod -aG admin usuario         # añade (-a) el usuario a un grupo secundario sin quitar los demás

* **chfn** cambia la información de contacto de un usuario.

* **chsh** cambia el shell del usuario especificado.

* **chage** gestiona la caducidad de la contraseña y de la cuenta del usuario.

  .. code-block:: bash

   chage -l usuario           # muestra la información de caducidad
   chage -E 2011-1-11 usuario # la cuenta expira en esa fecha
   chage -W 7 usuario         # avisa 7 días antes de que caduque la contraseña
   chage -M 7 usuario         # la contraseña dura 7 días como máximo,
                              # después deberá cambiarla de forma obligatoria


Comandos adicionales
====================

visudo
^^^^^^

Tradicionalmente, **visudo** abre el archivo **/etc/sudoers** con el editor de texto vi. Sin embargo, Ubuntu, ha configurado visudo para utilizar el editor de texto nano en su lugar.
Para cambiarlo de nuevo a vi, emita el siguiente comando: ``sudo update-alternatives --config editor``
encontramos los diferentes campos:

.. code-block:: bash

  usuario ALL=(ALL:ALL) ALL 

* El **primer campo** indica el nombre de usuario al que se aplicará la regla.

* El primer "**ALL**" indica que esta regla se aplica a todos los hosts.

* **(ALL:ALL)** Esta parte de la regla especifica el usuario y el grupo al que se puede cambiar mediante sudo. En este caso, "ALL" significa que el usuario username puede cambiar a cualquier usuario y grupo. Podrías restringirlo a un usuario y grupo específico si lo deseas.

* El ultimo **ALL** indica los comandos específicos que un usuario puede ejecutar con privilegios de administrador. Por ejemplo ``usuario ALL=(ALL:ALL) /bin/ls, /usr/bin/apt-get``
  
.. code-block:: bash

 $ whoami
 alumno

 $ groups
 alumno adm dialout cdrom plugdev lpadmin admin sambashare

 $id
 uid=1000(alumno) gid=1000(alumno) grupos=4(adm),20(dialout),24(cdrom),
 46(plugdev),105(lpadmin),119(admin),122(sambashare),1000(alumno)

 $ who
 alumno tty7 2011-02-09 09:52 (:0)
 alumno pts/0 2011-02-09 10:05 (:0.0)
 alumno pts/1 2011-02-09 10:10 (:0.0)
 alumno pts/2 2011-02-09 10:19 (:0.0)
 alumno pts/4 2011-02-09 11:10 (:0.0)
 profesor pts/5 2011-02-09 11:12
 profesor pts/6 2011-02-09 11:19 (192.168.248.1)
 
 $ w
 11:19:52 up 1:29, 7 users, load average: 1.47, 1.03, 0.97
 USER TTY FROM LOGIN@ IDLE JCPU PCPU WHAT
 alumno tty7 :0 09:52 1:28m 6:56 1.42s gnome-session
 alumno pts/0 :0.0 10:05 9.00s 0.47s 0.47s bash
 alumno pts/1 :0.0 10:10 4:11 1.06s 1.06s bash
 alumno pts/2 :0.0 10:19 31:30 1:26 1:25 texmacs.bin
 alumno pts/4 :0.0 11:10 6:19 0.62s 17.92s gnome-terminal
 profesor pts/5 - 11:12 1:18 1.36s 0.56s -bash
 profesor pts/6 192.168.248.1 11:19 19.00s 0.34s 0.34s -bash

 $ last
 profesor pts/6 192.168.248.1 Wed Feb 9 11:19 still logged in
 profesor pts/5 Wed Feb 9 11:12 still logged in
 profesor pts/5 Wed Feb 9 11:12 - 11:12 (00:00)
 alumno pts/5 :0.0 Wed Feb 9 11:10 - 11:12 (00:01)
 alumno pts/4 :0.0 Wed Feb 9 11:10 still logged in

 $ finger dani
 Login: dani                             Name: (null)
 Directory: /home/dani                   Shell: /bin/bash
 On since Sun Feb 27 19:12 (CET) on pts/18 from 74.125.230.178
 No mail.
 No Plan.

 # getent en Linux sirve para consultar bases de datos del sistema usando la configuración de NSS (Name Service Switch).
 getent passwd #todos los usuarios
 getent passwd usuario_concreto
 getent group #ver los grupos
 getent hosts google.com # consulta IP
 getent services ssh # consulta un servicio
 # Otros
 write, wall, mesg, newgrp, ...
 

Añadir Quotas a los usuarios
============================

Las cuotas (quotas) permiten limitar el espacio en disco que un usuario o grupo puede utilizar en un sistema de archivos específico. (`vídeo <https://mediateca.educa.madrid.org/video/145lrmv6eqsma3pi>`_)

.. code-block:: bash

 #tenemos que añadir usrquota,grpquota en el fstab
 
 vi /etc/fstab
 UUID=XXXX /home      ext4    defaults,usrquota,grpquota        0       2
 
 #para activarlo
 mount -a 
 
 #si no funciona podemos remontar
 mount -o remount,usrquota,grpquota /home 
 
 #escaneo de las quotas asignadas a grupos y usuarios
 #en caso de que sea la primera vez, crea los ficheros de quota para usuarios y grupos
 quotacheck -cgumv /home 
 
 #activar las quotas
 quotaon -ugv /home 
 
 #setquota -u usuario 10M 10M 0 0 /home
 edquota usuario
 
 #setquota -g grupo 10M 10M 0 0 /home
 edquota -g grupo
 
 #crear un informe del uso del disco para el grupo y por usuarios
 repquota -vg /home
 repquota -vu -a

.. toctree::
   :hidden:

   03_cuestionario_permisos_usuarios_grupos.rst
