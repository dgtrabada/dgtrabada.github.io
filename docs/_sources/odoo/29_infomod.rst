**********************
Información del módulo
**********************

modifica el archivo ``__manifest__.py`` para que aparezcas como autor de la aplicación, cambia el resumen la descripción, haz que aparezca en una categoría y pon una la licencia de uso, por ejemplo:

.. code-block:: bash

  'category': 'Inventory/Inventory',
  'application': True,
  'license': 'LGPL-3'

Para que se cargue una imagen, copiamos la imagen en ``static/description/icon.png`` y en el modulo, en ``views.xml``

.. code-block:: bash

    <!-- Top menu item -->
    <menuitem id="desechos.menu_root"
            name="desechos"
            web_icon="desechos,static/description/icon.png"/>

Actualiza la aplicación y sube al curso un pantallazo en que se muestren los cambios realizados

.. image:: imagenes/23_infomod.png


