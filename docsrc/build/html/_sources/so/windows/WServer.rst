**************
Windows Server
**************

Windows Server es la plataforma para crear una infraestructura de aplicaciones conectadas, redes y servicios web. Como administrador de Windows Server, probablemente haya usado muchas de las consolas nativas de Administración de Microsoft (MMC) de Windows Server para mantener la infraestructura segura y disponible.


* **Windows Server Standard:** permite ejecutar como máximo dos VMs en hasta dos procesadores y 64GB RAM. Es ideal para un entorno no virtualizado o poco virtualizado en el que se desee incluir características de alta disponibilidad.

* **Windows Server  Datacenter:** permite ejecutar un número ilimitado de VMs en hasta dos procesadores. Se recomienda para un entorno altamente virtualizado que requiera características de alta disponibilidad, incluida la agrupación en clústeres.

* Respecto a la interfaz de usuario, se ofrecen dos posibilidades pero siempre se podrá pasar de una opción a la otra libremente en cualquier momento.

  * **Server Core:** reduce el espacio requerido en el disco, la posible superficie expuesta a ataques y especialmente los requisitos de servicio y reinicio del servidor.
  
  * **Servidor con una GUI:** ofrece los elementos de la interfaz de usuario y las herramientas de administración de gráficos.

Active Directory
================

El Directorio Activo o Active Directory es un servicio de directorio de red que proporciona una infraestructura de directorio lógica para la administración de usuarios, ordenadores y otros recursos en una red informática. Se utiliza comúnmente en entornos empresariales para facilitar la administración de la red y proporcionar una autenticación unificada para los usuarios.

El directorio activo se basa en el protocolo LDAP (Lightweight Directory Access Protocol) y utiliza un árbol jerárquico para organizar los objetos en la red, como usuarios, ordenadores y dispositivos. Cada objeto en el directorio activo tiene atributos asociados, como nombre de usuario, dirección de correo electrónico y dirección de red, que se pueden utilizar para buscar y filtrar objetos.

El directorio activo se utiliza para facilitar la administración centralizada de la red y proporcionar una autenticación unificada para los usuarios. Por ejemplo, si un usuario cambia su contraseña en el directorio activo, esa contraseña se actualizará en todos los servicios y aplicaciones que utilicen el directorio activo para la autenticación. También se pueden utilizar los grupos del directorio activo para controlar el acceso a recursos en la red y simplificar la administración de permisos.

Controlador de dominio
================

El controlador de dominio es un componente clave del directorio activo (Active Directory) que proporciona servicios de autenticación y autorización a los usuarios y equipos en un dominio de Active Directory. También proporciona servicios de replicación de directorio a través de la red y mantiene una copia del directorio activo en sí.

Dominio
======

Un dominio es una unidad mínima de directorio que internamente contiene información sobre los recursos (usuarios, grupos, directivas...) disponibles para los ordenadores que forman parte de dicho dominio.

El primer dominio de un árbol se denomina dominio raíz. Todos los dominios que comparten el mismo dominio raíz forman un árbol de dominios y constituyen un espacio de nombres contiguo. Los dominios adicionales del mismo árbol de dominios se denominan dominios secundarios o  subdominios.

Un dominio que se encuentra inmediatamente encima de otro dominio del Administración de  Sistemas Corporativos basados en Windows 2012 Server: Active Directory mismo árbol se denomina dominio principal del dominio secundario. Los dominios que forman parte de un árbol están unidos entre sí mediante relaciones de confianza transitivas y bidireccionales. Estas relaciones permiten que un único proceso de inicio de sesión sirva para autenticar un usuario en todos los dominios del bosque o del árbol de dominios.

Un bosque está formado por uno o varios árboles de dominio. Los árboles de dominio de un bosque no constituyen un espacio de nombres contiguo, pero podría ocurrir que hubiese dos árboles en un bosque con nombres de subdominio iguales. Los bosques no tienen ningún dominio raíz propiamente dicho. El dominio raíz de un bosque por convenio es el primer dominio que se creó en el bosque.

Unidades organizativas
==========

Las unidades organizativas del directorio activo son objetos lógicos utilizados para organizar y gestionar los recursos de una red de computadoras basada en el protocolo de directorio activo de Microsoft. Las unidades organizativas se utilizan para agrupar objetos de directorio, como usuarios, grupos y equipos, y para aplicar políticas y configuraciones a ellos de manera centralizada.

Las unidades organizativas se crean en una jerarquía dentro del directorio activo y se pueden utilizar para representar la estructura de la empresa, como departamentos o ubicaciones geográficas. Cada unidad organizativa tiene su propio espacio de nombres y puede tener objetos secundarios, como otras unidades organizativas o objetos de usuario, grupo o equipo.

Grupos
=====

* Tipos de grupos

  * Los grupos de distribución sólo se pueden utilizar con aplicaciones de correo electrónico para enviar correo electrónico a grupos de usuarios. Los grupos de distribución no tienen habilitada la seguridad, lo que significa que no se pueden incluir en las listas de control de acceso.
  * Los grupos de seguridad se utilizan para controlar el acceso a los recursos de la red. Se pueden crear reglas de acceso a recursos, como carpetas compartidas o impresoras, y aplicarlas a un grupo de usuarios. Los usuarios que pertenecen al grupo tendrán acceso a los recursos permitidos por las reglas de acceso del grupo.

* Ámbitos

  * Los grupos de ámbito universal: pueden incluir como miembros las cuentas de cualquier dominio del bosque, los grupos globales y los grupos universales. Además, al grupo se le puede asignar permisos en cualquier dominio.
  * Los grupos de ámbito global: pueden incluir como miembros las cuentas del mismo dominio y los grupos globales del mismo dominio. Además, se le puede asignar permisos en cualquier dominio.
  * Los grupos de ámbito de dominio local: pueden incluir como miembros cuentas de cualquier dominio, grupos globales, grupos universales y grupos locales de dominio pero sólo del mismo dominio que el grupo local de dominio principal. Además, los permisos de miembro sólo se pueden asignar en el mismo dominio que el grupo local de dominio principal.

Tipos de perfiles de usuario
====================

Como se ha podido deducir por lo dicho hasta ahora, existen diferentes tipos de perfiles de usuario que utilizaremos según las necesidades particulares de cada momento.

Entre los perfiles de usuario que podemos utilizar, se encuentran los siguientes:

* *Perfil de usuario local*: Se guarda en el disco duro local del equipo cliente, de modo que todas las modificaciones que se realicen serán específicas del ordenador en el que se han establecido.

* *Perfil de usuario móvil*: Los crea el administrador y se almacenan en una carpeta compartida por el servidor. Está asociada a la cuenta del dominio, de modo que estará disponible de forma independiente al ordenador concreto desde el que inicie sesión el usuario. Dado que el perfil se encuentra en el servidor, todos los cambios realizados en éste también se guardan en el servidor.

* *Perfil de usuario obligatorio*: Podríamos decir que son perfiles móviles de sólo lectura, ya que solamente los administradores del dominio pueden realizar cambios en estos perfiles. De esta forma, el administrador podrá definir configuraciones para usuarios o grupos, y éstos no podrán cambiarlos.

* *Perfil de usuario temporal*: Cuando se produce un error que impide cargar un perfil móvil o un perfil obligatorio, se crea un perfil temporal para facilitar el inicio de sesión del usuario. Cuando el usuario acaba su sesión, el perfil temporal se elimina y se pierden todas las modificaciones realizadas por el usuario en su entorno.

* *Perfil de usuario super-obligatorio*: Este tipo de perfiles se incorpora a partir de Windows Server 2008 y su objetivo es similar al de los perfiles obligatorios, con la diferencia de que, si se produce un error que impida cargar el perfil, el usuario no podrá iniciar sesión. En otras palabras, un perfil de usuario super-obligatorio impedirá que se cargue un perfil temporal cuando exista algún motivo que impida la carga del perfil super-obligatorio.

Directiva de Grupo GPO
==============

**Directiva de Grupo** es una característica de Windows NT, familia de Sistemas Operativos. Directiva de grupo es un conjunto de reglas que controlan el entorno de trabajo de cuentas de usuario y cuentas de equipo. Directiva de grupo proporciona la gestión centralizada y configuración de sistemas operativos, aplicaciones y configuración de los usuarios en un entorno de Active Directory. En otras palabras, la Directiva de Grupo, en parte, controla lo que los usuarios pueden y no pueden hacer en un sistema informático

Las GPO se pueden diferenciar dependiendo del objeto al que configuran y se pueden entender en distintos niveles:

* Equipo Local: tan solo se aplican en el equipo que las tiene asignadas independientemente del dominio al que pertenezca.
* Sitio: se aplican a los equipos y/o usuarios de un sitio, independientemente del dominio.
* Dominio: se aplican a todos los equipos y/o usuarios de un dominio.
* Unidad Organizativa (OU): se aplican únicamente a los equipos y/o usuarios que pertenecen a la OU.

Windows Deployment Services (WDS)
================

Windows Deployment Services (WDS) es un servicio que nos permite, a través de un rol de Windows Server, cargar los ficheros de las imágenes de instalación de Windows en un servidor y lanzar una instalación desde el Network Boot PXE del ordenador.

