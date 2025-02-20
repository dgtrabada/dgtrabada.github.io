******
Apache
******


Apache es un servidor web de código abierto, es compatible con varios lenguajes de programación como PHP, Python, Perl, ...


Caso práctico: Apache
********************

Instalamos el servicor de Apache:

.. code-block:: bash

 #Primero actualizamos
 apt update

 #Instalamos apache
 apt install apache2
 
 #podemos verificar si se a instalado
 systemctl status apache2 

Abre un navegador web y visita la dirección IP de tu servidor. Es decir ``http://tu_direccion_ip``

.. image:: imagenes/apache2_0.png


Para configurar un nuevo sitio web, crea un nuevo archivo de configuración en ``sites-available/``, crea el sitio llamado tunombre.com, es decir ``/etc/apache2/sites-available/tunombre.conf``:

.. code-block:: bash

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

Habilitamos el sitio

.. code-block:: bash

  sudo a2ensite tunombre.conf
 
Deshabilitar el sitio por defecto:

.. code-block:: bash

 sudo a2dissite 000-default.conf
 
Creamos el directorio del sitio

.. code-block:: bash

  sudo mkdir -p /var/www/tunombre

Para recargar la configuración de apache

.. code-block:: bash

  sudo systemctl reload apache2

Añadimos la siguiente we sencilla en ``/var/www/tunombre/index.html``

.. code-block:: bash

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

Obtendremos:

.. image:: imagenes/apache2_1.png
