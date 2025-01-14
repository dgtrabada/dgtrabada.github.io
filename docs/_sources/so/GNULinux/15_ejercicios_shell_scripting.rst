*****************************
Ejercicios de shell scripting
*****************************

.. tabs::

    .. tab:: disk.sh

        Crea un script llamado **disk.sh** que imprima por pantalla el porcentaje que esta ocupada la partición ``/home``. Tiene que quedar:

        ``75% /home``

    .. tab:: Solución

        .. literalinclude:: scripts/disk.sh
           :language: shell


.. tabs::

    .. tab:: mem.sh

        Crea un script llamado **mem.sh**, obtiene solamente la memoria en MB ocupada y haz que se escriban en un archivo llamado ``free.log`` cada vez que se ejecute, sin borrar el anterior registro.

    .. tab:: Solución

        .. literalinclude:: scripts/mem.sh
           :language: shell


.. tabs::

    .. tab:: mac.sh

        Crea un script llamado **mac.sh** que obtiene la MAC de tu tarjeta de red

    .. tab:: Solución

        .. literalinclude:: scripts/mac.sh
           :language: shell


.. tabs::

    .. tab:: listar_usuario_grupo.sh

        Crea un script llamado **listar_usuario_grupo.sh** que saque por pantalla el nombre de los usuarios que hay creados en el sistema y al grupo que pertenecen, por ejemplo

        .. code-block:: bash
          
           alumno1 : smr1
           alumno2 : smr1
           alumno3 : asir1
           alumno4 : asir2

    .. tab:: Solución

        .. literalinclude:: scripts/listar_usuario_grupo.sh
           :language: shell
