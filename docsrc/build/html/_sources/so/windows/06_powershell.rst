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


Alias
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
   netsh interface ip set dnsserver "Ethernet" static 8.8.8.8 primary

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
   
   #Para iniciar el servicio ssh durante el arranque de forma automática:
   Set-Service -Name sshd -StartupType 'Automatic'
   
   #Para conectarse sin contraseña primero copia tu
   #clave publica .ssh/id_rsa.pub a IP:C:\Users\Administrador\.ssh\authorized_keys
   ssh -X Administrador@IP
 
   

