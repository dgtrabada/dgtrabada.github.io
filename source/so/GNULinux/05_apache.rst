******
Apache
******

Apache es un servidor web de código abierto y multiplataforma, uno de los más usados del mundo junto a nginx. Escucha por defecto en el **puerto 80** (HTTP) y en el **443** (HTTPS), funciona por módulos y es compatible con varios lenguajes de programación como PHP, Python, Perl, ...

En Debian/Ubuntu el paquete se llama **apache2**, el contenido web por defecto está en ``/var/www/html`` y la configuración en ``/etc/apache2/``:

* **sites-available/** los sitios configurados (disponibles).
* **sites-enabled/** los sitios activos: son enlaces simbólicos a los anteriores, que se crean y borran con ``a2ensite`` y ``a2dissite``.
* Los módulos se activan igual con ``a2enmod`` y ``a2dismod``.

Caso práctico: Apache
=====================

Instalamos el servidor de Apache:

.. code-block:: bash

 #Primero actualizamos
 sudo apt update

 #Instalamos apache
 sudo apt install apache2

 #podemos verificar si se ha instalado
 systemctl status apache2

Abre un navegador web y visita la dirección IP de tu servidor, es decir ``http://tu_direccion_ip``. Verás la página por defecto (el sitio 000-default, que sirve /var/www/html):

.. image:: imagenes/apache2_0.png


Para configurar un nuevo sitio web, crea un nuevo archivo de configuración en ``sites-available/``, crea el sitio llamado tunombre.com, es decir ``/etc/apache2/sites-available/tunombre.conf``:

.. code-block:: apache

  <VirtualHost *:80>
      ServerAdmin webmaster@tunombre.com
      ServerName tunombre.com
      ServerAlias www.tunombre.com
      DocumentRoot /var/www/tunombre

      <Directory /var/www/tunombre>
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
      </Directory>

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>

Un **VirtualHost** permite servir varios sitios web desde el mismo servidor: Apache elige uno u otro según el nombre con el que se le pide la página (**ServerName** o cualquiera de sus **ServerAlias**). **DocumentRoot** es la carpeta donde está el contenido del sitio, y los **logs** de accesos y errores quedan en ``/var/log/apache2/``.

Habilitamos el sitio (crea el enlace simbólico en sites-enabled/):

.. code-block:: bash

  sudo a2ensite tunombre.conf

Deshabilitar el sitio por defecto:

.. code-block:: bash

 sudo a2dissite 000-default.conf

Creamos el directorio del sitio

.. code-block:: bash

  sudo mkdir -p /var/www/tunombre

Comprobamos que la configuración no tiene errores y recargamos apache:

.. code-block:: bash

  sudo apache2ctl configtest
  sudo systemctl reload apache2

Añadimos la siguiente web sencilla en ``/var/www/tunombre/index.html``

.. code-block:: html

  <!DOCTYPE html>
  <html>
  <head>
      <title>Sitio Web tunombre</title>
  </head>
  <body>
      <h1>Sitio Web tunombre</h1>
      <p>Este es un sitio web de prueba.</p>
  </body>
  </html>

Como el nombre tunombre.com no existe en ningún DNS, para probar el sitio por su nombre añadimos esta línea al ``/etc/hosts`` de la máquina **desde la que abrimos el navegador** (si es la misma, usa 127.0.0.1):

.. code-block:: bash

  IP_del_servidor   tunombre.com www.tunombre.com

Visitando ``http://tunombre.com`` obtendremos:

.. image:: imagenes/apache2_1.png
