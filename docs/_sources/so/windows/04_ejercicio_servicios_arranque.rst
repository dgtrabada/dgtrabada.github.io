*********************************
Ejercicio de servicios y arranque
*********************************

Este ejercicio se hace sobre la máquina virtual de Windows 11. Antes de empezar, consulta :ref:`Arranque de Windows`.

**Primera parte: Consulta de servicios**

Abre la consola de servicios (Inicio / Ejecutar / ``services.msc``) y responde:

* **1.1** ¿Qué servicio se encarga de las actualizaciones de Windows?
* **1.2** ¿En qué estado está (en ejecución, detenido…)?
* **1.3** ¿Qué tipo de inicio tiene configurado (automático, manual, deshabilitado)?

Sube el **pantallazo**\ :sup:`1`, donde se vean la lista de servicios y el estado de alguno de ellos.

**Segunda parte: Servicios desde la línea de comandos**

Abre PowerShell como administrador y ejecuta:

.. code-block:: powershell

   Get-Service
   Get-Service Spooler

Responde:

* **2.1** ¿Qué información muestra el comando ``Get-Service``?
* **2.2** ¿Qué estado indica ``Get-Service Spooler``?

**Tercera parte: Modificación de un servicio**

Busca el servicio **Cola de impresión** (*Print Spooler*) y detenlo desde PowerShell como administrador con ``Stop-Service``.

Sube el **pantallazo**\ :sup:`2`, donde se vea que el servicio está detenido.

**Cuarta parte: Programas de inicio**

Abre el Administrador de tareas (**Ctrl+Mayús+Esc**), ve a la pestaña **Aplicaciones de arranque** y responde:

* **4.1** ¿Qué programas se inician automáticamente?
* **4.2** ¿Cuál tiene mayor impacto en el inicio?

Deshabilita uno que no sea crítico y sube el **pantallazo**\ :sup:`3`, donde se vean la lista de programas de inicio y el cambio realizado.

**Quinta parte: Arranque del sistema**

* Crea un clon enlazado de la máquina virtual de Windows 11 y haz el resto del ejercicio en el clon.
* Con ``msconfig`` (consulta :ref:`msconfig`), haz que el siguiente arranque sea en **Arranque a prueba de errores** con la opción **Shell alterno**.
* Reinicia, ve a tu escritorio, ejecuta ``dir`` y sube el **pantallazo**\ :sup:`4`, donde se vea la salida del comando. Si el arranque con shell alterno no funciona, sube un pantallazo del modo seguro.
* Para salir, escribe ``shutdown -r``.

Responde y hazlo:

* **5.1** ¿Qué hay que hacer para que Windows vuelva a iniciarse de forma normal?

Cuando Windows arranque de forma normal, sube el **pantallazo**\ :sup:`5`.
