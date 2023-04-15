***********
Rocky Linux
***********

* Instalación `Rocky Linux <https://rockylinux.org/>`_

  * Descargate la iso Minimal para la arquitectura X86_64
  * Utiliza un disco de 200 GB y 2G de RAM
  * Llama a esta maquina virtual **"MV Rocky Linux"**.
  * Utilizad dos adaptadores de red:
    * Tarjeta red modo "**Puente**" : 10.4.X.Y/8 , DNS 8.8.8.8 , Gateway 10.0.0.2. (DHCP si usas portátil)
    * Tarjeta de red modo "**Red interna**" : 172.16.0.10/16
  * En el destino de la instalación, selecciona el disco duro si no esta ya seleccionado y deja la configuración de almacenamiento de forma Automática
  * Configura la red en (RED Y NOMBRE DE ANFITRIÓN), haz que el nombre del equipo sea **compute-0-0**
  * Crea la contraseña de root
  * Añade en /etc/hosts

    .. code-block:: bash
  
     172.16.0.10 compute-0-0
     172.16.0.11 compute-0-1
     172.16.0.12 compute-0-2
     172.16.0.13 compute-0-3
  
    En el caso de que necesites reconfigurar la red utiliza el comando **nmtui**

* Crea dos clones enlazados de "MV Rocky Linux" llámalos "**compute-0-0**" y "**compute-0-1**"

  * **compute-0-0**:
  
    * Tarjeta red modo "Puente" : 10.4.X.Y/8 (DHCP si usas portátil)
    * Tarjeta de red modo "Red interna" : 172.16.0.10/16
    * Haz que el usuario root pueda acceder por ssh sin pedir contraseña
    
  * **compute-0-1**
  
    * Deja solo una tarjeta de red en modo "Red interna" : 172.16.0.11/16 (tiene internet a través de compute-0-0), deshabilita la segunda tarjeta nmtui (IPv4 <disabled>)
    * Cambia el nombre por compute-0-1 (/etc/h0stname)
    * Haz que el usuario root pueda acceder desde compute-0-0 por ssh sin pedir contraseña
    
  * Crea un servicio como hicimos en ubuntu-server, pero haz que el script se ejecute desde:
    
    .. code-block:: bash

     /usr/local/bin/enrutar.sh
     
     #si tienes algún problema prueba a deshabilitar
     systemctl disable firewalld

* Instala el servidor LDAP en compute-0-0

Servidor Rocky Linux
********************

Vamos a instalar el servidor  ldap en compute-0-0:

.. code-block:: bash

 dnf update

El **plus repo** esta deshabilitado por defecto en rocky linux

.. code-block:: bash

 dnf config-manager --set-enabled plus 
 dnf clean all
 dnf -y install openldap-servers openldap-clients


Podemos confirmar que todo esta instalado ejecutando:

.. code-block:: bash
 
 rpm -qa | grep ldap
 cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
 chown ldap. /var/lib/ldap/DB_CONFIG
 systemctl enable --now slapd
 systemctl restart slapd

Comprueba que esta corriendo e instalado

.. code-block:: bash
 
 systemctl status slapd

Generamos la contraseña del admin para ello ejecutamos

.. code-block:: bash

 slappasswd

En mi caso con alumno obtengo

.. code-block:: bash
  
 {SSHA}ZjYOkjfHrwAx/mjrOndWyUIzyuaXSZJf

La directiva TheolcRootPW puede usarse para especificar la password del DN para el rootdn

.. code-block:: bash

 cat changerootpw.ldif
 dn: olcDatabase={0}config,cn=config
 changetype: modify
 add: olcRootPW
 olcRootPW: {SSHA}ZjYOkjfHrwAx/mjrOndWyUIzyuaXSZJf
 
 ldapadd -Y EXTERNAL -H ldapi:/// -f changerootpw.ldif
 SASL/EXTERNAL authentication started
 SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
 SASL SSF: 0
 modifying entry "olcDatabase={0}config,cn=config"   

Importamos lo esquemas básicos

.. code-block:: bash

 ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
 ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
 ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif


 $ cat setdomainname.ldif

 dn: olcDatabase={2}mdb,cn=config
 changetype: modify
 replace: olcSuffix
 olcSuffix: dc=ldap,dc=tunombre,dc=local

 dn: olcDatabase={2}mdb,cn=config
 changetype: modify
 replace: olcRootDN
 olcRootDN: cn=admin, dc=ldap,dc=tunombre,dc=local

 dn: olcDatabase={2}mdb,cn=config
 changetype: modify
 add: olcRootPW
 olcRootPW:  {SSHA}ZjYOkjfHrwAx/mjrOndWyUIzyuaXSZJf


Aplicamos setdomainname.ldif

.. code-block:: bash
 
 ldapmodify -Y EXTERNAL -H ldapi:/// -f setdomainname.ldif

Vamos a crear las unidades organizativas

.. code-block:: bash

 $ cat adddomain.ldif

 dn: dc=ldap,dc=tunombre,dc=local
 objectClass: top
 objectClass: dcObject
 objectclass: organization
 o: My example Organisation
 dc: ldap

 dn: cn=admin, dc=ldap,dc=tunombre,dc=local
 objectClass: organizationalRole
 cn: admin
 description: OpenLDAP Manager

 dn: ou=usuarios,dc=ldap,dc=tunombre,dc=local
 objectClass: organizationalUnit
 ou: usuarios

 dn: ou=grupos,dc=ldap,dc=tunombre,dc=local 
 objectClass: organizationalUnit
 ou: grupos

Aplicamos los cambios:

.. code-block:: bash
 
 ldapadd -x -D "cn=admin,dc=ldap,dc=tunombre,dc=local" -W -f adddomain.ldif

Para añadir nuevos usuarios

.. code-block:: bash

 cat addtestuser.ldif
 dn: uid=tunombre1,ou=usuarios,dc=ldap,dc=tunombre,dc=local
 objectClass: inetOrgPerson
 objectClass: posixAccount
 objectClass: shadowAccount
 cn: tunombre1
 sn: tunombre1
 userPassword: alumno
 loginShell: /bin/bash
 uidNumber: 1010
 gidNumber: 501
 homeDirectory: /home/tunombre1
 shadowLastChange: 0
 shadowMax: 0
 shadowWarning: 0 

Lo añadimos:

.. code-block:: bash

 sudo ldapadd -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -W -f addtestuser.ldif

Para añadir un grupo

.. code-block:: bash

 $ cat grupo.ldif

 dn: cn=tuapellido,ou=grupos,dc=ldap,dc=tunombre,dc=local
 objectClass: posixGroup
 cn: tuapellido
 gidNumber: 501 

Para añadir la información al ldap

.. code-block:: bash

 sudo ldapadd -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -W -f grupo.ldif

Comprobamos y subimos un pantallazo al curso del siguiente comnado ejecutado en compute-0-0:

.. code-block:: bash

 [root@compute-0-0 ~] ldapsearch -xLLL -b "dc=ldap,dc=tunombre,dc=local"

Configuración de los certificados TLS

.. code-block:: bash

 dnf -y install openssl #instalamos el paquete openssl para crear certificados

Vamos a General nuestro propio certificado CA requerido para la comunicación segura del LDAP

.. code-block:: bash

 cd /etc/pki/CA/
 touch index.txt
 echo 01 > serial

Generamos la clave privada para el certificado CA

.. code-block:: bash
 
 openssl genrsa -out ldap.example.com.key 4096

Usamos nuestra clave privada para general el certificado CA

.. code-block:: bash
 
 openssl req -new -key ldap.tunombre.local.key -out ldap.tunombre.local.csr

 ES
 Madrid
 Madrid
 IESQuevedo
 INF
 ldap.tunombre.local
 tu_correo@educa.madrid.org

Vamos a crear un certificado SAN para evitar crear multiples certificados para cada cliente del ldap, para ello introduciremos los clientes que vamos a utilizar para hacer la conexión segura

.. code-block:: bash
 
 $cat server_cert_ext.cnf
 [v3_ca]
 basicConstraints = CA:FALSE
 nsCertType = server
 nsComment = "OpenSSL Generated Server Certificate"
 subjectKeyIdentifier = hash
 authorityKeyIdentifier = keyid,issuer:always
 keyUsage = critical, digitalSignature, keyEncipherment
 extendedKeyUsage = serverAuth
 subjectAltName = @alt_names
 [alt_names]
 IP.1 = 172.16.0.10
 IP.2 = 172.16.0.11
 IP.3 = 172.16.0.12
 IP.4 = 172.16.0.13
 IP.5 = 172.16.0.14
 DNS.1 = 8.8.8.8

Necesitaremos otra clave privada para el servidor LDAP con el nombre "ldap.tunombre.local.key" para ello

.. code-block:: bash
 
 cd /etc/pki/CA/private
 openssl genrsa -out ldap.tunombre.local.key 4096


También necesitaremos crear una solicitud de firma del certificado (csr)

.. code-block:: bash

 openssl req -new -key ldap.tunombre.local.key -out ldap.tunombre.local.csr

Por ultimo creamos nuestro certificado del servidor ldap, utilizando CSR, la clve CA y el certificado CA creado anteriormente, este certificado sera valido por 365 días y esta encriptado con un algoritmo sha256

.. code-block:: bash

 cd /etc/pki/CA/
 openssl ca -keyfile ca.key -cert ca.cert.pem -in private/ldap.tunombre.local.csr -out private/ldap.tunombre.local.crt -extensions v3_ca -extfile server_cert_ext.cnf

Podemos ver que index.txt ha sido actualizado

.. code-block:: bash 
 
 cat index.txt

Para verificar el certificado del cliente

.. code-block:: bash

 openssl verify -CAfile ca.cert.pem private/ldap.tunombre.local.crt

Podemos ver que contine la lista de IPs y DNS que le proporcionamos

.. code-block:: bash
 
 openssl x509  -noout -text -in private/ldap.tunombre.local.crt | grep -A 1 "Subject Alternative Name"

Copiamos los certificados dentro de la configuración del ldap

.. code-block:: bash 
 
 cp -v private/ldap.tunombre.local.crt private/ldap.tunombre.local.key /etc/openldap/certs/
 cp -v ca.cert.pem /etc/openldap/cacerts/
 chown -R ldap:ldap /etc/openldap/certs
 chown -R ldap:ldap /etc/openldap/cacerts

Podemos comprobar que estos son los valores por defecto en los que slapcat buscara los certificados

.. code-block:: bash
 
 slapcat -b "cn=config" | egrep "olcTLSCertificateFile|olcTLSCertificateKeyFile"

Vamos a modificar los valores  olcTLSCertificateFile y olcTLSCertificateKeyFile

.. code-block:: bash

 $ cat tls7.ldif
 dn: cn=config
 changetype: modify
 replace: olcTLSCertificateFile
 olcTLSCertificateFile: /etc/openldap/certs/ldap.tunombre.local.crt
 -
 replace: olcTLSCertificateKeyFile
 olcTLSCertificateKeyFile: /etc/openldap/certs/ldap.tunombre.local.key

 ldapmodify -Y EXTERNAL -H ldapi:// -f tls7.ldif

 $ cat tls7_1.ldif
 dn: cn=config
 changetype: modify
 replace: olcTLSCertificateFile
 olcTLSCertificateFile: /etc/openldap/certs/ldap.tunombre.local.crt
 -
 replace: olcTLSCertificateKeyFile
 olcTLSCertificateKeyFile: /etc/openldap/certs/ldap.tunombre.local.key

 $ cat tls7_1.ldif
 dn: cn=config
 changetype: modify
 add: olcTLSCACertificateFile
 olcTLSCACertificateFile: /etc/openldap/cacerts/ca.cert.pem

Aplicamos los cambios

.. code-block:: bash

 ldapmodify -Y EXTERNAL -H ldapi:// -f tls7_1.ldif

Validamos los nuevos valores

.. code-block:: bash
 
 slapcat -b "cn=config" | egrep "olcTLSCertificateFile|olcTLSCertificateKeyFile|olcTLSCACertificateFile"

Habilitados la configuración del TLS en LDAP, para ello añadimos en /etc/openldap/ldap.conf

.. code-block:: bash

 TLS_CACERTDIR /etc/openldap/certs
 TLS_CACERT /etc/openldap/cacerts/ca.cert.pem
 TLS_REQCERT allow

Activamos los cambios

.. code-block:: bash

 systemctl status slapd

Permitimos el trafico del firewall entrante

.. code-block:: bash

 firewall-cmd --add-service=ldap
 firewall-cmd --add-service=ldaps
 firewall-cmd --reload

probamos:

.. code-block:: bash
 
 ldapsearch -x -ZZ

Cliente Rocky Linux
*******************


.. code-block:: bash

 dnf -y install openldap-clients sssd sssd-ldap oddjob-mkhomedir

 $ cat /etc/sssd/sssd.conf
 [domain/default]
 id_provider = ldap
 autofs_provider = ldap
 auth_provider = ldap
 chpass_provider = ldap
 ldap_uri = ldap://ldap.tunombre.local
 ldap_search_base = dc=ldap,dc=tunombre,dc=local
 ldap_id_use_start_tls = False
 ldap_tls_cacertdir = /etc/openldap/certs
 cache_credentials = True
 ldap_tls_reqcert = allow
 enumerate = true
 
 [sssd]
 services = nss, pam, autofs
 domains = default  

 [nss]
 homedir_substring = /home

 $ chmod 600 /etc/sssd/sssd.conf
 $ systemctl restart sssd
 $ systemctl enable sssd

Añanade en /etc/hosts

.. code-block:: bash

 172.16.0.10 ldap.tunombre.local

 #instalamos 
 dnf install authconfig -y

 authconfig --enableldap --enableldapauth --ldapserver=ldap.tunombre.local --ldapbasedn="dc=ldap,dc=tunombre,dc=local" --enablemkhomedir --update

Fíjate que en /etc/openldap/ldap.conf ha introducido las siguientes lineas

.. code-block:: bash

 BASE dc=ldap,dc=tunombre,dc=local
 URI ldap://ldap.tunombre.local


Bibliografía:
https://www.golinuxcloud.com/configure-openldap-with-tls-certificates/#Create_private_key_for_CA_certificate