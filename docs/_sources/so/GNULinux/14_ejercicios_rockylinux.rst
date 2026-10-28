*************************
Ejercicios Rocky Linux
*************************

Ejercicio 1: Instalación de Rocky Linux
=======================================

* Descárgate la ISO de `Rocky Linux <https://rockylinux.org/>`_ **Minimal** para la arquitectura x86_64
* Crea una máquina virtual llamada **"MV Rocky Linux"** con un disco de 200 GB y 2 GB de RAM
* Utiliza un único adaptador de red en modo "**Puente**": 10.4.X.Y/8, DNS 8.8.8.8, puerta de enlace 10.0.0.2 (DHCP si usas portátil)
* En el instalador, dale directamente a **Install Rocky Linux**
* En el destino de la instalación, selecciona el disco duro si no está ya seleccionado y deja la configuración de almacenamiento de forma **automática**
* Configura la red en **Red y nombre de anfitrión**. Si después necesitas cambiarla, utiliza el comando **nmtui**
* Crea la contraseña de root y el usuario **alumno**
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
