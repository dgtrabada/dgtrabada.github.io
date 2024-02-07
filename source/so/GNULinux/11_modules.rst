*******************
Environment modules
*******************

Modules permite el cambio rápido de un entorno a otro porque nos deja cargar o borrar las variables necesarios para un programa ejecutando un comando sencillo y avisa si hay conflictos entre un entorno ya definido con otro que el usuario quiere cargar.

Una vez instalado, es fácil definir los entornos, consiste básicamente en crear los diferentes ficheros en modulefiles como podemos ver en el vídeo `<https://mediateca.educa.madrid.org/video/fsvyrjlovd95w8ht>`_

Los modulefiles están escritos en Tcl (Tool Command Language) y son
interpretados por el modulecmd que se ejecuta cada vez que invocamos
module

Debe inicializarse con el login de los usuarios según la shell que se usa

.. code-block:: bash

 source /usr/share/modules/init/bash

Especifica variables como el MODULESHOME o MODULEPATH


Los comandos básicos de la herramienta son:

.. code-block:: bash

 module avail   # Muestra los módulos de entornos de programas disponibles
 module load    # Carga el entorno del programa <prog> de la versión por defecto
 module load    # Carga el entorno del programa <prog> de la versión <vers>
 module list    # Muestra los módulos cargados actualmente
 module unload  # Quita el entorno del <prog>
 module show    # Muestra el entorno que define el módulo
 module whatis  # información que aparecerá al usar module whatis modulefile

Configuración de environment modules:
instalamos en el servidor :

.. code-block:: bash

 apt-get install environment-modules
 
Podemos comprobar que se ha instalado

.. code-block:: bash

 tunombre1@compute-0-0:~$ module avail
 ------------------------ /usr/share/modules/modulefiles ------------------------
 dot  module-git  module-info  modules  null  use.own 


Vamos a crear un nuevo modulo

.. code-block:: bash

 root@compute-0-0:/usr/share/modules/modulefiles# cat test
 #%Module
 ##
 ## test modulefile
 ##
 ##
 proc ModulesHelp { } {
 global version modroot
 puts stderr "\ttest carga nada"
 }
 module-whatis "Entorno para test"
 prepend-path PATH /export/apps/test/bin

 root@compute-0-0:~# cat /export/apps/test/bin/test.x
 echo hola $(whoami)
 echo hoy es $(date)
 
Podemos comprobar que se ha cargado

.. code-block:: bash

 tunombre1@compute-0-0:~$ module avail
 ------------------------ /usr/share/modules/modulefiles ------------------------
 dot  module-git  module-info  modules  null  test  use.own    
 
 tunombre1@compute-0-0:~$ module whatis test
 ------------------------ /usr/share/modules/modulefiles ------------------------
 test: Entorno para test
                
 tunombre1@compute-0-0:~$ module help test
 -------------------------------------------------------------------
 Module Specific Help for /usr/share/modules/modulefiles/test: 
 
         test carga nada
 -------------------------------------------------------------------
 
 tunombre1@compute-0-0:~$ text.x
 text.x: command not found
 
 tunombre1@compute-0-0:~$ module list
 No Modulefiles Currently Loaded.
 
 tunombre1@compute-0-0:~$ module load test
 tunombre1@compute-0-0:~$ module list
 Currently Loaded Modulefiles:
  1) test  
  
 tunombre1@compute-0-0:~$ test.x 
 hola tunombre1
 hoy es vie 14 abr 2023 10:21:49 UTC
 
 tunombre1@compute-0-0:~$ module rm test
 tunombre1@compute-0-0:~$ module list
 No Modulefiles Currently Loaded.
 tunombre1@compute-0-0:~$ test.x
 test.x: command not found

Ahora vamos a lanzarlo al sistema de colas con sbatch:


.. code-block:: bash

 tunombre1@compute-0-0:~$ cat script.sh 
 #!/bin/bash
 #SBATCH --job-name=serial_job_test    # Job name
 #SBATCH --ntasks=1                    # Run on a single CPU
 #SBATCH --partition=debug
 #SBATCH --time=00:05:00               # Time limit hrs:min:sec
 #SBATCH --output=serial_test_%j.log   # Standard output and error log
 
 module load test
 pwd > salida
 hostname >> salida
 test.x >> salida

 tunombre1@compute-0-0:~$ sbatch script.sh 
 Submitted batch job 10
 
 tunombre1@compute-0-0:~$ cat salida 
 /home/tunombre1
 compute-0-1

 tunombre1@compute-0-0:~$ cat serial_test_10.log 
 tunombre1@compute-0-0:~$ cat salida 
 /var/lib/slurm/slurmd/job00010/slurm_script: line 12: test.x: command not found

como podemos ver, no se encuentra el ejecutable test.x, para que funcione tenemos que exportar a los nodos /export/app, instalar los environment-modules en los nodos  y copiar su configuración:

.. code-block:: bash

 tunombre1@compute-0-0:~$ scp /usr/share/modules/modulefiles/test compute-0-1:/usr/share/modules/modulefiles/test
 
 tunombre1@compute-0-0:~$ tail -5 /etc/exports
 /home/tunombre1 172.16.0.12(rw,sync,no_root_squash,no_subtree_check)
 /home/tunombre1 172.16.0.13(rw,sync,no_root_squash,no_subtree_check)
 /home/tunombre1 172.16.0.14(rw,sync,no_root_squash,no_subtree_check)
 /export 172.16.0.10(rw,async,no_root_squash) 172.16.0.0/255.255.255.0(rw,async) 
 /export/apps *(rw,async,no_root_squash)

 tunombre1@compute-0-1:~$ tail -4 /etc/auto.master
 #
 +auto.master
 /home /etc/auto.home
 /export /etc/auto.share --timeout=1200
 
 tunombre1@compute-0-1:~$ tail -4 /etc/auto.home 
 *    compute-0-0:/home/&
 
 tunombre1@compute-0-1:~$ tail -4 /etc/auto.share 
 apps compute-0-0:/export/&


Volvemos a lanzar el proceso y comprobamos que ahora si existe el comando test.x

.. code-block:: bash

 tunombre1@compute-0-0:~$ sbatch script.sh 
 Submitted batch job 11
 
 tunombre1@compute-0-0:~$ cat salida 
 /home/tunombre1
 compute-0-1
 hola tunombre1
 hoy es vie 14 abr 2023 10:23:51 UTC

 #No hace falta tenerlo cargado en el nodo principal
 tunombre1@compute-0-0:~$ module list
 No Modulefiles Currently Loaded.


