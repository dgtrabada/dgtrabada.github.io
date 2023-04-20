**********************
MV Ubuntu Server 22.04
**********************

* Descárgate el sistema operativo Ubuntu Server 22.04 en formato (ISO) de su página oficial

* Utiliza un disco de 200 GB y 2G de RAM

* Iniciamos la maquina y procedemos a la instalación, llama a esta maquina virtual **MV Ubuntu Server 22.04**

* Utiliza un adaptador puente para la red con **IP** 10.4.X.Y/8 (255.0.0.0), donde **X.Y** son parte de las ips de vuestros equipos, en el caso de que tengas un portátil utiliza DHCP.

* **DNS** 8.8.8.8, **Gateway** 10.0.0.2 y **subred** 10.0.0.0/8, 

* Hacemos el siguiente esquema de particiones, para ello selecciona (x) Custom storage layout

  .. image:: imagenes//MV_Ubuntu_Server_22.04.jpg

* Usuario: tunombre y utiliza de contraseña: alumno
  Para el nombre del servidor utiliza compute-0-0, para ello modifica el archivo **/etc/hostname** 

Configurtación sshd
*******************

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
