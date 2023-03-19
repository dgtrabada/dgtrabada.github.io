**************************
Comandos básicos GNU/Linux
**************************

Control de procesos
*******************

.. code-block:: bash

  ps            # ver procesos ps -ef
  top, htop     # monitorización de procesos
       [Espacio] Realiza un refresco de la pantalla
       [h] Muestra la pantalla de ayuda
       [k] Mata un proceso. Se le pedirá que introduzca el ID del proceso así como la señal que hay que enviarle.
       [n] Cambia el número de procesos que se muestran en pantalla. Se le pedirá que introduzca un número.
       [u] Ordena por usuario.
       [M] Ordena por uso de memoria.
       [P] Ordena por uso del CPU.
  nice          # Ejecuta un comando con una prioridad determinada, o modifica la prioridad a de un proceso
  kill          # mata procesos
  pstree        # Muestra en vista de árbol (de forma jerárquica) una lista de los procesos en ejecución.
  nohup         # permite mantener la ejecución de un comando (el cual le pasamos como un argumento) pese a salir de la terminal
  jobs, fg %2, bg %1, ctrol+c, ctrol+z
       sleep 10 & # Ponemos tarea en segundo plano añadiendo & al final del comando.
       fg %1      # Ponerlo en primer plano
       bg %1
       Ctrl+Z     # para  detener una tarea en primer plano
       Ctrl+C     # para cancelar una tarea en primer plano

dddd