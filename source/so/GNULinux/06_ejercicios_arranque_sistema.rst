*********************************
Ejercicios arranque del sistema
*********************************

Vídeo de ayuda: `arranque del sistema <https://mediateca.educa.madrid.org/video/df391snkbvi1zqz1>`__.

Crea el archivo ``/root/encendido.sh``:

.. code-block:: bash

   #!/bin/bash
   date >> /root/encendido.log

Ejercicio 1: crontab diario
===========================

Haz que ``/root/encendido.sh`` se ejecute todos los días (consulta :ref:`Crontab`). Haz un **pantallazo**\ :sup:`1` del crontab en el que aparezca dicha tarea.

Ejercicio 2: crontab semanal
============================

Haz que ``/root/encendido.sh`` se ejecute todos los domingos a las 0:00 h. Haz un **pantallazo**\ :sup:`2` del crontab en el que aparezca dicha tarea.

Ejercicio 3: servicio con systemd
=================================

Crea un servicio llamado ``/etc/systemd/system/encendido.service`` y haz que se ejecute al inicio de la sesión (consulta :ref:`Ejemplo de servicio encendido`).

Sube al curso un **pantallazo**\ :sup:`3` de los siguientes comandos:

.. code-block:: bash

   systemctl status encendido.service
   tail /root/encendido.log
   systemctl restart encendido.service
   tail /root/encendido.log

Ejercicio 4: resetear la contraseña
===================================

Vamos a resetear la contraseña del administrador. Para ello entramos en el modo de recuperación desde GRUB, en **Advanced options for Ubuntu**:

.. image:: imagenes/arranque_ej04_1.png

Elegimos la entrada **(recovery mode)**:

.. image:: imagenes/arranque_ej04_2.png

Y en el menú de recuperación entramos en **root** (consola de superusuario):

.. image:: imagenes/arranque_ej04_3.png

Ejecutamos el comando ``passwd alumno`` (en nuestro caso este es el usuario administrador). Si da error porque el sistema de archivos está en modo solo lectura, ejecuta antes ``mount -o remount,rw /``. Haz un **pantallazo**\ :sup:`4` de este paso y súbelo al curso.

.. code-block:: bash

   passwd alumno
   init 6  # reiniciamos el ordenador

* Comprueba que la contraseña es la nueva.
* Cambia la contraseña por la anterior. Si te da problemas, hazte root (``sudo su``) y luego ejecuta el mismo comando ``passwd alumno``.

.. note::

   Si no puedes acceder al modo de recuperación porque no aparece el menú de GRUB, cambia lo siguiente en el archivo ``/etc/default/grub``:

   .. code-block:: bash

      GRUB_TIMEOUT=10
      GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

   Guarda los cambios, ejecuta ``sudo update-grub`` en la terminal y reinicia con ``init 6``.
