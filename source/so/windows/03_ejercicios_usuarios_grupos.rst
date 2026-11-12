******************************
Ejercicio de usuarios y grupos
******************************

Este ejercicio se hace sobre la máquina virtual de Windows 11 Education (``lusrmgr.msc`` y ``secpol.msc`` no existen en Windows 11 Home). Antes de empezar, consulta :ref:`Usuarios y grupos Windows` y :ref:`Permisos NTFS`.

**Primera parte: Grupos y usuarios**

Utiliza ``lusrmgr.msc`` para:

* Crear los grupos **GA** y **GB**.
* Crear los usuarios **tunombre_A01**, **tunombre_A02**, **tunombre_B01** y **tunombre_B02**, todos con contraseña: Windows no deja entrar por red a una cuenta sin contraseña.
* Agregar al grupo GA los usuarios tunombre_A01 y tunombre_A02.
* Agregar al grupo GB los usuarios tunombre_B01 y tunombre_B02.

Sube el **pantallazo**\ :sup:`1`, con las propiedades del grupo GB, donde se vean los usuarios que pertenecen a él.

**Segunda parte: Permisos de carpetas**

Inicia sesión al menos una vez con tunombre_A01, tunombre_A02, tunombre_B01 y tunombre_B02. Así se crean sus carpetas en ``C:\Usuarios``:

.. image:: imagenes/usuarios_carpetas_users.png

* Inicia sesión como tunombre_A01 y crea en el escritorio una carpeta llamada **tunombre**.
* Haz clic con el botón derecho sobre ella, **Conceder acceso a / Usuarios específicos…**, agrega a tunombre_A02 con permisos de **Lectura y escritura** y pulsa **Compartir**.
* Sube el **pantallazo**\ :sup:`2`, con las propiedades de la carpeta.

Inicia sesión como tunombre_A02 y responde:

* **2.1** ¿Puede entrar en ``C:\Users\tunombre_B01``?
* **2.2** ¿Puede entrar en ``C:\Users\tunombre_A01``?
* **2.3** ¿Puede entrar en ``C:\Users\tunombre_A01\Contacts``?
* **2.4** ¿Puede entrar en ``C:\Users\tunombre_A01\Desktop\tunombre``?

**Tercera parte: Carpetas compartidas**

* Pon la red de la máquina virtual en **adaptador puente** (Configuración / Red / Conectado a: Adaptador puente).
* Abre el Símbolo del sistema, ejecuta ``ipconfig`` y apunta la IP.
* Inicia sesión como tunombre_A01 y crea una carpeta llamada **tunombre** en la unidad E: (el disco que creaste en :ref:`Ejercicios de configuración`).
* Haz clic con el botón derecho sobre ella, **Propiedades / Compartir / Compartir…**, y da permisos de **Lectura y escritura** al grupo **GA** y de **Lectura** al grupo **GB**. Así no hay que dar permisos usuario a usuario:

  .. image:: imagenes/usuarios_compartir.png

* Si Windows pregunta si quieres activar la detección de redes y el uso compartido de archivos, acepta. Si después no llegas a la carpeta, pon la red como **privada** en Configuración / Red e Internet / Ethernet.
* Abre la carpeta compartida desde tu ordenador (en Windows ``\\IP``; en Linux ``smb://IP``) y sube el **pantallazo**\ :sup:`3`, donde se vea cómo has iniciado sesión desde tu ordenador, por ejemplo:

  .. image:: imagenes/usuarios_smb.png

Responde:

* **3.1** ¿Puedes leer y escribir en la carpeta con el usuario tunombre?
* **3.2** ¿Y con tunombre_A01?
* **3.3** ¿Y con tunombre_A02?
* **3.4** ¿Y con tunombre_B01?
* **3.5** ¿Y con tunombre_B02?
* **3.6** Si llega un usuario nuevo, tunombre_A03, ¿qué tienes que hacer para que pueda leer y escribir en la carpeta?

**Cuarta parte: Directivas de contraseñas**

Consulta el apartado :ref:`Directivas de contraseñas locales`. Inicia sesión con una cuenta de administrador y, con ``secpol.msc``, configura:

* Longitud mínima de la contraseña: **8** caracteres.
* La contraseña debe cumplir los requisitos de complejidad: **Habilitada**.
* Vigencia máxima de la contraseña: **30** días.
* Umbral de bloqueo de cuenta: **3** intentos.
* Duración del bloqueo de cuenta: **5** minutos.

Abre el Símbolo del sistema como administrador, ejecuta ``net accounts`` y sube el **pantallazo**\ :sup:`4`, donde se vean los valores nuevos.

En esa misma ventana, intenta cambiar la contraseña de tunombre_B02 por una que no cumpla la directiva:

.. code-block:: bat

   net user tunombre_B02 1234

Responde:

* **4.1** ¿Qué mensaje aparece?
* **4.2** Escribe una contraseña que sí acepte y explica por qué cumple la directiva.
* **4.3** Las contraseñas de tunombre_A01 y tunombre_A02 ya existían. ¿Siguen funcionando? ¿Por qué?

Ahora cierra la sesión e intenta entrar como tunombre_B01 con una contraseña equivocada hasta que la cuenta se bloquee.

* **4.4** ¿Qué mensaje aparece cuando la cuenta se bloquea?
* Entra como administrador y abre las propiedades de tunombre_B01 en ``lusrmgr.msc``. Sube el **pantallazo**\ :sup:`5`, donde se vea marcada la casilla **La cuenta está bloqueada**.
* Desbloquea la cuenta. **4.5** ¿Cómo lo has hecho?
