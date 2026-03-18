*****
Samba
*****


Samba es una implementación libre del protocolo de archivos compartidos de Microsoft Windows (antiguamente llamado SMB, renombrado recientemente a CIFS) para sistemas de tipo UNIX. De esta forma, es posible que computadoras con GNU/Linux, Mac OS X o Unix en general se vean como servidores o actúen como clientes en redes de Windows. Samba también permite validar usuarios haciendo de Controlador Principal de Dominio (PDC), como miembro de dominio e incluso como un dominio Active Directory para redes basadas en Windows; aparte de ser capaz de servir colas de impresión, directorios compartidos y autentificar con su propio archivo de usuarios.


Caso práctico: Samba
********************

Instalamos el servicor de samba:

.. code-block:: bash

 sudo apt install samba

Al final de ``/etc/samba/smb.conf``

.. code-block:: bash

 [share]
  comment = Ubuntu File Server Share
  path = /srv/samba/share
  browsable = yes
  guest ok = yes
  read only = no
  create mask = 0755

Creamos la carpeta

.. code-block:: bash

 mkdir -p /srv/samba/share
 
Le cambiamos los permisos

.. code-block:: bash

 chown nobody:nogroup /srv/samba/share/
 
En el caso de tener problemas puedes probar con chmod a+rwx

Reiniciamos el servicio

.. code-block:: bash

  systemctl restart smbd


* Para acceder desde GNU/Linux poner en el administrador de archivos ``smb://IP/share/``

* Para acceder desde windows ``\\IP\share``, en el caso de que tengas problemas crear o habilitar un usuario en Samba (SMB) y asignarle contraseña ´´smbpasswd -a nombre_usuario``

