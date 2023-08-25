**********
PowerShell
**********

PowerShell es una interfaz de consola con posibilidad de escritura y unión de comandos por medio de instrucciones. Es compatible con muchas plataformas, incluyendo Windows, macOS y Linux. PowerShell se distribuye bajo la licencia MIT, que es una licencia de software libre y de código abierto

Control de procesos y servicios
===============================

* **ps -> Get-Process** ver procesos
* **kill -> Stop-Process** mata procesos
* **Get-Service -ProcessName <servicio>**
* **Stop-Service -ProcessName <servicio>** 
* **Start-Service -ProcessName <servicio>**
* **Suspend-Service -ProcessName <servicio>**

Ejemplo:

.. code-block:: powershell
  
 calc.exe
 Get-Process -ProcessName CalculatorApp
 Stop-Process -ProcessName CalculatorApp
 calc.exe
 Stop-Process -Id 2828   

Ficheros y directorios
======================

* **cp -r -> Copy-Item** copiar
* **mv -> Move-Item** mover, renombrar
* **rm -> Remove-Item** borrar
* **mkdir** crear directorio
* **pwd -> Get-Location** donde te encuentras
* **ls -> Get-ChildItem** listar archivos y carpetas, para ver los archivos ocultos -h
* **diff -> Compare-Object** diferencias entre ficheros y directorios
* **echo** repetir salida estándar
* **Get-ChildItem -Recurse -Filter '*.txt'** busca todos los archivos *.txt
* **Get-Help -Name Get-ChildItem** obtener ayuda
* **Test-Path -Path <archivo>** nos dice si exite el archivo o carpeta
* **select -> Select-Object**


Alias [#alias]_
=====

* **New-Alias -Name "ver" -Value Get-ChildItem**
* **Get-Alias** ver los alias que hay en el sistema

Caracteres especiales
=====================

* \* ? \ " > >> |


Visualizadores de archivos
==========================

* **cat -> Get-Content** visualizar el contenido archivo
* **Get-Content archivo.dat -tail 10 -wait** es como el comando tail -f en GNULinux
* **more** mostrar archivos haciendo pausa en cada pantalla

Filtros y búsqueda información
==============================

* **sort -> Sort-Object** ordenar
* **sls -> Select-String = grep** filtrar,
* **Select-String -Pattern <texto>** -Quiet nos devuelve solo True o nada
* **ft -> Format-Table** dar a la salida formato de tabla :
  Get-Service | Format-Table -Property Name, DependentServices


Ejemplo:

.. code-block:: powershell

 PS C:\> Get-Alias -Name cat
 
 CommandType     Name 
 -----------     ---- 
 Alias           cat -> Get-Content 

 PS C:\> echo 1 > archivo.dat
 PS C:\> echo 2 >> archivo.dat
 PS C:\> Test-Path -Path .\archivo.dat   
 True
 2
 PS C:\> Get-Content archivo.dat
 1 
 2
 3
 PS C:\> Get-Content archivo.dat -Head 2
 1
 2
 PS C:\> cat archivo.dat -Head 2 | select -Last 1
 2
 PS C:\> Get-Content archivo.dat | select -First 2
 1  

 PS C:\> Get-Content archivo.dat | %{ $_ -replace '2', 'B' } 
 1 
 B
 3
 PS C:\> Get-Content archivo.dat | %{ $_ -replace '2', 'B' } | sort
 1 
 3
 B 
 
 PS C:\> sls 2 archivo.dat 

 archivo.dat:2:2
 
 
 PS C:\> sls 5 archivo.dat -Quiet
 False
 PS C:\> sls 2 archivo.dat -Quiet
 True


Gestión de ACL
==============

Access Control List o "Lista de Control de Acceso" es utilizado para definir y controlar los permisos de acceso a recursos, como archivos, carpetas, impresoras y otros objetos en un sistema informáticos, con el comando Get-Acl podemos obtener la ACL de una archivo o carpeta.

.. code-block:: powershell

  PS C:\Users> Get-Acl A

  Path Owner                   Access
  ---- -----                   ------
  A    BUILTIN\Administradores NT AUTHORITY\SYSTEM Allow  FullControl...

  PS C:\Users> $(Get-Acl A).Owner
  BUILTIN\Administradores
  PS C:\Users> $(Get-Acl A).Group
  WC22TUNOMBRE\Ninguno

Con el comando icacls puedes administrar las Listas de Control de Acceso (ACLs) en archivos y carpetas.

.. code-block:: powershell

  #Cambiar permisos en un archivo o carpeta:
  PS C:\Users> icacls A /grant "wc22tunombre\tu_nombrea1:(OI)(CI)RW"           
  PS C:\Users> Get-Acl A

  Path Owner                   Access
  ---- -----                   ------
  A    BUILTIN\Administradores WC22TUNOMBRE\tu_nombreA1 Allow  Write, Read, Synchronize...

  #le hemos dado permisos de RW al usuario tu_nombreA1
  
  #Para cambiar propietario
  icacls A /setowner "wc22tunombre\tu_nombrea1"
  

Ejemplo de como dar permisos de RW a un grupo completo:

.. code-block:: powershell

  $permissions = "Read", "Write" 

  $acl = Get-Acl -Path A

  # Crear una regla de acceso para el grupo A
  $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("A", $permissions, "ContainerInherit, ObjectInherit", "None", "Allow")

  $acl.SetAccessRule($accessRule)
  Set-Acl -Path A -AclObject $acl


Gestión de usuarios
===================

Para ser administrador

.. code-block:: powershell

 start-process powershell -verb runas

* **Listar usuarios, grupos y usuarios del grupo**

  .. code-block:: PowerShell

   Get-LocalUser
   Get-LocalGroup
   Get-LocalGroupMember -Name nombre_grupo
  
* **Crear un usuario con contraseña**

  .. code-block:: PowerShell
  
    $Password = Read-Host -AsSecureString
    New-LocalUser -Name nombre_usuario -Password $Password
  
    #Sin que pida confirmación
    $Password = ConvertTo-SecureString «alumno» -AsPlainText -Force 
    
* **Crear un usuario sin contraseña**

  .. code-block:: PowerShell
  
   New-LocalUser -Name nombre_usuario -NoPassword
   
   #Se la podemos asignar después: 
   Set-LocalUser -Name nombre_usuario -Password $Password
   
* **Asignar usuario a un grupo**

  .. code-block:: PowerShell
  
   Add-LocalGroupMember -Group nombre_grupo -Member nombre_usuario
  
* **Eliminar un usuario**

  .. code-block:: PowerShell
  
   Remove-LocalUser -Name nombre_usuario
  
* **Crear y borrar un grupo**

  .. code-block:: PowerShell
  
   New-LocalGroup -Name nombre_grupo
   Remove-LocalGroup -Name nombre_grupo

*************************************
Configuración de Windows (PowerShell)
*************************************

* **Reiniciar**

  .. code-block:: PowerShell
 
   shutdown /r
   shutdown /f #de forma forzosa
   
* **Apagar**  

  .. code-block:: PowerShell
 
   shutdown /s   
 
* **Consultar IP**

  .. code-block:: PowerShell
  
   ipconfig

    
* **Cambiar IP**

  .. code-block:: PowerShell
  
   netsh interface ip set address name="Ethernet" source=static addr=10.4.104.100 mask=255.0.0.0 gateway=10.0.0.2


* **Cambiar y consultar el DNS**   

  .. code-block:: PowerShell
  
   ipconfig /all #consultar dns
   netsh interface ip set dns "Ethernet" static 8.8.8.8

* **Cambiar el nombre del equipo**

  .. code-block:: PowerShell
  
   Rename-Computer -NewName "WC0-tunombre"

* **Habilitar ping**  

  .. code-block:: PowerShell
  
   netsh advfirewall firewall add rule name="Habilitar respuesta ICMP IPv4" protocol=icmpv4:8,any dir=in action=allow

* **Instalar el servidor ssh**

  .. code-block:: powershell

   Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
   Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
   
   #Iniciar el servicio ssh :
   Start-Service sshd
   
   #Para reiniciarlo
   Restart-Service sshd
   
   #Para iniciar el servicio ssh durante el arranque de forma automática:
   Set-Service -Name sshd -StartupType 'Automatic'
   
   #Para conectarse sin contraseña primero copia tu clave publica 
   scp -P22 .ssh/id_rsa.pub Administrador@IP:C:\Users\Administrador\.ssh\authorized_keys
   
   #después ya te puedes conectar sin meter contraseña
   ssh -X Administrador@IP
 
* **Instalar edior vi**

  * Con Chocolatey:

    .. code-block:: powershell
  
      #Instalar Chocolatey (si aún no lo tienes):
      Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  
      choco install vim
  
  * Sin Chocolatey [#alias]_:

    .. code-block:: powershell
  
      # Visita el sitio oficial de Vim para Windows en https://www.vim.org/download.php
      # Descarga el instalador adecuado para tu sistema, en mi caso:
      curl.exe https://ftp.nluug.nl/pub/vim/pc/gvim90.exe -o gvim90.exe
  
      # Ejecutalo dentro de Windows, o desde una conexsión en la que se exporte el display
      ./gvim90.exe
  
      # Crea un alias:
      Set-Alias -Name vi -Value 'C:\Program Files (x86)\Vim\vim90\vim.exe'
   


.. rubric:: Footnotes

.. [#alias] 
  
  Para crear un alias que esté disponible al principio de cada sesión de PowerShell, debes agregar el comando Set-Alias al archivo de perfil de PowerShell. El archivo de perfil es un script que se ejecuta automáticamente cada vez que inicias una nueva sesión de PowerShell.

  Los perfiles pueden ser específicos del usuario o del sistema. Aquí te muestro cómo crear un alias en tu perfil de usuario:

  Abre PowerShell como administrador (esto es necesario para modificar archivos en la ubicación del perfil).

  Verifica la existencia del archivo de perfil. Puedes hacerlo ejecutando el siguiente comando:

  .. code-block:: powershell

    Test-Path $PROFILE

  Si el comando anterior devuelve False, significa que no tienes un archivo de perfil. En ese caso, puedes crear uno ejecutando el siguiente comando:

  .. code-block:: powershell

    New-Item -Path $PROFILE -Type File -Force

  Abre el archivo de perfil en tu editor de texto preferido. Puedes hacerlo ejecutando el siguiente comando:

  .. code-block:: powershell

    C:\Program Files (x86)\Vim\vim90\vim.exe $PROFILE

  Agrega el comando Set-Alias con el alias que deseas crear y el comando que deseas asociar. Por ejemplo:

  .. code-block:: powershell
  
    Set-Alias -Name vi -Value 'C:\Program Files (x86)\Vim\vim90\vim.exe' 

  Guarda el archivo y cierra el editor de texto.

  Cierra y vuelve a abrir PowerShell. El alias que agregaste debería estar disponible al principio de cada sesión.
  


  
  