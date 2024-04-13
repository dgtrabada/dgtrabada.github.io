********************************************
Casos prácticos : Active Directory sin GUI
********************************************


Caso práctico: AD y DNS sin GUI
====================================================

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



Unidades Organizativas, usuarios y grupos
-----------------------------------------

Vamos a crear las siguientes  unidades organizativas:

.. code-block:: powershell

  New-ADOrganizationalUnit -DisplayName "Despacho1" -Name "Despacho1" -path "DC=tunombre,DC=local"
  New-ADOrganizationalUnit -DisplayName "Despacho2" -Name "Despacho2" -path "DC=tunombre,DC=local"
  
Puedes comprobar las unidades creadas:

.. code-block:: powershell

  Get-ADOrganizationalUnit -LDAPFilter "(name=*)"  | FT Name,DistinguishedName
  

Grupos y usuarios
------------------

Vamos a crear los mismos usuarios que hicimos con entorno gráfico, es decir tu_nombreA1 en el grupo A, tu_nombreA2 en el grupo A, tu_nombreB1 en el grupo B y tu_nombreB2 en grupo B.

Primero vamos a crear los grupos de seguridad

.. code-block:: powershell

  New-ADGroup -DisplayName "A" -Name "A" -GroupScope DomainLocal -GroupCategory Security -Path "DC=tunombre,DC=local"
  New-ADGroup -DisplayName "B" -Name "B" -GroupScope DomainLocal -GroupCategory Security -Path "DC=tunombre,DC=local"


Después creamos los usuarios, como se ve en el siguiente ejemplo con el usuario tu_nombreA1

.. code-block:: powershell 
  
  New-ADUser -DisplayName "tu_nombreA1" -Name "tu_nombreA1" -UserPrincipalName "tu_nombreA1" -Enabled:$True -Path "DC=tunombre,DC=local" -AccountPassword (ConvertTo-SecureString -string "@lumn0A1" -AsPlainText -Force) -ChangePasswordAtLogon:$True

Por ultio lo añadimos al grupo

.. code-block:: powershell
 
  Add-ADGroupMember -Identity "A" -Members "tu_nombreA1"


Podemos comprobar que se han creado los grupos y los usuarios:

.. code-block:: powershell

  $lista = Get-ADGroup -Filter *  -SearchBase "DC=tunombre,DC=local" | select Name
  foreach ( $g in $lista) {
  echo ""
  echo $g
  echo "-------------"
  Get-ADGroupMember $g.Name -recursive | Select-Object Name
  }


Unir equipo al dominio
----------------------

Para añadir el equipo al dominio **CLient-tunombre** primero tendremos que cambiar el DNS:

.. code-block:: powershell

  #Comprobamos el DNS
  Get-DnsClientServerAddress

   #En el caso de que no apunte al servidor, lo cambiamos:
   Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddresses ("10.4.100.100", "8.8.8.8")
   
Por ultimo lo metemos dentro del dominio con el siguiente comando, necesitaremos exportar el display para que aparezca el dialogo para meter la contraseña

.. code-block:: powershell

  Add-computer -domainname "tunombre.local" -Credential  tunombre\administrador -restart -force
   
  #puedes comprobar que se añadido en el servidor ejecuntando allí
  Get-ADComputer -Filter * | FT Name

Es posible que al haber clonado los equipos no os deje por tener el mismo SID, para cambiarlo:


.. image:: imagenes/sysprep.png


Si queremos sacar la maquina del dominio, en una terminal con permiso de administrador ejceutamos:

.. code-block:: powershell

  Remove-Computer -UnjoinDomainCredential tunombre\Administrador -PassThru -Verbose


En Windows, puedes utilizar el siguiente comando para sincronizar la hora con un servidor de tiempo en línea:

.. code-block:: powershell
  
  w32tm /resync
