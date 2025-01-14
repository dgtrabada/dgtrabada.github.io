************************
Ejercicios de PowerShell
************************

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