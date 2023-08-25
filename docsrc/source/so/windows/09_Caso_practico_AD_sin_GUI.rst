********************************************
Casos prácticos : Active Directory sin GUI
********************************************


Caso práctico: AD y DNS con adaptador puente
===============================

Crea los siguiente clones enlazados con los adaptadores en modo puente:

* Clon enlazado 1 de "Windows Server 2022 sin GUI" llamado **WS22tunombre** con IP 10.4.X.Y/8
* Clon enlazado 2 de "Windows Server 2022 sin GUI" llamado **CLient-tunombre** 10.5.X.Y/8

Instalación y configuración de Active Directory y DNS
-------------

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






Creación de un dominio:
-------

* Partiendo de la ventana Resultados de la instalación de Active Directory, pulsar en Promover este servidor a controlador de dominio. (Si se había cerrado la ventana anterior es posible acceder a ella pulsando en el icono de advertencia de la barra de herramientas del Administrador del servidor)





netsh interface ip set address name="Ethernet" source=static addr=172.16.0.12 mask=255.0.0.0 gateway=172.16.0.10

netsh interface ip set dnsserver "Ethernet" static 172.16.0.10 primary


Rename-Computer -NewName "WC22tunombre"
Restart-Computer

Add-Computer -DomainName tu_nombre.local

Si queremos sacar la maquina del dominio, en una terminal con permiso de administrador ejceutamos:

Remove-Computer -UnjoinDomainCredential tunombre\Administrador -PassThru -Verbose





En Windows, puedes utilizar el siguiente comando para sincronizar la hora con un servidor de tiempo en línea:

w32tm /resync