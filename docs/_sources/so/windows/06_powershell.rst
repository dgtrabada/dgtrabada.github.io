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
 
 

Alias [#alias]_
===============

* **New-Alias -Name "ver" -Value Get-ChildItem**
* **Get-Alias** ver los alias que hay en el sistema


Ficheros y directorios
======================

* **pwd -> Get-Location** donde te encuentras
* **cp -r -> Copy-Item** copiar
* **mv -> Move-Item** mover, renombrar
* **rm, rm -r -> Remove-Item** borrar
* **mkdir** crear directorio
* **ls -> Get-ChildItem** listar archivos y carpetas, para ver los archivos ocultos -h
  
  * l (vínculo)
  * d (directorio)
  * a (archivo)
  * r (solo lectura)
  * h (oculto)
  * s (sistema)

* **echo** repetir salida estándar
* **Test-Path -Path <archivo>** nos dice si exite el archivo o carpeta
* **Get-Help -Name Get-ChildItem** obtener ayuda

Ejemplo:

.. code-block:: powershell

  PS C:\> pwd

  Path
  ----
  C:\

  PS C:\> mkdir A

  Directorio: C:\
  Mode                 LastWriteTime         Length Name        
  ----                 -------------         ------ ----        
  d-----        29/03/2024      9:27                A

  PS C:\> cd A   

  PS C:\A> mkdir B  

  Directorio: C:\A
  Mode                 LastWriteTime         Length Name        
  ----                 -------------         ------ ----        
  d-----        29/03/2024      9:27                B

  PS C:\A> mkdir C

  Directorio: C:\A
  Mode                 LastWriteTime         Length Name        
  ----                 -------------         ------ ----        
  d-----        29/03/2024      9:27                C

  PS C:\A> ls                  

  Directorio: C:\A

  Mode                 LastWriteTime         Length Name        
  ----                 -------------         ------ ----        
  d-----        29/03/2024      9:27                B
  d-----        29/03/2024      9:27                C
  -a----        29/03/2024      9:28              8 archivo.dat 

  PS C:\A> Test-Path D                            
  False
  PS C:\A> Test-Path B
  True
  PS C:\A> pwd

  Path
  ----
  C:\A

  PS C:\A> mv B D
  PS C:\A> cp -r D F
  PS C:\A> ls

  Directorio: C:\A
  Mode                 LastWriteTime         Length Name        
  ----                 -------------         ------ ----        
  d-----        29/03/2024      9:27                C
  d-----        29/03/2024      9:27                D
  d-----        29/03/2024      9:29                F
  -a----        29/03/2024      9:28              8 archivo.dat 

  PS C:\A> rm F
  PS C:\A> ls

  Directorio: C:\A
  Mode                 LastWriteTime         Length Name        
  ----                 -------------         ------ ----        
  d-----        29/03/2024      9:27                C  
  d-----        29/03/2024      9:27                D
  -a----        29/03/2024      9:28              8 archivo.dat 


Caracteres especiales
=====================
  
* **\*** (Asterisco):

  Se utiliza como comodín para hacer coincidir cero o más caracteres en una ruta o nombre de archivo, por ejemplo, para listar todos los archivos .txt en un directorio, puedes usar:

  .. code-block:: powershell

   Get-ChildItem C:\Directorio\*.txt

* **?** (Signo de interrogación):

  Se utiliza como comodín para hacer coincidir un único carácter en una ruta o nombre de archivo, por ejemplo, para listar todos los archivos que tengan una extensión de tres caracteres en un directorio, puedes usar:

  .. code-block:: powershell

   Get-ChildItem C:\Directorio\???.*


* **\\** (Barra invertida):

  Se utiliza como separador de ruta en las rutas de archivo y directorio en Windows.

  .. code-block:: powershell

   cd C:\Directorio

* **\"** (Comillas dobles):

  Se utilizan para delimitar cadenas de texto que contienen espacios u otros caracteres especiales, por ejemplo, para especificar un nombre de archivo con espacios al usar un comando como Get-ChildItem:

  .. code-block:: powershell

   Get-ChildItem "C:\Directorio con Espacios\Archivo.txt"

* **\>** (Redireccionamiento de salida):

  Se utiliza para redirigir la salida de un comando hacia un archivo (sobrescribiendo el archivo si ya existe), por ejemplo, para guardar la salida de un comando en un archivo de texto:

  .. code-block:: powershell

   Get-Process > procesos.txt

* **\>\>** (Redireccionamiento de salida, añadir al final del archivo):

  Se utiliza para redirigir la salida de un comando y agregarla al final de un archivo (sin sobrescribir el contenido existente), por ejemplo, para agregar la salida de un comando al final de un archivo de registro:

  .. code-block:: powershell

   Get-Date >> registro.txt


* **\|** (Tubo o pipe):

  Se utiliza para pasar la salida de un comando como entrada a otro comando, por ejemplo, para filtrar la salida de un comando usando Where-Object, puedes usar:

  .. code-block:: powershell

   Get-Process | Where-Object { $_.Name -eq "explorer" }


Visualizadores de archivos, filtros y búsqueda de información
=============================================================

* **more** mostrar archivos haciendo pausa en cada pantalla
* **cat -> Get-Content** visualizar el contenido archivo

  **Get-Content archivo.dat -tail 10 -wait** es como el comando tail -f en GNULinux
  
  **(Get-Content archivo.dat)[2]** podemos ver la linea 3

* **select -> Select-Object** se utiliza para seleccionar y proyectar propiedades específicas de un objeto.

  **Get-Content -head 3 archivo.dat | select -Last 1**
  
* **sort -> Sort-Object** ordenar
* **sls -> Select-String = grep** filtrar,
* **Select-String -Pattern <texto>** -Quiet nos devuelve el texto o nada
* **ft -> Format-Table** dar a la salida formato de tabla :

  **Get-Service | Format-Table -Property Name, DependentServices**


Ejemplo:

.. code-block:: powershell

  PS C:\> cat archivo.dat  
  1 linea
  2 linea
  3 linea
  4 linea
  5 linea 

  PS C:\> (Get-Content archivo.dat)[2]
  3 linea
 
  PS C:\> Get-Content -head 3 archivo.dat | select -last 1 
  3 linea   
  True
  2
 
  PS C:\> Get-Content -head 3 archivo.dat | select -First 3
  1 linea
  2 linea
  3 linea

  PS C:\> vi .\archivo.dat                                      
  PS C:\>  Get-Content archivo.dat | %{ $_ -replace '2', 'B' }
  1 linea
  B linea
  3 linea
  4 linea
  5 linea

  PS C:\> Get-Content archivo.dat | %{ $_ -replace '2', 'B' } | sort
  1 linea
  3 linea
  4 linea
  5 linea
  B linea 
 
  PS C:\> sls 2 archivo.dat   

  archivo.dat:2:2 linea

  PS C:\> sls linea archivo.dat 
  archivo.dat:1:1 linea
  archivo.dat:2:2 linea
  archivo.dat:3:3 linea
  archivo.dat:4:4 linea
  archivo.dat:5:5 linea

  PS C:\> sls linea archivo.dat -Quiet
  True
  PS C:\> sls J archivo.dat -Quiet    
  False
 
  PS C:\> Get-Content archivo.dat | Select-String -Pattern  2  
 
  2 linea


  PS C:\> Get-Content archivo.dat | Select-String -Pattern  liena
  PS C:\> Get-Content archivo.dat | Select-String -Pattern  linea

  1 linea
  2 linea
  3 linea
  4 linea
  5 linea

  PS C:\> Get-Service | Format-Table -Property Name, Displayname | select -First 4          
  Name                                       DisplayName
  ----                                       -----------
  ADWS                                       Servicios web de Active  Directory 
  AJRouter                                   Servicio de enrutador de AllJoyn

Información de harware
======================

* **Get-PSDrive** cmdlet obtiene las unidades de la sesión actual.
* **Get-NetAdapter** en PowerShell te mostrará información sobre las interfaces de red
* **Get-WmiObject** optener información sobre el procesador
* **Get-CimInstance** se utiliza para recuperar instancias de una clase

Ejemplo:

.. code-block:: powershell

  PS C:\>  Get-PSDrive                                                                                                          
  
  Name           Used (GB)     Free (GB) Provider      Root                                                     CurrentLocation
  ----           ---------     --------- --------      ----                                                     --------------- 
  Alias                                  Alias
  C                   8,28         91,07 FileSystem    C:\
  Cert                                   Certificate   \
  D                                      FileSystem    D:\
  Env                                    Environment
  Function                               Function
  HKCU                                   Registry      HKEY_CURRENT_USER
  HKLM                                   Registry      HKEY_LOCAL_MACHINE
  Variable                               Variable
  WSMan                                  WSMan     

  PS C:\> Get-PSDrive -PSProvider FileSystem                                                                     
         
  Name           Used (GB)     Free (GB) Provider      Root                                                     CurrentLocation
  ----           ---------     --------- --------      ----                                                     --------------- 
  C                   8,28         91,07 FileSystem    C:\
  D                                      FileSystem    D:\   

  PS C:\> Get-PSDrive -PSProvider FileSystem |  Select-Object Name, Used, Free                         
  
  Name       Used        Free
  ----       ----        ----
  C    8886775808 97782759424
  D             0   

  PS C:\> Get-PSDrive -PSProvider FileSystem |  Select-Object Name, Used, Free |  Select-Object -Index 0                                   
  Name       Used        Free
  ----       ----        ----
  C    8886775808 97782759424 
 

  PS C:\> $particion_C=$(Get-PSDrive -PSProvider FileSystem |  Select-Object Name, Used, Free |  Select-Object -Index 0)
  PS C:\> echo $particion_C.Used
  8886775808
  PS C:\> $porcentaje=100*$particion_C.Used/($particion_C.Used+$particion_C.Free)
  PS C:\> echo $porcentaje
  8,33112827263359
  PS C:\> $porcentaje=[math]::Round(100*$particion_C.Used/($particion_C.Used+$particion_C.Free),2)
  PS C:\> echo $porcentaje
  8,33
  PS C:\> echo "El $porcentaje % de la partición C esta ocupada"
  El 8.33 % de la partición C esta ocupada
 
 
 
Ejemplo:

.. code-block:: powershell

  PS C:\> (Get-WmiObject Win32_Processor).caption
  Intel64 Family 6 Model 142 Stepping 10
  PS C:\> (Get-WmiObject Win32_ComputerSystem).SystemType
  x64-based PC
  PS C:\> (Get-WmiObject Win32_Processor).name
  Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
  PS C:\> ((Get-WmiObject Win32_Processor).name).split("@")[1]
  1.60GHz
  PS C:\> Get-WmiObject -Class Win32_Processor | Select -Property Name, Number* 

  Name                                     NumberOfCores NumberOfEnabledCore NumberOfLogicalProcessors
  ----                                     ------------- ------------------- -------------------------
  Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz             2                                             2

  
  PS C:\> Get-WmiObject -Class Win32_Processor | Select-Object NumberOfCores

  NumberOfCores
 -------------
              2

  PS C:\> Get-WmiObject win32_processor | Select-Object LoadPercentage
  
  LoadPercentage
  --------------
              44
   

  PS C:\> Get-WmiObject -class "Win32_Processor"| % { 
  >>     Write-Host "CPU ID: "
  >>     Write-Host $_.DeviceID
  >>     Write-Host "CPU Model: "
  >>     Write-Host $_.Name
  >>     Write-Host "CPU Cores: "
  >>     Write-Host $_.NumberOfCores
  >>     Write-Host "CPU Max Speed: "
  >>     Write-Host $_.MaxClockSpeed
  >>     Write-Host "CPU Status: "
  >>     Write-Host $_.Status
  >>     Write-Host 
  >> }
  CPU ID: 
  CPU0
  CPU Model:
  Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
  CPU Cores: 
  2
  CPU Max Speed:
  1800
  CPU Status: 
  OK
 

Ejemplo:

.. code-block:: powershell

  PS C:\>  Get-CimInstance -ClassName Win32_OperatingSystem

  SystemDirectory     Organization BuildNumber RegisteredUser     SerialNumber            Version   
  ---------------     ------------ ----------- --------------     ------------            -------   
  C:\Windows\system32              20348       Usuario de Windows 00454-40000-00001-AA444 10.0.20348
    
   
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory                       
  986776
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).TotalVirtualMemorySize
  3276340
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).NumberOfUsers                             
  6
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).BootDevice   
  \Device\HarddiskVolume1
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).Version   
  10.0.20348
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).WindowsDirectory
  C:\Windows
  PS C:\> $(Get-CimInstance -ClassName Win32_OperatingSystem).CountryCode                              
  34


Configuración de Windows (PowerShell)
=====================================

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
  
   Rename-Computer -NewName "WS22tunombre"

* **Habilitar ping**  

  .. code-block:: PowerShell
  
   netsh advfirewall firewall add rule name="Habilitar respuesta ICMP IPv4" protocol=icmpv4:8,any dir=in action=allow

.. marca:: windows_ssh

Instalar el servidor ssh
========================

.. code-block:: powershell

 #Primero buscamos características disponibles en línea que coincidan con el patrón 
 Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
 
 #Luego la añadimos:
 Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
   
 #Iniciar el servicio ssh :
 Start-Service sshd
   
 #Para reiniciarlo
 Restart-Service sshd
   
 #Para iniciar el servicio ssh durante el arranque de forma automática:
 Set-Service -Name sshd -StartupType Automatic
   
 #Para conectarse sin contraseña primero copia tu clave publica 
 scp -P22 .ssh/id_rsa.pub Administrador@IP:C:\Users\Administrador\.ssh\authorized_keys
   
 #Después ya te puedes conectar sin meter contraseña
 ssh -X Administrador@IP

Para instalarlo con un solo comando:

.. code-block:: powershell

  Add-WindowsCapability -Online -Name $(Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.server*' | Select-Object  Name| Select-Object -Index 0)


En el caso que que quieras conectarte a una sesión de powershell, abre el archivo .ssh/config. Si no existe, puedes crearlo y agrega las siguientes líneas, sonde la \<ip\> es la **ip o el nombre del equipo al que nos conectamos** y queremos loguarnos directamente con powershell:

.. code-block:: PowerShell
 
  Host <ip>
    RequestTTY force
    RemoteCommand powershell -NoLogo -NoProfile


Instalar edior vi
=================

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

