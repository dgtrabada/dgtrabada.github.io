*****
Samba
*****

Samba es una implementación libre del protocolo de archivos compartidos de Microsoft Windows **SMB** (Server Message Block), también conocido por el nombre de su dialecto antiguo CIFS (hoy obsoleto; las versiones actuales del protocolo son SMB2 y SMB3). De esta forma, es posible que computadoras con GNU/Linux, macOS o Unix en general se vean como servidores o actúen como clientes en redes de Windows. Samba también permite validar usuarios haciendo de Controlador Principal de Dominio (PDC), como miembro de dominio e incluso como un dominio Active Directory para redes basadas en Windows; aparte de ser capaz de servir colas de impresión, directorios compartidos y autenticar con su propio archivo de usuarios.

El servidor son dos servicios: **smbd**, que sirve los archivos y las impresoras (puerto 445), y **nmbd**, que se encarga de la resolución de nombres NetBIOS en redes antiguas. La configuración está en ``/etc/samba/smb.conf``.

Caso práctico: compartir una carpeta sin autenticación
======================================================

Podemos ver el `vídeo <https://mediateca.educa.madrid.org/video/hpxp95mqhnryu8v7>`_.

Instalamos el servidor de samba:

.. code-block:: bash

 sudo apt install samba

Al final de ``/etc/samba/smb.conf`` añadimos el recurso:

.. code-block:: bash

 [share]
  comment = Ubuntu File Server Share
  path = /srv/samba/share
  browseable = yes
  guest ok = yes
  read only = no
  create mask = 0755

* **[share]** es el nombre con el que se verá el recurso en la red.
* **guest ok = yes** permite entrar sin usuario ni contraseña (invitado).
* **read only = no** permite escribir.
* **create mask** son los permisos con los que se crearán los archivos nuevos.

Creamos la carpeta:

.. code-block:: bash

 sudo mkdir -p /srv/samba/share

Le cambiamos el propietario al usuario invitado de Samba:

.. code-block:: bash

 sudo chown nobody:nogroup /srv/samba/share/

En el caso de tener problemas puedes probar con ``chmod a+rwx`` (vale para salir del paso en el laboratorio, pero en un servidor real hay que ajustar los permisos, no abrirlos del todo).

Comprobamos que no hay errores en la configuración y reiniciamos el servicio:

.. code-block:: bash

  testparm
  sudo systemctl restart smbd

Acceder al recurso
==================

* Desde GNU/Linux, en el administrador de archivos: ``smb://IP/share/``
* Desde la terminal podemos listar los recursos que comparte un servidor y también montarlos:

  .. code-block:: bash

   smbclient -L //IP                                    # listar los recursos compartidos
   sudo apt install cifs-utils
   sudo mount -t cifs //IP/share /mnt -o guest          # montar el share como invitado

* Desde Windows: ``\\IP\share``

Caso práctico: compartir una carpeta con usuario y contraseña
=============================================================

Samba tiene su **propia base de datos de contraseñas**, separada de la del sistema: el usuario debe existir en Linux y además hay que darlo de alta en Samba con ``smbpasswd``:

.. code-block:: bash

 sudo smbpasswd -a usuario     # da de alta el usuario en Samba y le asigna contraseña

Añadimos al final de ``/etc/samba/smb.conf`` un recurso que solo admite a ese usuario:

.. code-block:: bash

 [privado]
  comment = Carpeta privada
  path = /srv/samba/privado
  browseable = yes
  guest ok = no
  read only = no
  valid users = usuario

Creamos la carpeta, se la asignamos al usuario y reiniciamos:

.. code-block:: bash

 sudo mkdir -p /srv/samba/privado
 sudo chown usuario:usuario /srv/samba/privado
 sudo systemctl restart smbd

Al acceder a ``smb://IP/privado/`` (o ``\\IP\privado`` desde Windows) nos pedirá el usuario y la contraseña **de Samba**.
