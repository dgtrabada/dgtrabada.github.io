***
SSH 
***

Si no lo has hecho durante la instalación instala el servidor de ssh en el servidor.

.. code-block:: bash

 $ sudo apt-get install openssh-server

Para poder loguearse por ssh con el usuario root, primero tendremos que asignarle una contraseña, para ello ejecutamos los siguientes comandos:

.. code-block:: bash

 $ sudo su
 $ passwd

En el archivo **/etc/ssh/sshd_config** desomentar o incluir la linea : **PermitRootLogin yes**

En el caso de que tu maquina anfitriona sea **Windows**, pudes conectarte con MobaXterm, la primera vez te preguntara la contraseña.

En el caso de que tu maquina anfitriona sea **GNU/Linux**, primero genera un par de claves rsa una privada y publica, para ello ejecuta el siguiente comando en tu home:

.. code-block:: bash

 $ ssh-keygen
    
Puedes comprobar que se ha generado (ls .ssh/) tendrá que aparecer las dos claves (id_rsa  id_rsa.pub), lo siguiente será exportar la clave publica al cliente, para ello ejecutamos:

.. code-block:: bash

 $ ssh-copy-id roo@10.4.X.Y
     
Conectate sin que te pida la contraseña.
