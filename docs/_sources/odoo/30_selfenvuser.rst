*************
self.env.user
*************

Crea una campo en que se puedan seleccionar los usuarios del sistema:

ayuda:
models.py :
  user_id = fields.Many2one('res.users','Responsable', default=lambda self: self.env.user)
views.xml :
  <field name="user_id"/>

Sube un pantallazo en el que se vea que puedes seleccionar a los usuarios:

Ir a...

.. image:: imagenes/24_selfuser.png

.. image:: imagenes/24_seluser2.png