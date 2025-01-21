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



.. tabs::

    .. tab:: lastlog_ip.sh

        Crea un script llamado **lastlog_ip.sh** que muestre un listado ordenado con el nº de veces que se a logueado cada ip, por ejemplo

        .. code-block:: bash
          
           16 10.2.104.100
           11 10.2.3.100
           10 139.47.103.76
           9 10.2.105.100
           8 2.153.195.106
           8 10.2.4.100
           8 10.2.105.106


    .. tab:: Solución

        .. literalinclude:: scripts/lastlog_ip.sh
           :language: shell


.. tabs::

    .. tab:: lastlog.sh

        Crea un script llamado **lastlog.sh** que muestre un listado ordenado con el nº de veces que se a logueado cada usuario y el grupo al que pertenecen, por ejemplo

        .. code-block:: bash
          
           44 alumno1 smr1
           32 alumno2 smr1
           14 alumno3 asir1
           4 alumno4 asir2


    .. tab:: Solución

        .. literalinclude:: scripts/lastlog.sh
           :language: shell


.. tabs::

    .. tab:: tabla_multiplicar_read.sh

        Crea un script llamado **tabla_multiplicar_read.sh** que pide un número al usuario y muestre su tabla de multiplicar

    .. tab:: Solución

        .. literalinclude:: scripts/tabla_multiplicar_read.sh
           :language: shell



.. tabs::

    .. tab:: tabla_multiplicar.sh

        Crea un script llamado **tabla_multiplicar.sh**, ahora no preguntara por el numero al usuario y haz muestre su tabla de multiplicar cuando se ejecute por ejemplo ``./tabla_multiplicat.sh <N>`` siendo <N> un numero del 1 al 10.

        * En el caso de ejecutar ``./tabla_multiplicat.sh --help`` mostrara un mensaje de ayuda (consejo utiliza una función)
        * En el caso de ejecutar ``./tabla_multiplicar.sh X Y Z ...`` , es decir con más de un argumento saldrá un mensaje ``No se puede dar más de un argumento``
        * En el caso de ejecutar ``./tabla_multiplicar.sh`` sin argumentos se ejecutara la opción de --help


    .. tab:: Solución

        .. literalinclude:: scripts/tabla_multiplicar.sh
           :language: shell



.. tabs::

    .. tab:: imag.sh

        Crea una carpeta llamada imagenes, entra dentro y ejecuta los siguiente comandos:

        .. code-block:: bash
          
           for i in jpeg jpg png gif tiff bmp svg
           do
             for((j=0;j<10;j++))
             do
               echo imag_${RANDOM}.$i > imag_${RANDOM}.$i 
             done
           done

        Crea un script llamado **imag.sh** que cambie todas extensiones de todos los archivos a png conservando el nombre

    .. tab:: Solución

        .. literalinclude:: scripts/imag.sh
           :language: shell

.. tabs::

    .. tab:: rnd.sh

        Haz un script llamado **rnd.sh** que muestre 5 números aleatorios del 1 al 10 seguidos de el mismo número de As,

        .. code-block:: bash

           1 A
           3 AAA
           1 A
           6 AAAAAA
           2 AA

        Haz que el reciba como argumento de entrada en numero de intentos, es decir ``./rnd.sh 5``

        En el caso de no recibir ningún numero haz que saque 5

    .. tab:: Solución

        .. literalinclude:: scripts/rnd.sh
           :language: shell



.. tabs::

    .. tab:: adivina.sh

        Haz un script llamado **adivina.sh** que escoja un numero aleatorio entre 1 y 20, pregunte al usuario, le diga si es más pequeño o más grande y que continué hasta que acierte.

        Cuando el usuario acierte haz que muestre el número de intentos.

    .. tab:: Solución

        .. literalinclude:: scripts/adivina.sh
           :language: shell


.. tabs::

    .. tab:: notas.sh

        Haz un script llamado **notas.sh** que a partir de un fichero donde se recogen las calificaciones de los alumnos en los distintos módulos denominado calificaciones.txt con el siguiente formato:

        .. code-block:: bash

           Lucía Sánchez: 10, 6, 6, 5, 8
           María Vargas: 9, 7, 4, 4, 7
           Lucía Pérez: 7, 5, 10, 8, 4
           Miguel González: 9, 7, 10, 3, 5
           Miguel López: 6, 4, 6, 10, 9
           Elena García: 3, 3, 3, 10, 4
           Pedro Torres: 6, 4, 10, 9, 4

        Se pide:
    
        1) El número de alumnos matriculados.

        #) El número de alumnos que han aprobado todos los módulos.

        #) El número de alumnos que han suspendido sólo un módulo.

        #) El número de alumnos que han suspendido dos módulo.

        #) El número de alumnos que han suspendido tres módulos o más.

        #) Indicar el número de alumnos aprobados/suspensos en porcentaje.

    .. tab:: Solución

        .. literalinclude:: scripts/a.sh
           :language: shell


.. tabs::

    .. tab:: usuarios.sh

        Haz un script llamado **usuarios.sh** utiliza para ello un clon enlazado de la "MV Ubuntu Server 24.04"

        .. code-block:: bash

           ./usuarios.sh -addgroup GA
           El script tiene que crear el grupo GA si no existe, en el caso de que exista devuelve "No se crea el grupo el grupo GA existe"

           ./usuarios.sh -delgroup GA
           El script tiene que borrar el grupo GA si existe, en el caso de que no exista devuelve "No se borra el grupo el grupo GA no existe"
           
           ./usuarios.sh -adduser usuario1 GA
           El script tiene que crear el usuario usuario1 en el grupo GA, si el grupo no existe lo crea primero, 
           en el caso de que exista el usuario no lo crea y sale por pantalla "No se crea el usuario usuario", 
           haz que la contraseña por defecto sea cambiame.
       
           ./usuarios.sh -adduser usuario1
           En el caso de que se ejecute sin grupo el sistema lo creara por defecto en grupo usuario1

           ./usuarios.sh -deluser usuario1
           El script tiene que borrar el usuario usuario1 si no existe devuelve "No se borra el usuario usuario1 no existe"

           ./usuarios.sh -lista
           El script lista todos los grupos con todos los usuarios que tiene

        Chequea tu script con las siguientes instrucciones y sube un pantallazo de su ejecución

        .. code-block:: bash

           cat usuarios.sh
           for g in GA GB GC GD
           do
             ./usuarios.sh -addgroup $g
             for u in 01 02 03 04
               do
               usuario=usuario_${g}_${u}
               ./usuarios.sh -adduser ${usuario} ${g}
             done
           done
           ./usuarios.sh -lista

           ./usuarios.sh -help
           El script muestra una ayuda con las opciones que puede tiene

    .. tab:: Solución

        .. literalinclude:: scripts/usuarios.sh
           :language: shell












