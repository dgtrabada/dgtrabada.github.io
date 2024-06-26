*******************
Crear un modulo/app
*******************

Para el ejemplo crearemos la aplicación llamada desechos, la utilizaremos para gestionar los desechos nucleares, en tu caso crea una aplicación que se ajuste a tu empresa

https://www.odoo.com/documentation/14.0/administration/odoo_sh/getting_started/first_module.html

.. code-block:: bash

  /usr/bin/python3 /usr/bin/odoo scaffold --help

  server: /usr/bin/python3 /usr/bin/odoo scaffold desechos
  docker: /usr/bin/python3 /usr/bin/odoo scaffold desechos /mnt/extra-addons #desechos /usr/lib/python3/dist-packages/odoo/addons

En el caso de que hayamos tenido problemas para montar de forma local la carpeta extra-addons y /var/lib/odoo podemos abrir una consola:

.. code-block:: bash

  docker ps (anotamos CONTAINER ID)
  docker exec -i -t "CONTAINER ID" /bin/bash

Para loguearse como root: 

.. code-block:: bash

  docker exec -i -u root -t 19621416140d /bin/bash
  
Una vez logueados podemos instalar por ejemplo el editor vi  ``apt-get install vim`` y crear el modulo ejecutanto ``python3 /usr/bin/odoo scaffold desechos /mnt/extra-addons``


.. code-block:: bash

  Dentro de ...addons/desechos/ se habrán creado los siguientes archivos y carpetas:
  ├── controllers
  │   ├── controllers.py
  │   └── __init__.py
  ├── demo
  │   └── demo.xml
  ├── __init__.py
  ├── __manifest__.py
  ├── models
  │   ├── __init__.py
  │   └── models.py
  ├── security
  │   └── ir.model.access.csv
  └── views
      ├── templates.xml
      └── views.xml

descomentamos: 

* views/views.xml
* demo/demo.xml
* controllers/controllers.py
* views/templates.xml
* models/models.py
* __manifest__.py ('security/ir.model.access.csv')

Añade a odoo.conf
``addons_path = /usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons``

Ajustes/Opciones generales/Activar el modo desarrollador

Aplicaciones/Actualizaciones/Actualizar lista de aplicaciones

.. image:: imagenes/22_modulo1.png

* Instalamos la aplicación
* Cuando hagáis cambios en la aplicación actualizarla
* Vamos a cambiar Value por Cantidad y quitar el Value2, en vuestro caso podréis usar * Cantidad u otro nombre que se ajuste mejor a vuestra empresa

.. image:: imagenes/22_modulo2.png

En el archivo models/models.py cambiamos:
``value = fields.Integer() por : cantidad = fields.Float()``
quitamos la linea de ``value2`` y  ``@api.depends('cantidad')....``


En ``views/views.xml <field name="value"/>`` por ``<field name="cantidad"/>`` y quitamos ``value2``

En ``demo/demo.xml`` cambiamos ``value`` por ``cantidad``

.. image:: imagenes/22_modulo3.png

Creamos un desecho

.. image:: imagenes/22_modulo4.png

.. image:: imagenes/22_modulo5.png

Sube un pantallazo al curso de la aplicación que has creado

ayuda:

.. code-block:: bash

  tail -f /var/log/odoo/odoo-server.log
  systemctl restart odoo
  systemctl stop odoo ; su -c "/usr/bin/python3  /usr/bin/odoo -u desechos -d odoo" odoo

Es posible que tengas que comentar la parte de (server action) y (Server to list), esto implementa una forma de interactuar con el modelo mucho mas sencilla, de momento dejalo comentado o coméntalo si estaba comentado si te da problemas.


