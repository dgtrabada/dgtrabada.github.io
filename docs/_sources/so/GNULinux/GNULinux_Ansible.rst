*******
Ansible
*******

El **nodo de control**, es la máquina que tiene instalado Ansible. Desde ella administraremos el resto de nodos.

El **Inventario** es el archivo host para Ansible. En él se incluye información, estática o dinámica, de los nodos administrados y su información. Datos como IP o nombre.

Los **Módulos**, como en otros lenguajes, serían las librerías que ejecuta Ansible.

Los **Playbooks** se encargan de definir todas las tareas que debemos realizar sobre un conjunto de nodos administrador.

Los **Roles** es una agrupación de ficheros, tareas y plantillas

Una **Task** se podría definir como una acción a realizar.

Instalamos ansible

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
************************

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

 ansible server1:server2 -m ping -u root

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

 ansible-playbook -l server1 myplaybook.yml
 
Para cambiar el grupo de hosts por defecto.

.. code-block:: bash

 ansible-playbook sampleplaybook.yml -i ansible_hosts 
 
 
Roles
*****

Cuando se crea un rol, se descompone el playbook en partes y esas partes se encuentran en una estructura de directorios.

Vamos a ver un ejemplo utilizando el comando

.. code-block:: bash

 ansible-galaxy init --offline cluster-ubuntu22.04

Como podemos ver se han creado los siguientes directorios:

.. code-block:: bash

 root@compute-0-0:~# tree cluster-ubuntu22.04/
 cluster-ubuntu22.04/
 ├── defaults
 │   └── main.yml
 ├── handlers
 │   └── main.yml
 ├── meta
 │   └── main.yml
 ├── README.md
 ├── tasks
 │   └── main.yml
 ├── tests
 │   ├── inventory
 │   └── test.yml
 └── vars
     └── main.yml

 6 directories, 8 files

Los diversos archivos main.yml contienen contenido dependiendo de su ubicación en la estructura de directorios que se muestra arriba. Por ejemplo, vars/main.yml hace referencia a variables, handlers/main.yaml describe controladores, y así sucesivamente.

Las variables se pueden establecer en vars/main.yml o defaults/main.yml, pero no en ambos lugares.

Para programar los roles podemos utilizar un control de versiones como es el git, además podemos publicarlo y luego indexarlo desde   https://galaxy.ansible.com/, para su posterior instalación.