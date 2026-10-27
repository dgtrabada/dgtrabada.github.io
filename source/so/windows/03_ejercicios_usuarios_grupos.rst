******************************
Ejercicio de usuarios y grupos
******************************

Este ejercicio se hace sobre la máquina virtual de Windows 11. Antes de empezar, consulta :ref:`Usuarios y grupos Windows` y :ref:`Permisos NTFS`.

**Primera parte: Grupos y usuarios**

Utiliza ``lusrmgr.msc`` para:

* Crear los grupos **GA** y **GB**.
* Crear los usuarios **tunombre_A01**, **tunombre_A02**, **tunombre_B01** y **tunombre_B02**.
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
* Haz clic con el botón derecho sobre ella, **Propiedades / Compartir / Compartir…**, y da permisos de **Lectura y escritura** a tunombre_A02 y de **Lectura** a tunombre_B01:

  .. image:: imagenes/usuarios_compartir.png

* Abre la carpeta compartida desde tu ordenador (en Windows ``\\IP``; en Linux ``smb://IP``) y sube el **pantallazo**\ :sup:`3`, donde se vea cómo has iniciado sesión desde tu ordenador, por ejemplo:

  .. image:: imagenes/usuarios_smb.png

Responde:

* **3.1** ¿Puedes leer y escribir en la carpeta con el usuario tunombre?
* **3.2** ¿Y con tunombre_A01?
* **3.3** ¿Y con tunombre_A02?
* **3.4** ¿Y con tunombre_B01?
* **3.5** ¿Y con tunombre_B02?
