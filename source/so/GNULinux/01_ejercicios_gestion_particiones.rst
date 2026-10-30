***********************************
Ejercicios gestión de particiones
***********************************

Vídeo de ayuda: `particiones <https://mediateca.educa.madrid.org/video/3ehvjqglgqchzd3j>`__.

Utilizando una máquina virtual con un live CD (drbl), crea cuatro particiones primarias con formato ext4 que ocupen cada una el 25% del disco duro. Para montar las particiones primero tenemos que crear los puntos de montaje: crearemos cuatro carpetas dentro de ``/media`` llamadas **carpeta1**, **carpeta2**, **carpeta3** y **carpeta4**.

#. Sube al curso un **pantallazo**\ :sup:`0` de cómo se ven las particiones en gparted.

#. Monta las cuatro primeras particiones del primer disco duro en las carpetas. Busca un comando para comprobar que las cuatro particiones han sido montadas y sube al curso un **pantallazo**\ :sup:`1` del comando:

   .. code-block:: bash

      cd /media ; tree

#. Sin desmontar las particiones:

   * Crea una carpeta llamada **1PAR** dentro de **carpeta1**.
   * Crea una carpeta llamada **2PAR** dentro de **carpeta2**.
   * Crea una carpeta llamada **3PAR** dentro de **carpeta3**.
   * Crea una carpeta llamada **4PAR** dentro de **carpeta4**.
   * Sube al curso un **pantallazo**\ :sup:`2` del comando ``df -h``.
   * Desmonta las cuatro particiones.
   * Crea una carpeta con tu nombre dentro de ``/media/carpeta1``.
   * Monta la primera partición del primer disco duro en ``/media/carpeta1``.
   * Sube al curso un **pantallazo**\ :sup:`3` del comando ``ls /media/carpeta1``.

#. Monta la 2ª partición en ``/media/carpeta1``. Sube al curso un **pantallazo**\ :sup:`4` del comando ``ls /media/carpeta1``.

#. Monta la 3ª partición en ``/media/carpeta1``. Sube al curso un **pantallazo**\ :sup:`5` del comando ``ls /media/carpeta1``.

#. Monta la 4ª partición en ``/media/carpeta1``. Sube al curso un **pantallazo**\ :sup:`6` del comando ``ls /media/carpeta1``.

#. Desmonta todas las particiones. Sube al curso un **pantallazo**\ :sup:`7` del comando ``ls /media/carpeta1``.
