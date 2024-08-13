********
Menuitem
********

Crea 2 menus con dos más en cada caso.

Sube un par de pantallazos como el siguiente:

.. image:: imagenes/25_Menuitem.png

ayuda:

.. code-block:: bash

    <!-- menu categories -->
    <menuitem name="Menu 1" id="desechos.menu_1" parent="desechos.menu_root"/>
    <menuitem name="Menu 2" id="desechos.menu_2" parent="desechos.menu_root"/>
    <!-- actions -->
    <menuitem name="menuitem 1" id="desechos.menu_1_list" parent="desechos.menu_1"
        action="desechos.action_window"/>
    <menuitem name="menuitem 2" id="desechos.menu_2_list" parent="desechos.menu_1"
      action="desechos.action_window"/>
    <menuitem name="menuitem 3" id="desechos.menu_3_list" parent="desechos.menu_2"
        action="desechos.action_window"/>
    <menuitem name="menuitem 4" id="desechos.menu_4_list" parent="desechos.menu_2"
        action="desechos.action_window"/>
    <!--