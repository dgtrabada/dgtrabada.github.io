****************************
Ejercicios de configuración
****************************

Estos ejercicios se hacen sobre la máquina virtual de Windows 11. En cada pantallazo tiene que aparecer **tunombre**.

Ejercicio 1: Información del sistema
====================================

**Información del sistema**

Responde a las siguientes preguntas:

* **1.1** Instala VLC y Firefox desde Microsoft Store y ánclalos a la barra de tareas. ¿Cómo lo has hecho?
* **1.2** Entra en Inicio / Configuración / Sistema / Almacenamiento. ¿Cuántos GB están usados y cuántos están libres?
* **1.3** Entra en Panel de control / Sistema. ¿Cuánta RAM tiene?
* **1.4** ¿Cuál es la arquitectura del sistema operativo, x64 o x86 (es decir, 64 bits o 32 bits)?

**Rendimiento de Windows**

Consulta el apartado :ref:`Administrador de tareas` y sube:

* El **pantallazo**\ :sup:`1`, con el rendimiento de tu CPU.
* El **pantallazo**\ :sup:`2`, con los procesos que se están ejecutando, con el botón **Finalizar tarea** a la vista.
* El **pantallazo**\ :sup:`3`, con el Monitor de recursos.

**Hardware y software**

* **1.5** Abre la información del sistema con el comando ``msinfo32`` y escribe:

  * El procesador.
  * La versión y fecha de la BIOS.
  * La memoria física total.

* **1.6** Abre la herramienta de diagnóstico de DirectX con el comando ``dxdiag``. Si te pregunta si quieres comprobar las firmas de los controladores, pulsa **No**. Esta herramienta informa de los componentes y controladores de DirectX instalados. ¿Qué versión de DirectX está instalada?

**CPU-Z**

`CPU-Z <https://www.cpuid.com/softwares/cpu-z.html>`__ es una aplicación gratuita para Windows que muestra información del procesador, la memoria y la placa base: nombre, número y nombre en clave del procesador, etc.

Descárgala, haz un **Bench CPU** y sube el **pantallazo**\ :sup:`4`, como este:

.. image:: imagenes/conf2_cpuz.jpg

**WinDirStat**

WinDirStat (https://windirstat.net/) analiza qué es lo que más ocupa en las unidades de disco. Descárgalo, analiza el disco duro y responde:

* **1.7** ¿Bajo qué licencia está publicado?
* **1.8** ¿Existe una versión para Linux y macOS?
* **1.9** ¿Cuál es el archivo más grande que ha encontrado?

Ejercicio 2: Escritorio y explorador
====================================

**Acceso directo en el escritorio**

* Crea un acceso directo a la calculadora en el escritorio. La calculadora se abre con el comando ``calc.exe``.
* Sube el **pantallazo**\ :sup:`1`.

**Opciones de Windows**

* **2.1** Cambia el protector de pantalla y configúralo para que el monitor se apague a los 15 minutos y los discos duros no se apaguen nunca. ¿Cómo lo has hecho?
* **2.2** ¿Cómo consigues que se vean los archivos ocultos?
* **2.3** ¿Qué pasos sigues para comprimir una carpeta que está en el escritorio?

**Búsquedas**

Consulta el apartado :ref:`Explorador de Windows` y responde:

* **2.4** Busca todos los archivos de C: que empiecen por **no** y acaben por **exe**. ¿Cómo lo has hecho?
* **2.5** ¿Cómo buscarías todos los ficheros de ``C:\Windows`` (incluidas las subcarpetas) que empiecen por **M**, con cualquier extensión?
* **2.6** ¿Cómo buscarías todos los ficheros creados hace un mes?
* **2.7** ¿Cómo buscarías todos los ficheros de ``C:\Windows`` (incluidas las subcarpetas) que contengan la palabra **Multimedia**?
* **2.8** ¿Cómo buscarías todos los ficheros creados entre el 1 de enero de 1999 y hoy que contengan la palabra **Screen**?
* **2.9** ¿Cómo buscarías todos los ficheros con un tamaño máximo de 300 KB?

**La papelera**

* Crea la carpeta A01 en el escritorio con la siguiente estructura:

  .. image:: imagenes/conf2_carpeta_A01.png

* Selecciónala con el ratón y pulsa **Supr**.
* Abre la papelera y restáurala. **2.10** ¿Cuánto espacio disponible tiene la papelera?
* Vuelve a seleccionar la carpeta A01 en el escritorio y pulsa **Mayús + Supr**. **2.11** ¿Puedes volver a restaurarla?

Ejercicio 3: Equipo, usuarios y red
===================================

**Cambiar el nombre del equipo**

* Abre una terminal (Inicio / Ejecutar / ``cmd``) y ejecuta el comando ``hostname``.
* Cambia el nombre del equipo por **PC-tuapellido1**:

  * Panel de control / Sistema y seguridad / Sistema
  * Nombre de equipo / Cambiar el nombre de este equipo

* Reinicia el equipo y vuelve a ejecutar ``hostname``.

Sube el **pantallazo**\ :sup:`1`, en el que se vea el cambio con el comando ``hostname``.

**Cuenta local de administrador**

Crea una cuenta local con tu apellido:

* Inicio / Configuración / Cuentas / Familia y otros usuarios.
* «No tengo los datos de inicio de sesión de esta persona».
* «Agregar un usuario sin cuenta Microsoft».
* Escribe como nombre de usuario **tuapellido**, una contraseña y las preguntas de seguridad, y pulsa Siguiente.

Ahora cambia la cuenta a administrador:

* En Configuración / Cuentas / Familia y otros usuarios, selecciona la cuenta y pulsa **Cambiar el tipo de cuenta**.
* En Tipo de cuenta, selecciona **Administrador** y Aceptar.

  .. image:: imagenes/conf1_cuenta_admin.jpg

* Inicia sesión con la nueva cuenta y sube el **pantallazo**\ :sup:`2`, en el que se vea que es administrador.

**Dirección IPv4 estática**

Pon la máquina virtual en **adaptador puente** y configura en Windows:

* Dirección IP: 10.4.X.Y/8 (máscara 255.0.0.0)
* Puerta de enlace: 10.0.0.2
* DNS: 8.8.8.8

Si usas un portátil, déjalo en DHCP.

Sube el **pantallazo**\ :sup:`3`, como este:

.. image:: imagenes/conf1_ip_estatica.jpg

**Escritorio remoto**

Conéctate a Windows por escritorio remoto. Antes tienes que habilitarlo en Configuración / Sistema / Escritorio remoto.

* Si te conectas desde Linux:

  .. image:: imagenes/conf2_rdp_linux.png

* Si te conectas desde Windows:

  .. image:: imagenes/conf2_rdp_windows.png

* Sube el **pantallazo**\ :sup:`4`, en el que se vea que te has conectado, ejecutando ``ipconfig`` y ``query session``:

  .. image:: imagenes/conf2_query_session.png

* **Ayuda**: para que los dos equipos estén en la misma red, usa la IP estática del apartado anterior en adaptador puente (con un portátil, usa DHCP):

  .. image:: imagenes/conf2_ip_puente.png

  Este sería el caso de que la IP de tu equipo fuese:

  .. image:: imagenes/conf2_ip_ejemplo.png

  Es decir, **10.4.X.Y**, siendo **X** e **Y** los números correspondientes a tu IP.

Ejercicio 4: Discos y copias de seguridad
=========================================

**Disco duro nuevo**

* Con la máquina de Windows 11 apagada, en Configuración / Almacenamiento añade un disco nuevo de 50 GB reservado dinámicamente.
* Selecciónalo y marca **Conectable en caliente**.
* Arranca Windows y busca en Inicio **Crear y formatear particiones del disco duro**.
* Dale formato NTFS, con la etiqueta «tunombre tuapellido1», y móntalo en la unidad **E:**. Sube el **pantallazo**\ :sup:`1`, como este:

  .. image:: imagenes/conf2_disco_E.png

**Historial de archivos**

Vamos a hacer una copia de seguridad con el **Historial de archivos** (escribe «Historial de archivos» en el menú Inicio).

* Activa el Historial de archivos:

  .. image:: imagenes/conf2_historial1.png

* Selecciona la unidad E: que has creado en el apartado anterior:

  .. image:: imagenes/conf2_historial2.png

* Ejecuta ahora la copia de seguridad:

  .. image:: imagenes/conf2_historial3.png

* Cuando termine, borra de forma permanente algunos archivos del escritorio y pulsa **Restaurar archivos personales**:

  .. image:: imagenes/conf2_restaurar1.png

Sube el **pantallazo**\ :sup:`2`, del proceso de restauración, como estos:

.. image:: imagenes/conf2_restaurar2.png

.. image:: imagenes/conf2_restaurar3.png

**Copia de seguridad de los controladores**

Con la herramienta DISM puedes exportar a una carpeta los controladores instalados. Si reinstalas Windows, puedes volver a instalarlos desde esa carpeta (en otra partición, un USB o un disco externo) sin programas de terceros.

#. Instala el controlador de una impresora (la que quieras).
#. Abre el Símbolo del sistema como administrador.
#. Ejecuta:

   .. code-block:: bat

      dism /online /export-driver /destination:e:\Controladores

#. Sube el **pantallazo**\ :sup:`3`, en el que se vea la carpeta ``E:\Controladores``, por ejemplo:

   .. image:: imagenes/conf2_controladores.png

.. note::

   DISM solo exporta los controladores de terceros, no los de Microsoft. VirtualBox usa controladores genéricos de Microsoft, por eso, si usas una máquina virtual, la carpeta puede quedar vacía.

Ejercicio 5: Recuperación y registro
====================================

**Punto de restauración**

Los puntos de restauración permiten devolver el sistema a una fecha anterior. Es útil si una actualización o un programa nuevo da problemas.

* En el cuadro de búsqueda de la barra de tareas, escribe **Crear un punto de restauración** y selecciónalo.
* Crea un punto de restauración con el nombre de la fecha actual + tunombre (la primera vez tendrás que activar la protección del sistema).
* Instala GIMP, descargándolo o desde Microsoft Store.
* Crea una carpeta en el escritorio con la fecha y hora actual y tu nombre de usuario.
* Restaura el punto de restauración que has creado (``rstrui.exe``).

Sube el **pantallazo**\ :sup:`1`, del punto de restauración como este:

.. image:: imagenes/conf2_punto_restauracion.png

Responde:

* **5.1** ¿Qué ha pasado con GIMP?
* **5.2** ¿Los puntos de restauración afectan a los archivos personales?

**Copia y modificación del registro**

Consulta el apartado :ref:`El registro de Windows` antes de empezar.

Haz una copia de seguridad del registro de forma manual:

#. En el menú Inicio, escribe ``regedit.exe`` y pulsa Intro. Si te pide contraseña de administrador o confirmación, dásela.
#. En el Editor del Registro, haz clic en la clave o subclave de la que quieras hacer la copia.
#. Haz clic en **Archivo / Exportar**.
#. Elige dónde guardar la copia y escribe un nombre en **Nombre de archivo**.
#. Haz clic en **Guardar**.

No hace falta que la restaures, pero si lo necesitaras:

#. Abre ``regedit.exe``.
#. Haz clic en **Archivo / Importar**.
#. Selecciona el archivo de la copia y haz clic en **Abrir**.

Ahora vamos a añadir un programa al menú contextual (el del botón derecho en el escritorio):

* Ve a la clave ``HKEY_CLASSES_ROOT\Directory\Background\shell``.
* Dentro de ``shell``, crea una clave nueva con el nombre del programa (por ejemplo, ``Notepad``) y, dentro de ella, otra clave llamada ``command``.
* La clave ``command`` tiene un valor **(Predeterminado)**. Haz doble clic sobre él y escribe, entre comillas, la ruta del ``.exe`` del programa:

  .. image:: imagenes/conf3_regedit_notepad.png

Elige una aplicación distinta de Notepad, crea su entrada en el menú contextual y sube el **pantallazo**\ :sup:`2`, como este:

.. image:: imagenes/conf3_menu_contextual.png

**Widgets y modo oscuro**

* Para quitar los widgets de noticias e intereses de Windows 11, entra en ``HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft`` y crea una clave llamada ``Dsh``. Dentro, crea un valor DWORD (32 bits) llamado ``AllowNewsAndInterests`` con el valor ``0``.
* Activa el modo oscuro: en ``HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize``, haz doble clic en ``AppsUseLightTheme`` y cambia el valor ``1`` por ``0``.
* Sube el **pantallazo**\ :sup:`3`, donde se vea el cambio y tunombre.

**Fondo de escritorio**

* Descarga dos imágenes relacionadas con la astronomía.
* Pon una de ellas como fondo de escritorio. Como Windows no está activado, hazlo desde el explorador:

  .. image:: imagenes/conf3_fondo.jpg

* En el registro, ve a ``HKEY_CURRENT_USER\Control Panel\Desktop``, haz clic con el botón derecho y elige **Exportar**. Guarda la copia en el escritorio con el nombre ``desktop.reg``.
* Cambia el valor ``WallPaper`` por la ruta de la otra imagen:

  .. image:: imagenes/conf3_wallpaper.png

* Reinicia el ordenador. **5.3** ¿Qué fondo tiene ahora?
* Restaura la copia ``desktop.reg`` que dejaste en el escritorio.
* Reinicia el ordenador. **5.4** ¿Qué fondo tiene ahora?

Cuestionario de configuración
=============================

Para repasar, haz el :doc:`02c_cuestionario_configuracion`.
