*****
Slurm
*****

**Slurm** (Simple Linux Utility for Resources Management), es un sistema de gestión de tareas y de clústeres (nodos o servidores de cómputo).

.. code-block:: bash

 srun    # Envía un trabajo para su ejecución
 scancel # Finaliza trabajos que se encuentren en ejecución o pendientes
 sinfo   # Muestra información sobre el estado de los nodos de cómputo
 squeue  # Informa sobre el estado de los trabajos en ejecución y pendientes
 sbatch  # Envía un script para su posterior ejecución

Caso práctico: Red interna con NIS, NFS, autofs y Slurm
*******************************************************

Servidor compute-0-0
********************

Lo instalaremos en el servidor compute-0-0, en el que exporta los usuarios por NIS y el home por NFS, como podemos ver también en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/e84ii5ywht6gafmy>`_

.. code-block:: bash

 apt install slurm-wlm
 
**Munge** es un servicio de autenticación y validación de credenciales. Se utilizará con Slurm para validar sus procesos. comprueba que se haya instalado ejecutando

.. code-block:: bash

 munge -n | unmunge

Lo instalamos en todos los nodos, para eso copiamos la clave desde el controlador **compute-0-0** a los clientes, ejemplo con el nodo compute-0-1

.. code-block:: bash

 scp /etc/munge/munge.key compute-0-1:/etc/munge/  

Nos concetamos al cliente **compute-0-1**

.. code-block:: bash

 chown munge /etc/munge/munge.key
 chmod 400 /etc/munge/munge.key
 systemctl enable munge --now
 systemctl restart munge
 systemctl status munge


Lo siguiente que hacemos es configurar el archivo de configuración del slurm ''/etc/slurm/slurm.conf''

.. code-block:: bash

 # Control machine
 ControlMachine=compute-0-0

 # Cluster info
 ClusterName=Cluster_tunombre
 SlurmUser=slurm
 SlurmdUser=root
 
 # Logging
 SlurmctldLogFile=/var/log/slurmctld.log
 SlurmdLogFile=/var/log/slurmd.log
 SlurmdSpoolDir=/var/spool/slurmd
 
 # Communication
 StateSaveLocation=/var/spool/slurmctld
 SlurmdPort=6818
 SlurmctldPort=6817
 AuthType=auth/munge
 AccountingStorageType=none
 
 # Scheduling
 SchedulerType=sched/backfill

 # Node definition
 NodeName=compute-0-[1-2] CPUs=1 State=UNKNOWN RealMemory=1024
 PartitionName=debug Nodes=compute-0-[1-2] Default=YES MaxTime=INFINITE State=UP
 ReturnToService=2


Lanza los servicios en el controlador **compute-0-0**:

.. code-block:: bash

 systemctl start slurmctld

Fíjate que el cliente **compute-0-1** no esta todavía configurado **STATE = unkonwn**

.. code-block:: bash

 root@compute-0-0:~# sinfo
 PARTITION AVAL   TIMELIMIT   NODES  STATE NODELIST
 debug*      up      infite       1   unk* compute-0-1
 

Cliente compute-0-1
*******************

Instalamos Slurmd

.. code-block:: bash

 apt-get install slurmd

Necesitamos que los clientes seán accesibles por el root desde el servidor sin el uso de contraseña, para comprobarlo:

.. code-block:: bash

 root@compute-0-0:~# ssh compute-0-1 hostname
 compute-0-1

para que los nodos se puedan autentificar en el servidor tienen que tener configurado munge, para comprobarlo desde el controlador ejecutamos:

.. code-block:: bash
 
 munge -n | ssh compute-0-1 unmunge 

Copiamos la configuración de slurm desde **compute-0-0** a compute-0-1:

.. code-block:: bash
 
 scp /etc/slurm/slurm.conf  compute-0-1:/etc/slurm/slurm.conf

Cambiamos permisos y lanzamos slurmd en **compute-0-1**

.. code-block:: bash
 
 touch /var/log/slurmd.log
 chown slurm: /var/log/slurmd.log
 systemctl enable slurmd.service

 systemctl start slurmd.service
 systemctl restart slurmd.service
 systemctl status slurmd.service
  
Para ver los cambios desde **compute-0-0** 

.. code-block:: bash
 
 systemctl restart slurmctld.service
 systemctl status slurmctld.service
  
Volvemos a comprobar desde el servidor el estado del nodo

.. code-block:: bash

 root@compute-0-0:~# sinfo
 PARTITION AVAL   TIMELIMIT   NODES  STATE NODELIST
 debug*      up      infite       1   idle compute-0-1

En el caso de que no se cambie el estado automaticamente lo podemos intentar a cambiar a mano

.. code-block:: bash

 scontrol update nodename=compute-0-1 state=idle
