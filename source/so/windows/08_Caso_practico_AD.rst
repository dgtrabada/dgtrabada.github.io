*******************************************************
Casos prácticos : Active Directory con adaptador puente
*******************************************************

Crea los siguientes clones enlazados con los adaptadores en modo puente:

* Clon enlazado 1 de `Windows Server 2022 <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-server-2022>`_ llamado **SRV-tunombre** con IP 10.4.X.Y/8, DHCP si es portátil
* Clon enlazado 2 de `Windows 11 <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-11>`_ llamado **WC5-tunombre** 10.5.X.Y/8, DHCP si es portátil

El servidor debe tener **IP fija**: va a ser el controlador de dominio y el DNS de la red, y los clientes lo tienen que localizar siempre en la misma dirección.

Puedes ver la configuración en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/v7q1diqc4c9ldsg6>`_

Instalación y configuración de Active Directory y DNS
-----------------------------------------------------

* En **SRV-tunombre** vamos a **Administrador del servidor/Panel/Agregar roles y características/Instalación basada en características o en roles** Seleccionar un servidor del grupo de servidores, escoger **SRV-tunombre/Marcar la casilla Servicios de dominio de Active Directory**


Creación de un dominio
----------------------

* Partiendo de la ventana Resultados de la instalación de Active Directory, pulsar en Promover este servidor a controlador de dominio. (Si se había cerrado la ventana anterior es posible acceder a ella pulsando en el icono de advertencia de la barra de herramientas del Administrador del servidor)

  .. image:: imagenes/WS_promoverservidorCD.png
    
* De momento, el servidor SRV-tunombre no pertenece a ningún dominio. Tampoco existe un bosque al que agregar un nuevo dominio. Por lo tanto, el primer paso para formar el dominio **tunombre.local** es crear un nuevo bosque. Para ello seleccionar la opción **Agregar un nuevo bosque**. Tras escribir el nombre del dominio: tunombre.local, pulsar Siguiente. En capacidades del controlador del dominio, el Servidor de Sistema de nombres de dominio (DNS) y el Catálogo global (GC) deben estar marcados. Como contraseña de **restauración de servicios de directorio (DSRM)** [#DSRM]_ pondremos @lumn0

Verificar el nombre NetBIOS [#NetBIOS]_ tunombre y pulsar Siguiente

Si todo ha sido configurado correctamente, hacer clic en Instalar.

Por último, cuando se reinicie, habilita las actualizaciones dinámicas para que los clientes puedan registrar automáticamente sus nombres en el DNS: en **Inicio->Herramientas administrativas/DNS/expandir SRV-TUNOMBRE/expandir Zonas de búsqueda directa/** clic con el botón derecho del ratón en **tunombre.local/Propiedades/General/lista Actualizaciones dinámicas**, elegir **sin seguridad y con seguridad** y a continuación hacer clic en Aceptar.

Unidades Organizativas, usuarios y grupos
-----------------------------------------

La estructura lógica de Windows Server se basa en la utilización de dominios y unidades organizativas. En un dominio se puede crear una jerarquía de unidades organizativas, las cuales pueden contener usuarios, grupos, equipos, impresoras y carpetas compartidas, además de otras unidades organizativas.

Para crear las unidades organizativas, en **Inicio/Herramientas administrativas/Usuarios y equipos de Active Directory**, dentro del dominio **tunombre.local** crea las unidades organizativas **Usuarios** y **Grupos** (clic con el botón derecho del ratón -> Nuevo -> Unidad Organizativa)

.. image:: imagenes/WS_UO.png

Dentro de la UO Grupos, crea los grupos de seguridad de ámbito global **A** y **B**

Dentro de la UO Usuarios, crea los usuarios:

* tunombreA1

  * Nombre completo: tunombreA1 tuapellidoA1.
  * Contraseña @lumn0A1
  * Nombre de inicio de sesión del usuario: tunombreA1@tunombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo A

* tunombreA2 

  * Nombre completo: tunombreA2 tuapellidoA2
  * Contraseña @lumn0A2
  * Nombre de inicio de sesión del usuario: tunombreA2@tunombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo A

* tunombreB1

  * Nombre completo: tunombreB1 tuapellidoB1.
  * Contraseña @lumn0B1
  * Nombre de inicio de sesión del usuario: tunombreB1@tunombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo B

* tunombreB2 

  * Nombre completo: tunombreB2 tuapellidoB2
  * Contraseña @lumn0B2
  * Nombre de inicio de sesión del usuario: tunombreB2@tunombre.local
  * La contraseña nunca expira
  * Hazle miembro del grupo B


Unir un equipo al dominio
-------------------------

Vamos a unir **WC5-tunombre** al dominio tunombre.local, para ello:

1. Cambiamos el nombre de la máquina a **WC5-tunombre**.

#. Ponemos como servidor DNS la IP de **SRV-tunombre** (10.4.X.Y): es el requisito imprescindible, porque el cliente localiza el controlador de dominio preguntando a ese DNS.

#. Haz clic derecho en el botón "Inicio" y selecciona "Sistema > Información" en el menú desplegable.

#. En la ventana de "Sistema", haz clic en "Configuración avanzada del sistema" en el panel izquierdo.

#. Se abrirá la ventana de "Propiedades del sistema". Haz clic en la pestaña "Nombre de equipo" y luego en el botón "Cambiar".

#. En la siguiente ventana, verás la opción "Miembro de". Asegúrate de seleccionar la opción "Dominio" en lugar de "Grupo de trabajo".

#. Ingresa un nombre del dominio **tunombre.local**

   .. image:: imagenes/quitar_dominio.png


#. Al aceptar te pedirá las credenciales de un usuario del dominio con permisos para unir equipos (por ejemplo **Administrador**).

#. Haz clic en "OK" para guardar los cambios. Es posible que se te solicite reiniciar el equipo para aplicar los nuevos ajustes.

#. Para comprobarlo, en la pantalla de inicio de sesión elige "Otro usuario" y entra con una cuenta del dominio, por ejemplo **tunombreA1@tunombre.local**. En el servidor, el equipo aparecerá en el contenedor **Computers** de *Usuarios y equipos de Active Directory*.


Quitar el equipo del dominio
----------------------------

1. Accede al equipo con una cuenta de administrador local.

#. Haz clic derecho en el botón "Inicio" y selecciona "Sistema" en el menú desplegable.

#. En la ventana de "Sistema", haz clic en "Configuración avanzada del sistema" en el panel izquierdo.

#. Se abrirá la ventana de "Propiedades del sistema". Haz clic en la pestaña "Nombre de equipo" y luego en el botón "Cambiar".

#. En la siguiente ventana, verás la opción "Miembro de". Asegúrate de seleccionar la opción "Grupo de trabajo" en lugar de "Dominio".

#. Ingresa un nombre de grupo de trabajo para el equipo. Por defecto, el grupo de trabajo suele ser "WORKGROUP", pero puedes ingresar un nombre diferente si lo deseas.

#. Haz clic en "OK" para guardar los cambios. Es posible que se te solicite reiniciar el equipo para aplicar los nuevos ajustes.

#. En el servidor **"Inicio/Herramientas administrativas/Usuarios y equipos de Active Directory/"**

#. Selecciona **tunombre.local**, y elimina del contenedor **Computers** las cuentas de los equipos que has sacado del dominio (quitar el equipo del dominio no borra su cuenta en el servidor).

Configurar una carpeta compartida
---------------------------------

Al compartir una carpeta intervienen dos juegos de permisos (ver :ref:`Permisos NTFS y carpetas compartidas`): los **permisos del recurso compartido** — que solo son tres: **Control total**, **Cambiar** y **Leer**, y solo se aplican al acceder por red — y los **permisos NTFS** de la carpeta. Cuando un usuario accede por red se aplica el más restrictivo de los dos.

Vamos a compartir la carpeta **C:\\compartida** alojada en nuestro servidor, con permisos solo de lectura. Para ello:

Con el botón **derecho del ratón** accedemos a las propiedades de la carpeta, vamos a la pestaña de **Compartir** y aquí, en **Uso compartido avanzado**, seleccionamos compartir esta carpeta.

En el mismo diálogo, en **Permisos**, comprobamos que **Todos** tiene solo permisos de **Lectura**.

Como podemos ver, está compartida en: **\\\\SRV-TUNOMBRE\\compartida** o **\\\\10.4.X.Y\\compartida**; si el cliente es GNU/Linux podemos acceder con **smb://10.4.X.Y/compartida**

Instalación de software utilizando directivas de grupo
------------------------------------------------------

Puedes ver la configuración en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/3eeqjzksxsgrpaco>`_

1. Vamos a instalar `VideoLAN <https://www.videolan.org/>`_ en formato msi [#msi]_ (la instalación de software por directivas de grupo solo admite paquetes ``.msi``). Para ello lo bajamos y lo guardamos dentro de la carpeta SYSVOL [#sysvol]_ **C:\\Windows\\Sysvol**, una carpeta que el servidor ya comparte con todos los equipos del dominio

#. Para crear un objeto de directiva de grupo, abre la consola de administración de directivas de grupo (Group Policy Management Console) en el controlador de dominio **Inicio/Herramientas administrativas de Windows/Administración de directivas de grupo**. Crea un nuevo objeto de directiva de grupo (GPO) **Instalar VLC**

   .. image:: imagenes/GPO_VLC.png

#. En la pestaña de **Configuración/Configuración del equipo** vamos a Edición

   .. image:: imagenes/GPO_VLC_configuracion.png

#. En **Directiva Instalar/Configuración del equipo/Directivas/Configuración de software** creamos un nuevo paquete  
   
   .. image:: imagenes/GPO_VLC_editar.png
   

#. Especificar la ubicación del paquete ``.msi`` **con su ruta de red** (``\\servidor\recurso\...``, en nuestro caso la carpeta compartida que hemos creado o, por lo general, SYSVOL [#sysvol]_), nunca con la ruta local ``C:\...``: son los clientes los que tienen que poder descargar el paquete. A continuación seleccionamos una instalación **asignada**: como la hemos puesto en *Configuración del equipo*, se instala automáticamente cuando el equipo arranca. (La instalación **publicada** solo está disponible en *Configuración de usuario*: el usuario puede elegir instalarla desde el Panel de control.)

   .. image:: imagenes/GPO_VLC_editar2.png
    
#. Haz un par de clientes más para nuestro dominio. Crea una nueva UO llamada Equipo y dentro crea otra llamada Despacho1, deja el cliente WC5-Tunombre fuera y dentro del Despacho1 el cliente WC6-Tunombre y WC7-Tunombre

   .. image:: imagenes/GPO_VLC_Equipos.png
    
#. En la consola de administración de Directivas de grupo, navega hasta  Despacho1, haz clic derecho en la OU y selecciona **Vincular un GPO existente**

   .. image:: imagenes/GPO_VLC_editar3.png
    
#. Los cambios en las políticas de grupo pueden requerir que el cliente se reinicie para que las configuraciones tengan efecto. Por otro lado si queremos aplicar nosotros mismos las directivas de grupo en los clientes de Windows, abre una ventana del símbolo del sistema (cmd) o PowerShell y ejecuta el comando **gpupdate /force**. Esto obligará al equipo a buscar y aplicar las nuevas directivas de grupo.


Unir un cliente Ubuntu al dominio
---------------------------------

Puedes ver la configuración en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/rc3ogoh99gwnkmbh>`_


* Configura la IP 10.10.X.Y/8 (255.0.0.0), donde X.Y son parte de las ips de vuestros equipos, con gateway 10.0.0.2 y subred 10.0.0.0/8 en el caso de que tengas un portátil utiliza DHCP.

* Cambia el DNS (IP del Windows Server), haz que aparezca en **/etc/hosts** el nombre del dominio y sincroniza la hora de los dos ordenadores (Kerberos rechaza la autenticación si los relojes difieren más de unos minutos).

Instalar los paquetes necesarios:

.. code-block:: bash

  apt install sssd-ad sssd-tools realmd adcli
  
  apt install krb5-user
  #Reino predeterminado de la versión 5 de Kerberos:
  Reino de Kerberos: tunombre.local
  Servidores : srv-tunombre.tunombre.local
  Servidor administrativo: srv-tunombre


  

Deshabilitamos la resolución inversa de DNS (rdns = false) en /etc/krb5.conf

.. code-block:: bash

  head -3  /etc/krb5.conf
  [libdefaults]
        default_realm = TUNOMBRE.LOCAL
        rdns = false

Añadimos nuestro Ubuntu al AD:

.. code-block:: bash

  sudo realm join --user=Administrador -v tunombre.local

Para que se cree el home de forma automática cuando el usuario inicia sesión (marcar la opción *Create home directory on login*):

.. code-block:: bash

  pam-auth-update

.. image:: imagenes/ubuntuADSRV.png

Seleccionar otro usuario

.. image:: imagenes/ubuntuAD.png
    :scale: 50%
    
También puedes conectarte por ssh
   
.. image:: imagenes/ubuntuADssh.png
    :scale: 50%
   
Ayuda: Usa "kinit administrador@tunombre.local" para iniciar sesión como administrador en el dominio. Puedes verificar la configuración DNS en "/etc/resolv.conf". Recuerda sincronizar los relojes de los sistemas para mantener una hora precisa en toda la red.

.. rubric:: Footnotes

.. [#NetBIOS] NetBIOS (Sistema Básico de Entrada/Salida de Red) es un protocolo de red desarrollado originalmente por IBM en los años 80. Es un protocolo de capa de aplicación que permite la comunicación entre dispositivos en una red local (LAN). Aunque es una tecnología más antigua, todavía se encuentra en uso en algunas redes, especialmente en entornos heredados y redes locales más pequeñas. Las características importantes de NetBIOS:

 * Identificación de nombres de red: NetBIOS proporciona un método para que los dispositivos en una red local se identifiquen entre sí mediante nombres de red. Estos nombres NetBIOS son de hasta 15 caracteres alfanuméricos y se utilizan para identificar recursos de red como impresoras, carpetas compartidas y otros dispositivos.

 * Resolución de nombres: NetBIOS también incluye un servicio de resolución de nombres que permite a los dispositivos de la red traducir nombres de recursos NetBIOS en direcciones IP que puedan ser utilizadas para la comunicación en la red.

 * Sesiones NetBIOS: NetBIOS permite establecer sesiones entre dispositivos en la red para la transferencia de datos. Estas sesiones pueden ser utilizadas para la comunicación entre aplicaciones en diferentes dispositivos.

 * Datagramas NetBIOS: Además de las sesiones, NetBIOS también admite la comunicación de datagramas, que son mensajes de longitud fija que pueden ser enviados a todos los dispositivos en la red o a dispositivos específicos.

 * Puertos NetBIOS: NetBIOS utiliza el puerto TCP/UDP 137 para la resolución de nombres, el puerto TCP 139 para las sesiones NetBIOS y el puerto UDP 138 para datagramas NetBIOS.

.. [#DSRM] La contraseña de **DSRM** (*Directory Services Restore Mode*, modo de restauración de servicios de directorio) es la del administrador local que se utiliza para arrancar el controlador de dominio en modo de recuperación cuando Active Directory no está disponible. No es la contraseña del administrador del dominio.

.. [#msi] El formato **MSI** es un estándar de instalación utilizado en Windows que proporciona una forma estructurada y coherente de distribuir, administrar y desinstalar aplicaciones. Permite una gestión centralizada, una instalación consistente y confiable, y un mantenimiento y actualización eficientes de las aplicaciones en entornos Windows.

.. [#sysvol] SYSVOL significa Volumen del Sistema, y es un directorio compartido utilizado por Active Directory (AD) para almacenar sus datos públicos, como políticas de grupo, scripts y otros datos esenciales. Juega un papel crucial en la replicación de controladores de dominio y en el mantenimiento de la consistencia en todo un dominio.

  Dentro de SYSVOL, encontrarás varias carpetas y archivos, incluidos:

  * **Policies** (Políticas): Esta carpeta contiene Objetos de Política de Grupo (GPO), que definen varios ajustes y configuraciones para usuarios y computadoras dentro de un dominio.

  * **Scripts**: Esta carpeta puede contener scripts de inicio de sesión u otros scripts utilizados para diversas tareas administrativas.

  * **Staging** (Escenario): Utilizado durante el proceso de replicación para preparar cambios antes de que se apliquen a otros controladores de dominio.

  * **Domain** (Dominio): Contiene información específica del dominio.

  * **StarterGPOs**: Contiene Objetos de Política de Grupo Iniciales, que son plantillas para crear nuevos GPO.
