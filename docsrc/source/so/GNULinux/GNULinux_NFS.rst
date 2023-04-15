***
NFS
***

Las siglas **NFS** provienen del inglés Network File System (Sistema de archivos de red). Se trata de un protocolo, implementado en 1984 por la empresa Sun Microsystems, que se utiliza en redes de área local para crear un sistema de archivos distribuido.
El objetivo de NFS es que varios usuarios (o programas) de una red local puedan acceder a archivos y directorios compartidos como si fuesen locales. De esta forma, se puede centralizar la capacidad de almacenamiento de la red, pudiendo ser más reducida en los clientes.

Actualmente, el protocolo NFS está incluido en la mayoría de las distribuciones Linux, y en las diferentes versiones del sistema operativo OSX de Apple.

En los sistemas Microsoft, la situación es algo más confusa: Para las versiones 2000, 2003 y XP, había que descargar e instalar el paquete Windows Services for UNIX). En Windows 8 ya se incluye de fábrica, pero sólo en la versión Enterprise edition y, hasta el momento de escribir este documento, no existe forma de instalarlo en otras versiones más modestas. De hecho, los usuarios que actualizan desde las ediciones Windows 7 Ultimate o Windows 7 Enterprise a la edición Windows 8 Pro, no podrán seguir usando NFS.

Servidor NFS (Ubuntu Server 22.04)
**********************************

Instalamos

.. code-block:: bash

 apt update
 apt install nfs-kernel-server

Supongamos que queremos compartir la carpeta **/home/tunombre1** situada en un servidor con un cliente, para ello crearemos las siguientes líneas en el archivo **/etc/exports**

.. code-block:: bash

 /home/tunombre1 172.16.0.11(rw,sync,no_root_squash,no_subtree_check)

* **rw**: Da permisos de lectura y escritura al cliente
* **sync**: sincroniczar la escritura
* **no_subtree_check**: permite que no se compruebe el camino hasta el directorio que se exporta, en el caso de que el usuario no tenga permisos sobre el directorio exportado
* **no_root_squash**: permite que los usuarios root de los equipos cliente tengan acceso root en el servido

Cada vez que cambiemos el archivo **/etc/exports** tendremos que reiniciar el servicio

.. code-block:: bash

 systemctl restart nfs-kernel-server.service
 
Cliente NFS
***********

Instalamos

.. code-block:: bash

 apt-get install nfs-common

Para probar que funciona el nfs podemos montar a mano el directorio ejecutamos como root en el cliente:

.. code-block:: bash

 mkdir /home/tunombre1
 mount 172.16.0.10:/home/tunombre1 /home/tunombre1

En el caso de que queramos que los cambios sean permanentes copiamos en /etc/fstab del cliente:

.. code-block:: bash

 172.16.0.10:/home/tunombre1 /home/tunombre1 nfs auto,noatime,nolock,bg,nfsvers=3,intr,tcp,actimeo=1800 0 0

Uno de los problemas que plantea el uso de NFS es que no permite validar a los usuarios que tratan de acceder a una carpeta compartida. En realidad, el servidor NFS envía al cliente los permisos de cada archivo y subcarpeta que encuentre dentro de la carpeta compartida. Además, también se envía el UID del usuario propietario y el GID de su grupo principal.

El problema es que, cuando existan usuarios y/o grupos en los equipos cliente que tengan asignado el mismo UID o dispongan del mismo GID para su grupo principal, estos usuarios locales asumirán los permisos que tenían los usuarios del equipo servidor sobre el contenido de las carpetas compartidas. Este problema se puede corregir utilizando un sistema **NIS** o **LDAP**

Montar un sistema de archivos NFS usando autofs
***********************************************

Otra opción para montar datos compartidos con NFS es utilizar autofs. Autofs utiliza el demonio automount para controlar los puntos de montaje dinámicamente tan sólo montándolos cuando sea necesario.

Autofs consulta el mapa maestro del archivo de configuración /etc/auto.master para ver qué puntos de montaje se han definido. Luego arranca un proceso automount con los parámetros adecuados para cada punto de montaje. Cada línea del mapa maestro define un punto de montaje y un archivo de mapa separado que define el sistema de archivos que se tiene que montar en este punto de montaje. Por ejemplo, el archivo /etc/auto.misc define los puntos de montaje en el directorio /misc; esta relación debe ser definida en el archivo /etc/auto.master.


Caso 1: Red interna con  NFS
*****************************

Vamos a utilizar el caso 2 que vimos en la NIS, es decir:

* **compute-0-0** : servidor con dos tarjetas de red
* **compute-0-1** : cliente con una tarjeta de red

En ejercicio anterior marcaste la opción de que se cree el directorio automáticamente en el cliente **sudo pam-auth-update**, vuelve a ejecutar el comando en el cliente y esta vez dejalo desmarcado

.. code-block:: bash

 [ ] Create home directory on login

Borra los directorios de los usuarios que se hayan creado. Si nos conectamos ahora con cualquier usuario obtenemos:

.. code-block:: bash

 tunombre1@ubuntu-client:/home$ cd
 bash: cd: /home/tunombre1: No such file or directory

Haz que el home del usuario1 situado en el servidor se exporte al cliente de forma permanente por medio de NFS

Si no lo hiciste, genera la clave publica (ssh-keygen) para el usuario tunombre1, de esta forma no te pedira la contraseña, cópiela (cp .ssh/id_rsa.pub .ssh/authorized_keys)  , conéctate por ssh

Caso 1: Red interna con NFS y autofs
************************************

Vamos a configurar autofs para montar de forma automática el home de los usuarios, para ello vamos a instalar al cliente **compute-0-1**:

.. code-block:: bash

 apt-get install autofs

En **/etc/auto.master** incluimos la siguiente linea

.. code-block:: bash

 /home /etc/auto.home

Donde el archivo  **/etc/auto.home** sería:

.. code-block:: bash

 # /etc/auto.home
 tunombre1 compute-0-0:/home/tunombre1
 tunombre2 compute-0-0:/home/tunombre2
 tunombre3 compute-0-0:/home/tunombre3

No lo hacemos así para exportar el home de los usuarios por separado, de otra forma cada vez que un usuarios se loguease en el cliente todas las carpetas se exportarían, podemos escribirlo de una forma más resumida:

.. code-block:: bash

 *    compute-0-0:/home/&

El asterico (*) se utiliza para remplazar el punto de montaje y (&) lo que queremos montar

Hacemos que se inicie cuando se reinicia el cliente **compute-0-1**

.. code-block:: bash

 systemctl enable autofs

Fíjate como funcionaría:

.. code-block:: bash

 root@compute-0-1:~# df -h | grep tunombre
 root@compute-0-1:~# su tunombre1
 tunombre1@compute-0-1:/root$ df -h | grep tunombre
 compute-0-0:/home/tunombre1 116G   128K   110G   1% /home/tunombre1

