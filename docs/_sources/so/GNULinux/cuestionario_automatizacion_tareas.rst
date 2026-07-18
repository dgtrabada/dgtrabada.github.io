*************************************
Cuestionario automatización de tareas
*************************************

.. cuestionario::

   1. El comando at:
      - 1. ¿Qué comando utilizamos para programar un trabajo que se ejecute una sola vez a una hora concreta?
        (x) at
        ( ) cron
        ( ) sleep
      - 2. ¿Cómo vemos la lista de trabajos pendientes?
        = at -l | atq
      - 3. ¿Cómo borramos el trabajo número 16?
        = at -d 16 | atrm 16
      - 4. Una vez escritos los comandos en el prompt de at, ¿cómo guardamos el trabajo y salimos?
        (x) Ctrl+D
        ( ) Ctrl+C
        ( ) Escribiendo exit
      - 5. ¿Se cancela el trabajo si cerramos la sesión antes de la hora programada?
        ( ) Sí
        (x) No
      - 6. ¿En qué ficheros se controla qué usuarios pueden usar at?
        (x) /etc/at.allow y /etc/at.deny
        ( ) /etc/at.conf
        ( ) /etc/security/at.conf

   2. El comando crontab:
      - 1. ¿Cómo editamos nuestro fichero crontab?
        = crontab -e
      - 2. ¿Cómo mostramos nuestro fichero crontab?
        = crontab -l
      - 3. ¿Cómo borramos nuestro fichero crontab?
        = crontab -r
      - 4. ¿Cuál es el orden correcto de los campos de una línea del crontab?
        (x) minuto hora díaDelMes mes díaDeLaSemana comando
        ( ) hora minuto díaDelMes mes díaDeLaSemana comando
        ( ) comando minuto hora díaDelMes mes díaDeLaSemana
      - 5. ¿Cada cuánto tiempo revisa cron si tiene tareas que ejecutar?
        (x) Cada minuto
        ( ) Cada segundo
        ( ) Cada hora

   3. Interpreta las siguientes líneas del crontab:
      - 1. ¿Cuándo se ejecuta **00 5 * * 0 comando**?
        (x) A las 5:00 todos los domingos
        ( ) A las 5:00 todos los días
        ( ) Cada minuto de 5:00 a 5:59 los domingos
      - 2. ¿Cuándo se ejecuta * 5 * * Sun comando?
        ( ) A las 5:00 todos los domingos
        (x) Cada minuto de 5:00 a 5:59 todos los domingos
        ( ) Cada 5 minutos los domingos
      - 3. ¿Cuándo se ejecuta **45 19 1 * * comando**?
        (x) A las 19:45 del día 1 de cada mes
        ( ) A las 19:45 todos los días de enero
        ( ) El 19 de cada mes a la 1:45
      - 4. ¿Cuándo se ejecuta **00 12 16 * Wed comando**?
        ( ) Al mediodía de los días 16 solo si caen en miércoles
        (x) Al mediodía de los días 16 y además todos los miércoles
        ( ) Solo al mediodía de los miércoles
      - 5. ¿Cuándo se ejecuta * * * * * comando?
        (x) Cada minuto
        ( ) Cada hora
        ( ) Nunca
      - 6. Escribe la línea del crontab para ejecutar /root/b.sh todos los días a las 8:15
        = 15 8 * * * /root/b.sh

   4. Systemd y las unidades:
      - 1. ¿Qué proceso tiene el PID 1 en un sistema con systemd?
        [systemd]
      - 2. ¿Qué extensión tienen los archivos de unidad de los servicios?
        [.service|service]
      - 3. ¿En qué directorio crea el administrador sus propias unidades?
        (x) /etc/systemd/system/
        ( ) /usr/lib/systemd/system/
        ( ) /run/systemd/system/
      - 4. ¿En qué sección del archivo de unidad se pone ExecStart?
        ( ) [Unit]
        (x) [Service]
        ( ) [Install]
      - 5. ¿En qué sección se pone WantedBy=multi-user.target?
        ( ) [Unit]
        ( ) [Service]
        (x) [Install]
      - 6. ¿Qué opción de [Unit] define solo el orden de arranque, sin activar la otra unidad?
        (x) After
        ( ) Requires
        ( ) Wants
      - 7. ¿Qué Type usamos para un script que hace un trabajo sencillo y termina?
        ( ) simple
        ( ) forking
        (x) oneshot
      - 8. ¿Qué comando hay que ejecutar después de crear un archivo de unidad nuevo para que systemd lo lea?
        = systemctl daemon-reload | sudo systemctl daemon-reload

   5. Targets:
      - 1. ¿A qué target corresponde el runlevel 3 (multiusuario sin gráfico)?
        [multi-user.target|multi-user]
      - 2. ¿A qué target corresponde el runlevel 5 (multiusuario con entorno gráfico)?
        [graphical.target|graphical]
      - 3. ¿Cómo vemos el target con el que arranca el sistema?
        = systemctl get-default
      - 4. ¿Qué comando cambia de target en caliente, sin reiniciar?
        (x) systemctl isolate
        ( ) systemctl set-default
        ( ) systemctl switch

   6. Systemctl y journalctl:
      - 1. ¿Cómo habilitamos el servicio ssh para que arranque automáticamente con el sistema?
        = systemctl enable ssh | sudo systemctl enable ssh
      - 2. ¿Qué orden recarga la configuración de un servicio sin reiniciarlo?
        ( ) restart
        (x) reload
        ( ) refresh
      - 3. ¿Qué opción marca un servicio como completamente inarrancable?
        ( ) disable
        (x) mask
        ( ) stop
      - 4. ¿Cómo vemos los registros del sistema en tiempo real (como tail -f)?
        = journalctl -f
      - 5. ¿Cómo vemos solo los registros del servicio ssh?
        = journalctl -u ssh | journalctl -u ssh.service
      - 6. ¿Cómo vemos los registros del arranque actual?
        = journalctl -b
