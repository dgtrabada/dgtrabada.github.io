************************************
Cuestionario instalaciones
************************************

.. cuestionario::

   1. Distribuciones y familias:
      - 1. ¿En qué distribución se basa Linux Mint?
        ( ) Debian
        (x) Ubuntu
        ( ) Fedora
        ( ) Arch Linux
      - 2. ¿En qué distribución se basa MX Linux?
        (x) Debian estable
        ( ) Ubuntu
        ( ) openSUSE
        ( ) Es independiente
      - 3. ¿Cuál es la relación entre Fedora y Red Hat Enterprise Linux (RHEL)?
        ( ) Fedora es la versión de pago de RHEL
        (x) Las novedades aparecen primero en Fedora, pasan a CentOS Stream y después llegan a RHEL
        ( ) RHEL se basa en Ubuntu y Fedora en Debian
        ( ) No tienen ninguna relación
      - 4. ¿Qué distribuciones de los ejercicios usan paquetes RPM?
        ( ) Ubuntu y Linux Mint
        ( ) MX Linux y Fedora
        (x) Fedora y openSUSE
        ( ) Todas
      - 5. ¿Qué gestor de paquetes usa openSUSE desde la línea de comandos?
        = zypper

   2. Versiones:
      - 1. ¿Qué significa el número de la versión 26.04 de Ubuntu?
        ( ) Que es la versión 26 con 4 actualizaciones
        (x) Que salió en abril (mes 04) de 2026
        ( ) Que tiene 26 meses de soporte
        ( ) Que es la cuarta versión del año 2026
      - 2. ¿Cada cuánto sale una versión LTS de Ubuntu?
        ( ) Cada 6 meses
        ( ) Cada año
        (x) Cada dos años, en abril de los años pares
        ( ) Cada cinco años
      - 3. ¿Qué es la 26.04.1?
        ( ) Una versión nueva con otro núcleo y otro escritorio
        (x) La misma versión, con la ISO regenerada con las actualizaciones acumuladas
        ( ) Una versión de prueba que sale antes de la 26.04
        ( ) La versión para servidores
      - 4. ¿Qué es una distribución rolling release, como openSUSE Tumbleweed?
        ( ) Una distribución que solo funciona en modo live
        ( ) Una distribución que saca una versión nueva cada dos años
        (x) Una distribución sin versiones, que se va actualizando siempre a lo último
        ( ) Una distribución que se reinstala en cada actualización

   3. Instalación y particiones:
      - 1. En VirtualBox creamos un disco de 400 GB y el instalador de Ubuntu dice que tiene 429,50 GB. ¿Por qué?
        ( ) Porque VirtualBox añade espacio extra para el sistema
        (x) Porque VirtualBox cuenta en GiB (2^{30} bytes) y el instalador en GB (10^{9} bytes)
        ( ) Porque el disco es dinámico y crece al instalar
        ( ) Porque el instalador cuenta también la partición swap
      - 2. Al instalar Ubuntu con BIOS y una tabla de particiones GPT, aparece una partición de 1 MB que no hemos creado. ¿Qué es?
        ( ) La partición del sistema EFI
        ( ) Una partición de recuperación
        (x) Una partición bios_grub, donde GRUB guarda parte de su código
        ( ) Un error del instalador que hay que borrar
      - 3. ¿Qué tienes que hacer en VirtualBox cuando termina la instalación para no volver a arrancar el instalador?
        ( ) Desactivar EFI
        (x) Quitar la ISO de la unidad óptica
        ( ) Cambiar la red a NAT
        ( ) Borrar el disco duro virtual

   4. El área de intercambio (swap):
      - 1. ¿Qué tipo de swap crea Ubuntu por defecto?
        ( ) Una partición swap
        (x) Un archivo de intercambio, /swap.img
        ( ) zram
        ( ) No usa swap
      - 2. ¿Qué tipo de swap usa Fedora por defecto?
        ( ) Una partición swap
        ( ) Un archivo de intercambio
        (x) zram, un disco comprimido dentro de la RAM
        ( ) No usa swap
      - 3. ¿Qué ventaja tiene un archivo de intercambio frente a una partición?
        (x) Se puede agrandar, encoger o quitar sin tocar las particiones del disco
        ( ) Es mucho más rápido que la RAM
        ( ) No ocupa espacio en el disco
        ( ) Solo lo puede usar el administrador
      - 4. ¿Qué comando muestra qué swap está usando el sistema y de qué tipo es?
        = swapon --show

   5. Gestión de paquetes y usuarios:
      - 1. ¿Qué hace sudo apt update?
        ( ) Instala las versiones nuevas de todos los programas
        (x) Descarga la lista de paquetes disponibles en los repositorios, sin instalar nada
        ( ) Actualiza el sistema a la siguiente versión de Ubuntu
        ( ) Borra los paquetes que no se usan
      - 2. ¿Qué hace sudo apt upgrade?
        ( ) Descarga la lista de paquetes de los repositorios
        (x) Instala las versiones nuevas de los programas que ya tienes
        ( ) Cambia los repositorios del sistema
        ( ) Instala un programa nuevo
      - 3. ¿Qué comando muestra los paquetes que se pueden actualizar en Ubuntu?
        = apt list --upgradable
      - 4. Un usuario estándar (sin permisos de administrador) intenta instalar un programa con sudo. ¿Qué pasa?
        ( ) Se instala igual que con un administrador
        ( ) Se instala solo para ese usuario
        (x) El sistema le dice que no está en el archivo sudoers y no se instala
        ( ) Se le pide la contraseña del administrador y se instala
      - 5. ¿Qué comando muestra los grupos a los que pertenece el usuario?
        = groups

   6. Máquinas virtuales y DistroWatch:
      - 1. ¿Qué es un archivo OVA?
        ( ) Un disco duro virtual vacío
        (x) Una máquina virtual exportada en un solo archivo, que se puede importar en otro equipo
        ( ) La ISO de instalación de una distribución
        ( ) Una instantánea de la máquina virtual
      - 2. ¿Qué tiene de particular una clonación enlazada?
        ( ) Copia el disco entero, así que ocupa lo mismo que la original
        (x) Comparte el disco con la máquina original y solo guarda los cambios, así que ocupa poco
        ( ) Solo funciona si la máquina original está encendida
        ( ) Se puede usar en otro ordenador sin la original
      - 3. ¿Qué mide la clasificación de DistroWatch (Page Hit Ranking)?
        ( ) El número de usuarios de cada distribución
        ( ) El número de descargas de cada ISO
        (x) Las visitas a la página de cada distribución en DistroWatch
        ( ) La valoración de los usuarios
