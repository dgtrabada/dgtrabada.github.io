***
SSH 
***

Vamos a configurar una conexión ssh desde un cliente a un servidor exportando la clave publica

Si no lo has hecho durante la instalación instala el servidor de ssh en el **servidor**.

.. code-block:: bash

  [user1@server ~]$ sudo su
  [root@server ~]$ apt install openssh-server

Para poder loguearse por ssh con el usuario root, primero tendremos que asignarle una contraseña, para ello ejecutamos los siguientes comandos en el **servidor**:

.. code-block:: bash

  [user1@server ~]$ sudo su
  [root@server ~]$  passwd

En el archivo **/etc/ssh/sshd_config** del **servidor** desomentar o incluir la linea : **PermitRootLogin yes**, y por ultimo reinicia el servicio sshd

.. code-block:: bash

  [root@server ~]$ systemctl restart  sshd.service

Genera en el **cliente** un par de claves rsa, una privada y otra publica, para ello ejecuta el siguiente comando en tu home:

.. code-block:: bash

  [user2@client ~]$ ssh-keygen
    
Puedes comprobar que se ha generado en el **cliente** (ls .ssh/) tendrá que aparecer las dos claves (id_rsa  id_rsa.pub), lo siguiente será exportar la clave publica al **servidor**, para ello ejecutamos:

.. code-block:: bash

  [user2@client ~]$ ssh-copy-id root@IP_servidor
     
Conectate sin que te pida la contraseña desde el **cliente**

.. code-block:: bash

  [user2@client ~]$ ssh root@IP_servidor