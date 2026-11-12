*********************
Configuración Windows
*********************

Menú inicio
===========

.. image:: imagenes/menu_inicio.png

Explorador de Windows
=====================

* El explorador de Windows es un componente principal del sistema operativo que permite administrar el equipo, crear archivos y carpetas, lanzar aplicaciones, etc

  .. image:: imagenes/explorador.png

* Podemos buscar archivos por tamaño ``System.Size: > 100 MB``

* Podemos buscar por una cierta extensión y tamaño ``System.Size: > 100 MB .reg``

* Solo por extensión ``*.reg``; que empiecen por An y acaben por dat ``"An*dat"``

* Entre varios tamaños ``System.Size: > 100 MB < 200MB``

* Por fecha de modificación ``fechademodificación:hoy``

* Por fecha de creación ``fechadecreación:``. Al escribirlo aparece un calendario para elegir un día, un intervalo o un periodo ya preparado (ayer, la semana pasada, el mes pasado…).

* Desde una fecha ``fechadecreación:>=01/01/1999``; entre dos fechas ``fechadecreación:01/01/1999..31/12/2020``

* Por tamaño máximo ``tamaño:<=300KB``

* Por el texto que contiene el archivo ``contenido:Multimedia``

* Los filtros se pueden combinar separándolos con un espacio: ``contenido:Screen fechadecreación:>=01/01/1999``

La búsqueda se hace en la carpeta abierta en ese momento y en todas sus subcarpetas.

Administrador de tareas
=======================

Para ver el Administrador de tareas, haz clic derecho sobre cualquier espacio libre de la barra de tareas del Escritorio (o sobre el botón Inicio) y elige «Administrador de tareas»; también puedes abrirlo con **Ctrl+Mayús+Esc**.

.. image:: imagenes/administrador_tareas.png

En Windows 10 se abre en una vista reducida y hay que pulsar **Más detalles**. En Windows 11 se abre ya completo, con las secciones (Procesos, Rendimiento, Aplicaciones de arranque, Usuarios, Servicios…) en el panel izquierdo.

.. image:: imagenes/administrador_tareas1.png

Además, en la solapa Rendimiento obtendremos información gráfica y numérica sobre el uso del procesador, la memoria, el disco y el hardware de red durante el último minuto.

Información sobre el procesador.

.. image:: imagenes/administrador_tareas2.png

Mientras estemos mostrando la información sobre la CPU, podremos revisar bastantes datos sobre ella:

* El grado de utilización en este instante
* Su velocidad.
* La cantidad de procesos y subprocesos que está ejecutando.
* Los identificadores que tiene asignados.
* El tiempo que lleva funcionando desde que se arrancó el ordenador.
* El tamaño de la caché de nivel 1 (L1) y de nivel 2 (L2).
* El número de núcleos que incluye.
* etc.

Además, en la parte superior, se muestra su modelo exacto (en mi caso, Intel(R) Core(TM) i5-4460 a 3,2GHz) y un gráfico que muestra su comportamiento en el último minuto.

Si observáramos un consumo excesivo de procesador (un gráfico estadístico que muestra continuamente valores elevados), podríamos tener un proceso que funciona de forma inadecuada y está consumiendo demasiado tiempo de procesador. También puede ocurrir que estemos ejecutando demasiados programas de forma simultánea. En cualquier caso, habremos comprobado que el procesador estará suponiendo un cuello de botella en el rendimiento del equipo.

Cuando tenemos varios procesadores, o un procesador con varios núcleos, podemos mostrar gráficos de uso diferenciados para cada uno de ellos. Haciendo clic sobre la categoría Memoria en el panel izquierdo, obtendremos detalles sobre el uso de la RAM.

Información sobre la memoria.

.. image:: imagenes/administrador_tareas3.png

Sobre la memoria, podremos consultar la cantidad que se está usando y la que aún nos queda disponible. Además, podemos ver cuál es el máximo que podremos utilizar (incluyendo la memoria virtual), cuanta tenemos destinada a caché, la cantidad que tenemos paginada y la que aún no lo está.

Como en el caso anterior, también disponemos de una representación gráfica que nos muestra la evolución en el uso de la memoria durante el último minuto. Además, ahora se incluye un gráfico que nos representa (de izquierda a derecha) diferentes datos:

* La cantidad de memoria ocupada por los procesos, los controladores y el sistema operativo.

* La memoria que debe escribirse a disco.

* La memoria que contiene datos y código a modo de caché, pero que no se están usando de forma activa.

* La memoria libre (la primera que será asignada cuando sea necesario).

Si observamos un nivel de ocupación excesivamente elevado (porque estamos ejecutando demasiados programas para la cantidad de memoria instalada o porque tenemos un proceso que está consumiendo una cantidad excesiva), el sistema operativo se estará viendo forzado a usar de forma intensiva la memoria virtual. Esto supondrá un intercambio continuo de páginas de memoria entre la RAM y el disco, lo que puede implicar, de nuevo, un cuello de botella en el sistema que afectará directamente a su rendimiento.

Haciendo clic sobre la categoría Disco en el panel izquierdo, obtendremos detalles sobre el uso del disco duro.

Aspecto de la información sobre el disco.

.. image:: imagenes/administrador_tareas4.png
 
Como ves en la imagen, cuando tenemos más de un disco, aparecen varias entradas, etiquetadas como Disco 0, Disco 1, etc.

En cada uno de ellos podremos consultar diferentes datos:

* El tiempo de actividad (en porcentaje).
* El tiempo medio de respuesta (en milisegundos).
* La velocidad de lectura y escritura en cada instante (medida en KB/s).
* La capacidad total (antes y después de formatear).
* Si se trata del disco donde está instalado el sistema.
* Si contiene el archivo de paginación.

Además, en la parte superior, disponemos de una representación gráfica del tiempo de actividad y de la velocidad de transferencia en el último minuto

Haciendo clic sobre la categoría Ethernet en el panel izquierdo, obtendremos detalles sobre el uso de la conexión de red.

Aspecto de la información sobre la conexión de red.

.. image:: imagenes/administrador_tareas6.png

Como en el caso anterior, es importante que aclaremos que, en el caso de que nuestro ordenador tuviese varias tarjetas de red, en el panel izquierdo aparecería una entrada por cada una de ellas.

Entre los datos que contiene, nos encontramos los siguientes:

* La velocidad de envío y recepción de datos en cada momento (medida en Kbps).

* La dirección IP (tanto IPv4 como IPv6).

* El nombre DNS del equipo.

* etc.

Como antes, la parte superior incluye un gráfico que representa la actividad del dispositivo en el último minuto.

Por último, debemos tener en cuenta que el panel izquierdo puede contener otros elementos, según los dispositivos que tenga nuestro ordenador. En este sentido, es frecuente que incluya entradas para Wi-Fi o Bluetooth.

Algo que puede resultar muy útil es mantener la ventana del Administrador de tareas en primer plano.

En Windows 10 lo conseguimos con la opción Siempre visible del menú Opciones; en Windows 11 está en **Configuración** (la rueda dentada de abajo a la izquierda) / Administración de ventanas / **Siempre visible**.

.. image:: imagenes/administrador_tareas_opciones.png

Incluso podemos reducir la ventana para que sólo nos muestre el gráfico que queramos.

En el caso de que queramos finalizar una tarea con el Administrador de tareas simplemente la seleccionamos y finalizamos tarea.

.. image:: imagenes/administrador_tareas_finalizar.png

En resumen, la pestaña **Rendimiento** nos permite conocer en tiempo real el consumo de cada uno de los núcleos del procesador, la velocidad de procesado actual, la memoria RAM libre y ocupada, así como la velocidad de trabajo de los discos que tenemos instalados e incluso de la conexión a la red que estemos usando en ese mismo instante.

.. image:: imagenes/administrador_tareas7.png

Para ver con más detalle qué proceso usa cada recurso está el **Monitor de recursos**: se abre desde la pestaña Rendimiento (menú de los tres puntos / Monitor de recursos) o con el comando ``resmon``. Tiene una pestaña para la CPU, la memoria, el disco y la red, y en cada una se pueden filtrar los datos por proceso.

Grupos de trabajo y nombre de equipo
====================================

En **Configuración/Sistema/Información** podemos cambiar el nombre del equipo, para cambiar el grupo de trabajo vamos a:

.. image:: imagenes/windows_cambiar_nombre_equipo.png


y entramos en **Dominio o grupo de trabajo**

.. image:: imagenes/windows_nombre_equipo.png

Los **grupos de trabajo** son una de las posibles formas de organizar los equipos dentro de una red local.

La totalidad de equipos pertenecientes a un mismo grupo de trabajo podrán verse y comunicarse entre ellos.

En ningún momento los grupos de trabajo sirven para centralizar o gestionar permisos de equipos. 

La administración de usuarios y privilegios se hará de forma individual en cada uno de los equipos que forman parte del grupo de trabajo. Cada uno de los equipos pertenecientes a un grupo de trabajo tienen una relación de igual a igual entre ellos y se administran de forma local

Cada equipo perteneciente al grupo de trabajo debe disponer de su cuenta de usuario local. Por lo tanto, para iniciar la sesión en un equipo perteneciente a un grupo de trabajo debemos disponer de una cuenta de usuario en este equipo.

Todos los usuarios de una red local pueden pertenecer a un grupo de trabajo sin necesidad de pedir permiso ni introducir ninguna contraseña. Por lo tanto, cuando compartimos una carpeta hay que configurar de forma adecuada los permisos y los usuarios que tendrán acceso a nuestra carpeta compartida.

Resolución de nombres en Windows
================================

Los equipos se comunican con direcciones IP, pero las personas usamos nombres. Resolver un nombre es averiguar la IP que le corresponde. La configuración de red, incluidos los servidores DNS, se ve con:

.. code-block:: powershell

 ipconfig /all        # IP, máscara, puerta de enlace, DNS y dirección física

Cuando un programa pide un nombre, Windows lo busca en este orden:

#. El fichero **hosts**, que está en ``C:\Windows\System32\drivers\etc\hosts``. Cada línea tiene una IP y un nombre. Para modificarlo hay que abrir el Bloc de notas como administrador.
#. La **caché DNS**, donde guarda durante un tiempo los nombres que ya ha resuelto.
#. Los **servidores DNS** configurados en la tarjeta de red.
#. Si el nombre no lleva dominio y nadie lo ha resuelto, pregunta a los equipos de la red local.

.. code-block:: powershell

 ping www.educa.madrid.org          # resuelve el nombre como cualquier programa
 nslookup www.educa.madrid.org      # pregunta al servidor DNS configurado
 nslookup www.educa.madrid.org 1.1.1.1   # pregunta a otro servidor DNS
 Resolve-DnsName www.educa.madrid.org    # lo mismo en PowerShell
 ipconfig /displaydns               # muestra la caché DNS
 ipconfig /flushdns                 # vacía la caché DNS

``nslookup`` solo pregunta a los servidores DNS: no mira el fichero hosts ni la caché. Por eso un nombre escrito en hosts responde con ``ping`` y no con ``nslookup``.

Administración de discos
========================

Con **diskmgmt.msc** (Administración de discos) podemos inicializar discos nuevos, crear, formatear, extender o reducir particiones (Windows las llama *volúmenes*) y cambiar las letras de unidad, todo de forma gráfica — es el equivalente al gparted de GNU/Linux.

Desde la línea de comandos disponemos de **diskpart** (como administrador):

.. code-block:: powershell

 diskpart
 list disk                         # discos del equipo
 select disk 1                     # elegimos el disco
 clean                             # borra su tabla de particiones
 create partition primary size=10240   # partición primaria de 10 GB
 format fs=ntfs quick label=datos  # formato NTFS rápido
 assign letter=E                   # le asigna la letra E:
 exit

Copia de seguridad y restauración
=================================

Existen dos tipos principales de copias de seguridad:

* **Copia de seguridad de los archivos**. La copia de seguridad de archivos te permite crear una copia de los documentos que tienes guardados en tu PC, ya sea de manera individual o de varios ficheros a la vez, para tenerlos en otro dispositivo y recuperarlos cuando quieras. En Windows se hace con el **Historial de archivos** (necesita una unidad distinta de la del sistema: un segundo disco, un disco externo o una carpeta de red).

* **Copia de seguridad del sistema**. La copia de seguridad del sistema te permite crear una copia de todo el sistema operativo Windows que en ese momento tienes en tu ordenador, es decir, de todos los programas, los archivos y los valores de configuración. Se hace creando una **imagen de sistema** (Panel de control → Copia de seguridad y restauración).

Además, Windows cuenta con los **puntos de restauración** (Restaurar sistema): instantáneas de los archivos del sistema y del registro que se crean automáticamente antes de instalar programas, controladores o actualizaciones. No afectan a los documentos del usuario: solo devuelven el *sistema* a un estado anterior.

.. code-block:: powershell

 sysdm.cpl     # pestaña Protección del sistema: activar la protección y crear puntos manualmente
 rstrui        # asistente para restaurar el sistema a un punto anterior

Si Windows no llega a arrancar, disponemos del **entorno de recuperación (WinRE)**: se entra manteniendo pulsada la tecla **Mayús mientras se hace clic en Reiniciar** (o desde Configuración → Recuperación → Inicio avanzado, o automáticamente tras varios arranques fallidos). Desde él podemos arrancar en **modo seguro**, usar la reparación de inicio, abrir un símbolo del sistema, restaurar un punto de restauración o recuperar una imagen de sistema.

El registro de Windows
======================

El registro de Windows es una base de datos donde aplicaciones y controladores guardan/buscan la información necesaria para funcionar. Su estructura está formada en forma de carpetas:

Se abre con **Win+R** y el comando ``regedit``:

.. image:: imagenes/registro_windows.png

* Estructura del registro (Jerarquía de carpetas)

  * HKEY/Claves/Subclaves
  * HKEY = Handle to a Key (identificador de clave)

* Tipos:

  * CONSTANTES: Se crean y modifican sólo en determinados momentos. Modificación del sistema, instalación/eliminación de un programa, creación de un usuario….
  * DINÁMICAS: Se vuelven a crear cuando se inicia Windows.
    
* **HKEYS’S**

  * **HKEY_CLASSES_ROOT**,  contiene información sobre aplicaciones registradas.
    
  * **HKEY_CURRENT_USER**,  almacena configuraciones específicas del usuario con sesión iniciada en esos momentos.

    * Es un acceso directo a la rama de HKEY_USERS correspondiente al usuario actual.

    * Control Panel/Desktop/WallPaper/  Imagen de fondo de escritorio

  * **HKEY_LOCAL_MACHINE**, almacena configuraciones específicas del equipo local.

  * **HKEY_USERS**, contiene una subclave (equivalente a HKEY_CURRENT_USER) por cada perfil de usuario cargado activamente en el equipo, aunque normalmente solo se cargan los subárboles de los usuarios con sesión iniciada en esos momentos.
  
  * **HKEY_CURRENT_CONFIG**,  contiene la información referente a algunos de los dispositivos Plug and Play que tiene el ordenador.
  
* **Búsquedas en el registro**

  HKEY correspondiente, y hacemos: Edición / Buscar

* **Limpieza del registro**

  Windows no incluye ninguna herramienta para limpiar el registro y Microsoft desaconseja los limpiadores de otros fabricantes: borrar claves a ciegas puede dejar programas sin funcionar. Si hay que modificarlo, se hace antes una copia.
    
* **Copia de seguridad del registro**, 

  Es aconsejable realizarlos siempre antes que:   
  
  * Instalación de un nuevo programa.
  * Desinstalación de un programa.
  * Instalación de un nuevo periférico.
  * Desinstalación de un periférico.
  * Modificación o actualización del sistema.
  * Siempre que el usuario lo estime oportuno.
  
  Para realizar la copia: Archivo > Exportar
  
  Para realizar la restaurar : Archivo > Importar
  
  Para hacer una copia parcial
  
  * Seleccionamos la rama o la clave a guardar
  * Pulsamos en Archivo / Exportar, con la opción **Rama seleccionada** marcada


Comandos Panel de Control
=========================

Todas estas herramientas pueden abrirse escribiendo su comando en Ejecutar (**Win+R**) o en la búsqueda del menú Inicio. Estos son los más utilizados:

* **control**: abre el Panel de control clásico.
* **sysdm.cpl**: propiedades del sistema.
* **appwiz.cpl**: programas y características (agregar o quitar programas).
* **optionalfeatures**: activar o desactivar características de Windows.
* **compmgmt.msc**: administración de equipos (agrupa varias de las siguientes).
* **devmgmt.msc**: administrador de dispositivos.
* **diskmgmt.msc**: administración de discos (particiones).
* **services.msc**: administrador de servicios.
* **msconfig**: utilidad de configuración del sistema (arranque).
* **regedit**: editor del registro.
* **lusrmgr.msc**: usuarios y grupos locales.
* **netplwiz** (o control userpasswords2): administración de cuentas de usuario.
* **gpedit.msc**: editor de directivas de grupo local (ediciones Pro y superiores).
* **secpol.msc**: directivas de seguridad local.
* **taskschd.msc**: programador de tareas.
* **eventvwr.msc**: visor de eventos.
* **perfmon.msc**: monitor de rendimiento.
* **mdsched**: diagnóstico de la memoria.
* **dxdiag**: herramienta de diagnóstico de DirectX.
* **ncpa.cpl**: conexiones de red.
* **firewall.cpl**: firewall de Windows.
* **desk.cpl**: configuración de pantalla.
* **main.cpl**: propiedades del ratón.
* **mmsys.cpl**: dispositivos de sonido.
* **powercfg.cpl**: opciones de energía.
* **timedate.cpl**: fecha y hora.
* **intl.cpl**: configuración regional y de idioma.
* **mmc**: abre una consola de administración vacía.

.. toctree::
   :hidden:

   02b_ejercicios_configuracion.rst
   02c_cuestionario_configuracion.rst
