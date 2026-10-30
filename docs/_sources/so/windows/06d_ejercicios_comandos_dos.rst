*****************************
Ejercicios comandos MS-DOS
*****************************

Lee la teoría de :doc:`05_comandos_dos` y realiza los siguientes ejercicios.

Ejercicio 1: árbol de directorios y attrib
==========================================

* Crea el siguiente esquema de directorios:

  .. image:: imagenes/ej_arbol_esquema.png

* Si hacemos ``tree 1``:

  .. image:: imagenes/dos_ej01_tree.png

* Intercambia la carpeta **9** por la **4** como se indica en la figura:

  .. image:: imagenes/ej_arbol_intercambio.png

* Sube un **pantallazo**\ :sup:`1` del comando ``tree``.
* Utilizando el comando ``attrib`` haz que el directorio **4** sea oculto.
* Haz un ``tree 1`` y sube un **pantallazo**\ :sup:`2`. ¿Qué ha sucedido?

Ejercicio 2: información del sistema
====================================

Responde a las siguientes preguntas y sube un pantallazo de cada una:

#. ¿Qué comando utilizarías para ver el nombre de tu usuario? **Pantallazo**\ :sup:`3`.
#. ¿Qué comando utilizarías para ver el nombre del equipo? **Pantallazo**\ :sup:`4`.
#. ¿Qué comando utilizarías para ver dónde está el directorio actual? **Pantallazo**\ :sup:`5`.
#. ¿Qué comando utilizarías para ver dónde está el directorio de tu usuario? **Pantallazo**\ :sup:`6`.
#. ¿Qué comando utilizarías para ver la versión del sistema operativo? **Pantallazo**\ :sup:`7`.

Ejercicio 3: redirecciones y borrado
====================================

* Crea las carpetas:

  * **A_tu_nombre**
  * **B_tu_nombre**
  * **C_tu_nombre**
  * **D_tu_nombre**

* Haz un ``dir`` y redirecciónalo al archivo **DIR.txt**.
* Comprueba que se ha creado utilizando el comando ``type`` y el comando ``more``, y sube un **pantallazo**\ :sup:`8`.
* Crea una carpeta llamada **tu_apellido** dentro de la carpeta **D_tu_nombre**.
* Borra la carpeta **D_tu_nombre** sin que te pregunte si estás seguro. ¿Qué comando y opciones has utilizado para ello? Sube un **pantallazo**\ :sup:`9`.

Ejercicio 4: variables
======================

* Crea una variable **a** que tenga el valor 5.
* Crea una variable **b** que tenga el valor 6.
* Crea una variable **str** que sea el texto ``a+b``, en este caso ``5+6``.
* Crea una variable **sum** que sea la suma de a + b, es decir, 11.
* Compruébalo con los siguientes comandos y sube un **pantallazo**\ :sup:`10`:

  .. code-block:: bat

     echo %a%
     echo %b%
     echo %str%
     echo %sum%
