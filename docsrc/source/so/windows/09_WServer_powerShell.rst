********************************************
Casos prácticos : Active Directory sin GUI
********************************************


netsh interface ip set address name="Ethernet" source=static addr=172.16.0.12 mask=255.0.0.0 gateway=172.16.0.10

netsh interface ip set dnsserver "Ethernet" static 172.16.0.10 primary


Rename-Computer -NewName "WC22tunombre"
Restart-Computer

Add-Computer -DomainName tu_nombre.local

Si queremos sacar la maquina del dominio, en una terminal con permiso de administrador ejceutamos:

Remove-Computer -UnjoinDomainCredential tunombre\Administrador -PassThru -Verbose





En Windows, puedes utilizar el siguiente comando para sincronizar la hora con un servidor de tiempo en línea:

w32tm /resync