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

Partiremos del caso práctico de NIS, NFS y autofs con red interna, donde se exportan los usuarios por NIS y el home por NFS, como podemos ver también en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/e84ii5ywht6gafmy>`_. Empezamos instalandos en el servidor **compute-0-0** el controlador central:

.. code-block:: bash

 root@compute-0-0:~# apt install slurm-wlm

Instalamos Slurmd

.. code-block:: bash

 root@compute-0-1:~# apt-get install slurmd

Necesitamos que el cliente compute-0-1 seán accesibles por el root desde el servidor sin el uso de contraseña, y que tengan instalado **slurmd**

.. code-block:: bash

 root@compute-0-1:~# apt-get install slurmd
 
**Munge** es un servicio de autenticación. Se utilizará con Slurm para validar sus procesos. comprueba que se haya instalado en caso contrarío instalalo

.. code-block:: bash

 root@compute-0-0:~# munge -n | unmunge

Lo instalamos en todos los nodos y copiamos la clave desde el controlador **compute-0-0** a los clientes, ejemplo con el nodo compute-0-1

.. code-block:: bash

 root@compute-0-1:~# apt-get install munge 
 root@compute-0-0:~# scp /etc/munge/munge.key compute-0-1:/etc/munge/  

Nos concetamos al cliente **compute-0-1**

.. code-block:: bash

 #chown munge /etc/munge/munge.key
 #chmod 400 /etc/munge/munge.key
 #systemctl enable munge --now
 systemctl restart munge
 #systemctl status munge

.. code-block:: bash
 
 root@compute-0-0:~# munge -n | ssh compute-0-1 unmunge
 Tiene que aparecer STATUS: Success.

Lo siguiente que hacemos es configurar el archivo de configuración del slurm ``/etc/slurm/slurm.conf``

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
 NodeName=compute-0-1 CPUs=2 State=UNKNOWN RealMemory=1024
 PartitionName=debug Nodes=compute-0-1 Default=YES MaxTime=INFINITE State=UP
 ReturnToService=2


Creamos en compute-0-0 los directorios necesarios y les damos los permisos adecuados

.. code-block:: bash

 sudo mkdir -p /var/spool/slurmctld
 sudo mkdir -p /var/log/slurm
 sudo chown -R slurm:slurm /var/spool/slurmctld
 sudo chown -R slurm:slurm /var/log/slurm

Copiamos la configuración de slurm desde compute-0-0 a compute-0-1:

.. code-block:: bash

 root@compute-0-0:~# scp /etc/slurm/slurm.conf  compute-0-1:/etc/slurm/slurm.conf

Cambiamos permisos y lanzamos slurmd en **compute-0-1**

.. code-block:: bash
 
 touch /var/log/slurmd.log
 chown slurm: /var/log/slurmd.log
 systemctl enable slurmd.service

 systemctl stop slurmd.service
 systemctl start slurmd.service
 systemctl status slurmd.service



Lanza los servicios en el controlador **compute-0-0**:

.. code-block:: bash

 systemctl restart slurmctld.service
 systemctl status slurmctld.service

Comprobar desde el servidor el estado del nodo

.. code-block:: bash

 root@compute-0-0:~# sinfo
 PARTITION AVAL   TIMELIMIT   NODES  STATE NODELIST
 debug*      up      infite       1   idle compute-0-1

En el caso de que no se cambie el estado automaticamente lo podemos intentar a cambiar a mano

.. code-block:: bash

 scontrol update nodename=compute-0-1 state=idle

Clonamos otro cliente **compute-0-2**, cambiamos en compute-0-0:/etc/slurm/slurm.conf

.. code-block:: bash

 # Node definition
 NodeName=compute-0-[1-2] CPUs=1 State=UNKNOWN RealMemory=1024
 PartitionName=debug Nodes=compute-0-[1-2] Default=YES MaxTime=INFINITE State=UP
 ReturnToService=2

Hacemos la instalacion en **compute-0-2** desde el **compute-0-0**

.. code-block:: bash

 ssh compute-0-2 apt install slurm-wlm -y
 scp /etc/munge/munge.key compute-0-2:/etc/munge/
 ssh compute-0-2 systemctl restart munge
 munge -n | ssh compute-0-2 unmunge

 scp /etc/slurm/slurm.conf  compute-0-2:/etc/slurm/slurm.conf
 ssh compute-0-2 touch /var/log/slurmd.log
 ssh compute-0-2 chown slurm: /var/log/slurmd.log
 ssh compute-0-2 systemctl restart slurmd.service
 ssh compute-0-2 systemctl status slurmd.service

 !Cambiamos también en compute-0-1
 scp /etc/slurm/slurm.conf  compute-0-1:/etc/slurm/slurm.conf
 ssh compute-0-1 systemctl restart slurmd.service

 systemctl restart slurmctld.service

