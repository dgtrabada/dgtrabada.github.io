****
LDAP
****

¿Qué es LDAP?
=============

LDAP es un protocolo que ofrece el acceso a un servicio de directorio implementado sobre un entorno de red, con el objeto de acceder a una determinada información. Puede ejecutarse sobre TCP/IP o sobre cualquier otro servicio de trasferencia orientado a la conexión.

LDAP son las siglas en inglés de Lightweight Directory Access Protocol (Protocolo Ligero de Acceso a Directorios) y podemos considerarlo como un sistema de almacenamiento de red (normalmente construido como una base de datos) al que se pueden realizar consultas.

¿Qué es OpenLDAP?
=================

OpenLDAP es un desarrollo del protocolo LDAP, implementado con la filosofía del software libre y código abierto. El proyecto OpenLDAP se inició en agosto de 1998 y está sustentado por una entidad sin ánimo de lucro llamada OpenLDAP Foundation, creada por el desarrollador estadounidense Kurt D. Zeilenga para coordinar las actividades del proyecto.

¿Cómo funcionan LDAP y OpenLDAP?
================================

El modelo de información de LDAP se basa en entradas, entendiendo por entrada un conjunto de atributos identificados por un nombre global único (Distinguished Name – DN), que se utiliza para identificarla de forma específica. Las entradas se organizan de forma lógica y jerárquica mediante un esquema de directorio, que contiene la definición de los objetos que pueden formar parte del directorio.

Entre los atributos que suelen emplearse habitualmente, encontramos los siguientes, aunque puede haber muchos más:

* uid (user id): Identificación única de la entrada en el árbol.
* objectClass: Indica el tipo de objeto al que pertenece la entrada.
* cn (common name): Nombre de la persona representada en el objeto.
* givenname: Nombre de pila.
* sn (surname): Apellido de la persona.
* o (organization): Entidad a la que pertenece la persona.
* u (organizational unit): El departamento en el que trabaja la persona.
* mail: dirección de correo electrónico de la persona.

.. image:: imagenes/LDAP.png

Instalación del servidor LDAP
=============================

.. code-block:: bash

 sudo apt-get install slapd ldap-utils
 #contraseña slapd : alumno
 
   NO
   dominio DNS : ldap.tunombre.local
   organización : tunombre
   contraseña : alumno
   HDB
 
 #Si necesitamos reconfigurarlo
 sudo dpkg-reconfigure slapd 
 
Puedes chequear que se ha creado tu LDAP utilizando el comando:

.. code-block:: bash

 sudo ldapsearch -xLLL -b "dc=ldap,dc=tunombre,dc=local"

Crear la estructura del directorio
==================================

Una vez configurado el servidor, deberemos configurar la estructura básica del directorio. Es decir, crearemos la estructura jerárquica del árbol (DIT – Directory Information Tree).

Una de las formas más sencillas de añadir información al directorio es utilizar archivos LDIF (LDAP Data Interchange Format). En realidad, se trata de archivos en texto plano, pero con un formato particular que debemos conocer poder construirlos correctamente

El formato básico de una entrada es así:

.. code-block:: bash

 # comentario
 dn: <nombre global único>
 <atributo>: <valor>
 <atributo>: <valor>
 ...

<atributo> puede ser un tipo de atributo como cn o objectClass, o puede incluir opciones como cn;lang_en_US o userCertificate;binary.

Entre dos entradas consecutivas debe existir siempre una línea en blanco.
Si una línea es demasiado larga, podemos repartir su contenido entre varias, siempre que las líneas de continuación comiencen con un carácter de tabulación o un espacio en blanco.

Por ejemplo, las siguientes líneas son equivalentes:

.. code-block:: bash

 dn: uid=alumno1, ou=ldap, dc=tunombre,dc=local

 dn: uid=alumno1, ou=ldap,

  dc=tunombre,dc=es

Vamos insertar los siguientes objetos en el LDAP

.. code-block:: bash

 $ sudo cat tunombre.ldif

 dn: ou=usuarios, dc=ldap, dc=tunombre, dc=local
 objectClass: organizationalUnit
 ou: usuarios
 
 dn: ou=grupos,dc=ldap, dc=tunombre, dc=local
 objectClass: organizationalUnit
 ou: grupos


Añadimos la información a la base de datos OpenLDAP. Con el comando ldapadd:

.. code-block:: bash

 sudo ldapadd -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -W -f tunombre.ldif


Para comprobar que todo esta bien, podemos ejecutar:

.. code-block:: bash

 sudo ldapsearch -xLLL -b "dc=ldap,dc=tunombre,dc=local"

Para añadir nuevos usuarios

.. code-block:: bash

 $ sudo cat usuarios.ldif 

 dn: uid=tunombre1,dc=ldap,dc=tunombre,dc=local
 objectClass: inetOrgPerson
 objectClass: posixAccount
 objectClass: shadowAccount
 uid: tunombre1
 sn: sntunombre1
 givenName: tunombre1
 cn: tunombre1
 displayName: tunombre1
 uidNumber: 1010
 gidNumber: 501
 userPassword: tunombre1
 loginShell: /bin/bash
 homeDirectory: /home/tunombre1
 shadowExpire: -1
 shadowFlag: 0
 shadowWarning: 7
 shadowMin: 8
 shadowMax: 999999
 shadowLastChange: 10877
 mail: tunombre1@ldap.tunombre.local
 postalCode: 28027 

Para cargar el nuevo usuario en el directorio.

.. code-block:: bash

 sudo ldapadd -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -W -f usuarios.ldif

Para añadir un grupo

.. code-block:: bash

 $ sudo cat grupo.ldif 
 
 dn: cn=tuapellido,ou=grupos,dc=ldap,dc=tunombre,dc=local
 objectClass: posixGroup
 cn: GA
 gidNumber: 501 

Para añadir la información al ldap

.. code-block:: bash

 sudo ldapadd -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -W -f grupo.ldif

Cuando añadas nuevos usuarios, recuerda que los valores para los atributos uidNumber y homeDirectory deben ser diferentes para cada usuario.

Lo mismo ocurre con el atributo gidNumber de los grupos.

Además, los valores de los campos uidNumber y gidNumber no deben coincidir con el UID y GID de ningún usuario y grupo local.

Ahora podemos comprobar que el contenido anterior se ha añadido correctamente. Para lograrlo podemos utilizar, por ejemplo, el comando ldapsearch , que nos permite hacer una búsqueda en el directorio.:

.. code-block:: bash

 sudo ldapsearch -xLLL -b "dc=ldap,dc=tunombre,dc=local" uid=tunombre1

Otra opción interesante para comprobar el contenido del directorio es utilizar el comando slapcat. Su cometido es mostrar el contenido completo del directorio LDAP. Además, esta información se obtiene en formato LDIF, lo que nos permitirá volcarla a un fichero y exportar la base de datos de un modo muy sencillo.

Editar Objetos:

.. code-block:: bash

 $ cat change.ldif 

 dn: uid=usuario4,dc=ldap,dc=tunombre,dc=local
 changetype: modify
 replace: uidNumber
 uidNumber: 1014

 $ sudo ldapmodify -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -f change.ldif -W

Añadir Objetos:

.. code-block:: bash

 $ cat add.ldif

 dn: uid=usuario4,dc=ldap,dc=tunombre,dc=local
 changetype: modify
 add: homePhone
 homePhone: 1234567

 $ sudo ldapmodify -x -D cn=admin,dc=ldap,dc=tunombre,dc=local -f add.ldif -W

Para borrar por ejemplo el objeto tunombre1 : 


.. code-block:: bash

 sudo ldapdelete -x -W -D "cn=admin,dc=ldap,dc=tunombre,dc=local" "uid=tunombre1,dc=ldap,dc=tunombre,dc=local"

Cuando lo borramos, aunque no aparezca nada, si hacemos un ldapsearch veremos que no esta


.. code-block:: bash

 sudo ldapsearch -xLL -b "dc=ldap,dc=tunombre,dc=local" uid=tunombre1

Para hacer copias de seguridad y restaurarlas utilizamos:


.. code-block:: bash

 $ slapcat -l backup.ldif #hacemos un backup

 #borramos los usuarios, por error ...
 sudo ldapdelete -x -W -D "cn=admin,dc=ldap,dc=tunombre,dc=local" "uid=tunombre1......,dc=ldap,dc=tunombre,dc=local"
 systemctl stop slapd.service  #antes de restaurar paramos el servicio
 rm -Rf /var/lib/ldap/* #limpiamos el directorio ldap
 slapadd -v -c -l backup.ldif  #restauramos
 slapindex -v #rehacemos indices
 chown -Rf openldap.openldap /var/lib/ldap/*
 systemctl start slapd.service

Configuración de los clientes: Autenticación con OpenLDAP
=========================================================

.. code-block:: bash

 $ sudo apt-get install libnss-ldap libpam-ldap ldap-utils -y

   ldap://172.16.0.10
   dc=ldap,dc=tunombre,dc=local
   LDAP version : 3
   Yes
   No
   LDAP account for root: cn=admin,dc=ldap,dc=tunombre,dc=local
   alumno

 #reconfigurar :  sudo dpkg-reconfigure ldap-auth-config

 vi /etc/hosts
 172.16.0.10   ldap.tunombre.local

 vi  /etc/ldap.conf
 #Ponemos la siguiente linea al final: 172.16.0.10


 sudo pam-auth-update #marcar que se cree el directorio automaticamente
 sudo apt-get install sysv-rc-conf
 sudo sysv-rc-conf libnss-ldap on
 sudo auth-client-config -t nss -p lac_ldap

Algunos de estos comandos ya no están actualizados o tienen problemas lo importante es:


.. code-block:: bash

 /etc/nsswitch.conf
 passwd: files ldap
 shadow: files ldap
 group: files ldap

para comprobarlo puedes utilizar el comando:

.. code-block:: bash

 getent passwd

Hacer que funcione el caché de nombres

.. code-block:: bash

 apt-get install nscd
 
Para poder cambiar el password

.. code-block:: bash
  
 apt-get install libpam-cracklib