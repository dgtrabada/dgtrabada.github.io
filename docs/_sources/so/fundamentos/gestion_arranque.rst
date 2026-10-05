********************
Gestión del arranque
********************


Un gestor de arranque, como su nombre indica, es un programa que se carga al inicio del ordenador, antes del sistema operativo, y que nos permite elegir el sistema operativo que queremos cargar.

Estos programas pueden leer automáticamente las particiones del ordenador para detectar y configurar los sistemas instalados, permiten crear nuestras propias entradas (útil en el caso de Linux, por ejemplo, para cargar el sistema con parámetros o un kernel específico) y pueden contar con medidas de seguridad adicionales, como, por ejemplo, protección mediante contraseña.

Los principales sistemas operativos cuentan con sus propios gestores de arranque. Y además, nosotros mismos podemos instalar otras alternativas manualmente para hacer uso del arranque dual, o dual boot, en nuestro ordenador.

Cómo arranca un ordenador
=========================

Cuando encendemos el ordenador, el sistema operativo todavía no está cargado en memoria. El arranque sigue estos pasos:

#. **Firmware (BIOS o UEFI)**: es el programa que viene grabado en la placa base y es lo primero que se ejecuta.
#. **POST** (*Power-On Self-Test*): el firmware comprueba que el hardware básico (memoria, procesador, teclado, discos...) funciona.
#. **Búsqueda del gestor de arranque**: el firmware busca, según el orden de arranque configurado, un disco o USB desde el que arrancar y carga su gestor de arranque.
#. **Gestor de arranque**: muestra el menú (si hay varios sistemas) y carga el núcleo (*kernel*) del sistema operativo elegido.
#. **Sistema operativo**: el núcleo toma el control e inicia el resto del sistema.

Dónde se guarda el gestor de arranque depende del tipo de firmware y de la tabla de particiones del disco:

+---------------------------+-----------------------------------+-------------------------------------------+
|                           | **BIOS + MBR** (equipos antiguos) | **UEFI + GPT** (lo habitual hoy)          |
+===========================+===================================+===========================================+
| Dónde está el gestor      | En los primeros 512 bytes del     | Es un archivo ``.efi`` dentro de la       |
| de arranque               | disco (el MBR, *Master Boot       | **partición del sistema EFI (ESP)**,      |
|                           | Record*)                          | formateada en FAT32                       |
+---------------------------+-----------------------------------+-------------------------------------------+
| Particiones               | Máximo 4 primarias                | Hasta 128                                 |
+---------------------------+-----------------------------------+-------------------------------------------+
| Tamaño máximo del disco   | 2 TB                              | Prácticamente ilimitado                   |
+---------------------------+-----------------------------------+-------------------------------------------+

En los equipos UEFI cada sistema operativo deja su gestor de arranque en la partición ESP (en Linux se monta en ``/boot/efi``), y el propio firmware sabe cuáles hay instalados.

Además, al encender el equipo podemos pulsar una tecla (**F12**, **F8**, **F11** o **Esc**, según el fabricante) para abrir el **menú de arranque del firmware** y elegir desde qué disco o USB queremos arrancar, por ejemplo para instalar un sistema operativo desde un USB.

Gestor de arranque de Windows
=============================

Cuando instalamos Windows, durante el proceso de instalación se crean una serie de particiones con ficheros críticos del sistema operativo. Una de estas particiones creadas contiene las opciones de recuperación del sistema y toda la información del arranque. También se encuentra en ella el gestor de arranque de Windows.

Si solo tenemos un sistema operativo instalado en el ordenador, este gestor de arranque no nos aparecerá. Si instalamos otro Windows, el asistente lo detecta y añade una entrada al gestor, que nos aparecerá cuando vayamos a arrancar el PC. En cambio, **el gestor de Windows no detecta Linux**: para arrancar Linux usaremos GRUB o tendremos que añadir la entrada a mano (por ejemplo, con EasyBCD).

Este gestor de arranque se instala automáticamente junto al sistema operativo, por lo que generalmente no tenemos que hacer nada. En un arranque dual con Linux conviene **instalar primero Windows y Linux al final**: si instalamos Windows después, sobrescribe el arranque y el menú de GRUB desaparece (veremos cómo recuperarlo más adelante).

Además, desde Panel de control > Sistema > Configuración avanzada del sistema > Inicio y recuperación podremos configurar el comportamiento de este gestor de arranque, como el tiempo de espera o el sistema operativo predeterminado.

.. image:: imagenes/gestor_arranque_windows.png

Y si queremos una forma más rápida y sencilla de editar el BCD de Windows, el programa EasyBCD nos permite configurar el gestor de arranque de Windows, añadir o quitar sistemas operativos y mejorarlo para poder usarlo más cómodamente.

.. image:: imagenes/easyBCD.png

También podemos ver y editar el BCD desde la línea de comandos con ``bcdedit``:

.. code-block:: shell

 bcdedit                # muestra las entradas del arranque
 bcdedit /timeout 5     # segundos de espera del menú
 bcdedit /default {ID}  # sistema operativo por defecto

Si el arranque de Windows se estropea (por ejemplo, al borrar la partición de Linux), podemos repararlo arrancando desde un USB de instalación de Windows, en Reparar el equipo > Símbolo del sistema. En un equipo con BIOS y disco MBR:

.. code-block:: shell

 bootrec /fixmbr       # repara el MBR
 bootrec /fixboot      # repara el sector de arranque
 bootrec /rebuildbcd   # busca los Windows instalados y regenera el BCD

En los equipos UEFI actuales no hay MBR, así que ``bootrec /fixmbr`` no sirve. Lo que hacemos es volver a copiar los archivos de arranque de Windows en la partición ESP:

.. code-block:: shell

 bcdboot C:\Windows   # copia los archivos de arranque de Windows a la partición ESP y crea el BCD

Gestores de arranque de Linux
=============================

Linux, igual que Windows, tiene también su propio gestor de arranque. Sus archivos (configuración, núcleos, etc.) se guardan en el punto de montaje /boot; en los equipos UEFI, además, el archivo ``.efi`` del gestor va en la partición ESP, montada en /boot/efi.

Hoy el gestor de arranque más utilizado en las distribuciones es **GRUB** (*GRand Unified Bootloader*). Mientras que el gestor de arranque de Windows no detecta las particiones Linux, GRUB detecta tanto Linux como Windows y es mucho más completo y personalizable.

.. image:: imagenes/grub.png

La forma ideal de instalar este gestor de arranque es instalar todos los demás sistemas operativos que vayamos a utilizar, y el Linux que queramos que controle todo lo demás el último. De esta manera, cuando se instale y configure GRUB, se detectarán todos los sistemas instalados y se añadirán a la lista.

De todas formas, si en cualquier momento instalamos un nuevo sistema operativo (da igual que sea Windows o Linux), y queremos volver a generar el gestor de arranque, tan solo debemos ir a la distro Linux y ejecutar el siguiente comando para regenerar la configuración con los nuevos sistemas:

.. code-block:: bash

 sudo update-grub    # en algunas distribuciones también existe el alias update-grub2

La configuración de GRUB se encuentra en el fichero /etc/default/grub, donde podemos cambiar, entre otras cosas, la entrada por defecto y el tiempo de espera del menú:

.. code-block:: bash

 GRUB_DEFAULT=0    # entrada del menú que arranca por defecto
 GRUB_TIMEOUT=5    # segundos de espera

Después de modificarlo hay que ejecutar ``sudo update-grub`` para regenerar la configuración.

Si GRUB desaparece (por ejemplo, después de reinstalar Windows, que sobrescribe el arranque), podemos recuperarlo arrancando con un live USB de Linux y reinstalándolo con ``grub-install``, o con la herramienta gráfica Boot-Repair, que automatiza todo el proceso.

En caso de que tengamos solo Windows y queramos usar este gestor de arranque, vamos a poder usar el software Grub2Win para instalar fácilmente este gestor desde Windows.

Además, este programa cuenta con una sencilla interfaz gráfica que nos va a permitir configurar y personalizar la apariencia de GRUB, pudiendo tener todos los sistemas operativos que queramos para elegir cuál arrancar en cada boot.

Problemas típicos del arranque dual
===================================

* **Secure Boot**: es una medida de seguridad del firmware que solo permite arrancar gestores firmados digitalmente. Las distribuciones grandes (Ubuntu, Fedora...) están firmadas y arrancan sin problema, pero con otras puede ser necesario desactivarlo en la configuración del equipo.

* **Inicio rápido de Windows**: cuando está activado, Windows no se apaga del todo (hiberna parte del sistema) y deja sus particiones bloqueadas, por lo que desde Linux no podremos montarlas. Se desactiva en Panel de control > Opciones de energía > Elegir el comportamiento de los botones de inicio/apagado.

Otras alternativas
==================

Además de GRUB existen otros gestores de arranque, como **systemd-boot** (utilizado por ejemplo por Pop!_OS), más sencillo y pensado para equipos UEFI, o **rEFInd**, con una interfaz gráfica muy personalizable.

.. toctree::
   :hidden:

   cuestionario_gestion_arranque.rst