*******************
Sistemas operativos
*******************

«Sin su software, la computadora es básicamente un montón de metal inútil» (Andrew S. Tanenbaum).

El Sistema Operativo es el software principal o conjunto de programas de un sistema informático que gestiona los recursos de hardware y provee servicios a los programas de aplicación de software.

El sistema operativo actúa como intermediario entre las aplicaciones y el hardware: gestiona los recursos, su localización y la protección de acceso, lo que alivia a los programadores de aplicaciones de tener que tratar con estos detalles.

Funciones del sistema operativo
===============================

1. Gestión de procesos
----------------------

La creación y eliminación de procesos tanto del usuario como del Sistema Operativo. La planificación de los procesos. La provisión de mecanismos para sincronización, comunicación y manejo de bloqueos mutuos.

2. Gestión de memoria
---------------------

La memoria principal es un almacén de datos compartido por la CPU y las aplicaciones. La gestión de memoria consiste en asignar memoria a los programas que la solicitan y administrarla, una tarea de suma importancia para el funcionamiento del sistema.

3. Gestión del sistema de archivos
----------------------------------

Los archivos son formatos creados por el usuario en el ordenador, los cuales se convierten en tablas que se deben registrar en el sistema si se quieren conservar y volver a usar en un futuro.

4. Gestión del arranque
-----------------------

Un gestor de arranque es un programa que permite elegir el siguiente código a ejecutar en el proceso de arranque, tradicionalmente a través de un menú.​​ Habitualmente el gestor de arranque forma parte del cargador de arranque como por ejemplo en GRUB, GRUB 2, LILO o SYSLINUX

5. Gestión del sistema de entrada y salida
------------------------------------------

Se encarga de gestionar los puertos de entrada y salida del ordenador, a los que se conectan los periféricos: el monitor, el ratón, la impresora, los auriculares, un pen-drive...

6. Administración de usuarios
-----------------------------

El sistema operativo también se encarga de la gestión de los perfiles que se hayan creado y almacenado en el ordenador, pudiendo ser esta administración tipo monousuario o multiusuario.

No se debe entender con monousuario como que el sistema operativo solo permite que sólo se cree un usuario para utilizar el ordenador. Monousuario implica que sólo las ejecuciones de ese usuario estarán activas y solo las de él. En cambio, multiusuario significa que permite que las tareas de más de un usuario estén activas al mismo tiempo.

Clasificación de Sistemas Operativos
=====================================

Los sistemas operativos se pueden clasificar de acuerdo a diferentes criterios

* **Por el número de usuarios**

  * Monousuarios
  * Multiusuarios

* **Por el número de tareas**

  * Monotarea
  * Multitarea

* **Por el número de procesadores**

  * Monoprocesador
  * Multiprocesador

    * Simétrico
    * Asimétrico

  Los sistemas operativos monousuario o monopuesto son aquellos que únicamente soportan un usuario a la vez, los sistemas operativos multiusuario o multipuesto son capaces de dar servicio a más de un usuario a la vez.

  Los sistemas monotarea son aquellos que solo permiten una tarea a la vez por usuario; los multitarea permiten tener varias tareas activas al mismo tiempo.

  Los sistemas monoprocesador son los que solo cuentan con una CPU; aun así pueden simular la multitarea repartiendo el tiempo de CPU entre los procesos con un intercambio muy rápido. Los sistemas multiprocesador disponen de varias CPUs y pueden ser simétricos, que distribuyen la carga de procesamiento por igual entre todos los procesadores, o asimétricos, en los que los procesadores tienen papeles distintos (por ejemplo, un procesador maestro reparte el trabajo entre los demás).

  .. image:: imagenes/simetria.png
