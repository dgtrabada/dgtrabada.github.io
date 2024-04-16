**********************************
Casos prácticos : Active Directory
**********************************

Caso práctico: AD y DNS con adaptador puente
============================================

Crea los siguiente clones enlazados con los adaptadores en modo puente:

* Clon enlazado 1 de "Windows Server 2022" llamado **SRV-tunombre** con IP 10.4.X.Y/8, DHCP si es portatil
* Clon enlazado 2 de "Windows 11" llamado **WC5-tunombre** 10.5.X.Y/8, DHCP si es portatil

Puedes ver la configuración en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/v7q1diqc4c9ldsg6>`_

Instalación y configuración de Active Directory y DNS
-----------------------------------------------------

* En **SRV-tunombre** vamos a **Administrador del servidor/Panel/Agregar roles y características/Instalación basada en características o en roles** Seleccionar un servidor del grupo de servidores, escoger **SRV-tunombre/Marcar la casilla Servicios de dominio de Active Directory**


Creación de un dominio:
-----------------------

* Partiendo de la ventana Resultados de la instalación de Active Directory, pulsar en Promover este servidor a controlador de dominio. (Si se había cerrado la ventana anterior es posible acceder a ella pulsando en el icono de advertencia de la barra de herramientas del Administrador del servidor)

  .. image:: imagenes/WS_promoverservidorCD.png
    
* De momento, el servidor SRV-tunombre no pertenece a ningún dominio. Tampoco existe un bosque al que agregar un nuevo dominio. Por lo tanto, el primer paso para formar el dominio **tunombre.local** es crear un nuevo bosque. Para ello seleccionar la opción **Agregar un nuevo bosque**. Tras escribir el nombre del dominio: tunombre.local, pulsar Siguiente. En capacidades del controlador del dominio, el Servidor de Sistema de nombres de dominio (DNS) y el Catálogo global (GC) deben estar marcados. Contraseña @lumn0

Verificar el nombre NetBIOS [#NetBIOS]_ tu_nombre y pulsar Siguiente

Si todo ha sido configurado correctamente, hacer clic en Instalar.

Por ultimo cuando se reinicie habilita las actualizaciones dinámicas, para ello en **Inicio->Herramientas administrativas/DNS/expandir SRV-TUNOMBRE /expandir Zonas de búsqueda directa/** clic el botón derecho del ratón en **tu_nombre.local/Propiedades/General/lista Actualizaciones dinámicas** elegir **sin seguridad y con seguridad**, a continuación hacer clic en Aceptar.

Unidades Organizativas, usuarios y grupos
-----------------------------------------

La estructura lógica de Windows Server se basa en la utilización de dominios y unidades organizativas. En un dominio se puede crear una jerarquía de unidades organizativas, las cuales pueden contener usuarios, grupos, equipos, impresoras y carpetas compartidas, además de otras unidades organizativas.

Para crear de las unidades organizativas en **Inicio/Herramientas administrativas/Usuarios y equipos de Active Directory** dentro del domino **tu_nombre.local** crea las siguientes unidades organizativas (clic botón derecho del ratón -> Nuevo -> Unidad Organizativa) **Usuarios y Grupos**

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
-------------------------

Vamos a unir **WC5-tunombre** al dominio tu_nombre.local, para ello:

1. Cambiamos el nombre de la maquina

#. Ponemos el DNS la ip del dominio **SRV-tunombre**.

#. Haz clic derecho en el botón "Inicio" y selecciona "Sistema > Información" en el menú desplegable.

#. En la ventana de "Sistema", haz clic en "Configuración avanzada del sistema" en el panel izquierdo.

#. Se abrirá la ventana de "Propiedades del sistema". Haz clic en la pestaña "Nombre de equipo" y luego en el botón "Cambiar".

#. En la siguiente ventana, verás la opción "Miembro de". Asegúrate de seleccionar la opción "Dominio" en lugar de "Grupo de trabajo".

#. Ingresa un nombre del dominio **tu_nombre.local** 

   .. image:: imagenes/quitar_dominio.png
   

#. Haz clic en "OK" para guardar los cambios. Es posible que se te solicite reiniciar el equipo para aplicar los nuevos ajustes.


Quitar el equipo del dominio
----------------------------

1. Accede al equipo con una cuenta de administrador local.

#. Haz clic derecho en el botón "Inicio" y selecciona "Sistema" en el menú desplegable.

#. En la ventana de "Sistema", haz clic en "Configuración avanzada del sistema" en el panel izquierdo.

#. Se abrirá la ventana de "Propiedades del sistema". Haz clic en la pestaña "Nombre de equipo" y luego en el botón "Cambiar".

#. En la siguiente ventana, verás la opción "Miembro de". Asegúrate de seleccionar la opción "Grupo de trabajo" en lugar de "Dominio".

#. Ingresa un nombre de grupo de trabajo para el equipo. Por defecto, el grupo de trabajo suele ser "WORKGROUP", pero puedes ingresar un nombre diferente si lo deseas.

#. Haz clic en "OK" para guardar los cambios. Es posible que se te solicite reiniciar el equipo para aplicar los nuevos ajustes.

#. En el servicdor **"Inicio/Herramientas administrativas/Ususarios y equipos de Active Directory/"**

#. Selecciona **tu_nombre.local**, y quita los clientes que has sacado del dominio en la pestaña de **Computers**

Configurar una carpeta compartida
---------------------------------

Las carpetas y archivos en Windows permiten configurar los siguientes permisos:

* **Control total** el usuario tiene control total sobre la carpeta y puede añadir, cambiar, mover y eliminar elementos. El usuario también puede agregar y quitar permisos de la carpeta y subcarpetas.

* **Modificar** una combinación de lectura y escritura. El usuario también tiene la capacidad de eliminar los archivos dentro de la carpeta. También puede ver el contenido de las subcarpetas.

* **Leer y Ejecutar** los usuarios pueden leer el contenido de los archivos y ejecutar los programas de la carpeta.

Vamos a compartir la carpeta **C:\\compartida** alojada en nuestro servidor, con los permisos solo de lectura, para ello:

Con el botón **derecho del ratón** accedemos a las propiedades de la carpeta vamos a la pestaña de **Compartir** aqui en **Uso compartido avanzado** seleccionamos compartir esta carpeta. 

En la misma pestaña de **Compartir** este mismo dialogo nos vamos a **Compartir** permisos y comprobamos que **Todos** solo con permisos de Lectura

Como podemos ver esta compartida en: **\\SRV-TUNOMRE\compartida** o **\\10.4.100.100**, si el cliente es linux podemos acceder **smb://10.4.100.100/**

Instalación de software utilizando directivas de grupo
------------------------------------------------------

1. Vamos a poner en la carpeta compartida el programa a instalar en formato msi [#msi]_, para este caso utilizaremos `VideoLAN <https://www.videolan.org/>`_.

#. Para crear un objeto de directiva de grupo, abre la consola de administración de directivas de grupo (Group Policy Management Console) en el controlador de dominio **Inicio/Herramientas administrativas de Windows/Administración de directivas de grupo**. Crea un nuevo objeto de directiva de grupo (GPO) **Instalar VLC**

   .. image:: imagenes/GPO_VLC.png

#. En la pestaña de **Configuración/Configuración del equipo** vamos a Edición

   .. image:: imagenes/GPO_VLC_configuracion.png

#. En **Directiva Instalar/Configuración del equipo/Directivas/Configuración de software** creamos un nuevo paquete  
   
   .. image:: imagenes/GPO_VLC_editar.png
   

#. Especificar la ubicación del programa (.msi o .exe) dandole la ip y la carpeta compartida,para este caso usaremos la carpeta compartida que hemos creado, por lo general usaremos SYSVOL [#sysvol]_, lo siguiente será seleccionar una instalación asignada, es decir (se instala automáticamente cuando se inicia sesión) en el caso de seleccionar la instalación publicada (el usuario puede elegir instalarlo desde el Centro de software de Windows).

   .. image:: imagenes/GPO_VLC_editar2.png
    
#. Haz un par de clientes más para nuestro dominio. Crea una nueva UO llamada Equipo y dentro crea otra llamada Despacho1, deja el cliente WC5-Tunombre fuera y dentro del Despacho1 el cliente WC6-Tunombre y WC7-Tunombre

   .. image:: imagenes/GPO_VLC_Equipos.png
    
#. En la consola de administración de Directivas de grupo, navega hasta  Despacho1, haz clic derecho en la OU y selecciona **Vincular un GPO existente**

   .. image:: imagenes/GPO_VLC_editar3.png
    
#. Los cambios en las políticas de grupo pueden requerir que el cliente se reinicie para que las configuraciones tengan efecto. Por otro lado si queremos aplicar nosotros mismos las directivas de grupo en los clientes de Windows, abre una ventana del símbolo del sistema (cmd) o PowerShell y ejecuta el comando **gpupdate /force**. Esto obligará al equipo a buscar y aplicar las nuevas directivas de grupo.


.. rubric:: Footnotes

.. [#NetBIOS] NetBIOS (Sistema Básico de Entrada/Salida de Red) es un protocolo de red desarrollado originalmente por IBM en los años 80. Es un protocolo de capa de aplicación que permite la comunicación entre dispositivos en una red local (LAN). Aunque es una tecnología más antigua, todavía se encuentra en uso en algunas redes, especialmente en entornos heredados y redes locales más pequeñas. Las características importantes de NetBIOS:

 * Identificación de nombres de red: NetBIOS proporciona un método para que los dispositivos en una red local se identifiquen entre sí mediante nombres de red. Estos nombres NetBIOS son de hasta 15 caracteres alfanuméricos y se utilizan para identificar recursos de red como impresoras, carpetas compartidas y otros dispositivos.

 * Resolución de nombres: NetBIOS también incluye un servicio de resolución de nombres que permite a los dispositivos de la red traducir nombres de recursos NetBIOS en direcciones IP que puedan ser utilizadas para la comunicación en la red.

 * Sesiones NetBIOS: NetBIOS permite establecer sesiones entre dispositivos en la red para la transferencia de datos. Estas sesiones pueden ser utilizadas para la comunicación entre aplicaciones en diferentes dispositivos.

 * Datagramas NetBIOS: Además de las sesiones, NetBIOS también admite la comunicación de datagramas, que son mensajes de longitud fija que pueden ser enviados a todos los dispositivos en la red o a dispositivos específicos.

 * Puertos NetBIOS: NetBIOS utiliza el puerto TCP/UDP 137 para la resolución de nombres, el puerto TCP 139 para las sesiones NetBIOS y el puerto UDP 138 para datagramas NetBIOS.

.. [#msi] El formato **MSI** es un estándar de instalación utilizado en Windows que proporciona una forma estructurada y coherente de distribuir, administrar y desinstalar aplicaciones. Permite una gestión centralizada, una instalación consistente y confiable, y un mantenimiento y actualización eficientes de las aplicaciones en entornos Windows.

.. [#sysvol] SYSVOL significa Volumen del Sistema, y es un directorio compartido utilizado por Active Directory (AD) para almacenar sus datos públicos, como políticas de grupo, scripts y otros datos esenciales. Juega un papel crucial en la replicación de controladores de dominio y en el mantenimiento de la consistencia en todo un dominio. 

  Dentro de SYSVOL, encontrarás varias carpetas y archivos, incluidos:

  * **Policies** (Políticas): Esta carpeta contiene Objetos de Política de Grupo (GPO), que definen varios ajustes y configuraciones para usuarios y computadoras dentro de un dominio.

  * **Scripts**: Esta carpeta puede contener scripts de inicio de sesión u otros scripts utilizados para diversas tareas administrativas.

  * **Staging** (Escenario): Utilizado durante el proceso de replicación para preparar cambios antes de que se apliquen a otros controladores de dominio.

  * **Domain** (Dominio): Contiene información específica del dominio.

  * **StarterGPOs**: Contiene Objetos de Política de Grupo Iniciales, que son plantillas para crear nuevos GPO.
  

Unir un cliente Ubuntu al dominio
---------------------------------

* Configura la IP 10.10.X.Y/8 (255.0.0.0), donde X.Y son parte de las ips de vuestros equipos, con gateway 10.0.0.2 y subred 10.0.0.0/8 en el caso de que tengas un portátil utiliza DHCP.

* Cambia el DNS (ip windows server), haz que aparezca en **/ets/hosts** el nombre del dominio y sincroniza temporalmente los dos ordeandores. 

Instalar los paquetes necesarios:

.. code-block:: bash

  apt install sssd-ad sssd-tools realmd adcli
  
  apt install krb5-user
  #Reino predeterminado de la versión 5 de Kerberos:
  TUNOMBRE.LOCAL

  

Deshabilitamos la resolución inversa de DNS (rdns = false) en /etc/krb5.conf

.. code-block:: bash

  head -3  /etc/krb5.conf
  [libdefaults]
        default_realm = TUNOMBRE.LOCAL
        rdns = false

Añadimos nuestro Ubuntu al AD:

.. code-block:: bash

  sudo realm join --user=Administrador -v tunombre.local

Para que se cree el home de forma automatica cuando se loguea el usuario

.. code-block:: bash

  pam-auth-update

.. image:: imagenes/ubuntuADSRV.png

Seleccionar otro usaurio

.. image:: imagenes/ubuntuAD.png
    :scale: 50%
    
Tambien puedes conectarte por ssh
   
.. image:: imagenes/ubuntuADssh.png
    :scale: 50%
    

Caso práctico: AD y DNS con red interna
=======================================

Crea los siguiente clones enlazados con los adaptadores en modo puente:

* Clon enlazado 1 de "Windows Server 2022" llamado **SRVInt-tunombre** con IP 10.4.X.Y/8, DHCP si es portatil y un nuevo adaptador red para el servidor, le asignamos una red interna y le ponemos la dirección 172.16.0.10/16
* Clon enlazado 2 de "Windows 11" llamado **WC5Int-tunombre** con un adaptador a una red interna, le asignamos la red 172.16.0.15/16 con puerta de enlace 172.16.0.10 y DNS 172.16.0.10
* Clon enlazado 3 de "Windows 11" llamado **WC6Int-tunombre** con un adaptador a una red interna, le asignamos la red 172.16.0.16/16 con puerta de enlace 172.16.0.10 y DNS 172.16.0.10

Configurar servicio de enrutamiento
-----------------------------------

Para configurar el servicio de enrutamiento vamos a:

* Panel / Agregar roles y características

  Seleccionamos nuestro servidor **SRVInt-tunombre**

En Roles de servidor marcamos la casilla de:

* [x] Remote Access / **Acceso remoto**

En servicios de rol seleccionamos:

* [x] DirectAccess and VPN(RAS)

* [x] Routing


Para comfigurar servicio de **enrutamiento** vamos a **Panel/Herramientas/Enrutamiento y Acceso remoto**, seleccionamos nuestro servidor **SRVInt-tunombre**, presionamos el botón de la derecha del ratón y Configuramos y habilitamos el enrutamiento y acceso remoto seleccionando:

* [x] Traduccion de direcciones de red (NAT)

Seleccionamos la tarjeta que tengamos en modo puente. (10.4.X.Y) o por (DHCP caso portatil)

* [x] Configurar mas adelante el DHCP y el DNS


Configura el controlador de dominio
-----------------------------------

Crea un controlador de dominio llamado **empresa_tunombre.local** y las siguientes unidades organizativas:

* OU=Oficinas

  * OU=Madrid
 
    * OU=Ventas
      
    * OU=Marketing
   
    * OU=Administración
    
  * OU=Barcelona
   
    * OU=Ventas
            
    * OU=Marketing
      
    * OU=Administración
      
* OU=Departamentos
        
  * OU=Recursos Humanos
        
  * OU=Finanzas
      
  * OU=IT
      
* OU=Usuarios
        
  * OU=Empleados
        
  * OU=Contratistas

.. image:: imagenes/ADINT01.png



* La **OU Oficinas** se utiliza para agrupar las unidades organizativas por ubicación geográfica.

* Las **OU Madrid y Barcelona** se utilizan para agrupar los departamentos dentro de cada oficina.

* La **OU Departamentos** se utiliza para agrupar las unidades organizativas por función.

* La **OU Usuarios** se utiliza para agrupar las cuentas de usuario.

**Ayuda**: En el caso de querer borrar una OU que esta protegída contra el borrado accidental, en propiedades en la pestaña Objeto desmarcar dicha protección. En el caso de no ver esta pestaña, haz clic en ver en la barra de menú y selecciona Características avanzadas.
   
Configura los usuarios del sistema
-----------------------------------

Crea el grupo de seguridad global Empleados dentro del UO Empleados y Contratistas dentro de su UO Contratistas.
Dentro de cada unidad organizativa crea los siguientes usuarios:

* UO Empleados
  
  * E01_tunombre perteneciente al grupo Empleados

  * E02_tunombre perteneciente al grupo Empleados
  
* UO Contratistas
  
  * C01_tunombre perteneciente al grupo Contratista

  * C02_tunombre perteneciente al grupo Contratista

.. image:: imagenes/ADINT02.png

Directivas de passwords
-----------------------

Crear una nueva directiva de password sobre el grupo Empleados y Contratistas, para ello abre el **Centro de administración de Active Directory** selecciona tu_nombre (local)/System/Password Settings Container

.. image:: imagenes/directivaPASS01.jpeg

Nuevo/Configuración de contraseña

.. image:: imagenes/directivaPASS02.jpeg

Dentro del Centro de administración de Windows Server, puedes encontrar una sección para configurar las políticas de contraseña.

* **Nombre**: Es el nombre que le asignas a la política de contraseña para identificarla fácilmente. Puedes darle un nombre descriptivo que refleje los requisitos o el propósito de la política.

* **Precedencia**: La precedencia se refiere al orden en el que se aplican las políticas de contraseña cuando existen múltiples políticas configuradas. Este campo te permite establecer la prioridad o el nivel de precedencia de la política de contraseña en relación con otras políticas. La política con la precedencia más alta tiene prioridad.

* **Longitud mínima**: Especifica la longitud mínima que deben tener las contraseñas para cumplir con la política. Puedes establecer un valor numérico para indicar el número mínimo de caracteres requeridos.

* **Complejidad de la contraseña**: Este campo te permite configurar si las contraseñas deben cumplir con requisitos de complejidad. Puedes habilitar o deshabilitar la complejidad y definir qué elementos se requieren, como letras mayúsculas, letras minúsculas, números y caracteres especiales.

* **Duración máxima de la contraseña**: Aquí puedes especificar el tiempo máximo que una contraseña puede estar en uso antes de que los usuarios deban cambiarla. Puedes establecer una cantidad de días después de los cuales se requiere un cambio de contraseña.

* **Historial de contraseñas**: Este campo define el número de contraseñas anteriores que los usuarios no pueden reutilizar. Por ejemplo, si estableces un historial de contraseñas de 5, los usuarios no podrán usar ninguna de las últimas 5 contraseñas que hayan utilizado.

* **Bloqueo** de cuenta por intentos fallidos: Puedes configurar el número máximo de intentos fallidos de inicio de sesión permitidos antes de que una cuenta de usuario se bloquee temporalmente. Esto ayuda a proteger las cuentas contra ataques de fuerza bruta.

.. image:: imagenes/directivaPASS03.jpeg


Intalar programas y cambiar el fondo de escritorio por GPO
----------------------------------------------------------

Vamos a establecer un fondo de pantalla a través de una GPO y a instalar VideoLaN en los ordenadores que se encuentran en la UO Barcelona / Administración, es decir WC5Int-tunombre y WC6-tunombre

.. image:: imagenes/GPOINT01.png

En Inicio/Herramientas administrativas de Windows/Administración de directivas de grupo creamos una GPO llamada FondoPantalla y otra que se llame intalar VLC

.. image:: imagenes/GPOINT02.png

Utilizaremos la carpeta C:\\Windows\\SYSVOL [#sysvol]_, esta carpeta se comparte de forma predeterminada en los controladores de dominio, lo que permite a los clientes y otros controladores de dominio acceder a los archivos de políticas de grupo y scripts de inicio y cierre.

.. image:: imagenes/GPOINT03.png

En el Objeto de **directiva de grupo (GPO) Instalar VLC**, en la pestaña de **Configuración/Configuracióndel equipo**  vamos a Edición, en **Directivas Intalar VLC/Configuración del equipo/Directivas/Configuración de software/Instalación de sofware/** creamos un nuevo paquete y especificar la ubicación del programa (.msi o .exe) y seleccionamos el método de implementación asignada

.. image:: imagenes/GPOINT04.png

Para cambiar el fondo de pantalla,  editamos la directiva FondoPantalla, y en **Configuración de usuario/Directivas/Plantillas administrativas/Active Desktop/Tapiz del escritorio**, lo habilitamos

.. image:: imagenes/GPOINT05.png

Por ultimo vamos a **Administracion de directivas de grupo/** buscamos **Oficina/Barcelona/Administración** vinculamos las **dos GPO existenetes**

.. image:: imagenes/GPOINT06.png

Configuración de carpetas compartidas
-------------------------------------

Crea las siguientes carpetas compartidas con los siguientes permisos:

* C:\\compartida\\empleados\\E01_tunombre (E01_tunombre tiene permisos de lectura y escritura)
  
* C:\\compartida\\empleados\\E01_tunombre (E02_tunombre tiene permisos de lectura y escritura)

* C:\\compartida\\empleados\\empleados_compartida (al grupo de empleados tiene permiso de lectura)
 
* C:\\compartida\\contratista\\C01_tunombre (C01_tunombre tiene permisos de lectura y escritura)

* C:\\compartida\\contratista\\C01_tunombre (C02_tunombre tiene permisos de lectura y escritura)

* C:\\compartida\\contratista\\contratista_compartida (al grupo de contratista tiene permiso de lectura)

Montaje de una unidad
---------------------

Queremos que se monten de forma automatica la carpeta contratista_compartida en h: y la carpeta empleados_compartida i: para ello copiamos el siguiente script llamado **montar.bat** en \\\\SRVInt-tunombre\\NETLOGON o directamente en C:\Windows\SYSVOL\sysvol\empresa_tunombre.local\scripts

.. code-block:: bash

  net use h: \\SRVInt-tunombre\contratistas_compartida
  net use i: \\SRVInt-tunombre\empleados_compartida
  
Vamos a los usuarios en los que queremos que se monten las unidades, **Usuarios y equipos del AD / Usuarios / Empleados / E02_tunombre / propiedades y en la pestaña de perfil**  lo metemos en el Script de inicio de sesión

.. image:: imagenes/Perfil01.png

Perfil móvil
------------
Vamos a crear un perfil movil a los contratistas, para ello primero creamos una carpeta compartida llamada Perfiles con acceso de escritura y lectura para todos los usuarios.

En **Usuarios y equipos de Active Directory**, En la ventana de propiedades de la cuenta, hacemos clic sobre la solapa Perfil. En ella, debemos dar valor al cuadro de texto Ruta de acceso al perfil. El contenido seguirá el siguiente formato: **\\\\SRVInt-tunombre\\Perfiles\\C01_tunombre**, de forma mas general podríamos cambiar C01_tunombre por **%username%**

.. image:: imagenes/Perfil02.png

Aplicar cuota
-------------

Lo primero es agregar los roles y caracteríscas necesarias, en Administrador del servidor / Agregar roles y caracteristicas, en la lista de roles, dentro de "Servidor de archivos y almacenamiento / Servidor de iSCSI y archivo / Administrador de recursos del servidor de archivos"

.. image:: imagenes/CuotaAD01.png

Para activar las cuotas vamos a:

.. image:: imagenes/CuotaAD02.png

Creamos una nueva plantilla llamada **Límite 10MB tunombre**, con Advertencia al 20 y 50%

.. image:: imagenes/CuotaAD03.png

Aplica la plantilla creada en la carpeta compartida en la que se encunetran los perfiles móviles, cuando lo apliques no olvides marcar **Aplica la plantilla aut. y crear cuotas en subcarpetas nuevas y existentes.**

.. image:: imagenes/CuotaAD04.png

Inicia la sesión con algún usuario, copia algún archivo para que exceda la cuota, cuando cierres la sesisión te dara un error en la sincronización del perfil, vuelve a loguearte con el usuario y abre el visor de eventos:

.. image:: imagenes/CuotaAD05.png


Perfil Obligatorio
------------------

Un perfil obligatorio es un tipo especial de perfil de usuario que se carga desde una ubicación específica en lugar de desde la carpeta de perfil de usuario normalmente utilizada. Esto significa que los cambios realizados por el usuario durante la sesión no se guardan entre sesiones.

1. Creamos un nuevo perfil móvil, vamos a llamarlo usuario_plantilla : \\\\SRVInt-tunombre\\Perfiles\\usuario_plantilla

#. Iniciamos sesión en el cliente con el usuario plantilla, hacemos un link simbolico del block de notas en el escriotrio, creamos una carpeta llamada DOC, y cierra la pestaña sesión para que se cree la carpeta usuario_plantilla.v6 en la compartida de Perfiles 

#. Creamos en el servidor un nuevo grupo llamado perfilobligatorio

#. Cambiamos los permisos de seguridad a la carpeta usuario_plantilla.v6, ponemos al grupo de Administradores, reemplazamos propietario en contenedores y objetos. Añadimos tambien al grupo de perfilesobligatorios y le damos control total, recordar darlo con herencia.

#. Entramos en la carpeta usuario_plantilla.v6, activamos los elementos ocultos, si hay una carpeta en AppData llamada localLow o Roaming la eliminamos.

#. Abrimos el registro y vamos a HKEY_USERS, vamos a archivo, cargamos subarbol/usario_plantilla elegimos el archivo NTUSER.DAT, abrimos y le ponemos nombre a la clave (perfilobligatorio) y le damos permisos al grupo perfileobligatorio, le damos control total con herencia. Finalmente le damos archivo y descargamos el subárbol.

#. En el usuario_plantilla.v6 cambiamos NTUSER.DAT NTUSER.MAM.

#. Creamos el uausio C03_tunombre, le asignamos el Perfil \\\\srvint-tunombre\\Perfiles\\usuario_plantilla y le metomos en el grupo perfiles obligatorios
 
