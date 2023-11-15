************************************
Automatización de tareas y servicios
************************************

Comando at
**********

Permite indicar el momento en que se quiere ejecutar un trabajo ``at [opciones ] TIME`` , para ver los trabajos utilizamos ``at -l`` y para borrarlos ``at -d`` como se puede ver en el siguiente ejemplo:

.. code-block:: bash

  $ at 5:00 PM
  at> ls
  at> <EOT>
  job 16 at Tue Nov 14 17:00:00 2023
  $ at 7:00 PM
  at> ls
  at> <EOT>
  job 17 at Tue Nov 14 19:00:00 2023
  $ at -l
  16      Tue Nov 14 17:00:00 2023 a dani
  17      Tue Nov 14 19:00:00 2023 a dani
  $ at -d 16
  $ at -l
  17      Tue Nov 14 19:00:00 2023 a dani


Al ejecutar at pasamos a un nuevo prompt, que nos permite introducir comandos que se ejecutarán a la hora indicada. Para guardar trabajo y salir: **CTRL+D** (guarda el entorno), el trabajo no para aunque se cierre la sesión.

Mas opciones:

.. code-block:: bash

 -f FILE  # indica un fichero donde se encuentran las acciones a realizar.

 HH:MM -> 12:54
 HH:MMAM/PM, -> 1:35PM
 HH:MM MMDDYY -> 1:35PM 122505
 now + num -> at now+2hours
 num puede ser minutos, horas, días, semanas, ...
 today, tomorrow -> 22:44tomorrow

Control de acceso: /etc/at.allow, /etc/at.deny

Crontab
*******

Cron se emplea para ejecución de trabajos periódicos, mientras que el comando crontab permite configurar los procesos a ejecutar que posteriormente el demonio cron se encarga de ejecutar, el contrab del sistema se encuentra en **/etc/crontab**

.. code-block:: bash

 crontab -e    #edita el fichero crontab
 crontab -l    #muestra el fichero crontab
 crontab -r    #borra el fichero crontab 

Control de acceso: /etc/cron.allow, /etc/cron.deny

Hay al menos dos maneras distintas de usar cron:

La primera es en el directorio etc, encontrarás los siguientes directorios:

* cron.hourly
* cron.daily
* cron.weekly
* cron.monthly

Si se coloca un archivo tipo script en cualquiera de estos directorios, entonces el script se ejecutará cada hora, cada día, cada semana o cada mes, dependiendo del directorio.

Como segundo modo de ejecutar o usar cron es a través de manipular directamente el archivo /etc/crontab. En la instalación por defecto de varias distribuciones Linux, este archivo se verá a algo como lo siguiente:

.. code-block:: bash

 $ cat /etc/crontab
 SHELL=/bin/bash
 PATH=/sbin:/bin:/usr/sbin:/usr/bin
 MAILTO=root
 HOME=/

 # run-parts  
 01 * * * * root run-parts /etc/cron.hourly
 02 4 * * * root run-parts /etc/cron.daily
 22 4 * * 0 root run-parts /etc/cron.weekly
 42 4 1 * * root run-parts /etc/cron.monthly


las líneas que ejecutan las tareas programadas propiamente. No hay límites de cuantas tareas pueda haber, una por renglón. Los campos (son 7) que forman estas líneas están formados de la siguiente manera:

1. Minuto: Controla el minuto de la hora en que el comando será ejecutado, este valor debe de estar entre 0 y 59.
2. Hora: Controla la hora en que el comando será ejecutado, se especifica en un formato de 24 horas, los valores deben estar entre 0 y 23, 0 es medianoche.
3. Día del Mes: Día del mes en que se quiere ejecutar el comando. Por ejemplo se indicaría 20, para ejecutar el comando el día 20 del mes.
4. Mes: Mes en que el comando se ejecutará, puede ser indicado numéricamente (1-12), o por el nombre del mes en inglés, solo las tres primeras letras.
5. Día de la semana: Día en la semana en que se ejecutará el comando, puede ser numérico (0-7) o por el nombre del día en inglés, solo las tres primeras letras. (0 y 7 = domingo)
6. Usuario: Usuario que ejecuta el comando.
7. Comando: Comando, script o programa que se desea ejecutar. Este campo puede contener múltiples palabras y espacios.

Ejemplos:

.. code-block:: bash

 01 * * * *       Se ejecuta al minuto 1 de cada hora de todos los días
 15 8 * * *       A las 8:15 a.m. de cada día
 15 20 * * *      A las 8:15 p.m. de cada día
 00 5 * * 0       A las 5 a.m. todos los domingos
 * 5 * * Sun      Cada minuto de 5:00a.m. a 5:59a.m. todos los domingos
 45 19 1 * *      A las 7:45 p.m. del primero de cada mes
 01 * 20 7 *      Al minuto 1 de cada hora del 20 de julio
 10 1 * 12 1      A la 1:10 a.m. todos los lunes de diciembre
 00 12 16 * Wen   Al mediodía de los días 16 de cada mes y que sea Miércoles
 30 9 20 7 4      A las 9:30 a.m. del dia 20 de julio y que sea jueves
 30 9 20 7 *      A las 9:30 a.m. del dia 20 de julio sin importar el día de la semana
 20 * * * 6       Al minuto 20 de cada hora de los sábados
 20 * * 1 6       Al minuto 20 de cada hora de los sábados de enero

Ejemplo que se ejecute cada minuto:

.. code-block:: bash

 crontab -l
 * * * * * /root/encendido.sh

El programa cron se invoca cada minuto y ejecuta las tareas que sus campos se cumplan en ese preciso minuto.

Ejemplo de la utilización de rsync para hacer copias de seguridad

.. code-block:: bash

 rsync -av --delete /home/dani /media/dani/Backup/
 rsync -av --delete -e 'ssh -p22' dani@IP:/home/dani/ /media/dani/Backup/

Systemd
*******

Antiguamente se utilizaba el proceso init,  este es el proceso “padre”, es el primer proceso que se ejecuta al iniciar el sistema(es lanzado directamente por el kernel), y se encarga de lanzar todos los demás procesos.

Hace ya tiempo salio la noticia de que Ubuntu cambiaría su sistema init por Upstart, esto ocurrirá con la versión de Ubuntu 15.04 Vivid Vervet. El demonio init tradicional es estrictamente síncrono, bloqueando futuras tareas hasta que la actual se haya completado. Sus tareas deben ser definidas por adelantado, y solo pueden ser ejecutadas cuando el demonio init cambia de estado (cuando la máquina se arranca o se apaga).

Hoy en día Ubuntu ha cambiado upstart por Systemd. Systemd está hecho para proveer un mejor framework para expresar las dependencias del servicio, permite hacer más trabajo paralelamente al inicio del sistema y reducir la sobrecarga del shell. El nombre viene del sufijo system daemon (procesos en segundo plano) con la letra “d”.
Lo podemos comprobar:

.. code-block:: bash
 
 $ ls /sbin/init -l
 lrwxrwxrwx 1 root root 20 sep 17 10:35 /sbin/init -> /lib/systemd/systemd

Systemd remplaza a la secuencia de arranque de Linux y los niveles de ejecución controlados por el demonio de inicio tradicional , junto con la ejecución de los scripts bajo su control.

En systemd el primer demonio de ejecución se llama precisamente systemd y es el que tiene PID 1.

En systemd los servicios se denominan units. Cada unit se define en un archivo donde se especifica un proceso para arrancar por systemd. Evidentemente el arranque de un unit puede estar supeditado a determindas circunstancias como la dependencia de otros units.

Existen varios tipos de **units**, no sólo servicios, cuyos archivos se nombran con la extensión correspondiente:

* servicios (.service)
* puntos de montaje (.mount)
* dispositivos (.device)
* sockets (.socket)

Los archivos que definen los units (y los targets) se pueden encontrar básicamente en tres ubicaciones distintas:

* **/usr/lib/systemd/system/**: unidades distribuidas con paquetes RPM instalados.
* **/run/systemd/system/**: unidades creadas en tiempo de ejecución. Tiene precedencia sobre el directorio anterior.
* **/etc/systemd/system/**: unidades creadas y administradas por el administrador del sistema. Este directorio tiene precedencia sobre el directorio anterior.

El formato de un archivo unit sigue unas reglas y nomenclatura específicas. Básicamente se divide en varias secciones se las cuales las principales son:

* **[Unit]**
* **[Service]**
* **[Install]**

A continuación se indican esquemáticamente las opciones más importantes dentro de cada sección.

[Unit]
^^^^^^

**Description=<descrición del unit>**

Una descripción del servicio que se muestra al consultar el status del servicio.

**After=<units>**

Define el orden en el cual los unist se inician. El unit se inicia sólo después de que los units especificados en esta línea estén activos. La diferencia con Require es que After no activa explícitamente los units indicados aquí. La opción Before tiene la funcionalidad opuesta a After.

**Requires=<units>**

Configuras las dependencias sobre otras units. Los units listados aquí serán activados junto con este unit. Si alguno de los units requeridos falla en el arranque, este unit tampoco se activa.

**Wants=<units>**

Activa los units indicados aquí. Wants configura dependencias de manera más débil que Require. Si alguno de los units indicados por Wants no se inician correctamente no tienen ningún efecto en el estado de este unit. Wants es la manera recomendada para establecer dependencias personalizadas.

**Conflicts=<units>**

Configura dependencias negativas, es decir, es un opuesto a Requires. El servicio no se inicia si el servicio indicado en esta línea está activo.

[Service]
^^^^^^^^^

**TimeoutStartSec=<n>**

Tiempo tras el cuál, si el servicio no ha arrancado, se considera fallo y se detiene.

**ExecStart=<ejecutable>**

comando a ejecutar.

**Type=<opción>**

Configura el tipo de arranque del procesos de la unidad la cual afecta a la funcionalidad ExecStart. Las opciones son:

* **simple** – Es el valor por defecto. El proceso arrancado con ExecStart es el proceso principal del servicio. Este proceso se arranca inmediatamente. El proceso no debe desencadenar otros procesos que requieran ejecución en el algún orden. No utilizar este tipo si otros servicios necesitan ejecutarse en orden con él.
* **forking** – El proceso iniciado con ExecStart genera un proceso hijo que se convierte en el proceso principal del servicio. Se sale del proceso padre cuando el arranque se completa. El uso de esta opción es importante cuando ejecutamos un script que a su vez ejecuta otros procesos. Sin la opción forking estos subprocesos podrían salir inesperadamente al concluir el proceso principal.
* **oneshot** – Similar a simple, pero se sale del proceso antes de que se arranquen los subsiguientes units. Es útil para la ejecución de scripts que hacen un trabajo sencillo y luego salen. Con la opción RemainAfterExit=yes systemd considerará su proceso como activo después de que el proceso haya salido.
* **dbus** – Similar a simple, pero los subsiguientes units sólo son arrancados después de que el proceso principal adquiera un nombre D-Bus.
* **notify** – Similar a simple, pero los subsiguientes units sólo son arrancados después de que un mensaje de notificación se haya enviado mediante una función sd_notify().
* **idle** – Similar a simple, la ejecución actual del binario del servicio se retrasa hasta que todos los trabajos se terminan, lo que evita la mezcla de la salida de estados con las salidas de los servicios por la Shell.

[Install]
^^^^^^^^^^

**WantedBy=multi-user.target**

Indica el target al que pertenece este unit. Esto provoca que el comando systemctl enable <servicio>.service cree los enlaces simbólicos necesarios dentro del target multi-user.target.wants sin necesidad de hacerlo manualmente.

Lo que se consigue con esto es que el servicio se ejecute automáticamente al arrancar se target.

Los Targets
***********

Un conjunto de units definen un target. El target es el equivalente al concepto de runlevel, es decir un conjunto de servicios que se ejecutan en determinadas circunstancias. Así por ejemplo, el runlevel 3 de System V corresponde al target multi-user.target en systemd y el runlevel 5 correspondería al target llamado  graphical.target 0 # Apaga el sistema

* 1, Mono usuario #Modo mono-usuario
* 2, 4 Modo de inicio definido por el usuario/sistema, por default identico a 3
* 3 Multiusuario, entorno grafico
* 5 Multiusuario, entorno grafico, todos los servicios del nivel 3 mas un entorno grafico
* 6 Reinicio
reinicio #Shell de emergencia

A diferencia de los runlevels, los targests se pueden ejecutar a la vez.

Systemctl
*********

En Systemd la forma de controlar los servicios del sistema cambia. Los servicios ya no se controlan a través de /etc/init.d y tampoco se utiliza el comando “service”. Aquí se utiliza el gestor de servicios llamado **systemctl**.

La principal orden para controlar systemd es systemctl. systemctl sustituye a chkconfig de System V.

systenctl es una herramienta potente con muchas opciones. A continuación se listan los más importantes atendiendo su funcionalidad.

.. code-block:: bash

 systemctl                              #Lista servicios y unidades disponibles en el sistema.
 systemctl list-unit-files              #Lista ficheros de unidades
 systemctl list-units                   #Lista servicios disponibles q
 systemctl list-dependencies <servicio> #Lista las dependencias de un servicio
 systemctl show <service>               # Visualizar las propiedades del unit.
 systemctl start <servicio>             # Arrancar servicios.
 systemctl stop <servicio>              # Parar servicios.
 systemctl status <service>             # Visualiza el estado e información de un servicio.
 systemctl is-active <service>          # Muestra simplemente si el servicio está activo
 systemctl enable <servicio>            # Habilita un servicio en el arranque.
 systemctl disable <servicio>           # Deshabilita un servicio en el arranque.
 systemctl restart <servicio>           # Reinicia un servicio.
 systemctl reload <servicio>            # Recarga la configuración de un servicio si reiniciarlo
 systemctl mask <servicio>              # Marca un servicio como completamente inarrancable
 
Ejemplo :

.. code-block:: bash

 $ service --status-all | grep ssh
  [ + ]  ssh
  
 $ systemctl stop ssh
 
 $ service --status-all | grep ssh
 [ - ]  ssh
 
 $ systemctl start ssh
 $ service --status-all | grep ssh
 [ + ]  ssh


Ejemplo de encadenamiento de servicios
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Servicio A personalizado se ejecuta automáticamente en el arranque con el target multi-user.target:

.. code-block:: bash

 [Unit]
 Description=Servicio A
 Requires=multi-user.target
 [Service]
 Type=simple
 ExecStart=/bin/servicioA.sh
 [Install]
 WantedBy=multi-user.targe

Servicio A se ejecuta automáticamente con el arranque en el target multi-user.target. El servicio A una vez iniciado, lanza al servicio B:

.. code-block:: bash

 [Unit]
 Description=Servicio A
 Requires=multi-user.target
 Wants=ServicioB.service
 [Service]
 Type=simple
 ExecStart=/bin/servicioA.sh
 [Install]
 WantedBy=multi-user.target

servicio B

.. code-block:: bash

 [Unit]
 Description=Servicio B
 [Service]
 Type=simple
 ExecStart=/bin/servicioB.sh
 [Install]

Servicio A se ejecuta automáticdamnete con el arranque en el target multi-user.target. Una vez inicado el servicio A, éste lanza al servicio B cuando el servico A concluye:

.. code-block:: bash

 [Unit]
 Description=Servicio A
 Requires=multi-user.target
 [Service]
 Type=simple
 ExecStart=/bin/servicioA.sh
 ExecStop=/usr/bin/systemctl start ServicioB.service
 [Install]
 WantedBy=multi-user.target

servicio B

.. code-block:: bash
 [Unit]
 Description=Servicio B
 [Service]
 Type=simple
 ExecStart=/bin/servicioB.sh
 [Install] 


Acceder a los registros del sistema
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

La forma básica de acceder a los registros del sistema es:

.. code-block:: bash

 journalctl                             # cat /var/log/messages
 journalctl -f                          # tail -f /var/log/messages
 journalctl --list-boots                # Filtrar la salida de logs por boots
 journalctl -b                          # Logs del boot actual
 journalctl -b -1                       # Anteriores
 journalctl -k                          # Ver los mensajes del kernel
 journalctl -n                          # Filtrar por número de entradas
 journalctl _COMM=NetworkManager        # Filtras por ejecutables o programas
 journalctl /usr/sbin/NetworkManager    # Filtrar por especificando la ruta
 journalctl _PID=2527                   # Mostrar la salida por PID
 journalctl _UID=1001                   # id de los usuarios
 journalctl --since '30 min ago'        # Última media hora:
 journalctl /dev/sda                    # Funcionamiento en nuestras unidades de discos duros
 journalctl --disk-usage                # Ver el espacio que están ocupando 
 systemctl list-units -t service --all  # Filtrar la salida por servicios de systemd
 journalctl -u dbus.service             # Si nos interesa uno en particular
 
 #Filtrar por intervalos de tiempo
 journalctl --since 'yesterday' --until '02:00'
 journalctl --since='2015-02-29 00:01' --until='2015-03-29 00:01' 
 #Filtrar por programas e intervalos
 journalctl _COMM=firefox --since='2015-02-29 00:01' --until='2015-03-29 00:01'
 journalctl -u sshd.service --since='2015-02-29 00:01' --until='2015-03-29 00:01' 


Ejemplo de enrutamiento
***********************

.. code-block:: bash
 
 $ cat /root/enrutar.sh
 #!/bin/bash
 echo 1 > /proc/sys/net/ipv4/ip_forward
 iptables -F
 iptables -A FORWARD -j ACCEPT
 iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -o enp0s3 -j MASQUERADE

Para que se inicie automáticamente utilizamos el sistema systemctl

.. code-block:: bash

 $ cat /etc/systemd/system/enrutar.service
 
 [Unit]
 Description=Inicia enrutamiento
 After=syslog.target 

 [Service]
 ExecStart=/root/enrutar.sh
 User=root
 
 [Install]
 WantedBy=multi-user.target

 $ chmod +x /root/enrutar.sh
 $ systemctl enable enrutar.service
 $ systemctl start enrutar.service
 $ systemctl list-unit-files 
