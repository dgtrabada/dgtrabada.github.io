*******
Ansible
*******

El **nodo de control**, es la máquina que tiene instalado Ansible. Desde ella administraremos el resto de nodos.

El **Inventario** es el archivo host para Ansible. En él se incluye información, estática o dinámica, de los nodos administrados y su información. Datos como IP o nombre.

Los **Módulos**, como en otros lenguajes, serían las librerías que ejecuta Ansible.

Los **Playbooks** se encargan de definir todas las tareas que debemos realizar sobre un conjunto de nodos administrador.

Los **Roles** es una agrupación de ficheros, tareas y plantillas

Una **Task** se podría definir como una acción a realizar.

Instalamos ansible:

.. code-block:: bash

 apt install ansible -y

Añadimos al final del archivo :

.. code-block:: bash

 root@compute-0-0:~# cat /etc/ansible/hosts 
 [server]
 server0 ansible_host=172.16.0.10
 server1 ansible_host=172.16.0.11
 server2 ansible_host=172.16.0.12
 
 [all:vars]
 ansible python interpreter=/usr/bin/python3


Para consultar el inventario

.. code-block:: bash

 root@compute-0-0:~# ansible-inventory --list -y 
 all:
   children:
     server:
       hosts:
         server0:
           ansible python interpreter: /usr/bin/python3
           ansible_host: 172.16.0.10
         server1:
           ansible python interpreter: /usr/bin/python3
           ansible_host: 172.16.0.11
         server2:
           ansible python interpreter: /usr/bin/python3
           ansible_host: 172.16.0.12
     ungrouped: {}


Comprobamos la conexión

.. code-block:: bash

 root@compute-0-0:~# ansible all -m ping -u root
 server0 | SUCCESS => {
     "changed": false,
     "ping": "pong"
 }
 server1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
 }
 server2 | SUCCESS => {
     "changed": false,
     "ping": "pong"
 }



Comandos ad hoc
***************

Cualquier comando que ejecute normalmente en un servidor remoto a través de SSH puede ejecutarse con Ansible en los servidores especificados en su archivo de inventario. Como ejemplo, puede verificar la utilización del disco en todos los servidores con lo siguiente:

.. code-block:: bash

 root@compute-0-0:~# ansible all -a "df -h /dev/sda2" -u root
 server2 | CHANGED | rc=0 >>
 Filesystem      Size  Used Avail Use% Mounted on
 /dev/sda2        79G  6,0G   69G   9% /
 server1 | CHANGED | rc=0 >>
 Filesystem      Size  Used Avail Use% Mounted on
 /dev/sda2        79G  6,4G   68G   9% /
 server0 | CHANGED | rc=0 >>
 Filesystem      Size  Used Avail Use% Mounted on
 /dev/sda2        79G  6,5G   68G   9% /


Podemos instalar en todos los nodos el comando tree:

.. code-block:: bash

 ansible all -m apt -a "name=tree" -u root

Podemos comprobar que se ha instalado ejecutando:

.. code-block:: bash

 ansible all -a "tree" -u root

Podemos especificar múltiples hosts separándolos con comas:

.. code-block:: bash

 ansible server1,server2 -m ping -u root

Plabook
*******

Ansible ad hoc estan bien para algo rápido, sin embargo para organizar varios modulos se utilizan los playbook, por ejemplo:

.. code-block:: bash

 ansible all -m apt -a "name=vim state=latest" -u root

Podríamos escribir lo mismo con un plabook:

.. code-block:: bash

 root@compute-0-0:~# cat playbook.yml
 - name: Playbook
   hosts: all
   become: yes
   become_user: root
   tasks:
     - name: install vim latest
       apt:
         name: vim
         state: latest

Comprobamos la lista de tareas

.. code-block:: bash

 root@compute-0-0:~# ansible-playbook playbook.yml --list-tasks
 
 playbook: playbook.yml

 play #1 (all): Playbook	TAGS: []
   tasks:
     install vim latest	TAGS: []
     
Comprobamos la lista de maquinas dobre la que va actuar 

.. code-block:: bash

 root@compute-0-0:~# ansible-playbook playbook.yml --list-host

 playbook: playbook.yml

  play #1 (all): Playbook	TAGS: []
    pattern: ['all']
    hosts (3):
      server1
      server0
      server2
      

Ejecutamos con ansible el playbook

.. code-block:: bash

 root@compute-0-0:~# ansible-playbook playbook.yml 

 PLAY [Playbook] *************************************************************************
 
 TASK [Gathering Facts] ******************************************************************
 ok: [server2]
 ok: [server0]
 ok: [server1]

 TASK [install vim latest] ***************************************************************
 ok: [server1]
 ok: [server0]
 ok: [server2]

 PLAY RECA P******************************************************************************
 server0       : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0   
 server1       : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0   
 server2       : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0   


Podríamos ejecutarlo solo en el server1

.. code-block:: bash

 ansible-playbook -l server1 playbook.yml
 
Para cambiar el grupo de hosts por defecto.

.. code-block:: bash

 ansible-playbook playbook.yml -i ansible_hosts 
 
 
Roles
*****

Cuando trabajamos con **Ansible**, es habitual que los playbooks crezcan y se vuelvan difíciles de mantener. Para solucionar esto, Ansible introduce el concepto de **roles**, que permiten organizar la configuración en partes reutilizables y bien estructuradas.

Un **rol** es una forma de dividir un playbook en componentes más pequeños, cada uno con una función concreta (instalar paquetes, configurar servicios, gestionar usuarios, etc.).

Creación de un rol
==================

Podemos crear un rol con el siguiente comando:

.. code-block:: bash

   ansible-galaxy init --offline nombre_rol

Este comando genera automáticamente una estructura de directorios estándar como la siguiente:

.. code-block:: bash

   nombre_rol/
   ├── defaults
   │   └── main.yml
   ├── handlers
   │   └── main.yml
   ├── meta
   │   └── main.yml
   ├── README.md
   ├── tasks
   │   └── main.yml
   ├── tests
   │   ├── inventory
   │   └── test.yml
   └── vars
       └── main.yml

Estructura del rol
==================

Cada uno de estos directorios tiene un propósito específico:

- **tasks/main.yml**  
  Define las tareas principales del rol. Es donde se realiza el trabajo (instalar paquetes, copiar archivos, ejecutar comandos, etc.).

- **handlers/main.yml**  
  Contiene acciones que se ejecutan solo cuando son notificadas por una tarea, como reiniciar un servicio.

- **vars/main.yml**  
  Define variables internas del rol con alta prioridad.

- **defaults/main.yml**  
  Define variables por defecto (baja prioridad), pensadas para ser modificadas por el usuario.

- **meta/main.yml**  
  Incluye información del rol, como dependencias de otros roles.

- **tests/**  
  Permite probar el rol con un inventario y un playbook de ejemplo.

- **README.md**  
  Documentación del rol (uso, variables, descripción, etc.).

Consideraciones
===============

- Las variables pueden definirse tanto en **defaults** como en **vars**, pero normalmente se elige uno según la prioridad que necesitemos.
- La lógica principal del rol debe ir en **tasks**.
- Es recomendable mantener los roles simples y reutilizables.

Uso de un rol en un playbook
===========================

Un rol se utiliza dentro de un playbook de la siguiente forma:

.. code-block:: yaml

   - hosts: servidores
     roles:
       - nombre_rol

De esta forma, todas las tareas definidas en el rol se ejecutarán sobre los hosts indicados.

Ventajas de usar roles
=====================

- Facilitan la reutilización del código.
- Mejoran la organización y legibilidad.
- Permiten trabajar de forma modular.
- Se pueden versionar con herramientas como **git**.
- Se pueden compartir en plataformas como Ansible Galaxy.


Caso práctico: compute-0-3
**************************

Partimos de un cluster formado por:

* **compute-0-0**:

  * Tarjeta red modo "Red Nat 10.0.2.10/24 utiliza el puerto 2222 del anfitrión"
  * Tarjeta de red modo "Red interna" : 172.16.0.10/16
  * Servidor y cliente **LDAD** con usuarios (tunombre1, tunombre2, tunombre3 y grupo tupellido)
  * Utiliza NFS y autofs para exportar el home de los usuarios

* **compute-0-1**

  * Tarjeta de red modo "Red interna" : 172.16.0.11/16 (tiene internet a través de compute-0-0)
  * Cliente LDAP y monta el home de los usuarios con autofs

* **compute-0-2**

  * Tarjeta de red modo "Red interna" : 172.16.0.12/16 (tiene internet a través de compute-0-0)
  * Cliente LDAP y monta el home de los usuarios con autofs

Utiliza el gestor de tareas **Slurm** y **modules environment**

Vamos a crear el compute-0-3 utilizando ansible, para ello crea un rol llamado ``cluster_tunombre``

.. code-block:: bash

 ansible-galaxy init --offline cluster-tunombre

 # tree cluster_tunombre/
 cluster_tunombre/
 ├── defaults
 │   └── main.yml
 ├── files
 ├── handlers
 │   └── main.yml
 ├── meta
 │   └── main.yml
 ├── README.md
 ├── tasks
 │   └── main.yml
 ├── templates
 │   ├── auto.home.j2
 |   ├── auto.master.j2
 │   ├── ldap.conf.j2
 │   └── nsswitch.conf.j2
 ├── tests
 │   ├── inventory
 │   └── test.yml
 └── vars
     └── main.yml

En el archivo ``cluster-tunombre/tasks/main.yml`` tenemos:

.. code-block:: bash

 # tasks file for cluster-tunombre (Versión Moderna con libnss-ldapd)
 
 - name: Instalar paquetes cliente LDAP modernos
   apt:
     name:
       - libnss-ldap       # Para NSS (getent passwd, grupos)
       - libpam-ldap       # Para PAM (autenticación)
       - ldap-utils         # Utilidades como ldapsearch
     state: present
     update_cache: yes
 
 - name: Configurar ldap.conf
   template:
     src: ldap.conf.j2
     dest: /etc/ldap.conf
     owner: root
     group: root
     mode: '0644'
     backup: yes

 - name: Configurar NSS para usar LDAP
   template:
     src: nsswitch.conf.j2
     dest: /etc/nsswitch.conf
     owner: root
     group: root
     mode: '0644'
     backup: yes 
 
 - name: Inserta linea si no existe
   lineinfile:
     path: /etc/hosts
     line: "172.16.0.10 compute-0-0 ldap.tunombre.local"
     state: present

 - name: Instalar paquete nfs-common
   apt:
     name: nfs-common
     state: present
     update_cache: yes

 - name: Instalar autofs
   apt:
     name: autofs
     state: present
     update_cache: yes 

 - name: Configurar auto.master
   template:
     src: auto.master.j2
     dest: /etc/auto.master
     owner: root
     group: root
     mode: '0644'
     backup: yes 

 - name: Configurar auto.home
   template:
     src: auto.home.j2
     dest: /etc/auto.home
     owner: root
     group: root
     mode: '0644'
     backup: yes 

 - name: Iniciar y habilitar autofs
   systemd:
     name: autofs
     state: started
     enabled: yes 

Para aplicar el rol podemos usar ``aplicar_cliente_ldap.yml``

.. code-block:: bash

 - name: Configurar clientes LDAP
   hosts: cliente3
   become: yes
   tasks:
     - name: Importar todas las tareas del rol
       import_role:
         name: cluster-tunombre

con el siguiente inventario ``/etc/ansible/hosts``

.. code-block:: bash

 [servidor]
 server0 ansible_host=172.16.0.10 
 
 [clientes]
 cliente1 ansible_host=172.16.0.11
 cliente2 ansible_host=172.16.0.12
 cliente3 ansible_host=172.16.0.13

 [all:vars]

Podemos ejecutar el playbook de la siguiente manera

.. code-block:: bash

 # Verificar sintaxis
 ansible-playbook --syntax-check aplicar_cliente_ldap.yml

 # Ejecutar en modo prueba
 ansible-playbook --limit cliente3 --check --diff aplicar_cliente_ldap.yml

 # Podemos listar los hosts 
 ansible-playbook aplicar_cliente_ldap.yml --list-hosts

 # Aplicar configuración solo sobre uno
 ansible-playbook --limit cliente3 aplicar_cliente_ldap.yml


Docker + ansible
****************

Vamos a empezar creando la imagen desde el siguiente ``Dockerfile``

.. code-block:: bash

 FROM ubuntu:26.04
 
 RUN apt update && apt install -y \
     iproute2 \
     iputils-ping \
     net-tools \
     openssh-server \
     vim \
     sudo \
  && mkdir -p /run/sshd \
  && echo 'root:alumno' | chpasswd \
  && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

 CMD service ssh start && sleep infinity

Hacemos las imágenes (si hace falta) y levantamos los contenedores en segundo plano ``docker compose up -d --build``.

Utilizaremos el siguiente ``docker-compose.yml`` que define un mini clúster de 3 contenedores que simulan máquinas de un clúster

.. code-block:: bash

 services:
   compute-0-0:
     build: .
     container_name: compute-0-0
     privileged: true
     tty: true
     hostname: compute-0-0
     networks:
       internal_net:
         ipv4_address: 172.16.0.10   

   compute-0-1:
     build: .
     container_name: compute-0-1
     privileged: true
     tty: true
     hostname: compute-0-1
     networks:
       internal_net:
         ipv4_address: 172.16.0.11

   compute-0-2:
     build: .
     container_name: compute-0-2
     privileged: true
     tty: true
     hostname: compute-0-2
     networks:
       internal_net:
         ipv4_address: 172.16.0.12

 networks:
   internal_net:
     driver: bridge
     ipam:
       config:
         - subnet: 172.16.0.0/16
           gateway: 172.16.0.1  

Podemos levantar el cluster ``docker compose up -d --build`` y conectarnos con ``docker exec -it --user root compute-0-0 bash``

Instalamos ansible en compute-0-0 y exportamos la clave publica a todos los nodos. 

Descarga el rol dgtrabada.ansible desde Ansible Galaxy, entramos en su directorio de pruebas y ejecutamos el playbook sobre el inventario cluster.yml para aplicar la automatización en los hosts definidos.

.. code-block:: bash

 ansible-galaxy role install dgtrabada.ansible
 cd ~/.ansible/roles/dgtrabada.ansible/tests
 ansible-playbook -i inventory cluster.yml

Chequeamos el servidor ``ldapsearch -xLLL -b "dc=ldap,dc=tunombre,dc=local"``, y creamos la esctructura y los usuarios con el siguiente comando, **cambia en test.ldif tunombre por tu nombre**

.. code-block:: bash

 ldapadd -x -D "cn=admin,dc=ldap,dc=tunombre,dc=local" -W -f test.ldif


Videos
******
* `Ansible LDAP autofs en Ubuntu 24.04 LTS <https://mediateca.educa.madrid.org/video/m8p67seyxyz16zrk>`_
* `Ansible en Ubuntu 22.04 LTS <https://mediateca.educa.madrid.org/video/5hh37p3a38n692o8>`_

