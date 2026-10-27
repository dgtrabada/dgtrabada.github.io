************************
Ejercicios SSH y rsync
************************

Vídeo de ayuda: `ssh y rsync <https://mediateca.educa.madrid.org/video/6h8aqs9h2qu2bw6d>`__.

Ejercicio 1: SSH sin contraseña
===============================

Haz dos clones enlazados de **MV Ubuntu Server 26.04**, generando nuevas direcciones MAC, y dales las siguientes IPs (con DHCP si usas un portátil):

* Clon enlazado 1: **compute-0-0**, 10.4.X.Y/8
* Clon enlazado 2: **compute-0-1**, 10.5.X.Y/8

Configura las dos máquinas:

* Cambia el nombre de compute-0-1 en ``/etc/hostname``.
* Pon la IP de cada máquina en su archivo de ``/etc/netplan/``.
* Añade los nombres y las IPs de las dos máquinas en el ``/etc/hosts`` de ambas.

  .. image:: imagenes/ssh_ej_hosts.png

* Configura el servidor SSH (consulta :ref:`Práctica: acceso sin contraseña con clave pública`) para que el usuario **root** pueda entrar de una máquina a la otra sin contraseña: crea la clave pública (``id_rsa.pub``) y la privada (``id_rsa``) y exporta la pública (se copia en ``authorized_keys``).

  .. image:: imagenes/ssh_ej_keygen.png

  Desde compute-0-1:

  .. image:: imagenes/ssh_ej_copy_id.png

Sube el **pantallazo**\ :sup:`1`, con la salida de los siguientes comandos, cada uno desde su máquina:

.. code-block:: bash

   root@compute-0-0:~# ssh compute-0-1 ip a
   root@compute-0-1:~# ssh compute-0-0 ip a

Ejercicio 2: Sincronizar carpetas con rsync
===========================================

Crea la siguiente estructura de carpetas, cambiando **tunombre** por tu nombre:

.. image:: imagenes/rsync_ej_tree.png

Cada factura solo tiene tu nombre dentro:

.. image:: imagenes/rsync_ej_facturas.png

Sincroniza las dos carpetas con :ref:`rsync`:

.. code-block:: bash

   rsync -av --delete DOC/ DOC_copy

Comprueba que se ha creado la carpeta ``DOC_copy`` y que es igual que ``DOC``:

.. code-block:: bash

   diff -r DOC DOC_copy

Escribe tu apellido en la factura ``DOC/DIC_tunombre/1-15/factura_DIC_tunombre_11.dat`` y sube el **pantallazo**\ :sup:`2`, donde se vean el ``diff``, la sincronización y otra vez el ``diff``, como en este ejemplo:

.. image:: imagenes/rsync_ej_diff.png

Ahora haz que la carpeta ``DOC_copy`` esté en compute-0-1, sincronizando por SSH. Escribe tu apellido en la factura ``DOC/SEP_tunombre/1-15/factura_SEP_tunombre_11.dat``, vuelve a sincronizar y sube el **pantallazo**\ :sup:`3`, donde se vea el comando ``rsync`` haciendo la sincronización por SSH.
