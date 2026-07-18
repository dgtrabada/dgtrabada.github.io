********************************************
Casos prácticos : Active Directory sin GUI
********************************************

Crea los siguientes clones enlazados:

* Clon enlazado 1 de "`Windows Server 2022 sin GUI <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-server-2022-sin-gui>`_" llamado **WS22tunombre** con IP 10.4.X.Y/8 o DHCP si es portátil y un nuevo adaptador de red para el servidor, conectado a una red interna con la dirección 172.16.0.10/16

* Clon enlazado 2 de "`Windows 11 <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-11>`_" llamado **WC05tunombre** con un adaptador a la red interna, le asignamos la dirección 172.16.0.15/16 con puerta de enlace 172.16.0.10 y DNS 172.16.0.10

* Clon enlazado 3 de "`Windows 11 <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-11>`_" llamado **WC06tunombre** con un adaptador a la red interna, le asignamos la dirección 172.16.0.16/16 con puerta de enlace 172.16.0.10 y DNS 172.16.0.10

Puedes ver la configuración en el siguiente `vídeo <https://mediateca.educa.madrid.org/video/68dserxf2iosogqv>`_

Configurar servicio de enrutamiento
-----------------------------------

.. code-block:: powershell

  # Instalar el servicio de enrutamiento
  Install-WindowsFeature Routing -IncludeManagementTools

  # habilitar NAT para la red interna (se indica la red, no la IP del servidor)
  New-NetNat -Name "NAT" -InternalIPInterfaceAddressPrefix "172.16.0.0/16"

  # habilitamos el reenvío de paquetes
  Set-NetIPInterface -Forwarding Enabled

Instalación y configuración de Active Directory y DNS
-----------------------------------------------------

Instalamos el rol de Servicio de dominio de Active Directory

.. code-block:: powershell

  Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Promocionamos el servidor como controlador de dominio

.. code-block:: powershell

  Import-Module ADDSDeployment

No tenemos creada ninguna parte de la infraestructura, comenzamos creando el bosque y se creará automáticamente el resto de la estructura
  
.. code-block:: powershell

  Install-ADDSForest
  DomainName : tunombre.local
  # la contraseña que pide (SafeModeAdministratorPassword) es la de DSRM,
  # el modo de restauración de servicios de directorio
  password : @lumn0

Puedes comprobar que se ha creado con el siguiente comando:

.. code-block:: powershell

  Get-ADComputer -Filter * 

.. image:: imagenes/WS22NGUI00.png

Unidades Organizativas, usuarios y grupos
-----------------------------------------

Vamos a crear las siguientes  unidades organizativas:

.. code-block:: powershell

  New-ADOrganizationalUnit -DisplayName "DespachoX" -Name "DespachoX" -path "DC=tunombre,DC=local"
  New-ADOrganizationalUnit -DisplayName "DespachoY" -Name "DespachoY" -path "DC=tunombre,DC=local"

Puedes comprobar las unidades creadas:

.. code-block:: powershell

  Get-ADOrganizationalUnit -LDAPFilter "(name=*)"  | FT Name,DistinguishedName

.. image:: imagenes/WS22NGUI01.png

En el caso de que necesites borrar una OU, recuerda que primero tienes que deshabilitar la protección contra el borrado accidental y luego borrarla

.. code-block:: powershell

  Set-ADOrganizationalUnit -Identity "OU=DespachoX,DC=tunombre,DC=local" -ProtectedFromAccidentalDeletion $False
  Remove-ADOrganizationalUnit -Identity "OU=DespachoX,DC=tunombre,DC=local" -Recursive


Grupos y usuarios
------------------

Vamos a crear los siguientes usuarios y grupos de seguridad

* Grupo X
  
  * Usuario: tunombreX1 con la contraseña @lumn0X1, haz que sea miembro del grupo X
  * Usuario: tunombreX2 con la contraseña @lumn0X2, haz que sea miembro del grupo X
  
* Grupo Y
  
  * Usuario: tunombreY1 con la contraseña @lumn0Y1, haz que sea miembro del grupo Y
  * Usuario: tunombreY2 con la contraseña @lumn0Y2, haz que sea miembro del grupo Y  

.. code-block:: powershell

  New-ADGroup -DisplayName "X" -Name "X" -GroupScope DomainLocal -GroupCategory Security -Path "DC=tunombre,DC=local"
  New-ADGroup -DisplayName "Y" -Name "Y" -GroupScope DomainLocal -GroupCategory Security -Path "DC=tunombre,DC=local"


Después creamos los usuarios, como se ve en el siguiente ejemplo con el usuario tunombreX1

.. code-block:: powershell

  New-ADUser -DisplayName "tunombreX1" -Name "tunombreX1" -UserPrincipalName "tunombreX1@tunombre.local" -Enabled:$True -Path "DC=tunombre,DC=local" -AccountPassword (ConvertTo-SecureString -string "@lumn0X1" -AsPlainText -Force) -ChangePasswordAtLogon:$False

Al establecer ``-ChangePasswordAtLogon:$False``, estás indicando que no se requiere que el usuario cambie la contraseña la primera vez que inicia sesión. Si lo queremos cambiar sobre un usuario ya creado: ``Set-ADUser -Identity "tunombreX1" -ChangePasswordAtLogon $False``. En el otro caso tendremos que iniciar la sesión al menos una vez para cambiar la contraseña, y hasta que no lo hagamos no podremos iniciar sesión por ssh.

Por último lo añadimos al grupo

.. code-block:: powershell
 
  Add-ADGroupMember -Identity "X" -Members "tunombreX1"


Podemos comprobar que se han creado los grupos y los usuarios:

.. code-block:: powershell

  Get-ADGroupMember "X" | Select-Object Name
  Get-ADGroupMember "Y" | Select-Object Name

.. image:: imagenes/WS22NGUI02.png

En el caso de que queramos cambiar la directiva de las contraseñas, por ejemplo hacer que tengan una menor complejidad para hacer pruebas:

.. code-block:: powershell

  # Ver la directiva de contraseñas actual
  Get-ADDefaultDomainPasswordPolicy

  # Deshabilitar los requisitos de complejidad
  Set-ADDefaultDomainPasswordPolicy -Identity (Get-ADDomain).DistinguishedName -ComplexityEnabled $false

  # le damos la nueva contraseña
  Set-ADAccountPassword -Identity tunombreX1 -NewPassword (ConvertTo-SecureString "1234" -AsPlainText -Force) -Reset


Unir equipo al dominio
----------------------

Para añadir el equipo **WC05tunombre** al dominio, primero tendremos que cambiar el DNS y apuntar al Windows Server, luego en "Configuración/Sistema/Información/Dominio o grupo de trabajo" seleccionamos unir a dominio. En el caso de que el cliente no disponga de entorno gráfico:

.. code-block:: powershell

  # Comprobamos el DNS del cliente
  Get-DnsClientServerAddress

  # En el caso de que no apunte al servidor, lo cambiamos
  # (el InterfaceIndex es el de tu adaptador, lo ves en el comando anterior):
  Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddresses ("172.16.0.10", "8.8.8.8")

Por último lo metemos dentro del dominio con el siguiente comando que ejecutamos en el cliente; aparecerá un diálogo gráfico para introducir la contraseña

.. code-block:: powershell

  Add-Computer -DomainName "tunombre.local" -Credential tunombre\administrador -Restart -Force

  # puedes comprobar que se ha añadido, ejecutando en el servidor
  Get-ADComputer -Filter * | FT Name

.. image:: imagenes/WS22NGUI03.png

En el caso de que quieras hacerlo sin diálogo gráfico (por ejemplo, en una conexión por ssh):

.. code-block:: powershell

  $password = ConvertTo-SecureString "@lumn0" -AsPlainText -Force
  $credenciales = New-Object System.Management.Automation.PSCredential("tunombre\administrador", $password)

  Add-Computer -DomainName "tunombre.local" -Credential $credenciales -Restart -Force

Es posible que al clonar los equipos, puedan surgir problemas debido a que comparten el mismo SID. Para solucionarlo:

.. image:: imagenes/sysprep.png


Si queremos sacar la máquina del dominio:

.. code-block:: powershell

  # en el cliente (lo saca del dominio y lo devuelve a un grupo de trabajo):
  Remove-Computer -UnjoinDomainCredential tunombre\administrador -Restart -Force

  # en el servidor (borra la cuenta del equipo del directorio):
  Remove-ADComputer -Identity "WC06TUNOMBRE"


En Windows, puedes utilizar el siguiente comando para sincronizar la hora con un servidor de tiempo en línea:

.. code-block:: powershell
  
  w32tm /resync
  
  #darla a mano:
  Set-Date -Date "lunes, 6 de mayo de 2024 9:27:57"


Carpeta compartida
------------------

Creamos una carpeta en el servidor 

.. code-block:: text

  C:\XY-TUNOMBRE
  ├───X-tunombre
  └───Y-tunombre

y la compartimos:

.. code-block:: powershell

  New-SmbShare -Name "X" -Path "C:\XY-TUNOMBRE\X-tunombre" -FullAccess "X", "Administradores"

  Name ScopeName Path                        Description
  ---- --------- ----                        -----------
  X    *         C:\XY-TUNOMBRE\X-tunombre


Podemos comprobar las carpetas que hay compartidas, ejecutando en el servidor:

.. code-block:: powershell
   
  net share

Para acceder a ellas:

.. code-block:: powershell
   
  # Podemos ver que está en:
  ls "\\WS22TUNOMBRE\X"

  # Podemos montarla en el cliente en la unidad X:
  New-PSDrive -Name "X" -PSProvider "FileSystem" -Root "\\WS22TUNOMBRE\X"
  
Utilizando el entorno gráfico

.. image:: imagenes/WS22NGUI04.png

Para dejar de compartir la carpeta: 

.. code-block:: powershell
   
  net share NombreRecurso /delete



Administración remota
---------------------

WinRM (Windows Remote Management) es un conjunto de servicios de administración remota que permite a los administradores de sistemas administrar y ejecutar comandos en sistemas Windows de forma remota, utiliza el protocolo WS-Management (WSMan) para establecer conexiones remotas y ejecutar comandos de manera segura. 

Para permitir la administración remota del cliente, configuramos WinRM:

.. code-block:: powershell
   
  winrm quickconfig 
  
Desde el servidor podemos ejecutar comandos:

.. code-block:: powershell
   
  Invoke-Command -ComputerName WC05TUNOMBRE,WC06TUNOMBRE -ScriptBlock {HOSTNAME.EXE}

Invoke-Command se comunica con hasta 32 equipos a la vez; si ponemos más, los siguientes esperarán a que terminen los 32 primeros.

Si queremos abrir una sesión

.. code-block:: powershell
   
  Enter-PSSession WC06TUNOMBRE
  Exit-PSSession
  
También ofrece la opción de crear una conexión persistente ("PSSession"), en la que las re-conexiones son mucho más rápidas y se conserva el estado. Para ello creamos la sesión con **New-PSSession** y, en lugar de usar -ComputerName con Enter-PSSession o Invoke-Command, utilizaremos su parámetro **-Session** pasándole el objeto PSSession existente y abierto. Esto permite a los comandos volver a utilizar la conexión persistente que se había creado anteriormente.

.. code-block:: powershell
   
  # Crear una nueva sesión remota
  $session = New-PSSession -ComputerName WC06TUNOMBRE

  # Ejecutar un comando en la sesión remota
  Invoke-Command -Session $session -ScriptBlock { Get-PSSessionConfiguration }
  
  # Habilitar la ejecución de scripts en los equipos
  Invoke-Command -Session $session -ScriptBlock { Set-ExecutionPolicy Unrestricted }

  # Podemos instalar el servidor ssh de forma remota:
  Invoke-Command -Session $session -ScriptBlock { Add-WindowsCapability -Online -Name $(Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.server*' | Select-Object  Name| Select-Object -Index 0) }
  
  Invoke-Command -Session $session -ScriptBlock { Get-Service sshd }

Como la sesión se mantiene y se reutiliza, el estado se conserva entre llamadas:

.. code-block:: powershell
   
  Invoke-Command -Session $session -ScriptBlock { $a = 1 }          
  Invoke-Command -Session $session -ScriptBlock { echo $a }    
  1


Podemos cargar un script:

.. code-block:: powershell
   
   $scriptBlock = {
    echo "hola $(whoami.exe)"
    echo "hoy es $(date)"
  }

  Invoke-Command -Session $session -ScriptBlock $scriptBlock

También podemos cargarlo de un archivo, para editar el script lo podemos hacer directamente con el `editor vim <https://dgtrabada.github.io/so/windows/06_powershell.html#instalar-editor-vi>`_ utilizando una conexión por `ssh <https://dgtrabada.github.io/so/windows/06_powershell.html#instalar-el-servidor-ssh>`_

.. code-block:: powershell
     
  PS C:\Users\Administrador> cat script.ps1  
  echo "hola $(whoami.exe)"
  echo "hoy es $(date)"
  
  PS C:\Users\Administrador> Invoke-Command -FilePath script.ps1 -Session $session
  hola tunombre\administrador
  hoy es 05/06/2024 10:52:12

Para tener acceso a un recurso compartido de red en una sesión remota (por defecto la sesión remota no puede reutilizar nuestras credenciales contra un tercer equipo, es el llamado problema del doble salto), utilizamos `Enable-WSManCredSSP <https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/invoke-command?view=powershell-7.2#examples>`_, que sirve para habilitar la delegación de credenciales de CredSSP (Credential Security Support Provider) en el servidor de administración remota y en el cliente.

.. code-block:: powershell
     
  Enable-WSManCredSSP -Role client -DelegateComputer WC06TUNOMBRE
  # usamos la $session  creada 
  Invoke-Command -Session $session -ScriptBlock { Enable-WSManCredSSP -Role Server -Force }

  $parameters = @{
    ComputerName   = 'WC06TUNOMBRE'
    ScriptBlock    = { Get-Item \\WS22tunombre\sysvol\tunombre.local\scripts\mount.ps1 }
    Authentication = 'CredSSP'
    Credential     = 'tunombre\Administrador'  
    }
    
    Invoke-Command @parameters
    
Ten en cuenta que necesitarás acceso al entorno gráfico:

.. image:: imagenes/WS22NGUI05.png

De esta forma podemos instalar programas que se encuentren en una carpeta compartida

.. code-block:: powershell
     
  Invoke-Command -Credential tunombre\Administrador -ComputerName WC06TUNOMBRE -Authentication CredSSP -ScriptBlock {Start-Process msiexec.exe -ArgumentList "/i \\WS22tunombre\sysvol\tunombre.local\vlc-3.0.20-win64.msi /qn" -Wait}

Sería lo mismo que:

.. code-block:: powershell
     
  $parameters = @{
  Credential = 'tunombre\Administrador'
  ComputerName = 'WC06TUNOMBRE'
  Authentication = 'CredSSP'
  ScriptBlock = {
    param($dirmsi)
    Start-Process msiexec.exe -ArgumentList "/i $dirmsi /qn" -Wait
    }
    ArgumentList = '\\WS22tunombre\sysvol\tunombre.local\vlc-3.0.20-win64.msi'
  }

  Invoke-Command  @parameters

Mapear unidades de red a las carpetas compartidas 
-------------------------------------------------

.. code-block:: powershell

  cat \\WS22tunombre\sysvol\tunombre.local\scripts\mount.ps1
  New-PSDrive -Name "X" -PSProvider "FileSystem" -Root "\\WS22TUNOMBRE\X"
 
En el caso que queramos que el cambio sea permanente:

.. code-block:: powershell

  New-PSDrive -Persist -Name "X" -PSProvider "FileSystem" -Root "\\WS22TUNOMBRE\X" -Scope Global 
  
  
  
Mover objetos entre las diferentes unidades organizativas
---------------------------------------------------------

Vamos a mover un equipo de Computers a DespachoX, primero vemos los clientes que tenemos:

.. code-block:: powershell

  Get-ADComputer -Filter * | Select-Object Name, DistinguishedName

  # Nuestro cliente está en:
  Get-ADComputer -Filter {Name -eq "WC06TUNOMBRE"} | FT DistinguishedName

Vemos las siguientes unidades organizativas:

.. code-block:: powershell

  #Tenemos las siguientes unidades organizativas
  Get-ADOrganizationalUnit -Filter * -SearchBase "DC=tunombre,DC=local" | FT DistinguishedName
  
Movemos el equipo al "DespachoX"

.. code-block:: powershell

  $IdentidadEquipo = $(Get-ADComputer -Identity "WC06TUNOMBRE").DistinguishedName

  Move-ADObject -Identity $IdentidadEquipo -TargetPath "OU=DespachoX,DC=tunombre,DC=local" -Confirm:$False

Crear y vincular GPO
--------------------

Creamos la política de grupo:

.. code-block:: powershell

  New-GPO -Name "MapearX"
  
Asignar la configuración de inicio de sesión a la GPO. La clave **Run** del registro ejecuta lo que tenga como valor cada vez que se inicia sesión; como un ``.ps1`` no es directamente ejecutable, lo lanzamos a través de ``powershell.exe``:

.. code-block:: powershell

  $parameters = @{
  Name = 'MapearX'
  Key  = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
  ValueName = "ScriptName"
  Type = "String"
  Value = "powershell.exe -ExecutionPolicy Bypass -File \\WS22tunombre\sysvol\tunombre.local\scripts\mount.ps1"
  }

  Set-GPRegistryValue @parameters

  
La vinculamos:

.. code-block:: powershell

  Get-GPO -Name "MapearX"  | New-GPLink -Target "OU=DespachoX,DC=tunombre,DC=local"
  
Si queremos desvincular:  

.. code-block:: powershell

  Remove-GPLink -Name <Nombre> -Target <Path_OU_Dominio>
  
Borrarla:

.. code-block:: powershell

  Remove-GPO -Name <Nombre> -Domain <dominio>

Gestión de ACL sin entorno gráfico
----------------------------------

Access Control List o "Lista de Control de Acceso" se utiliza para definir y controlar los permisos de acceso a recursos, como archivos, carpetas, impresoras y otros objetos en un sistema informático (ver :ref:`Permisos NTFS y carpetas compartidas`). Con el comando Get-Acl podemos obtener la ACL de un archivo o carpeta.

.. code-block:: powershell

  PS C:\Users> Get-Acl A

  Path Owner                   Access
  ---- -----                   ------
  A    BUILTIN\Administradores NT AUTHORITY\SYSTEM Allow  FullControl...

  PS C:\Users> $(Get-Acl A).Owner
  BUILTIN\Administradores
  PS C:\Users> $(Get-Acl A).Group
  TUNOMBRE\Ninguno

Con el comando icacls puedes administrar las Listas de Control de Acceso (ACLs) en archivos y carpetas.

.. code-block:: powershell

  # Cambiar permisos en un archivo o carpeta:
  PS C:\Users> icacls A /grant "tunombre\tunombreX1:(OI)(CI)RW"
  PS C:\Users> Get-Acl A

  Path Owner                   Access
  ---- -----                   ------
  A    BUILTIN\Administradores TUNOMBRE\tunombreX1 Allow  Write, Read, Synchronize...

  # le hemos dado permisos de RW al usuario tunombreX1

  # Para cambiar propietario
  icacls A /setowner "tunombre\tunombreX1"
  

Ejemplo de cómo dar permisos de RW a un grupo completo:

.. code-block:: powershell

  $permissions = "Read", "Write"

  $acl = Get-Acl -Path A

  # Crear una regla de acceso para el grupo X
  $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("X", $permissions, "ContainerInherit, ObjectInherit", "None", "Allow")

  $acl.SetAccessRule($accessRule)
  Set-Acl -Path A -AclObject $acl


Otro ejemplo, vamos a crear una carpeta llamada 'XY' y dentro dos subcarpetas llamadas 'X' y 'Y'. Definiremos los permisos para que solo el grupo 'X' tenga acceso de entrada a la carpeta 'X' dentro de 'XY'.


Creamos las carpetas:

.. code-block:: powershell

  # si existía de antes, la borramos
  rm -r C:\Users\XY

  mkdir C:\Users\XY
  mkdir C:\Users\XY\X
  mkdir C:\Users\XY\Y

Obtenemos el objeto ACL actual de la carpeta XY

.. code-block:: powershell

  $acl= Get-Acl -Path "C:\Users\XY"

Damos permisos para la carpeta principal (lectura y listar el contenido)

.. code-block:: powershell

  $permisos= "ReadAndExecute", "ListDirectory"

Creamos las reglas de acceso para los grupos X e Y

.. code-block:: powershell

  $reglaX = New-Object System.Security.AccessControl.FileSystemAccessRule("X",$permisos, "Allow")
  $reglaY = New-Object System.Security.AccessControl.FileSystemAccessRule("Y",$permisos, "Allow")


Agregamos las reglas de acceso a la carpeta "XY"

.. code-block:: powershell

  $acl.AddAccessRule($reglaX)
  $acl.AddAccessRule($reglaY)
  Set-Acl -Path "C:\Users\XY" -AclObject $acl

Agregamos permisos para que la carpeta "X" pueda ser modificada por el grupo "X"

.. code-block:: powershell

  cd C:\Users\XY

  $acl= Get-Acl -Path "C:\Users\XY\X"
  $permisos = "Modify"
  $regla = New-Object System.Security.AccessControl.FileSystemAccessRule("X",$permisos, "Allow")

  $acl.AddAccessRule($regla)
  Set-Acl -Path "C:\Users\XY\X" -AclObject $acl

Agregamos permisos para que la carpeta "Y" pueda ser modificada por el grupo "Y"

.. code-block:: powershell

  $acl= Get-Acl -Path "C:\Users\XY\Y"
  $permisos = "Modify"
  $regla = New-Object System.Security.AccessControl.FileSystemAccessRule("Y",$permisos, "Allow")

  $acl.AddAccessRule($regla)
  Set-Acl -Path "C:\Users\XY\Y" -AclObject $acl



