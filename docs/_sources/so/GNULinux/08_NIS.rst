***
NIS
***

Originalmente **NIS** se llamaba *Páginas Amarillas (Yellow Pages)*, o *YP*, que todavía se utiliza para referirse a él. Desafortunadamente, ese nombre es una marca registrada de British Telecom, que exigió a Sun abandonar ese nombre. Sin embargo YP permanece como prefijo en los nombres de la mayoría de las órdenes relacionadas con NIS, como ypserv e ypbind.

DNS sirve un rango limitado de información, siendo la más importante la correspondencia entre el nombre de nodo y la dirección IP. Para otros tipos de información, no existe un servicio especializado así. Por otra parte, si sólo se administra una pequeña LAN sin conectividad a Internet, no parece que merezca la pena configurar DNS. Ésta es la razón por la que Sun desarrolló el Sistema de Información de Red (NIS). NIS proporciona prestaciones de acceso a bases de datos genéricas que pueden utilizarse para distribuir, por ejemplo, la información contenida en los ficheros passwd y groups a todos los nodos de su red. Esto hace que la red parezca un sistema individual, con las mismas cuentas en todos los nodos. De manera similar, se puede usar NIS para distribuir la información de nombres de nodo contenida en /etc/hosts a todas las máquinas de la red.

Hoy en día NIS se considera un servicio antiguo y en producción suele sustituirse por **LDAP** (que veremos más adelante), pero sigue siendo la forma más sencilla de entender qué es un servicio de directorio: un único servidor con las cuentas y muchos clientes que las consultan.

Caso práctico: NIS con red NAT y red Interna
********************************************

Puedes apoyarte en los vídeos [#v1]_.

* Haz dos clones enlazados de **MV Ubuntu Server 26.04** haz que tengan las siguientes IPs:

  * compute-0-0: (Servidor NIS)

    * Tarjeta red modo "Red Nat [#redNat1]_ 10.0.2.10/24 utiliza el puerto 2222 del anfitrión"
    * Tarjeta de red modo "Red interna" : 172.16.0.10/16

  * compute-0-1 (Cliente NIS)

    * Tarjeta de red modo "Red interna" : 172.16.0.11/16 (tiene internet a través de compute-0-0)

Cambia el nombre de las máquinas en el archivo ``/etc/hostname``, cambia la IP en ``/etc/netplan/00-installer-config.yaml`` y revisa ``/etc/hosts``

Para habilitar la conectividad, es necesario que el servidor actúe como router, reenviando el tráfico entre redes. Esto puede configurarse utilizando herramientas como systemd [#systemd]_ o nftables [#nftables]_, que permite definir reglas de encaminamiento y NAT.

Configuración del servidor
==========================

Crea los siguientes usuarios y grupos en el servidor **compute-0-0**
  
* **tunombre1** con contraseña **alumno** dentro del grupo **tuapellido**
* **tunombre2** con contraseña **alumno** dentro del grupo **tuapellido**
* **tunombre3** con contraseña **alumno** dentro del grupo **tuapellido**
* **tunombre4** con contraseña **alumno** dentro del grupo **tuapellido**
  
Instala el servidor NIS en el servidor (compute-0-0)

.. code-block:: bash

  apt-get -y install rpcbind   # en versiones antiguas el paquete se llamaba portmap

  # Instalamos nis; durante la instalación pedirá el dominio NIS,
  # pon servidor.X.nis donde X son las 3 primeras iniciales de tu nombre
  apt-get -y install nis

En ``/etc/hosts`` añadimos:

.. code-block:: bash

  <IP> servidor.X.nis

Ejecuta el comando domainname para mostrar o configurar el nombre de dominio de la máquina.

.. code-block:: bash

  domainname servidor.X.nis
  
Copia el nombre del dominio NIS en el archivo ``/etc/defaultdomain`` (de aquí lo leerá el servicio ypserv.service que inicia la nis)

.. code-block:: bash

  # Arrancamos el servidor y creamos los mapas de la NIS
  systemctl start ypserv
  /usr/lib/yp/ypinit -m

  # Comprobamos
  rpcinfo -p

.. note::

   Si más adelante creas o modificas usuarios en el servidor, recuerda **regenerar los mapas** para que los clientes vean los cambios: ``make -C /var/yp``

En el caso de que no funcione, puedes buscar posibles errores en firewall (iptables -F)

Iniciar el servidor nis :

.. code-block:: bash

  systemctl enable ypserv.service 
  systemctl status ypserv.service
  
Configura el archivo ``/etc/hosts`` del servidor añadiendo a todos los clientes.


Configuración del cliente
==========================
  
Instala el cliente NIS en el cliente **compute-0-1**

.. code-block:: bash

  apt-get -y install nis 
  
Podemos comprobar el dominio NIS con el comando nisdomainname (sin argumentos lo muestra; con argumento lo establece):

.. code-block:: bash

  nisdomainname servidor.X.nis

Copia el nombre del dominio NIS en el archivo ``/etc/defaultdomain`` (de aquí lo leerá el servicio ypbind.service que inicia la nis)

En ``/etc/nsswitch.conf`` añadimos al final de cada línea la palabra "nis".

.. code-block:: bash

  passwd: files systemd nis
  group: files systemd nis
  shadow: files nis

En /etc/yp.conf  añadimos ``ypserver <ip_del_servidor_nis>``, y añade el servidor al /etc/hosts

Por último lanzamos el servicio ypbind

.. code-block:: bash

  systemctl start ypbind

Para comprobarlo puedes utilizar los siguientes comandos (deben aparecer los usuarios del servidor):

.. code-block:: bash

  ypcat passwd            # muestra el mapa de usuarios que sirve la NIS
  getent passwd           # usuarios locales + los de la NIS
  su - tunombre1          # probamos a entrar con un usuario de la NIS

Para hacer que se cree el directorio de los usuarios de forma automática, ejecuta el siguiente comando y marca la opción de crear el directorio home en el primer inicio de sesión (mkhomedir):

.. code-block:: bash

  sudo pam-auth-update

PAM (Pluggable Authentication Modules) establece una interfaz entre los programas de usuario y distintos métodos de autenticación.   De esta forma, el método de autenticación se hace transparente para los programas.

Haz que el cliente NIS se inicie como servicios en el arranque del sistema, para ello

.. code-block:: bash

  systemctl enable ypbind.service
  systemctl status ypbind.service


Si diera algún error al conectar, podría ser por el firewall, para borrar las reglas: iptables -F 

Con entorno gráfico (por ejemplo xfce), si queremos que en la pantalla de inicio se pueda escribir el nombre de un usuario de la NIS, en ``/usr/share/lightdm/lightdm.conf.d/50-greeter-wrapper.conf`` añadimos ``greeter-show-manual-login=true`` y reiniciamos el entorno gráfico con ``sudo service lightdm restart``

   
.. rubric:: Notas

.. [#systemd] systemd

  .. code-block:: bash
   
   $ cat /root/enrutar.sh
   #!/bin/bash
   echo 1 > /proc/sys/net/ipv4/ip_forward
   iptables -F
   iptables -A FORWARD -j ACCEPT
   iptables -t nat -A POSTROUTING -s 172.16.0.0/16 -o enp0s3 -j MASQUERADE
   
* Le damos permisos de ejecución:

  .. code-block:: bash
   
   chmod +x /root/enrutar.sh

     
* Crea un script llamado enrutar.sh y crea un servicio donde se cargue este script para ello edita el archivo ``/etc/systemd/system/enrutar.service``:

  .. code-block:: bash
    
    [Unit]
    Description=Inicia enrutamiento
    After=syslog.target
    
    [Service]
    ExecStart=/root/enrutar.sh
    User=root

    [Install]
    WantedBy=multi-user.target

* Habilitamos el servicio y lo inicamos:

  .. code-block:: bash
  
    systemctl enable enrutar.service
    systemctl start enrutar.service

* Recuerda crear los usuarios en el servidor nis.

* Si no lo habías realizado, ejecutamos en el cliente ``sudo pam-auth-update`` y marcamos que se cree el directorio automáticamente; de esta forma, cuando un usuario acceda al cliente (compute-0-1) por primera vez se creará su home.

.. [#nftables] nftables

Podemos enrutar con **nftables**, es el sistema de filtrado de paquetes y firewall del kernel de Linux que permite controlar el tráfico de red (permitir, bloquear, redirigir o modificar paquetes).

.. code-block:: bash
  
  apt install nftables

Añadimos en ``/etc/nftables.conf``

.. code-block:: bash
  
  table ip nat {
      chain postrouting {
          type nat hook postrouting priority 100;
          oifname "enp0s3" ip saddr 172.16.0.0/16 masquerade
      }
  }

  table ip filter {
      chain forward {
          type filter hook forward priority 0;
          policy drop;
          ip saddr 172.16.0.0/16 oifname "enp0s3" accept
          ip daddr 172.16.0.0/16 ct state established,related accept
      }
  }

Para que el servidor enrute tráfico ``sudo sysctl -w net.ipv4.ip_forward=1``

Activamos ip_forward de forma permanente:

.. code-block:: bash
  
  echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-router.conf

Habilitamos el servicio y lo iniciamos

.. code-block:: bash
  
  systemctl enable nftables
  systemctl start nftables

  
.. [#redNat1] Configuración red NAT

 .. image:: imagenes/redNAT.png

.. [#v1] vídeos

 * `NIS red NAT Ubuntu Server 26.04 LTS red NAT <https://mediateca.educa.madrid.org/video/jhn2ix9u1fkthko9>`_
 * `NIS red NAT Ubuntu Server 24.04 LTS red NAT  <https://mediateca.educa.madrid.org/video/sp2bbcrk74wzr8iq>`_
 * `NIS Ubuntu Server 24.04 LTS con red interna  <https://mediateca.educa.madrid.org/video/gy1jjn5mlbfmtl4h>`_
 * `NIS Ubuntu Server 24.04 LTS adaptador puente <https://mediateca.educa.madrid.org/video/lkd39dlasakeg8ze>`_