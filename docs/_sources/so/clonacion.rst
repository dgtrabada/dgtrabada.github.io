*********
Clonación
*********


La clonación de sistemas operativos es el proceso de crear una copia exacta de un sistema operativo, incluyendo todos sus archivos, configuraciones, aplicaciones y datos.

Caso práctico: Clonación con DRBL
=================================

Puedes ver la configuración en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/6dr12pgqtozm9hd6>`_


DRBL (Diskless Remote Boot in Linux) es un sistema de software que permite a las computadoras arrancar y operar sin un disco duro local, utilizando en su lugar una red para obtener el sistema operativo y los datos necesarios. DRBL incluye Clonezilla, una herramienta de clonación de discos y particiones. Clonezilla puede usarse para clonar discos y particiones de manera eficiente en múltiples computadoras simultáneamente, lo que es útil para despliegues masivos.

Primero instalamos un sistema ligero, para este caso instalremos la versión minima de Xubuntu (xubuntu-24.04-minimal-amd64.iso ). Xubuntu es una variante oficial de Ubuntu que utiliza el entorno de escritorio XFCE, conocido por ser ligero y adecuado para sistemas con recursos limitados.

Utiliza 2GB de RAM con un disco duro de 50GB y haz que el usuario se llame **XUbuntu 24.04**

Vamos a crear otra maquina virtual con 2GB de RAM con un disco duro de 50GB y llamada **SERVER**, la iniciaremos con el disco de drbl-live-xfce, primero instalaremos y confiraremos un servidor de ssh, y montaremos el disco duro en /home/partimages

La primera parte sera crear una imagen de la maquina "Ubuntu 24.04" en el SERVER:/home/partimag, para ello iniciaremos "XUbuntu 24.04" con la iso de drbl-live-xfce e iniciamos el clonecilla, haciendo que cree una imagen del discoduro entero. Para ello seleccionamos la siguiente opción de Clonezilla live

* device-image work-with disks or partititios using images

* ssh_server Use SSH server

* Beginner

* savedisk

Creamos una nueva maquina virtual llamada "XUbuntu 01", con disco duro de 50GB y red interna, la iniciamos con drbl-live-xfce y restauramos la imágen que hemos creado. Para ello seleccionamos las mismas opciones  de Clonezilla live, cambiando savedisk por restoredisk


En la segunda parte, clonaremos varias maquinas al mismo tiempo, para ello iniciaremos el Clonezilla server, lo configuraremos para que restaure tres equipos y restaure la imágen que hemos creado antes.

Por otro lado crearemos tres maquinas virtuales más, con 50GB de disco duro y con red interna, las iniciaremos con drbl-live con la opción Network boot via iPXE, para que se inicie la clonación

