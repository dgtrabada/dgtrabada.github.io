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

Caracteres especiales
=====================

* \* ? \ " > >> |

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
* **Get-ChildItem -Recurse -Filter '*.txt'** es parecido al comando find
* **Get-Help -Name Get-ChildItem** obtener ayuda
* **select -> Select-Object**
* **cat archivo.dat | select -Last 2**
* **cat archivo.dat -Head 12 | select -Last 1**
* **cat archivo.dat | select -First 10**
* **Test-Path -Path <archivo>** nos dice si exite el archivo o carpeta

Visualizadores de archivos
==========================

* **cat -> Get-Content** visualizar el contenido archivo
* **Get-Content archivo.dat -head 10** Get-Content archivo.dat | select -First 10  # head
* **Get-Content archivo.dat -tail 10** es como el comando tail en GNULinux
* **Get-Content archivo.dat -tail 10 -wait** es como el comando tail -f en GNULinux
* **Get-Content archivo.dat | %{ $_ -replace 'A', 'B' }** reemplazar
* **more** mostrar archivos haciendo pausa en cada pantalla

Filtros y búsqueda información
==============================

* **sort -> Sort-Object** ordenar
* **sls -> Select-String = grep** filtrar,
* **Select-String -Pattern <texto>** -Quiet nos devuelve solo True o nada
  echo $(Select-String -Pattern "texto" archivo.dat| Measure-Object -Character).Characters, es como el comando grep -c GNULinux
* **ft -> Format-Table** dar a la salida formato de tabla :
  Get-Service | Format-Table -Property Name, DependentServices

Alias
=====

* **New-Alias -Name "ver" -Value Get-ChildItem**
* **Get-Alias** ver los alias que hay en el sistema

Gestión de usuarios
===================

Para hacerte administrador: **start-process powershell -verb runas***

* **Listar usuarios, grupos y usuarios del grupo**

  * Get-LocalUser
  * Get-LocalGroup
  * Get-LocalGroupMember -Name nombre_grupo
  
* **Crear un usuario con contraseña**

  * $Password = Read-Host –AsSecureString
  * **New-LocalUser -Name nombre_usuario -Password $Password**
  * Sin que pregunte: $Password = ConvertTo-SecureString «alumno» -AsPlainText -Force 
    
* **Crear un usuario sin contraseña**

  * New-LocalUser -Name nombre_usuario -NoPassword
   Se la podemos asignar después: Set-LocalUser -Name nombre_usuario -Password $Password
   
* **Asignar usuario a un grupo**

  * Add-LocalGroupMember -Group nombre_grupo -Member nombre_usuario
  
* **Eliminar un usuario**

  * Remove-LocalUser -Name nombre_usuario
  
* **Crear y borrar un grupo**

  * New-LocalGroup -Name nombre_grupo
  * Remove-LocalGroup -Name nombre_grupo

Configuración de Windows
========================

* **shutdown /r** reiniciamos, si añadimos /f lo hace de forma forzosa

* **shutdown /s** apagar
    
* **Cambiar IP** netsh interface ip set address name="Ethernet" source=static addr=10.4.104.100 mask=255.0.0.0 gateway=10.0.0.2

* **ipconfig** consultar ip

* **Cambiar el DNS** netsh interface ip set dnsserver "Ethernet" static 8.8.8.8 primary

* **ipconfig /all** consultar dns

* **Rename-Computer -NewName "WS19tunombre"** cambiar el nombre del equipo

* **Habilitar ping** netsh advfirewall firewall add rule name="Habilitar respuesta ICMP IPv4" protocol=icmpv4:8,any dir=in action=allow

* **Instalar el servidor ssh**

 .. code-block:: powershell

   Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
   Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
   #Iniciar el servicio ssh :
   Start-Service sshd
   #Para iniciar el servicio ssh durante el arranque de forma automática:
   Set-Service -Name sshd -StartupType 'Automatic'
   
 Para conectarse sin contraseña **ssh -X Administrador@IP**: Copia tu clave publica .ssh/id_rsa.pub a IP:C:\Users\Administrador\.ssh\authorized_keys
   

