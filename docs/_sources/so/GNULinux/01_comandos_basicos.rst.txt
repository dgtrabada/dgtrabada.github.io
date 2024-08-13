**************************
Comandos básicos GNU/Linux
**************************

Control de procesos
===================

* **ps** ver procesos ps -ef
* **top, htop** monitorización de procesos

  * [Espacio] Realiza un refresco de la pantalla
  * [h] Muestra la pantalla de ayuda
  * [k] Mata un proceso, pedirá la ID del proceso y la señal que hay que enviarle.
  * [n] Cambia el número de procesos que se muestran en pantalla.
  * [u] Ordena por usuario.
  * [M] Ordena por uso de memoria.
  * [P] Ordena por uso del CPU.

* **nice** ejecuta un comando con una prioridad determinada, o modifica la prioridad a de un proceso
* **kill** mata procesos
* **pstree** muestra en vista de árbol (de forma jerárquica) una lista de los procesos en ejecución.
* **nohup** permite mantener la ejecución de un comando pese a salir de la terminal
* **jobs, fg %2, bg %1, ctrol+c, ctrol+z**

.. code-block:: bash

 $ sleep 10m &    #mandamos al segundo plano añadiendo & al final
 [1] 7768
 $ sleep 10m &
 [2] 7770
 $ sleep 10m &
 [3] 7771
 $ jobs
 [1]   Ejecutando              sleep 10m &
 [2]-  Ejecutando              sleep 10m &
 [3]+  Ejecutando              sleep 10m &
 $ fg %1         #lo traemos al primer plano, bloquea la terminal
 sleep 10m       #para desbloquear terminal y no matar el proceso Ctrol+z
 ^Z              
 [1]+  Detenido                sleep 10m
 $ jobs
 [1]+  Detenido                sleep 10m
 [2]   Ejecutando              sleep 10m &
 [3]-  Ejecutando              sleep 10m &
 $ bg %1         #lo volvemos a mandar al segundo plano
 [1]+ sleep 10m &
 $ jobs
 [1]   Ejecutando              sleep 10m &
 [2]-  Ejecutando              sleep 10m &
 [3]+  Ejecutando              sleep 10m &
 $ kill %1      #matamos el proceso 1
 $ jobs
 [1]   Terminado               sleep 10m
 [2]-  Ejecutando              sleep 10m &
 [3]+  Ejecutando              sleep 10m &
 $ fg %2        #mandamos el proceso 2 al segundo plano
 sleep 10m      #para desbloquear terminal y matar el proceso Ctrol+c
 ^C           
 $ jobs
 [3]+  Ejecutando              sleep 10m &
 

 sleep 10 & # Ponemos tarea en segundo plano añadiendo & al final del comando.
 fg %1      # Ponerlo en primer plano
 bg %1
 Ctrl+Z     # para  detener una tarea en primer plano
 Ctrl+C     # para cancelar una tarea en primer plano
       
**/etc/security/limits.conf** es utilizado en sistemas Unix y Linux para configurar límites de recursos y privilegios para usuarios y grupos. Este archivo permite establecer restricciones específicas sobre cómo los usuarios pueden utilizar los recursos del sistema, como la cantidad de memoria, la cantidad de procesos, el número de archivos abiertos, entre otros. También se utiliza para establecer prioridades y políticas de programación para procesos específicos.nLos límites definidos en "/etc/security/limits.conf" son aplicados por el sistema de gestión de límites de recursos (RLIMIT) del kernel. Esto permite evitar el uso excesivo de recursos por parte de usuarios o grupos, lo que podría llevar a una degradación del rendimiento del sistema o incluso a problemas de seguridad.

**/proc/self** es un atajo que permite a un proceso acceder a información sobre sí mismo a través del sistema de archivos virtual /proc, que proporciona una ventana al kernel para monitorear y gestionar procesos y recursos del sistema.



Ficheros y directorios
======================

* **ls** listar archivos y carpetas

  .. code-block:: bash

   ls -la     #ver archivos ocultos
   ls -ai     #ver inodos
   ls *dat    #ver los archvios acabados en dat
   ls *T*     #ver archivos que contienen T
   ls ???.dat #ver archivos que tienen 3 caracteres y termian en .dat
  
* **ln -s** hacer links simbólicos -P son links duros sobre archivos

  .. code-block:: bash

   $ ln -s date.dat links
   $ ln  date.dat linkh
   $ ls -la
   -rw-r--r--. 2 dani profesores 31 mar 29 09:40 date.dat
   -rw-r--r--. 2 dani profesores 31 mar 29 09:40 linkh
   lrwxrwxrwx. 1 dani profesores  8 mar 29 09:40 links -> date.dat
   $ ls -ai
   238052 date.dat  238052 linkh  238053 links
   $ rm -fr date.dat
   $ ls -la
   $ head link*
   ==> linkh <==
   mié mar 29 09:40:27 CEST 2023
   head: no se puede abrir 'links' para lectura: No such file or directory


* **stat** muestra información del inodo

* **cp -r** copiar
* **mv** mover, renombrar
* **rm -fr** borrar
* **mkdir** crear directorio
* **cd** cambiar directorio
* **whereis** muestra donde esta el comando
* **pwd** print working directory, se utiliza para imprimir el nombre del directorio actual
* **locate** fichero  #busca el fichero
* **find** buscar; 

  .. code-block:: bash
  
    find -name *dat
    find -not -name *dat
    find . -type f -size +20M

Visualizadores de archivos
=====================================
    
* **cat** visualizar el contenido archivo
* **more** mostrar archivos haciendo pausa en cada pantalla

Editor vi
=========

* **vi hola.dat** abrir y editar el archivo hola.dat

  * i -> modo insertar
  * <esc> -> modo comandos
  * :w -> guardar
  * :q -> salir
  * :wq -> guardar y salir
  * :q! -> salir sin guardar
  * /cadena -> buscar cadena
  * N yy -> copiar N lineas
  * N dd -> borrar N lineas
  * p -> pegar
  * u -> undo
  * :%s/cadena1/cadena2/g -> sustituir una cadena
  * G -> ir al final del archivo
  * :set number -> ver los número de linea
  
  Para configurar configuración por defecto en el archivo .vimrc como por ejemplo:
  
  .. code-block:: bash 
 
    $ cat ~/.vimrc
    filetype indent off
  
  Para configurar que el editor vi sea nuestro editor de forma predeterminaada:
   
  .. code-block:: bash
     
     export EDITOR=/usr/bin/vim

  Esta configuración se aplica solo para la sesión actual, para que sea permanente agrega esta línea al archivo .bashrc
   
  .. code-block:: bash

    echo 'export EDITOR=/usr/bin/vi' >> ~/.bashrc
    bash
   
Compresión
==========

* **tar** se utiliza para comprimir una colección de archivos y carpetas                

  .. code-block:: bash
  
   tar -cf new.tar archivo
   tar -xvf new.tar
   
* **gzip, gunzip, zip**

Instalar software
=================

* **apt-get update** actualiza la lista de paquetes disponibles
* **apt-get upgrade** actualiza el paquete indicado si existe versión nueva en repositorio.
* **apt-get install** instala un paquete y sus dependencias (+install -remove)

  * con la opción --reinstall reinstala el paquete.
  
* **apt-get remove** desinstala un paquete instalado (+install -remove)
* **apt-get purge** desinstala eliminando ficheros de configuración.
* **apt-get install -f** resuelve las dependencias de paquetes rotos instalando lo necesario.
* **dpkg --configure -a** intenta reconfigurar todos los paquetes desplegados no configurados
* **dpkg -i** instalación manual

Configuración de la red
=======================

* **Optener IP local**
  
  .. code-block:: bash
   
   ip a

* **Reiniciar tarjeta de red**

  .. code-block:: bash
  
    sudo service networking restart

* **Activar/desactivar tajeta red**
  
  .. code-block:: bash
   
   sudo ip link set enp0s3 down/up
   
* **NetPlan** es la nueva utilidad para configurar la red, el antiguo /etc/network/interfaces ya no funciona. Debemos configurar **/etc/netplan/01-*.yaml**, por ejemplo:
  
  .. code-block:: yaml
  
   network:
     ethernets:
       enp0s3:
         addresses:
         - 10.4.105.100/8
         routes:
         - to: default
           via: 10.0.0.2
         nameservers:
           addresses: [8.8.8.8]
     version: 2

* **Probar NetPlan**
  
  .. code-block:: bash
    
   sudo netplan --debug apply
  
* **Aplicar NetPlan**
  
  .. code-block:: bash
    
   sudo netplan apply

virtualBox
==========

.. code-block:: bash

 VBoxManage list vms
 VBoxManage list runningvms
 VBoxManage startvm 'ubuntu-server' --type headless
 VBoxManage controlvm 'ubuntu-server' savestate

Gestión de particiones
======================


* **gparted** editor de particiones para el entorno de escritorio GNOME
* **cfdisk** similar a fdisk, pero con una interfaz diferente
* **fdisk**

  .. code-block:: bash
  
    fdisk -l # muestra discos y particiones que hay en el sistema
    fdisk /dev/sdX #para hacer el particionado del disco /dev/sdX
      # o crear nueva tabla de particiones (MSDOS)
      # n crear nueva particion
      # w escribir los cambios

* **mkfs.ext4 /dev/sdX1** dar formato ext4 a la partición sdX1
* **fsck** Utilidad para detectar, verificar y corregir los errores del sistema de archivo
* **mkswap /dev/sdX1** para convertir la partición /dev/sdX1 al formato SWAP
* **mkswapon** activan particiones de swap
* **mkswapoff** desactivan particiones de swap

* **df -h** muestra el estado actual de las particiones montadas
* **du -skh** tamaño de archivos
* **mount** Montar particiones

  .. code-block:: bash
  
    mount /dev/sda1 /media/carpeta1
    mount -t ext3 /dev/sdb3 /home
    mount /dev/sdaX /punto_de_montaje
    
* **umount** desmontar particiones

  .. code-block:: bash
  
   umount punto de montaje
   umount /media/carpeta1
   

* **lsblk -a** nos muestra información de todos los dispositivos de bloque
* **file** sirve para determinar el tipo archivo
* **dd** copia y clona datos discos y particiones.
  Podemos usarlo para limpiar nuestro MBR y la tabla de particiones

  .. code-block:: bash
  
   dd if=/dev/zero of=/dev/sda bs=512 count=1 
  
* **/etc/fstab** # contiene información sobre sistemas de archivos del sistema y sus puntos de montaje y opciones, las distribuciones recientes, se implementa un sistema de automontaje automático.

  .. code-block:: bash

   $ cat /etc/fstab    
   # /etc/fstab: static file system information.
   #
   # Use 'blkid' to print the universally unique identifier for a
   # device; this may be used with UUID= as a more robust way to name devices
   # that works even if disks are added and removed. See fstab(5).
   #
   # <file system> <mount point>   <type>  <options>       <dump>  <pass>
   # / was on /dev/sda2 during curtin installation
   /dev/disk/by-uuid/4609be84-f57c-4ee0-b876-3839f95d628c / ext4 defaults 0 1
   /dev/disk/by-uuid/f7832f7d-90b0-4c39-9145-4d5dfaaf5d47 none swap sw 0 0
   # /home was on /dev/sdb during curtin installation
   /dev/disk/by-uuid/093e58be-28c0-4620-87cc-c77e3cb03b8c /home ext4 defaults 0 1
   /swap.img	none	swap	sw	0	0
   
   $ sudo file -Ls /dev/sdb 
   /dev/sdb: Linux rev 1.0 ext4 filesystem data, UUID=093e58be-28c0-4620-87cc-c77e3cb03b8c 
   (needs journal    recovery) (extents) (64bit) (large files) (huge files)


La estructura de las instrucciones es de 6 columnas separadas por espacios o tabuladores

**<dispositivo> <punto_de_montaje> <sistema_de_archivos> <opciones> <dump-freq> <pass-num>**

* **<dispositivo>** es el directorio lógico que hace referencia a una partición o recurso. Nombre del dispositivo o etiqueta, podríamos sustituir la segunda linea por:

  .. code-block:: bash
  
   /dev/sdb1        /HOME           ext4    defaults        0       2
  
* **<punto_de_montaje>** es la carpeta en que se proyectarán los datos del sistema de archivos, en la liea anterior /HOME
* **<sistema de archivos>** es el algoritmo que se utilizará para interpretarlo.
* **<opciones>** es el lugar donde se especifican los parámetros que mount utilizará para montar el dispositivo, deben estar separadas por comas. Las opciones de montaje son numerosas. Las más usadas se listan a continuación:

  * **auto** : indica que el dispositivo se monta siempre que se inicie el sistema. La opuesta es noauto.
  * **rw**: indica que el dispositivo se monta con permisos de lectura y escritura.
  * **ro**: indica que el dispositivo se monta con permisos de lectura solamente.
  * **owner**: indica que el usuario conectado al sistema localmente en primer lugar tiene derechos a montar y desmontar el dispositivo (se adueña de este).
  * **user** : indica que cualquier usuario puede montar y solo el mismo usuario podrá desmontar el dispositivo. La opción opuesta es nouser. users : indica que cualquier usuario puede montar y cualquiera también, puede  desmontar el dispositivo.
  * **suid** : indica que el permiso ``s'' tenga efecto para los ejecutables presentes en el dispositivo. La opción opuesta es nosuid. (Todos los ejecutables del sistema se ejecutan como si fueran invocados por el root)
  * **exec** : indica que los binarios ejecutables almacenados en el dispositivo se pueden ejecutar. La opción opuesta es noexec.
  * **async** : expresa que todas las operaciones de entrada y salida se hacen de forma asíncrona, o sea, no necesariamente en el momento en que se invocan. La opción opuesta es sync.
  * **dev** : indica que se interprete como tal a los dispositivos especiales de bloques y de caracteres presentes en el dispositivo. La opción opuesta es nodev.
  
  * **defaults** : es una opción equivalente a la unión de rw, suid, dev, exec, auto, nouser y async.
* **<dump-freq>** es el comando que utiliza dump para hacer respaldos del sistema de archivos, si es cero no se toma en cuenta ese dispositivo.
* **<pass-num>** indica el orden en que la aplicación fsck revisará la partición en busca de errores durante el inicio, si es cero el dispositivo no se revisa.,2​3​

rsync
=====

rsync sirve para sincronización de archivos

.. code-block:: bash

  rsync [opciones] [origen] [destino]

Opciones comunes

* **-v** (verbose): Muestra información detallada sobre el proceso de sincronización.
* **-r** (recursive): Copia directorios recursivamente.
* **-a** (archive): Modo de copia de seguridad, que conserva metadatos como permisos, propiedades y fechas de modificación.
* **--delete**: Elimina archivos en el destino que no existen en el origen (útil para mantener los dos sistemas iguales).
* **--exclude**: Permite excluir ciertos archivos o patrones de archivos de la sincronización.
* **-n** (dry-run): Realiza una simulación de la sincronización sin realizar cambios en el sistema de archivos.
* **-P** (progress): Muestra el progreso de la transferencia.

Ejemplos de uso

.. code-block:: bash
  
  #Copiar un directorio local a otro lugar local
  rsync -av /ruta/de/origen/ /ruta/de/destino/
 
  #Copiar de local a un servidor remoto (SSH)
  rsync -av -e ssh /ruta/local/ usuario@servidor:/ruta/destino/

  #Copiar de un servidor remoto a local
  rsync -av -e ssh usuario@servidor:/ruta/origen/ /ruta/local/destino/

  #Eliminar archivos en el destino que no existen en el origen
  rsync -av --delete /ruta/de/origen/ /ruta/de/destino/

Consejos adicionales

* Usa ``-n`` para simular una sincronización antes de ejecutarla realmente. Esto te permitirá ver qué cambios se realizarán sin efectuarlos.

* Usa ``--exclude`` para evitar copiar ciertos archivos o directorios. Por ejemplo, ``--exclude=archivo.txt`` evitará la copia del archivo llamado archivo.txt.

  