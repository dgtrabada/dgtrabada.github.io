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

Tradicionalmente, **visudo** abre el archivo **/etc/sudoers** con el editor de texto vi (comprobando la sintaxis antes de guardar, por eso nunca se edita el archivo directamente). Sin embargo, Ubuntu ha configurado visudo para utilizar el editor de texto nano en su lugar.
Para cambiarlo de nuevo a vi, ejecuta el siguiente comando: ``sudo update-alternatives --config editor``.
En una regla de sudoers encontramos los siguientes campos:

.. code-block:: bash

  usuario ALL=(ALL:ALL) ALL 

* El **primer campo** indica el nombre de usuario al que se aplicará la regla.

* El primer "**ALL**" indica que esta regla se aplica a todos los hosts.

* **(ALL:ALL)** Esta parte de la regla especifica el usuario y el grupo al que se puede cambiar mediante sudo. En este caso, "ALL" significa que el usuario puede cambiar a cualquier usuario y grupo. Podrías restringirlo a un usuario y grupo específico si lo deseas.

* El último **ALL** indica los comandos específicos que un usuario puede ejecutar con privilegios de administrador. Por ejemplo ``usuario ALL=(ALL:ALL) /bin/ls, /usr/bin/apt-get``
  
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

**Cuota blanda, cuota dura y periodo de gracia**

``setquota`` no recibe un límite, sino cuatro, y después el punto de montaje:

.. code-block:: bash

 setquota -u usuario <bloques_blanda> <bloques_dura> <inodos_blanda> <inodos_dura> /home

 #5 MB de aviso y 10 MB de tope, sin limitar el numero de ficheros
 setquota -u tunombre1 5120 10240 0 0 /home

Los bloques son de 1 KiB, un ``0`` significa «sin límite» y las versiones actuales de ``quota-tools`` admiten sufijos, con lo que la orden anterior también se puede escribir ``setquota -u tunombre1 5M 10M 0 0 /home``. Los dos últimos valores limitan el número de ficheros (inodos) en lugar del espacio.

La diferencia entre los dos límites de espacio es lo que hace útil el sistema:

* La **cuota dura** no se puede rebasar nunca. La escritura falla en el momento con ``Disk quota exceeded``, y ese mensaje es la forma que tiene un script de enterarse de que el usuario ha llegado al tope.
* La **cuota blanda** sí se puede rebasar, pero al hacerlo arranca un **periodo de gracia**, siete días por omisión, que se cambia con ``edquota -t``. Mientras dura, el usuario sigue trabajando; si el plazo se agota sin que baje del límite, la blanda empieza a comportarse como si fuera dura.

Poner el mismo valor en los dos límites, que es lo más fácil, deja al usuario sin espacio de golpe y sin aviso previo. Es más razonable dejarle margen, por ejemplo la mitad: blanda ``5120`` y dura ``10240``.

Para ver el estado tenemos dos comandos, y los dos marcan los límites rebasados:

.. code-block:: bash

 #desde la sesion del propio usuario, en unidades legibles
 quota -s -u tunombre1

      Filesystem   space   quota   limit   grace   files   quota   limit   grace
       /dev/sda3   9232K*  5120K  10240K   6days      13       0       0

 #informe de todo el volumen
 repquota -u /home

 User            used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
 tunombre1 +-    9232    5120   10240  6days      13     0     0

Si preferimos leer los valores en megabytes, ``-s`` admite que le digamos las unidades, con un carácter para el espacio y otro para los inodos:

.. code-block:: bash

 repquota --human-readable=m,k /home

 User            used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
 tunombre1 +-     10M      5M     10M  6days      1k    0k    0k

Hay que darle los dos caracteres: con ``--human-readable=m`` a secas responde ``Bad output format units for human readable output: m``. Y conviene saber que **redondea hacia arriba**, así que los 9232K del ejemplo anterior salen aquí como ``10M`` y un usuario que ocupa 9 MB de 10 parece estar lleno. Con cuotas de pocos megabytes es más fiable la salida en KB; con cuotas de cientos de megabytes, la de megabytes se lee mucho mejor.

El ``*`` de ``quota`` y el ``+`` de la columna de indicadores de ``repquota`` (el primero es el de bloques y el segundo el de inodos) significan lo mismo: ese límite blando está rebasado y hay un plazo en marcha, el que aparece en la columna ``grace``. De estas columnas sale cualquier informe de ocupación que queramos construir después con AWK.

**Dos rarezas cuando esto se automatiza**

La primera: ``quotaon -p`` informa **por su salida y no por su código de retorno**. Con las cuotas activas escribe ``is on`` y, aun así, devuelve un código distinto de cero.

.. code-block:: bash

 quotaon -pu /home
 user quota on /home (/dev/sda3) is on

 echo $?
 1

Hay que mirar por tanto lo que escribe (``quotaon -pu /home | grep -qi 'is on'``) y no fiarse del ``$?``. En un script con ``set -o pipefail`` el despiste se paga doble, porque el código del primer comando contamina el de toda la tubería y el script concluye que las cuotas están apagadas cuando están funcionando.

La segunda: ``quotacheck`` **se niega a trabajar si las cuotas ya están activas**, y avisa con ``Quota for users is enabled on mountpoint /home so quotacheck might damage the file``. Es razonable que lo haga, porque el escaneo solo hace falta la primera vez, para crear ``aquota.user`` y ``aquota.group``. Un script que se ejecute más de una vez tiene que comprobar antes si están activas y saltárselo si lo están.

.. toctree::
   :hidden:

   03_cuestionario_permisos_usuarios_grupos.rst
