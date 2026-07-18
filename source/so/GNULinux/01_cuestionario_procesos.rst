********************************
Cuestionario gestión de procesos
********************************

.. cuestionario::

   1. Conceptos de procesos:
      - 1. ¿Puede haber varios procesos con el mismo número de identificador de proceso (PID)?
        ( ) Sí
        (x) No
      - 2. ¿Cuál es el ID de proceso (PID) del proceso principal en Linux? (fíjate en el primer proceso que aparece en ps -aux)
        (x) 1
        ( ) 100
        ( ) Depende del sistema
      - 3. ¿Qué letra en la columna de estado del comando ps indica que un proceso está durmiendo (interruptible sleep)?
        ( ) R
        (x) S
        ( ) T
        ( ) Z
      - 4. ¿Qué comando se utiliza para ver la lista de procesos en ejecución, junto con su estado y otros detalles, actualizándose en tiempo real?
        ( ) procs
        ( ) listprocs
        (x) top
        ( ) ps

   2. El comando top:
      - 1. Ejecutamos el comando top, para ver los procesos del usuario alumno...
        (x) Presionamos u y luego escribimos alumno
        ( ) Escribimos alumno
        ( ) Nos salimos y ejecutamos top alumno
      - 2. Sin salirte de top, ordena los procesos por el uso que hacen de la memoria:
        (x) Presionamos M
        ( ) Escribimos m
        ( ) Nos salimos y ejecutamos top -m
      - 3. Sin salirte de top, visualiza solo 5 procesos:
        (x) Presionamos n y luego 5
        ( ) No se puede
        ( ) Nos salimos y ejecutamos top -5

   3. Trabajos en segundo plano y señales:
      - 1. ¿Cómo evitamos que un comando se cancele automáticamente cuando se cierra la sesión o se sale de la shell?
        (x) nohup
        ( ) background
        ( ) send2
      - 2. ¿Cómo se puede poner un proceso en primer plano después de haberlo suspendido en segundo plano?
        ( ) kill
        (x) fg
        ( ) bg
        ( ) resume
      - 3. Inicia sleep 1000 y envíalo a segundo plano; realiza esta operación 5 veces. ¿Cuántos trabajos tienes ahora?
        [5|cinco]
      - 4. ¿Cómo pasas el 2º sleep al primer plano? (escribe el comando)
        = fg %2 | fg 2
      - 5. ¿Cómo lo paras sin eliminarlo?
        (x) Ctrl+Z
        ( ) Ctrl+C
        ( ) bg %2
      - 6. ¿Cómo lo continúas ejecutando en segundo plano?
        ( ) run %2
        ( ) fg %2
        (x) bg %2
      - 7. ¿Cómo eliminas el proceso 2 que corre ahora en segundo plano?
        ( ) Ctrl+C
        ( ) kill fg 2
        (x) kill %2
      - 8. ¿Cuál es el propósito del comando kill -9 PID?
        ( ) Pausar un proceso
        (x) Terminar abruptamente un proceso
        ( ) Reanudar un proceso
        ( ) Enviar una señal de advertencia a un proceso

   4. Prioridades, límites y /proc:
      - 1. ¿Cuál es el comando utilizado para cambiar la prioridad de ejecución de un proceso que ya está en ejecución?
        ( ) niceness
        (x) renice
        ( ) priority
        ( ) setpriority
      - 2. ¿Dónde está definido el número máximo de procesos que un usuario puede ejecutar simultáneamente?
        ( ) /etc/limit
        (x) /etc/security/limits.conf
        ( ) No hay un límite predefinido
      - 3. ¿Qué atajo del sistema de archivos /proc permite a un proceso acceder a información sobre sí mismo?
        ( ) /proc/stat
        ( ) /proc/system
        ( ) /proc/processes
        (x) /proc/self
      - 4. ¿Cuál es el propósito del archivo /proc/[PID]/status?
        ( ) Almacenar información sobre el estado del sistema
        ( ) Registrar eventos del kernel
        (x) Mostrar información sobre el estado y la actividad de un proceso
        ( ) Almacenar contraseñas de usuario
      - 5. ¿Cuál es el propósito del comando xkill?
        ( ) Mostrar la lista de procesos en ejecución
        ( ) Finalizar abruptamente un proceso en segundo plano
        (x) Terminar un proceso gráfico al hacer clic en su ventana
        ( ) Cambiar la prioridad de un proceso en ejecución
