**********************
Active Directory y DNS
**********************

Caso práctico: AD y DNS con adaptador puente
===============================

Crea los siguiente clones enlazados con los adaptadores en modo puente:

* Clon enlazado 1 de "Windows Server 2022" llamado **SRV-tunombre** con IP 10.4.X.Y/8
* Clon enlazado 2 de "Windows 11" llamado **WClient0-tunombre** 10.5.X.Y/8

Instalación y configuración de Active Directory y DNS
-------------

* En **SRV-tunombre** vamos a **Administrador del servidor/Panel/Agregar roles y características/Instalación basada en características o en roles** Seleccionar un servidor del grupo de servidores, escoger **SRV-tunombre/Marcar la casilla Servicios de dominio de Active Directory**


Creación de un dominio:
-------

* Partiendo de la ventana Resultados de la instalación de Active Directory, pulsar en Promover este servidor a controlador de dominio. (Si se había cerrado la ventana anterior es posible acceder a ella pulsando en el icono de advertencia de la barra de herramientas del Administrador del servidor)

  .. image:: imagenes/WS_promoverservidorCD.png
    
* De momento, el servidor SRV-tunombre no pertenece a ningún dominio. Tampoco existe un bosque al que agregar un nuevo dominio. Por lo tanto, el primer paso para formar el dominio **tunombre.local** es crear un nuevo bosque. Para ello seleccionar la opción **Agregar un nuevo bosque**. Tras escribir el nombre del dominio: tunombre.local, pulsar Siguiente. En capacidades del controlador del dominio, el Servidor de Sistema de nombres de dominio (DNS) y el Catálogo global (GC) deben estar marcados. Contraseña @lumn0

NetBIOS es una especificación de interfaz utilizado para nombrar recursos de red en sistemas Windows anteriores a Windows 2000. Verificar el nombre NetBIOS tu_nombre y pulsar Siguiente

Si todo ha sido configurado correctamente, hacer clic en Instalar.

Por ultimo cuando se reinicie habilita las actualizaciones dinámicas, para ello en **Inicio->Herramientas administrativas/DNS/expandir SRV16-X /expandir Zonas de búsqueda directa/** clic el botón derecho del ratón en **tunombre.local/Propiedades/General/lista Actualizaciones dinámicas** elegir **sin seguridad y con seguridad**, a continuación hacer clic en Aceptar.

Unidades Organizativas, usuarios y grupos
-------------------------

La estructura lógica de Windows Server se basa en la utilización de dominios y unidades organizativas. En un dominio se puede crear una jerarquía de unidades organizativas, las cuales pueden contener usuarios, grupos, equipos, impresoras y carpetas compartidas, además de otras unidades organizativas.

Para crear de las unidades organizativas en **Inicio/Herramientas administrativas/Usuarios y equipos de Active Directory** dentro del domino **tunombre.local** crea las siguientes unidades organizativas (clic botón derecho del ratón -> Nuevo -> Unidad Organizativa) **Usuarios y Grupos**

.. image:: imagenes/WS_UO.png

Dentro de la UO Grupos, crea el grupo global de seguridad A y B

Dentro de la UO Ususarios, crea los usuarios:

* tu_nombreA1

  * Nombre completo: tu_nombreA1 tu_apellido_A1.
  * Contraseña @lumn0A1
  * Nombre de inicio de sesión del usuario: tu_nombreA2@tu_nombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo A

* tu_nombreA2 

  * Nombre completo: tu_nombreA2 tu_apellido_A2
  * Contraseña @lumn0A2
  * Nombre de inicio de sesión del usuario: tu_nombreA2@tu_nombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo A

* tu_nombreB1

  * Nombre completo: tu_nombreB1 tu_apellido_B1.
  * Contraseña @lumn0B1
  * Nombre de inicio de sesión del usuario: tu_nombreB1@tu_nombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo B

* tu_nombreB2 

  * Nombre completo: tu_nombreB2 tu_apellido_B2
  * Contraseña @lumn0B2
  * Nombre de inicio de sesión del usuario: tu_nombreB2@tu_nombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo B

Unir un equipo al dominio
----------

Vamos a unir **WClient0-tunombre** al dominio tu_nombre.local, cambiamos el nombre, ponemos el DNS la ip del dominio **SRV-tunombre**.

una vez reiniciada la maquina vamos a "Este equipo"/Propiedades/Configuración de nombre, dominio y grupo de trabajo del equipo/Cambiar configuración/Cambiar el dominio : tu_nombre.local


Caso práctico: AD y DNS con red interna
===============================

* Creamos un nuevo adaptador red para el servidor, le asignamos una red interna y le ponemos la dirección 172.16.0.10/16

* Cambiamos en el cliente el adaptador a una red interna, le asignamos la red 172.16.0.11/16 con puerta de enlace 172.16.0.10 y DNS 172.16.0.10


Configurar servicio de enrutamiento
-------

Tenmos que la red interna es Ethernet 2 : 172.16.0.10

* Panel / Agregar roles y características

  Seleccionamos nuestro servidor **SRV-tunombre**

En Roles de servidor marcamos la casilla de:

* [x] Remote Access / **Acceso remoto**

En servicios de rol seleccionamos:

* [x] DirectAccess and VPN(RAS)

* [x] Routing


Para comfigurar servicio de **enrutamiento** vamos a **Panel/Herramientas/Enrutamiento y Acceso remoto**, seleccionamos nuestro servidor **SRV-tunombre**, presionamos el botón de la derecha del ratón y Configuramos y habilitamos el enrutamiento y acceso remoto seleccionando:

* [x] Traduccion de direcciones de red (NAT)

Seleccionamos la tarjeta que tengamos en modo puente. (10.4.X.Y)

* [x] Configurar mas adelante el DHCP y el DNS

Por ultimo unir un equipo al dominio tu_nombre.local, si utilizas la misma maquina virtual tendrás que quitarla del domnio, cambiarle el nombre y volver a meterla, si utilizas un nuevo clon enlazado simplemente únela como hemos hecho antes al dominio teniendo en cuenta que ahora el DNS y la puerta de enlace es 172.16.0.10

Configurar una carpeta compartida
-------

Vamos a compartir la carpeta **C:\\compartidaA** alojada en nuestro servidor, como lectura para el grupo B y rwx para el grupo A, para ello:

Con el botón derecho del ratón accedemos a las propiedades de la carpeta vamos a la pestaña de compartir aqui en **Uso compartido avanzado** seleccionamos compartir esta carpeta. En este mismo dialogo nos vamos a permisos y **quitamos Todos**, después agregamos A y B. Al grupo A le damos el control total y al grupo B solo leer

.. image:: imagenes/SRV_todo.png