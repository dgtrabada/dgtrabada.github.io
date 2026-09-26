*******************
Gestión de procesos
*******************

Procesos y estados
==================

Veamos el siguiente programa:

.. code-block:: C
 :emphasize-lines: 37

 /* primos.c is a free (GPLv3) program to list prime numbers using c
  * Copyright (C) 2009 by Daniel González Trabada
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */ 

 #include <stdio.h>
 #include <stdbool.h>
 #include <unistd.h>
 
 int main() {
     int c,d,n=10;
     bool es_primo=false;
     c=1;
     while (c < n) {
         c++;
         es_primo=true;
         for (d = 2; d < c; ++d) {
             if (c % d == 0) {
                 es_primo = false;
                 break;
             }
         }
         if (es_primo) {
             printf("%d ", c);
             sleep(1);
         }
     }
     printf("\n");
     return 0;
 }

Lo compilamos y ejecutamos de la siguiente forma:

.. code-block:: bash

 $ gcc primos.c
 $ ./a.out
 2 3 5 7

Si ahora cambiamos la sentencia **sleep(1)** por **sleep(100)** para que tarde un poco más y lo ejecutamos en el background varias veces, observamos:


.. code-block:: bash

 $ gcc primos.c && ./a.out &
 [1] 8310
 $ ./a.out &
 [2] 8318
 $ ./a.out &
 [3] 8319
 $ jobs
 [1]   Ejecutando              gcc primos.c && ./a.out &
 [2]-  Ejecutando              ./a.out &
 [3]+  Ejecutando              ./a.out &

El número entre corchetes es el **número de trabajo** (*job*) de la terminal, y el que va detrás (8310, 8318, 8319) es el **PID** (*process identifier*), el número con el que el sistema operativo identifica a cada proceso. Con ``ps`` podemos ver los procesos con su PID, y con ``top`` o ``htop`` ver en tiempo real cuánta CPU y memoria consume cada uno.

Traemos al primer plano el trabajo 2 y pulsando <ctrl>+z lo paramos:

.. code-block:: bash

 $ fg %2
 ./a.out
 ^Z
 [2]+  Detenido                ./a.out
 $ jobs
 [1]   Ejecutando              gcc primos.c && ./a.out &
 [2]+  Detenido                ./a.out
 [3]-  Ejecutando              ./a.out &
 
Un trabajo detenido se puede reanudar en primer plano con ``fg %2`` o en segundo plano con ``bg %2``.

Traemos al primer plano el trabajo 1 y lo matamos utilizando <ctrl>+c

.. code-block:: bash

 $ fg %1
 gcc primos.c && ./a.out
 ^C
 $ jobs
 [2]+  Detenido                ./a.out
 [3]-  Ejecutando              ./a.out &
 
Para matarlo no es necesario pasarlo al primer plano, podemos hacerlo con ``kill %n`` indicando el número de trabajo, o con ``kill PID`` indicando su PID desde cualquier terminal

.. code-block:: bash

 $ kill %3
 $ jobs
 [2]+  Detenido                ./a.out
 [3]-  Terminado               ./a.out


Como podemos ver, un **proceso** es un programa que está en ejecución. Los procesos pueden estar en alguno de los siguientes estados:

* **Nuevo**: el proceso se está creando.
* **Listo**: preparado para ejecutarse, esperando a que se le asigne la CPU.
* **En ejecución**: sus instrucciones se están ejecutando en la CPU.
* **Bloqueado**: esperando a que ocurra un suceso (por ejemplo, que termine una operación de E/S).
* **Terminado**: ha finalizado su ejecución.

.. image:: imagenes/estado_procesos.png
  :width: 600

Las transiciones entre estados son:

* **Nuevo → Listo**: el sistema operativo admite el proceso y lo pone en la cola de procesos listos.
* **Listo → En ejecución**: el planificador lo elige para que use la CPU.
* **En ejecución → Listo**: se le acaba el tiempo de CPU asignado (el *quantum*) y vuelve a la cola de listos.
* **En ejecución → Bloqueado**: tiene que esperar a que ocurra algo, por ejemplo a leer del disco o a que el usuario pulse una tecla.
* **Bloqueado → Listo**: ocurre lo que esperaba y vuelve a la cola de listos. Nunca pasa directamente a ejecución.
* **En ejecución → Terminado**: el proceso acaba.

Bloque de control de procesos (PCB)
-----------------------------------

El sistema operativo mantiene para cada proceso un bloque de control o **PCB** (*process control block*), donde guarda la información necesaria para gestionarlo y para reactivarlo si es suspendido:

* El identificador del proceso (**PID**) y el usuario al que pertenece.
* Su **estado** (listo, en ejecución, bloqueado...) y su **prioridad**.
* El **contador de programa**, es decir, la dirección de la siguiente instrucción que tiene que ejecutar, y el valor de los **registros** de la CPU.
* La **memoria** que tiene asignada y los **archivos abiertos**.

Cuando el sistema operativo entrega la CPU a otro proceso, tiene que guardar en el PCB el estado del proceso que estaba ejecutando y cargar el del nuevo proceso: esto es un **cambio de contexto**. Algunas CPUs tienen varios juegos de registros, de manera que el cambio se hace simplemente cambiando el puntero al juego de registros actual. El problema es que si hay más procesos que juegos de registros hay que apoyarse en la memoria, es decir, el cambio de contexto es una operación costosa.

Hilos
-----

Una forma de disminuir el coste de los cambios de contexto es utilizando threads o hilos. Los hilos de un mismo proceso comparten el mismo espacio de direccionamiento, así como también los recursos abiertos y la información del proceso (PCB) gracias a esto consiguen que su creación y el cambio de contexto sea mucho más barato. Por ejemplo, un procesador de textos puede tener un hilo que atiende al teclado, otro que revisa la ortografía y otro que guarda automáticamente el documento.

Planificación de procesos
=========================

Cada vez que la CPU queda libre, el sistema operativo tiene que decidir qué proceso de la cola de listos pasa a ejecutarse. De eso se encarga el **planificador**, y el orden que elija cambia mucho el tiempo que esperan los procesos.

Para comparar los algoritmos utilizamos los siguientes tiempos:

* **T**:sub:`I` (tiempo de llegada): instante en que el proceso llega a la cola de listos.
* **T**:sub:`X` (tiempo de ejecución): tiempo de CPU que necesita el proceso.
* **T**:sub:`E` (tiempo de espera): tiempo que el proceso pasa esperando en la cola de listos.
* **T**:sub:`R` (tiempo de retorno): tiempo desde que el proceso llega hasta que termina, es decir, T :sub:`R` = T :sub:`E` + T :sub:`X`

Por ejemplo, con 2 procesos que necesitan (4,6) unidades de CPU, si ejecutamos primero el de 4 y luego el de 6, el tiempo de espera total será (0+4) = 4, es decir, una media de 2; sin embargo, si primero ejecutamos el de 6, el tiempo de espera total será (0+6) = 6, una media de 3.

Los algoritmos pueden ser:

* **No apropiativos**: una vez que un proceso tiene la CPU, la conserva hasta que termina o se bloquea. Por ejemplo, FIFO y SJF.
* **Apropiativos** (o expulsivos): el sistema operativo puede quitarle la CPU a un proceso para dársela a otro. Por ejemplo, RR.

Para elegir un proceso de la cola de procesos listos tenemos diferentes algoritmos:

* **FIFO** (First in, first out, también llamado FCFS, First Come, First Served) es decir el primero que llega es el primero en ser atendido, cada proceso se ejecuta hasta que termina o se queda bloqueado.

* **SJF** (Shortest Job First, también llamado SJN, Shortest Job Next) toma como siguiente el proceso que va a terminar antes. Vamos a ver el siguiente ejemplo de tres procesos a<b<c, para este caso tendríamos un tiempo de espera de: (a+(a+b))=(2a+b), de hacerlo al revés tendríamos (2c+b) es decir la diferencia es de 2(a-c). 
  El problema de este algoritmo es el desconocimiento del tiempo que va a durar un proceso.
  
  Ejemplo : (2,4,8)

  .. image:: imagenes/procesos_1.png 
  
  Si lo hacemos utilizando el proceso que va a terminar antes tendríamos un tiempo de espera T :sub:`E` = 0+2+(2+4) = 8 y un tiempo de retorno T :sub:`R` = 2+6+14 = 22
  
  .. image:: imagenes/procesos_2.png 

  si lo hacemos al revés T :sub:`E` = 0+8+(8+4) = 20 y T :sub:`R` = 8+12+14 = 34

  .. image:: imagenes/procesos_3.png 

* **RR** (Round-Robin) Utiliza el algoritmo FIFO con la variante de que un proceso no puede estar utilizando la CPU por más de un quantum, cuando finaliza este quantum el SO provoca una interrupción haciendo que entre el siguiente proceso, si el quantum es muy grande recuperamos el FIFO y si es demasiado pequeño tendremos un costo muy elevado en los cambios de contexto. **Cuando se acaba el quantum, el proceso que se estaba ejecutando pasa al final de la cola; si en ese mismo instante llega un proceso nuevo, el nuevo se pone delante y el que sale del quantum detrás.**

Vemos el siguiente ejemplo. Debajo de cada tabla aparece la cola de procesos listos en cada instante: **x** indica que el proceso se está ejecutando y **-** que está esperando en la cola:

.. image:: imagenes/Ejemplo.png

Casos especiales en **RR**: cuando un proceso llega justo en el instante en que otro agota su quantum, el que llega se pone delante en la cola (P2 delante de P3 en el primer caso y P1 delante de P4 en el segundo):

.. image:: imagenes/desambi.png

Plantilla para ejercicios
=========================

* `Plantilla.odt <https://github.com/dgtrabada/dgtrabada.github.io/blob/3f72b8e18b914188c5dbbe3591006a6524d76b72/source/so/fundamentos/imagenes/Plantilla.odt>`_

* `Plantilla.pdf <https://github.com/dgtrabada/dgtrabada.github.io/blob/3f72b8e18b914188c5dbbe3591006a6524d76b72/source/so/fundamentos/imagenes/Plantilla.pdf>`_


Bloqueos
========

Un **interbloqueo** (deadlock) se produce cuando un conjunto de procesos queda bloqueado permanentemente porque cada uno espera un recurso que tiene otro proceso del conjunto.

Edsger Wybe Dijkstra propuso el problema de la cena de los filósofos: cinco filósofos se sientan a comer arroz, para ello necesitan dos palillos, en total solo hay 5 palillos, así que mientras unos comen otros piensan y hablan, el interbloqueo aparece cuando todos quieren comer a la vez y toman un palillo a su izquierda, cuando van a por el palillo de la derecha se quedan esperando interbloqueados.

.. image:: imagenes/plato.png

Para que se produzca un interbloqueo tienen que darse a la vez las cuatro **condiciones de Coffman**:

#. **Exclusión mutua**: el recurso solo lo puede usar un proceso a la vez (un palillo solo lo puede tener un filósofo).
#. **Retención y espera**: un proceso retiene un recurso mientras espera otro (el filósofo no suelta el palillo izquierdo mientras espera el derecho).
#. **No expropiación**: no se le puede quitar el recurso a un proceso, tiene que liberarlo él (nadie le quita el palillo a un filósofo).
#. **Espera circular**: cada proceso espera un recurso que tiene el siguiente, formando un círculo (cada filósofo espera el palillo del que tiene a su derecha).

Para evitar el interbloqueo basta con que no se cumpla una de ellas. Por ejemplo, si uno de los filósofos coge primero el palillo de la derecha y después el de la izquierda, ya no se puede formar el círculo de espera.

.. toctree::
   :hidden:

   cuestionario_gestion_procesos1.rst
   cuestionario_gestion_procesos2.rst
   cuestionario_gestion_procesos3.rst
