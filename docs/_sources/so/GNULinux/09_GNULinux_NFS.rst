***
NFS
***

Las siglas **NFS** provienen del inglés Network File System (Sistema de archivos de red). Se trata de un protocolo, implementado en 1984 por la empresa Sun Microsystems, que se utiliza en redes de área local para crear un sistema de archivos distribuido.
El objetivo de NFS es que varios usuarios (o programas) de una red local puedan acceder a archivos y directorios compartidos como si fuesen locales. De esta forma, se puede centralizar la capacidad de almacenamiento de la red, pudiendo ser más reducida en los clientes.

Actualmente, el protocolo NFS está incluido en la mayoría de las distribuciones Linux y en macOS.

En los sistemas Microsoft la situación es algo más confusa: en las versiones antiguas (2000, XP, 2003) había que instalar el paquete Windows Services for UNIX, y hoy en día el cliente NFS viene incluido solo en las ediciones Pro y Enterprise de Windows 10/11 (se activa en «Características de Windows»); en las ediciones Home no está disponible, y en redes Windows lo habitual es compartir con SMB (Samba).

Puedes apoyarte en los vídeos [#v1]_.

Servidor NFS
************

Instalamos

.. code-block:: bash

 apt update
 apt install nfs-kernel-server

Supongamos que queremos compartir la carpeta ``/home/tunombre1`` situada en un servidor con un cliente, para ello crearemos las siguientes líneas en el archivo ``/etc/exports``

.. code-block:: bash

 /home/tunombre1 172.16.0.11(rw,sync,no_root_squash,no_subtree_check)

* **rw**: Da permisos de lectura y escritura al cliente
* **sync**: sincronizar la escritura
* **no_subtree_check**: desactiva la comprobación de que cada acceso esté dentro del subárbol exportado (mejora el rendimiento y evita problemas al renombrar archivos)
* **no_root_squash**: permite que los usuarios root de los equipos cliente tengan acceso root en el servidor (cómodo en el laboratorio, pero inseguro en producción; lo contrario, root_squash, es lo predeterminado)

Cada vez que cambiemos el archivo ``/etc/exports`` tendremos que recargar los exports o reiniciar el servicio

.. code-block:: bash

 exportfs -ra                                   # recarga los exports
 exportfs -v                                    # muestra lo que se está exportando
 systemctl restart nfs-kernel-server.service    # o reiniciamos el servicio

Una forma abreviada de incluir más nodos sería:
 
.. code-block:: bash

 /home/tunombre1 172.16.0.0/24(rw,sync,no_root_squash,no_subtree_check)

Más abreviado:
 
.. code-block:: bash

 /home 172.16.0.0/24(rw,sync,no_root_squash,no_subtree_check)


 
Cliente NFS
***********

Instalamos

.. code-block:: bash

 apt-get install nfs-common

Podemos consultar qué exporta el servidor y, para probar que funciona, montar el directorio a mano; ejecutamos como root en el cliente:

.. code-block:: bash

 showmount -e 172.16.0.10     # lista lo que exporta el servidor
 mkdir /home/tunombre1
 mount 172.16.0.10:/home/tunombre1 /home/tunombre1

En el caso de que queramos que los cambios sean permanentes copiamos en /etc/fstab del cliente:

.. code-block:: bash

 172.16.0.10:/home/tunombre1 /home/tunombre1 nfs auto,noatime,nolock,bg,nfsvers=3,intr,tcp,actimeo=1800 0 0

 # con las versiones modernas (NFSv4) basta con:
 172.16.0.10:/home/tunombre1 /home/tunombre1 nfs defaults 0 0

Uno de los problemas que plantea el uso de NFS es que no permite validar a los usuarios que tratan de acceder a una carpeta compartida. En realidad, el servidor NFS envía al cliente los permisos de cada archivo y subcarpeta que encuentre dentro de la carpeta compartida. Además, también se envía el UID del usuario propietario y el GID de su grupo principal.

El problema es que, cuando existan usuarios y/o grupos en los equipos cliente que tengan asignado el mismo UID o dispongan del mismo GID para su grupo principal, estos usuarios locales asumirán los permisos que tenían los usuarios del equipo servidor sobre el contenido de las carpetas compartidas. Este problema se puede corregir utilizando un sistema **NIS** o **LDAP**

Montar un sistema de archivos NFS usando autofs
***********************************************

Otra opción para montar datos compartidos con NFS es utilizar autofs. Autofs utiliza el demonio automount para controlar los puntos de montaje dinámicamente tan sólo montándolos cuando sea necesario.

Autofs consulta el mapa maestro del archivo de configuración /etc/auto.master para ver qué puntos de montaje se han definido. Luego arranca un proceso automount con los parámetros adecuados para cada punto de montaje. Cada línea del mapa maestro define un punto de montaje y un archivo de mapa separado que define el sistema de archivos que se tiene que montar en este punto de montaje. Por ejemplo, el archivo /etc/auto.misc define los puntos de montaje en el directorio /misc; esta relación debe ser definida en el archivo /etc/auto.master.


Si en el cliente marcaste con **sudo pam-auth-update** la opción de crear el directorio automáticamente, vuelve a ejecutar el comando y esta vez déjala desmarcada: ahora los homes vendrán montados del servidor y no queremos que se creen en local

Vamos a configurar autofs para montar de forma automática el home de los usuarios, para ello vamos a instalar en los **clientes**

.. code-block:: bash

 apt-get install autofs

En ``/etc/auto.master`` incluimos la siguiente linea

.. code-block:: bash

 /home /etc/auto.home

Donde el archivo  ``/etc/auto.home`` sería:

.. code-block:: bash

 # /etc/auto.home
 tunombre1 compute-0-0:/home/tunombre1
 tunombre2 compute-0-0:/home/tunombre2
 tunombre3 compute-0-0:/home/tunombre3

En vez de escribir una línea por usuario, podemos usar la forma resumida, que monta bajo demanda solo el home del usuario que inicia sesión:

.. code-block:: bash

 *    compute-0-0:/home/&

El asterisco (*) representa cualquier nombre que se pida bajo /home, y el ampersand (&) repite ese mismo nombre en la ruta del servidor (por ejemplo, al entrar tunombre2 se monta compute-0-0:/home/tunombre2).

Aplicamos los cambios y hacemos que se inicie cuando se reinicia el cliente **compute-0-1**

.. code-block:: bash

 systemctl restart autofs
 systemctl enable autofs

Fíjate como funcionaría:

.. code-block:: bash

 root@compute-0-1:~# df -h | grep tunombre
 root@compute-0-1:~# su tunombre1
 tunombre1@compute-0-1:/root$ df -h | grep tunombre
 compute-0-0:/home/tunombre1 116G   128K   110G   1% /home/tunombre1


.. rubric:: Notas

.. [#v1] vídeos

 * `NIS NFS autofs Ubuntu Server 26.04 LTS <https://mediateca.educa.madrid.org/video/1cp8qi6cxvc9cpb5>`_
 * `NIS NFS autofs Ubuntu Server 24.04 LTS <https://mediateca.educa.madrid.org/video/5w95nxsv1pvq3sx9>`_