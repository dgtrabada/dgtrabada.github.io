*****************************
Ejercicios comandos básicos
*****************************

Ejercicio 1: árbol de directorios
=================================

Haz el siguiente esquema de directorios; donde pone **tuNombre** haz que aparezca una carpeta con tu nombre:

.. image:: imagenes/cb_ej01_esquema.png

Si hacemos ``tree H`` obtenemos:

.. image:: imagenes/cb_ej01_tree.png

Cuando termines sube un **pantallazo** del comando ``tree H``.

Ejercicio 2: link simbólico
===========================

Crea un link simbólico dentro de **O** hasta la carpeta con **tuNombre**; tiene que aparecer como se ve en la imagen:

.. image:: imagenes/cb_ej02_link.jpg

Cuando termines sube un **pantallazo** del comando ``tree H``.

Ejercicio 3: mover carpetas con mv
==================================

Utilizando el comando ``mv`` cambia el orden de las carpetas para que aparezca la siguiente estructura cuando ejecutamos el comando ``tree H``:

.. image:: imagenes/cb_ej03_mv.jpg

Cuando termines sube un **pantallazo** del comando ``tree H``.

Ejercicio 4: caminos a ROMA
===========================

Utiliza la línea de comandos y ejecuta los siguientes comandos:

.. code-block:: bash

   mkdir camino
   cd camino
   mkdir camino1 camino2
   cd camino1
   mkdir ROMA
   cd ../camino2/
   mkdir camino3 camino4
   cd camino3
   mkdir camino5 camino6
   cd camino5
   ln -s ../../../camino1/
   cd ../camino6/
   ln -s ../camino5/

No todos los caminos nos llevan a **ROMA**, ¿cuál o cuáles no nos llevan...?

Ejercicio 5: copiar y comparar carpetas
=======================================

* Crea la carpeta **a1**.
* Dentro de **a1** tenemos dos carpetas **b** y **c**.
* Dentro de **b** la carpeta **d**.
* Copia la carpeta **a1** a **a2**.
* Cambia la carpeta **d** de la carpeta **a2**, que está dentro de **b**, a **c**, es decir:

.. code-block:: bash

   $ tree a1/
   a1/
   |-- b -- d
   `-- c
   $ tree a2/
   a2/
   |-- b
   `-- c -- d

Escribe un comando que obtenga la diferencia entre estas dos carpetas y sube un **pantallazo** utilizándolo.

Ejercicio 6: comando find
=========================

Comando ``find``. Crea el siguiente árbol de carpetas:

.. image:: imagenes/cb_ej06_arbol1.png

.. image:: imagenes/cb_ej06_arbol2.png

Cuando termines vuelve al principio y busca la carpeta que has creado con tu nombre utilizando el comando:

.. code-block:: bash

   find -name tuNombre

Sube un **pantallazo** en el que aparezcan el comando ``tree 1`` y el comando que has utilizado para encontrar la carpeta con tu nombre.

Ejercicio 7: comando tar
========================

Crea el archivo **1.tar.gz** a partir de la carpeta **1** y lista los archivos utilizando el comando:

.. code-block:: bash

   tar -tvzf 1.tar.gz

Haz un **pantallazo** de la salida.
