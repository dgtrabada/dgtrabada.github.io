********************************************
Casos prácticos : Active Directory sin GUI
********************************************

Crea los siguiente clones enlazados:

* Clon enlazado 1 de "`Windows Server 2022 sin GUI <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-server-2022-sin-gui>`_" llamado **WS22tunombre** con IP 10.4.X.Y/8 o DHCP si es portatil y un nuevo adaptador red para el servidor, le asignamos una red interna a la que ponemos la dirección 172.16.0.10/16

* Clon enlazado 2 de "`Windows Server 11 <https://dgtrabada.github.io/so/maquinas_virtuales.html#caso-practico-windows-11>`_" llamado **WC05tunombre** con un adaptador a una red interna, le asignamos la red 172.16.0.15/16 con puerta de enlace 172.16.0.10 y DNS 172.16.0.10

Configurar servicio de enrutamiento
-----------------------------------

.. code-block:: powershell

  # Instalar el servicio de enrutamiento
  Install-WindowsFeature Routing -IncludeManagementTools
   
  # habilitar NAT para la red interna
  New-NetNat -Name "NAT" -InternalIPInterfaceAddressPrefix "172.16.0.10/16"
  
  #habilitamos el reenvío de paquetes
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

En el caso de que te necesites borrar una OU, recuerda que primero tienes que deshabilitar el borrado accidental y luuego borrar

.. code-block:: powershell

  Set-ADOrganizationalUnit -Identity "OU=DespachoX,DC=tunombre,DC=local" -ProtectedFromAccidentalDeletion $False
  Remove-ADOrganizationalUnit -Identity "OU=DespachoX,DC=tunombre,DC=local" -Recursive


Grupos y usuarios
------------------

Vamos a crear los sigientes usuarios y grupos de seguridad

* Grupo X
  
  * Usuario: tunombreX1 con la contraseña @lumn0X1, haz que sea miembro del grupo X
  * Usuario: tunombreX2 con la contraseña @lumn0X2, haz que sea miembro del grupo X
  
* Grupo Y
  
  * Usuario: tunombreY1 con la contraseña @lumn0Y1, haz que sea miembro del grupo Y
  * Usuario: tunombreY2 con la contraseña @lumn0Y2, haz que sea miembro del grupo Y  

.. code-block:: powershell

  New-ADGroup -DisplayName "X" -Name "X" -GroupScope DomainLocal -GroupCategory Security -Path "DC=tunombre,DC=local"
  New-ADGroup -DisplayName "Y" -Name "Y" -GroupScope DomainLocal -GroupCategory Security -Path "DC=tunombre,DC=local"


Después creamos los usuarios, como se ve en el siguiente ejemplo con el usuario tu_nombreA1

.. code-block:: powershell 
  
  New-ADUser -DisplayName "tunombreX1" -Name "tunombreX1" -UserPrincipalName "tunombreX1" -Enabled:$True -Path "DC=tunombre,DC=local" -AccountPassword (ConvertTo-SecureString -string "@lumn0X1" -AsPlainText -Force) -ChangePasswordAtLogon:$False

Al establecer ``-ChangePasswordAtLogon:$False``, estás indicando que no se requiere que el usuario cambie la contraseña la primera vez que inicia sesión. Si lo queremos cambiar sobre un usuario ya creado ``Set-ADUser -Identity "tunombreX1" -ChangePasswordAtLogon $False``, en el otro caso tendremos que iniciar la sesión al menos una vez para cambiar la contraseña y hasta que no lo hagamos no podremos loguearnos por ssh.

Por ultio lo añadimos al grupo

.. code-block:: powershell
 
  Add-ADGroupMember -Identity "X" -Members "tunombreX1"


Podemos comprobar que se han creado los grupos y los usuarios:

.. code-block:: powershell

  Get-ADGroupMember "X" | Select-Object Name
  Get-ADGroupMember "Y" | Select-Object Name

.. image:: imagenes/WS22NGUI02.png

Unir equipo al dominio
----------------------

Para añadir el equipo al dominio **WC05tunombre** primero tendremos que cambiar el DNS:

.. code-block:: powershell

  #Comprobamos el DNS del cliente
  Get-DnsClientServerAddress

  #En el caso de que no apunte al servidor, lo cambiamos:
  Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddresses ("172.16.0.10", "8.8.8.8")
   
Por ultimo lo metemos dentro del dominio con el siguiente comando que ejecutamos en el cliente, necesitaremos exportar el display para que aparezca el dialogo para meter la contraseña

.. code-block:: powershell

  Add-computer -domainname "tunombre.local" -Credential  tunombre\administrador -restart -force
   
  #puedes comprobar que se añadido en el servidor ejecuntando allí
  Get-ADComputer -Filter * | FT Name
  
.. image:: imagenes/WS22NGUI03.png

En el caso de que quieras hacerlo sin exportar el diplay:

.. code-block:: powershell

  $password = ConvertTo-SecureString "@lumn0" -AsPlainText -Force
  $credenciales = New-Object System.Management.Automation.PSCredential("tunombre\administrador", $password)

  Add-Computer -DomainName "tunombre.local" -Credential $credenciales -Restart -Force

Es posible que al haber clonado los equipos no os deje por tener el mismo SID, para cambiarlo:

.. image:: imagenes/sysprep.png


Si queremos sacar la maquina del dominio, en una terminal del servidor con permiso de administrador ejceutamos:

.. code-block:: powershell

  Remove-ADComputer -Identity "NombreDeLaComputadora"


En Windows, puedes utilizar el siguiente comando para sincronizar la hora con un servidor de tiempo en línea:

.. code-block:: powershell
  
  w32tm /resync


Carpeta compartida
------------------

Creamos una carpeta en el servidor y la compartimos:

.. code-block:: powershell

  #Desde el servidor
  mkdir C:\Users\compartida_tunombre
  New-SmbShare -Name "compartida_tunombre"  -Path "C:\Users\compartida_tunombre\" -ReadAccess "Todos" -FullAccess "Administradores"

.. image:: imagenes/WS22NGUI04.png

.. code-block:: powershell

    #La montamos en el cliente en la unidad Z
  New-PSDrive -Name "Z" -PSProvider "FileSystem" -Root "\\WS22TUNOMBRE\compartida_tunombre" 
  
.. image:: imagenes/WS22NGUI05.png
