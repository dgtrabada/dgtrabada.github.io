****************
Instalación odoo 
****************

Ejercicio instalación de odoo
------------------------------

* Cuando termines responde la siguiente pregunta en el curso:

  * Master Password :
  * Database Name :
  * Email :
  * Password :
  

Instalación en Windows (docker):
---------------------------------
* Descarga el archivo `docker-compose.yml <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/master/source/odoo/imagenes/docker-compose.yml>`_ 
* crea las carpetas correspondientes **odooodoo-web-data, config, addons**
* ejecuta el comando : **docker-compose up -d**

Comandos útiles:
----------------
* docker images                           # ver las imagenes
* docker rmi <REPOSITORY>
* docker ps                               # ver contendores que estan ejecutandose
* docker ps -a                            # ver todos los contenedores
* docker rm <CONTAINER ID>
* docker start/stop container


  
Instalación en XUbuntu 24.04:
-----------------------------

Pon un adaptador en modo puente con la ip:10.2.X.Y
usuario : tunombre
contraseña: alumno

sudo apt install python3-dev python3-pip python3-venv \
python3-wheel libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev \
libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev \
libjpeg-dev libpq-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev
Copia de seguridad utilizando docker:

~/odoo$ docker ps
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
7e9e3ea5f34b odoo:14.0 "/entrypoint.sh odoo" 8 minutes ago Up 8 minutes 0.0.0.0:8069->8069/tcp, :::8069->8069/tcp, 8071-8072/tcp odoo_web_1
9a7c5275eaeb postgres:13 "docker-entrypoint.s..." 8 minutes ago Up 8 minutes 5432/tcp

~/odoo$ docker stop 7e9e3ea5f34b 9a7c5275eaeb
~/odoo$ docker commit -p 7e9e3ea5f34b odoo:14.0.1
~/odoo$ docker commit -p 9a7c5275eae postgres:13.0.1

~/odoo$ docker images
REPOSITORY TAG IMAGE ID CREATED SIZE
postgres 13.0.1 17da5ee4dee6 4 seconds ago 371MB
odoo 14.0.1 c600a648fd0e 29 seconds ago 1.46GB
odoo 14.0 89152df6e5b4 8 days ago 1.46GB
postgres 13 0896a8e0282d 2 weeks ago 371MB

docker ps -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
7e9e3ea5f34b odoo:14.0 "/entrypoint.sh odoo" 19 minutes ago Exited (0) 10 minutes ago odoo_web_1
9a7c5275eaeb postgres:13 "docker-entrypoint.s..." 19 minutes ago Exited (0) 10 minutes ago odoo_db_1
dani@fireball:~/odoo$ docker rm 7e9e3ea5f34b 9a7c5275eaeb

actualizamos docker-compose.yml
image: odoo:14.0.1
postgres:13.0.1

docker-compose up

en el caso
docker images
docker save -o ~/container-postgres-backup.tar container-postgres-backup
docker save -o ~/container-odoo-backup.tar container-odoo-backup
sudo docker load -i container-postgres-backup.tar
sudo docker load -i container-odoo-backup.tar

sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db container-postgres-backup
sudo docker run -p 8069:8069 --name odoo --link db:db -t container-odoo-backup

sudo docker start db
nohup sudo docker start -a odoo &

#limpieza
docker rm $(docker ps -a -q)