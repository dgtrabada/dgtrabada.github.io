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
       
       
Ficheros y directorios
======================

* **ls** listar archivos y carpetas

  * ls -la para ver ocultos
  * ls -ai para ver lo inodos
  
* **stat** muestra información del inodo
* **ln -s** hacer links simbólicos -P son links duros sobre archivos
* **cp -r** copiar
* **mv** mover, renombrar
* **rm -fr** borrar
* **mkdir** crear directorio
* **rmdir** borrar directorio
* **cd** cambiar directorio
* **pwd** print working directory, se utiliza para imprimir el nombre del directorio actual
* **find** find -name nombre_archivo #busca el fichero dentro del directorio
* **locate** fichero  #busca el fichero

Editores y visualizadores de archivos
=====================================
    
* **cat** visualizar el contenido archivo
* **more** mostrar archivos haciendo pausa en cada pantalla
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
  
  .. code-block:: bash 
 
   export EDITOR=/usr/bin/vim
   cat ~/.vimrc
   filetype indent off

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
  
  .. code-block:: bash
  
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

* **fdisk -l** permite crear particiones en el disco duro
* **cfdisk** similar a fdisk, pero con una interfaz diferente
* **gparted** editor de particiones para el entorno de escritorio GNOME
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
   
* **mkfs** construir un sistema de ficheros de Linux sobre un dispositivo
* **fsck** Utilidad para detectar, verificar y corregir los errores del sistema de archivo
* **mkswap** para convertir un fichero vacío al formato SWAP
* **mkswapon** activan particiones de swap
* **mkswapoff** desactivan particiones de swap
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
   /dev/sdb: Linux rev 1.0 ext4 filesystem data, UUID=093e58be-28c0-4620-87cc-c77e3cb03b8c (needs journal    recovery) (extents) (64bit) (large files) (huge files)


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


  