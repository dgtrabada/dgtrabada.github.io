******************************************
Cuestionario gestión de procesos: teoría
******************************************

.. cuestionario::

   1. Preguntas de teoría:
      - 1. ¿Qué es un proceso?
        (x) Un programa en ejecución
        ( ) Un archivo ejecutable guardado en el disco
        ( ) Una parte del núcleo del sistema operativo
      - 2. ¿Puede un proceso pasar directamente de Bloqueado a En ejecución?
        ( ) Sí, en cuanto termina la operación de E/S
        (x) No, primero pasa a Listo y espera a que el planificador lo elija
      - 3. Un proceso en ejecución que tiene que leer un archivo del disco pasa a
        (x) Bloqueado
        ( ) Listo
        ( ) Terminado
      - 4. En RR, cuando a un proceso se le acaba el quantum pasa a
        ( ) Bloqueado
        (x) Listo, al final de la cola
        ( ) Terminado
      - 5. En RR, si en el mismo instante en que P1 agota su quantum llega P2, ¿cómo queda la cola?
        (x) P2 delante de P1
        ( ) P1 delante de P2
      - 6. ¿Qué es el PID?
        (x) El número con el que el sistema operativo identifica a cada proceso
        ( ) El número de trabajo que muestra jobs en la terminal
        ( ) El tiempo de CPU que necesita el proceso
      - 7. ¿Cuál de estos datos NO se guarda en el PCB de un proceso?
        ( ) Su estado
        ( ) El contador de programa y los registros
        ( ) Los archivos abiertos
        (x) El código fuente del programa
      - 8. Un cambio de contexto consiste en
        (x) guardar el estado del proceso que estaba en la CPU y cargar el de otro proceso
        ( ) cambiar de usuario en el sistema
        ( ) pasar un proceso de primer a segundo plano
      - 9. Los hilos de un mismo proceso
        (x) comparten la memoria y los archivos abiertos del proceso
        ( ) tienen cada uno su propia memoria
        ( ) no pueden ejecutarse a la vez
      - 10. ¿Cuál de estos algoritmos es apropiativo (puede quitarle la CPU a un proceso)?
        ( ) FIFO
        ( ) SJF
        (x) RR
      - 11. Si en RR el quantum es muy grande, el algoritmo se comporta como
        (x) FIFO
        ( ) SJF
      - 12. ¿Qué ocurre si en RR el quantum es demasiado pequeño?
        (x) Hay muchos cambios de contexto y se pierde mucho tiempo en ellos
        ( ) Los procesos no llegan a terminar nunca
        ( ) El algoritmo se convierte en SJF
      - 13. ¿Cuál es el principal problema del algoritmo SJF?
        (x) Hay que saber de antemano cuánto va a durar cada proceso
        ( ) Hace muchos cambios de contexto
        ( ) Los procesos cortos esperan más que los largos
