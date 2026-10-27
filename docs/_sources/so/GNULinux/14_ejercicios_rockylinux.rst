*************************
Ejercicios Rocky Linux
*************************

Ejercicio 1: Instalación de Rocky Linux
=======================================

* Instala la máquina virtual **MV Rocky Linux** siguiendo el :ref:`Caso práctico: Instalación de Rocky Linux`. En el instalador, dale directamente a **Install Rocky Linux**. De momento conecta solo el adaptador puente.
* Crea la contraseña de root y el usuario **alumno**.
* Sube el **pantallazo**\ :sup:`1`, con la salida de:

  .. code-block:: bash

     ip a
     ping -c 3 8.8.8.8

.. tip::

   Haz los siguientes ejercicios en una **clonación enlazada** de **MV Rocky Linux**.

Ejercicio 2: Usuarios y contraseñas
===================================

Crea los siguientes usuarios y grupos:

* **tunombre_1** dentro del grupo **GA**
* **tunombre_2** dentro del grupo **GA**
* **tunombre_3** dentro del grupo **GB**
* **tunombre_4** dentro del grupo **GB**

Para ponerles la contraseña de una vez, crea un archivo llamado ``lista_usuarios.dat``:

.. code-block:: text

   tunombre_1:contraseña_tunombre_1
   tunombre_2:contraseña_tunombre_2
   tunombre_3:contraseña_tunombre_3
   tunombre_4:contraseña_tunombre_4

y ejecuta como root:

.. code-block:: bash

   cat lista_usuarios.dat | chpasswd

Sube el **pantallazo**\ :sup:`2`, con la salida de:

.. code-block:: bash

   tail -2 /etc/group
   grep tunombre /etc/passwd
   grep tunombre /etc/shadow

Ejercicio 3: Red interna
========================

Haz otras dos clonaciones enlazadas de **MV Rocky Linux**, como en el :ref:`Caso práctico: Cluster con red interna`:

* **compute-0-0**: con las dos tarjetas de red, la de adaptador puente y la de red interna (172.16.0.10/16).
* **compute-0-1**: quítale la tarjeta de adaptador puente y deja solo la de red interna, con la IP 172.16.0.11/16 y la puerta de enlace 172.16.0.10. Cambia el nombre en ``/etc/hostname``. Para configurar la red, usa ``nmtui``.

Sube el **pantallazo**\ :sup:`3`, donde se vea que las dos máquinas se hacen ping.

Ejercicio 4: Enrutamiento
=========================

Haz que compute-0-1 tenga internet a través de compute-0-0. Para ello, activa el enrutamiento en compute-0-0:

.. code-block:: bash

   echo "1" > /proc/sys/net/ipv4/ip_forward
   iptables -A FORWARD -j ACCEPT
   iptables -t nat -A POSTROUTING -s 172.16.0.0/16 -o enp0s3 -j MASQUERADE

``enp0s3`` es la tarjeta de compute-0-0 que tiene salida a internet (compruébalo con ``ip a``). Si tienes algún problema, prueba a deshabilitar el cortafuegos con ``systemctl disable --now firewalld``.

Sube el **pantallazo**\ :sup:`4`, donde se vea ``ping -c 3 8.8.8.8`` desde compute-0-1.
