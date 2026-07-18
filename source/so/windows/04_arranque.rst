*******************
Arranque de Windows
*******************

En resumen, el arranque de Windows pasa por estas fases:

1. **Firmware (BIOS/UEFI)**: el POST comprueba el hardware y localiza el dispositivo de arranque (el MBR en sistemas BIOS, o la partición EFI en sistemas UEFI/GPT).
2. **Administrador de arranque de Windows** (bootmgr): lee la configuración de arranque (**BCD**) y, si hay varios sistemas, muestra el menú para elegir.
3. **Cargador del sistema** (winload.exe): carga el núcleo de Windows (ntoskrnl.exe) y los controladores esenciales.
4. **Inicio del sistema**: se lee la configuración del Registro, se cargan el resto de controladores y servicios, y winlogon presenta la pantalla de inicio de sesión.

Lo primero que se va a cargar son los ajustes del firmware, que comprueba que el sistema de disco es válido para llevar a cabo el inicio del PC; si el equipo tiene un MBR (o una partición EFI) válido, el proceso de arranque carga el conocido como “Administrador de arranque de Windows” y pasa a la segunda fase.

El administrador de arranque de Windows determina si en el equipo disponemos de varios sistemas operativos instalados o tan solo de uno. En el caso de que sean varios, en pantalla se muestra un menú con sus nombres para que podamos seleccionar el que nos interese.

Al elegir Windows se pone en marcha el fichero “winload.exe”, que comienza la carga de los controladores más importantes del equipo para poder iniciar el kernel del propio Windows. En este paso el núcleo del sistema utiliza los controladores para «comunicarse» con el hardware instalado.

En la última fase se recoge la configuración del Registro de Windows, así como el resto de controladores adicionales y demás elementos necesarios para el correcto funcionamiento del sistema operativo. Una vez cargado esto, se carga la interfaz de usuario y aparece la habitual pantalla de inicio de sesión de Windows para introducir las credenciales de acceso.

En los ordenadores con UEFI, el **arranque seguro (Secure Boot)** verifica que el gestor de arranque esté firmado digitalmente antes de ejecutarlo (un PC sin arranque seguro ejecuta cualquier gestor de arranque que encuentre en el disco), y la función **Trusted Boot** continúa esa cadena de confianza comprobando la firma del kernel y de los controladores durante el arranque de Windows.

msconfig
========

Es una utilidad del sistema operativo cuya función inicial era la de corregir problemas asociados con el inicio de Windows, pero la cual poco a poco ha tomado más fuerza gracias a sus diversas alternativas de uso. Gracias a msconfig será posible ejecutar tareas como:

* Facilidad para configurar la forma de inicio de Windows.
* Cambiar el procedimiento de inicio.
* Seleccionar los servicios de inicio y programas que serán cargados junto con el sistema y muchas acciones más.


Acceder a msconfig en Windows: Ejecutar el comando msconfig

.. image:: imagenes/configuracion_arranque.png

Como vemos, la utilidad msconfig nos brinda una serie de opciones a elegir, estas son:

* **Inicio normal**. Es la opción por defecto e indica que Windows cargará todos los elementos, controladores y servicios de inicio que han sido instalados, únicamente cuando se han realizado cambios en los controladores, servicios o aplicaciones que se cargan durante el arranque podemos seleccionar una opción adicional.

* **Inicio con diagnóstico**. Su uso es similar al inicio en modo seguro: al seleccionar esta opción solo se ejecutarán los servicios y controladores básicos de Windows. Ten en cuenta que esto deja sin arrancar los servicios de terceros, incluidos algunos de alto impacto para la seguridad como el antivirus o el firewall. Se suele usar para comprobar si algún servicio o programa de inicio es el causante de un problema, y así descartarlo.

* **Inicio selectivo**. Al seleccionar esta opción, Windows iniciará con los servicios básicos más aquellos servicios y elementos de inicio que dejemos marcados en las pestañas Servicios e Inicio.

Hoy en día es normal, para muchos usuarios, contar con modo de arranque dual el cual nos permite tener dos sistemas operativos instalados en el disco duro aprovechando así todos los recursos de hardware, en caso de contar con más de un sistema operativo instalado, la herramienta msconfig nos da la opción de elegir cuál de ellos será la opción predeterminada.

.. image:: imagenes/configuracion_sistema.png

Aquí podemos cambiar sistema de arranque inicio por defecto en Windows, si tienes sistema dual boot, aquí tienes los pasos para cambiar cuál es el Sistema Operativo que se inicia por defecto desde Windows. También podemos cambiar el tiempo de espera que por defecto son 30 segundos.

Existen una serie de opciones avanzadas en el sistema operativo que nos darán la opción de mejorar el arranque del sistema operativo, estas opciones avanzadas involucran cambios a nivel de memoria, procesadores o depuración de elementos.

.. image:: imagenes/opciones_avanzadas.png

En la sección “Número de procesadores” podemos definir la cantidad de procesadores disponibles en base al CPU de nuestro equipo (2, 4, 8 o más procesadores).

En la sección “Cantidad máxima de memoria” podremos asignar la cantidad de RAM que deseamos que Windows aplique al proceso de arranque, allí podemos usar toda la capacidad de la RAM instalada.

En el campo “Configuración global de depuración”, esta opción está deshabilitada por defecto y esta función se encarga de especificar la configuración de conexión del depurador en el equipo local con el fin de que un depurador de kernel pueda comunicarse con un host depurador, la conexión del depurador entre los equipos host y de destino puede ser de tipo Serie, IEEE 1394 o USB 2.0, en el puerto de depuración se especifica qué tipo de puerto será usado como tipo de conexión y puerto serie, el valor predeterminado es COM 1, finalmente la velocidad en baudios indica la velocidad en baudios que se usará al momento de seleccionar el puerto de depuración y el tipo de conexión de depuración, esta configuración es opcional y los valores válidos son 9600, 19.200, 38.400, 57.600 y 115.200. El valor predeterminado es 115.200 bps.

Para configurar este arranque en modo seguro, desde la pestaña Arranque, activaremos la casilla “Arranque a prueba de errores” y allí seleccionar alguna de las opciones disponibles que son la siguientes:

* **Mínimo**.  Con esta opción el arranque seguro se ejecuta de forma normal, con una interfaz de usuario y sin servicios de red habilitados.

* **Shell alterno**. Esta opción abre el símbolo del sistema en modo a prueba de errores. Los servicios de red y la interfaz gráfica de usuario están deshabilitados por defecto.

* **Reparar Active Directory**. Es un inicio seguro normal que ejecuta los servicios y características de Active Directory, útil para equipos en un dominio.

* **Red**. Ejecuta el inicio seguro normal con servicios de red habilitados.


Para deshabilitar opciones de arranque Windows, En la misma pestaña de arranque, encontramos en la parte inferior derecha una serie de opciones para aplicar a los procedimientos de arranque estándar y en modo seguro, estas opciones son.

* **Sin arranque de GUI**. Al seleccionar esta opción, durante el arranque, no se mostrará la pantalla de carga habitual, tan solo una pantalla negra sin información con el fin de mejorar la velocidad de arranque.

* **Registro de arranque**. En el proceso de inicio, Windows escribe un registro completo detallando toda la información sobre el proceso de inicio, por defecto esta información está en la ruta C:\Windows\Ntbtlog.txt.

* **Vídeo base**. Al seleccionar esta opción, ejecutamos un inicio de Windows estándar, en el cual solo serán cargados los controladores de vídeo estándar que vienen con el sistema operativo por defecto, en lugar de los específicos de la tarjeta de vídeo.

* **Información de arranque del SO**. Si usamos esta opción, también debemos activar la opción Sin arranque de GUI. Con estas opciones, la pantalla de carga de Windows habitual se verá reemplazada por una pantalla negra, donde veremos información completa sobre los controladores que son cargados durante el proceso de inicio, así, en caso de que Windows se bloquee en el proceso de arranque, este modo de visualización puede ser útil para encontrar el controlador que causa el bloqueo y así facilitar las tareas de soporte.

**Nota:** En caso de que sea necesario que los cambios que hemos realizado sean constantes, debemos activar la casilla “Convertir en permanente toda la configuración de arranque”, o para volver al inicio normal utilizar otra vez el comando msconfig

Podemos también definir los servicios que serán cargados en el arranque Windows. En la pestaña "Servicios"  será posible activar los servicios que serán ejecutados al inicio y desmarcar los que no lo serán, en caso de desear ver solo los servicios de terceros instalados por las aplicaciones, debemos activar la casilla “Ocultar todos los servicios de Microsoft”. Es aconsejable tener conocimiento sobre qué servicios han de deshabilitarse ya que si deshabilitamos algún servicio de Microsoft podemos causar anomalías en el sistema.
Para definir los programas que serán cargados en el arranque Windows
Es normal que los programa y aplicaciones que instalamos en Windows, cuenten con una opción la cual permite que estos sean cargados desde el proceso de arranque lo cual representa un impacto negativo en el rendimiento de este.

Para deshabilitar programas de Inicio arranque Windows, vamos a la pestaña “Inicio de Windows” y allí damos clic en la línea “Abrir el administrador de tareas” el cual nos redireccionará a la pestaña “Inicio” del administrador de tareas:

.. image:: imagenes/administrador_tareas_arranque.png

Si deseamos impedir que alguno de ellos sea ejecutado contamos con las siguientes opciones:
Dar clic derecho sobre él y seleccionar la opción “Deshabilitar”.
Seleccionarlo y pulsar en el botón “Deshabilitar” ubicado en la parte inferior

Finalmente, en la pestaña “Herramientas” de msconfig, disponemos de un conjunto de herramientas del sistema como Información del sistema, Editor del registro, Visor de eventos, Monitor de rendimiento y más, las cuales nos permiten realizar una tarea mucho más completa. Podemos ver que cada herramienta tiene asociado un comando de ejecución.

El BCD y bcdedit
================

La configuración del administrador de arranque (los sistemas del menú, el predeterminado, el tiempo de espera...) se guarda en el **BCD** (Boot Configuration Data), el equivalente en Windows al grub de Linux. Se puede consultar y modificar desde una consola como administrador con **bcdedit**:

.. code-block:: powershell

 bcdedit /enum                        # muestra las entradas de arranque
 bcdedit /timeout 10                  # cambia el tiempo de espera del menú a 10 segundos
 bcdedit /default {identificador}     # cambia el sistema que arranca por defecto

Gestión de servicios (PowerShell)
=================================

* Get-Service
* New-Service
* Restart-Service
* Resume-Service
* Set-Service
* Start-Service
* Stop-Service
* Suspend-Service

Ejemplo de uso:

.. code-block:: powershell

  PS C:\Users\alumno> Get-Service -Name Spooler
  
  Status   Name               DisplayName
  ------   ----               -----------
  Running  Spooler            Cola de impresión  

  
  PS C:\Users\alumno> Restart-Service -Name Spooler
  ADVERTENCIA: Esperando a que se inicie el servicio 'Cola de 
  impresión (Spooler)'...
