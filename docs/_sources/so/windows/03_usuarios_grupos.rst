*************************
Usuarios y grupos Windows
*************************

Cuenta de usuario
=================

Una cuenta de usuario se utiliza para:

* Autenticar la identidad del usuario
* Autorizar o denegar el acceso a los recursos
* Administrar la seguridad
* Auditar las acciones realizadas con la cuenta

Hay dos cuentas predefinidas: **Administrador** e **Invitado**; en las versiones actuales de Windows ambas vienen **deshabilitadas** por defecto (el primer usuario que se crea durante la instalación pertenece al grupo Administradores).

Un usuario local es una cuenta a la que se pueden conceder permisos y derechos para el equipo donde se está creando la cuenta. Desde Windows 8 se puede iniciar sesión también con una **cuenta Microsoft** (asociada a un correo), que sincroniza la configuración entre equipos; en los equipos de un dominio se usan cuentas de dominio (lo veremos con Active Directory).

Grupos
======

Se utilizan para poder asignar privilegios comunes a varios usuarios o equipos, haciendo más sencilla la administración.

Un usuario puede pertenecer a varios grupos y tener los permisos asignados a cada uno de ellos.

Durante la instalación del sistema se crean ciertos **grupos integrados**, entre otros:

* **Administradores**: control total del equipo.
* **Usuarios**: pueden trabajar con normalidad, pero no cambiar la configuración del sistema ni instalar software.
* **Invitados**: acceso muy limitado, sin perfil permanente.
* **Operadores de copia de seguridad**: pueden hacer copias de seguridad y restaurar archivos aunque no tengan permisos sobre ellos.
* **Usuarios de escritorio remoto**: pueden iniciar sesión de forma remota.

Además existen las **identidades especiales**, grupos cuyos miembros no se asignan a mano sino que los gestiona el propio sistema según la situación: **Todos**, **Usuarios autentificados**, **INTERACTIVE** (los que han iniciado sesión localmente), **SYSTEM**, etc.

Para administrar los usuarios y grupos locales ejecutamos el comando **lusrmgr.msc**

.. image:: imagenes/lusrmgr.png

También podemos administrarlos desde la línea de comandos (en PowerShell, donde # es un comentario; en cmd los comentarios serían con rem):

.. code-block:: powershell

 net user                          # lista los usuarios
 net user maria alumno /add        # crea el usuario maria con contraseña alumno
 net user maria /delete            # borra el usuario
 net localgroup                    # lista los grupos
 net localgroup profes /add        # crea el grupo profes
 net localgroup profes maria /add  # mete a maria en el grupo profes
 whoami                            # usuario actual
 whoami /groups                    # grupos a los que pertenece

Un grupo local
==============

Un grupo local es una cuenta a la que se pueden conceder permisos y derechos para el equipo donde se ha creado

Control de cuentas de usuario (UAC)
===================================

Aunque un usuario pertenezca al grupo Administradores, sus programas se ejecutan normalmente **sin** privilegios de administrador: cuando una acción los necesita, el **UAC** (User Account Control) oscurece la pantalla y pide confirmación — es la **elevación de privilegios**, el paralelo del sudo de GNU/Linux. Si el usuario es estándar, en lugar de confirmar deberá introducir las credenciales de un administrador.

* Para ejecutar un programa elevado desde el principio: clic derecho → **Ejecutar como administrador**.
* El nivel de aviso se configura en Panel de control → Cuentas de usuario → **Cambiar configuración de Control de cuentas de usuario** (cuatro niveles, desde avisar siempre hasta no avisar nunca; no es recomendable desactivarlo).

Perfiles de usuario
===================

El perfil de usuario define el entorno de trabajo del usuario (escritorio, documentos, configuración...). Se guarda en **C:\\Users\\nombre** (la parte de configuración del registro está en su archivo **ntuser.dat**). Hay varios tipos:

* **Perfil local**: sólo es accesible desde el equipo donde se ha creado. Es el habitual.
* **Perfil móvil (roaming)**: se guarda en un servidor, de forma que el usuario encuentra su entorno en cualquier equipo del dominio desde el que inicie sesión.
* **Perfil obligatorio**: un perfil móvil de solo lectura; los cambios del usuario se pierden al cerrar la sesión (útil en aulas).
* **Perfil temporal**: se crea cuando se produce un error en la carga del perfil de usuario, y se elimina al final de la sesión.

Se accede mediante la ficha Perfil de la pantalla de Propiedades del usuario:

.. image:: imagenes/perfil_usuario_windows.png

* Un perfil de usuario permite asignar scripts de inicio de sesión y rutas de acceso locales

* Un script de inicio de sesión es un archivo con extensión .bat que contiene una secuencia de comandos que se ejecuta automáticamente cuando el usuario inicia una sesión.

* Una ruta de acceso local es una ruta a un directorio local privado del usuario. Es el directorio predeterminado en Símbolo de Sistema.
