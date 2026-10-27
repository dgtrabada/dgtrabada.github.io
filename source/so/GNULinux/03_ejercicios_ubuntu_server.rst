**************************
Ejercicios Ubuntu Server
**************************

En estos ejercicios vamos a practicar desde la línea de comandos lo visto en :ref:`Permisos en GNU/Linux` y :ref:`Usuarios y grupos GNU/Linux`, sobre una máquina virtual con Ubuntu Server.

Ejercicio 1: Instalación de Ubuntu Server
=========================================

* Instala la máquina virtual **MV Ubuntu Server 26.04** siguiendo el :ref:`Caso práctico: MV Ubuntu Server 26.04`.
* Sube el **pantallazo**\ :sup:`1`, con la salida de:

  .. code-block:: bash

     sudo fdisk -l

* Si no lo has hecho durante la instalación, instala el servidor SSH, conéctate desde el ordenador anfitrión y sube el **pantallazo**\ :sup:`2`, donde se vea la conexión.

Vídeos de ayuda: `configuración ssh server + MobaXterm <https://mediateca.educa.madrid.org/video/i2z3z9s487z4jg55>`__ y `ssh-copy-id <https://mediateca.educa.madrid.org/video/d7modxsrdcxzzdnm>`__.

.. important::

   Cuando termines, apaga la máquina y exporta **MV Ubuntu Server 26.04** a un archivo **OVA** (Archivo / Exportar servicio virtualizado). Guárdalo en un **USB externo**, no en el ordenador de clase, para no llenar su disco duro. Así tendrás la máquina recién instalada por si la necesitas más adelante (`vídeo <https://mediateca.educa.madrid.org/video/abo2552y3rtg5vyn>`__).

.. tip::

   Haz los siguientes ejercicios en una **clonación enlazada** de **MV Ubuntu Server 26.04**. Si algo sale mal, borras el clon y haces otro, sin tener que volver a instalar.

Ejercicio 2: Usuarios, grupos y permisos
========================================

Vídeo de ayuda: `Gestión de usuarios <https://mediateca.educa.madrid.org/video/7koaa9my5wzg1zwq>`__.

* Crea los siguientes usuarios y grupos **sin entorno gráfico**:

  * **tunombre1**, con contraseña tunombre1, dentro del grupo **GA**
  * **tunombre2**, con contraseña tunombre2, dentro del grupo **GA**
  * **tunombre3**, con contraseña tunombre3, dentro del grupo **GB**
  * **tunombre4**, con contraseña tunombre4, dentro del grupo **GB**

  **2.1** ¿Qué comandos has utilizado para crear el grupo GA y el usuario tunombre1?

* Sube el **pantallazo**\ :sup:`3`, con la salida de:

  .. code-block:: bash

     tail -4 /etc/passwd
     tail -2 /etc/group

* Crea en ``/home`` una carpeta llamada **carpetaGA**, del usuario root y del grupo GA, con permisos de lectura, escritura y ejecución para los miembros del grupo y ninguno para los demás.

  **2.2** ¿Puedes entrar en ella como tunombre1?

* Intenta crear dentro de ``/home/carpetaGA`` una carpeta **u1** con tunombre1, **u2** con tunombre2, **u3** con tunombre3 y **u4** con tunombre4. Sube el **pantallazo**\ :sup:`4`, con la salida de:

  .. code-block:: bash

     ls -la /home/carpetaGA

* Quita a tunombre3 del grupo GB y mételo en el grupo GA.

  **2.3** ¿Qué comando has utilizado? Sube el **pantallazo**\ :sup:`5`, con la salida de ``tail -4 /etc/passwd``.

* **2.4** Cuando se crea un usuario, ¿dónde está la carpeta que se usa como molde para su directorio personal? ¿Cómo harías para que todos los usuarios nuevos tengan unas preferencias determinadas?

* **2.5** ¿Qué archivo se lee cuando el usuario inicia sesión? ¿Qué escribirías en él para que aparezca el siguiente mensaje?

  .. code-block:: text

     root@compute-0-0:~# su tunombre3
     Hola tunombre3
     Te encuentras en compute-0-0
     mar 27 oct 2026 19:30:12 CET

Ejercicio 3: sudo y permisos especiales
=======================================

**sudo**

Como has visto en :ref:`visudo`, el archivo ``/etc/sudoers`` indica qué usuarios pueden usar ``sudo``. Con ``visudo``, añade a tunombre1:

.. code-block:: text

   tunombre1 ALL=(ALL:ALL) ALL

Sube el **pantallazo**\ :sup:`6`, con la salida de:

.. code-block:: bash

   su tunombre1
   sudo ls /root
   su tunombre2
   sudo ls /root

Ten en cuenta que tunombre2 no tiene que estar en ``/etc/sudoers``.

**Bit setuid**

Consulta :ref:`Permisos especiales (setuid, setgid, sticky bit)`. Usa el bit setuid para que tunombre4 pueda ejecutar ``fdisk -l`` (`vídeo <https://mediateca.educa.madrid.org/video/blyluzp5zn31pil9>`__).

Sube el **pantallazo**\ :sup:`7`, con la salida de los siguientes comandos ejecutados como tunombre4:

.. code-block:: bash

   whoami
   ls -l /sbin/fdisk
   fdisk -l

**Sticky bit**

Crea un directorio compartido que pertenezca al usuario tunombre2 y al grupo GA. Añádele el sticky bit para que nadie, salvo el dueño de cada archivo, pueda borrarlo (`vídeo <https://mediateca.educa.madrid.org/video/ng5qlooz4vo5vbke>`__). Crea archivos con varios usuarios del grupo GA y responde:

* **3.1** ¿Puedes copiar los archivos de otros usuarios?
* **3.2** ¿Puedes ver los archivos de otros usuarios?
* **3.3** ¿Puedes borrarlos?

Ejercicio 4: Cuotas
===================

Para este ejercicio utiliza un **nuevo clon enlazado** de la máquina que ya tiene los usuarios. Consulta :ref:`Añadir Quotas a los usuarios` (`vídeo <https://mediateca.educa.madrid.org/video/145lrmv6eqsma3pi>`__).

* Haz que el usuario tunombre1 tenga una cuota dura de 10 MB. Sube el **pantallazo**\ :sup:`8`, con el comando que has utilizado.
* Haz que el grupo GB tenga una cuota blanda de 5 MB y una cuota dura de 10 MB. Sube el **pantallazo**\ :sup:`9`, con el comando que has utilizado.
* Inicia sesión con tunombre1 (grupo GA) y ejecuta:

  .. code-block:: bash

     dd if=/dev/zero of=test.img bs=20M count=1

* Inicia sesión con un usuario del grupo GB y ejecuta:

  .. code-block:: bash

     dd if=/dev/zero of=test.img bs=6M count=1

* Sube el **pantallazo**\ :sup:`10`, con la salida de:

  .. code-block:: bash

     sudo du -skh /home/*
     sudo repquota -vg /home

Cuando termines los ejercicios y los haya corregido el profesor, borra las máquinas enlazadas, pero deja la original **MV Ubuntu Server 26.04**.
