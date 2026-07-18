***
SSH
***

SSH (Secure Shell) es un protocolo de red seguro que utiliza criptografía asimétrica para la autenticación y el intercambio de claves, y criptografía simétrica para cifrar la comunicación. Sustituye a protocolos antiguos sin cifrar como telnet, rlogin o ftp.

Intervienen dos programas distintos:

* **ssh** el cliente, con el que nos conectamos.
* **sshd** el servidor (daemon), que escucha por defecto en el **puerto 22** esperando conexiones. En Debian/Ubuntu el servicio se llama ``ssh``.

Conexión básica con contraseña
==============================

.. code-block:: bash

  [user2@client ~]$ ssh usuario@IP_servidor        # conectarse
  [user2@client ~]$ ssh -p 2222 usuario@servidor   # si el servidor no escucha en el puerto 22

La primera vez que nos conectamos a un servidor, el cliente nos muestra la **huella (fingerprint) de la clave pública del servidor** y nos pide confirmar; al aceptar, se guarda en ``~/.ssh/known_hosts``. En conexiones posteriores el cliente comprueba que la clave del servidor coincide con la guardada: si algún día no coincide, avisa de una posible suplantación (o de que el servidor se ha reinstalado).

Para copiar archivos a través de ssh podemos usar **scp** (o **sftp** de forma interactiva):

.. code-block:: bash

  scp archivo.txt usuario@IP_servidor:/tmp/       # de local al servidor
  scp usuario@IP_servidor:/tmp/archivo.txt .      # del servidor a local
  scp -r carpeta usuario@IP_servidor:~            # carpetas, recursivo

Práctica: acceso sin contraseña con clave pública
=================================================

Vamos a configurar una conexión ssh desde un cliente a un servidor exportando la clave pública.

Si no lo has hecho durante la instalación, instala el servidor de ssh en el **servidor**:

.. code-block:: bash

  [user1@server ~]$ sudo su
  [root@server ~]# apt install openssh-server

Para poder loguearse por ssh con el usuario root, primero tendremos que asignarle una contraseña; para ello ejecutamos los siguientes comandos en el **servidor**:

.. code-block:: bash

  [user1@server ~]$ sudo su
  [root@server ~]# passwd

En el archivo ``/etc/ssh/sshd_config`` del **servidor** descomentar o incluir la línea ``PermitRootLogin yes``, y por último reiniciar el servicio ssh:

.. code-block:: bash

  [root@server ~]# systemctl restart ssh.service

.. note::

   Permitir el login de root por ssh con contraseña es útil para esta práctica, pero en un servidor real es **mala práctica**: es la primera cuenta que atacan los bots por fuerza bruta. Al terminar, vuelve a dejar ``PermitRootLogin prohibit-password`` (o ``no``).

Genera en el **cliente** un par de claves, una privada y otra pública; para ello ejecuta el siguiente comando en tu home:

.. code-block:: bash

  [user2@client ~]$ ssh-keygen

Puedes comprobar que se han generado con ``ls .ssh/``: tendrán que aparecer las dos claves, por ejemplo ``id_ed25519`` (privada) e ``id_ed25519.pub`` (pública). En versiones antiguas de OpenSSH el tipo por defecto era rsa (``id_rsa`` e ``id_rsa.pub``); puedes forzarlo con ``ssh-keygen -t rsa``.

La **clave privada no sale nunca del cliente**; lo que exportamos al servidor es la pública:

.. code-block:: bash

  [user2@client ~]$ ssh-copy-id root@IP_servidor

``ssh-copy-id`` lo que hace es añadir nuestra clave pública al final del archivo ``~/.ssh/authorized_keys`` del usuario en el **servidor** (podríamos hacerlo a mano copiando el contenido de ``id_ed25519.pub``).

Conéctate: ya no te pedirá la contraseña.

.. code-block:: bash

  [user2@client ~]$ ssh root@IP_servidor

¿Cómo funciona? Al conectar, el servidor comprueba si nuestra clave pública está en ``authorized_keys`` y lanza un **reto** que solo puede resolver quien tenga la **clave privada** correspondiente; el cliente lo resuelve y quedamos autenticados sin enviar ninguna contraseña por la red.

Endurecer la configuración del servidor
=======================================

Algunas opciones típicas de ``/etc/ssh/sshd_config`` para asegurar un servidor (tras cambiarlas hay que reiniciar el servicio):

* ``PermitRootLogin no`` no permite el login directo de root (se entra con un usuario normal y se usa sudo).
* ``PasswordAuthentication no`` solo se permite la autenticación con clave pública; los ataques de fuerza bruta dejan de tener sentido.
* ``Port 2222`` cambiar el puerto por defecto no aporta seguridad real, pero reduce el ruido de los escaneos automáticos.
* ``AllowUsers user1 user2`` lista de usuarios que pueden conectarse.
