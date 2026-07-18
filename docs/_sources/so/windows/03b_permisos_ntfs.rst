************************************
Permisos NTFS y carpetas compartidas
************************************

Permisos NTFS
=============

El sistema de archivos NTFS permite asignar permisos a archivos y carpetas mediante **listas de control de acceso (ACL)**: cada archivo o carpeta lleva una lista de entradas que indican qué usuarios y grupos pueden hacer qué. Se configuran desde **Propiedades → pestaña Seguridad**.

Los permisos básicos sobre una carpeta son:

* **Control total**: todo lo anterior más cambiar permisos y tomar posesión.
* **Modificar**: leer, ejecutar, escribir y borrar.
* **Lectura y ejecución**: ver el contenido y ejecutar programas.
* **Mostrar el contenido de la carpeta**: listar lo que contiene.
* **Lectura**: leer archivos y atributos.
* **Escritura**: crear archivos y carpetas y modificar su contenido.

Reglas que hay que conocer:

* **Los permisos se acumulan**: los permisos efectivos de un usuario son la suma de los suyos y los de todos los grupos a los que pertenece.
* **Denegar tiene prioridad sobre permitir**: si cualquiera de sus grupos tiene una denegación explícita, el usuario queda denegado.
* **Herencia**: las subcarpetas y archivos heredan por defecto los permisos de la carpeta que los contiene; se puede romper la herencia en Propiedades → Seguridad → Opciones avanzadas.
* El **propietario** de un archivo siempre puede cambiar sus permisos, y un administrador puede **tomar posesión** de cualquier archivo.
* Podemos comprobar qué puede hacer realmente un usuario en Propiedades → Seguridad → Opciones avanzadas → **Acceso efectivo**.

Desde la línea de comandos, las ACL se administran con **icacls**:

.. code-block:: powershell

 icacls C:\datos                            # ver los permisos
 icacls C:\datos /grant maria:(OI)(CI)M     # concede Modificar, heredable a archivos (OI) y carpetas (CI)
 icacls C:\datos /remove maria              # quita sus entradas
 icacls C:\datos /setowner maria            # cambia el propietario

Las letras de permiso más usadas en icacls son **F** (control total), **M** (modificar), **RX** (lectura y ejecución), **R** (lectura) y **W** (escritura).

Carpetas compartidas
====================

Para acceder a una carpeta desde otro equipo de la red hay que **compartirla**: Propiedades → pestaña **Compartir** → **Uso compartido avanzado**. El recurso queda accesible como ``\\equipo\recurso``, utilizando el protocolo SMB (el mismo que implementa Samba en GNU/Linux).

Los **permisos del recurso compartido** son solo tres — **Control total**, **Cambiar** y **Leer** — y se aplican únicamente cuando se accede **a través de la red** (no afectan al usuario sentado en el equipo).

.. important::

   Cuando un usuario accede por red, se combinan los permisos del recurso compartido y los permisos NTFS, y se aplica **el más restrictivo** de los dos. Por eso una configuración habitual es compartir el recurso con permisos amplios y afinar el control con los permisos NTFS.

Windows comparte automáticamente algunos recursos administrativos **ocultos**, cuyo nombre termina en ``$`` y no aparecen al explorar la red: ``C$`` (la unidad C:), ``ADMIN$`` (la carpeta de Windows)... Podemos crear los nuestros añadiendo ``$`` al nombre del recurso.

Desde la línea de comandos:

.. code-block:: powershell

 net share                                  # lista los recursos compartidos
 net share datos=C:\datos /grant:maria,change   # comparte C:\datos con permiso Cambiar para maria
 net share datos /delete                    # deja de compartir
 net use                                    # lista las conexiones de red
 net use Z: \\servidor\datos                # conecta el recurso como unidad Z:
 net use Z: /delete                         # desconecta la unidad
