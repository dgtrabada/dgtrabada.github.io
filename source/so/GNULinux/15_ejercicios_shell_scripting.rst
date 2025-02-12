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

    .. tab:: Solución (arrray)

        .. literalinclude:: scripts/tabla_multiplicar_array.sh
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

        .. literalinclude:: scripts/temperatura.sh
           :language: shell

.. tabs::

    .. tab:: temperatura.sh

        Crea un script llamado **temperatura.sh**, que lea las temperatura del archivo `temperatura.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/temperatura.dat>`_ y saque por pantalla la temperatura media


    .. tab:: Solución

        .. literalinclude:: scripts/temperatura.sh
           :language: shell

    .. tab:: Solución

        .. literalinclude:: scripts/temperatura_array.sh
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

    .. tab:: Solución

        .. literalinclude:: scripts/rnd_array.sh
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

        Haz un script llamado **notas.sh** que a partir de un fichero donde se recogen las calificaciones de los alumnos en los distintos módulos denominado `calificaciones.txt <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/calificaciones.txt>`_ con el siguiente formato:

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

        .. literalinclude:: scripts/notas.sh
           :language: shell



.. tabs::

    .. tab:: analizar_cal.sh

        Descarga el archivo `calendario.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/calendario.dat>`_, encontrara 543 citas donde el primer campo es el mes, el segundo campo es el día, el tercer campo es la hora y el cuarto la cita

        Crea una script llamado **analizar_cal.sh** que considere las siguientes entradas:

        
        * Muestra un mensaje de ayuda

          .. code-block:: bash

           ./analizar_cal.sh --help
           salida:
           Uso : analizar [OPCION]
           Options:
           - mes <mes>  muestra el número de citas que hay en un mes
           - d <día> muestra el numero de citas que hay para ese día para todos los meses

        * En el caso de no dar ninguna entrada tambien mostrará el mensaje de ayuda

        * Muestra el número de citas que hay por mes

          .. code-block:: bash

           ./analizar_cal.sh -mes Julio
           39

        * Muestra el número de citas que hay por un determinado día para todos los meses

          .. code-block:: bash

           ./analizar_cal.sh -d 4
           11

        * Muestra el número de citas que se han producido durante todo el año de forma ordenada

          .. code-block:: bash

           ./analizar_cal.sh -resumen citas | head
           23 Reunión de trabajo.
           16 Cita con el médico.
           14 Llamada con un cliente.
           14 Entrega de proyectos.
           14 Cumpleaños de un amigo.
           14 Clase de yoga o ejercicio.
           14 Cena con amigos.
           14 Aniversario de boda.
           13 Conferencia o seminario.
           10 Visita al dentista.


        * Muestra el numero de citas que hay por diferentes franjas horarias

          .. code-block:: bash

           ./analizar_cal.sh -resumen horas
           De 10:00-10:59 hay 87 citas
           De 11:00-10:59 hay 80 citas
           De 12:00-10:59 hay 99 citas
           De 13:00-10:59 hay 97 citas
           De 14:00-10:59 hay 79 citas
           De 15:00-10:59 hay 101 citas

    .. tab:: Solución

        .. literalinclude:: scripts/analizar_cal.sh
           :language: shell


.. tabs::

    .. tab:: rep.sh

        Crea un script llamado **rep.sh** que diga el numero de veces que estan repetidos los siguientes nombres del archivo `nombres.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/nombres.dat>`_

    .. tab:: Solución

        .. literalinclude:: scripts/rep.sh
           :language: shell

    .. tab:: Solución (array)

        .. literalinclude:: scripts/rep_array.sh
           :language: shell


.. tabs::

    .. tab:: dados.sh

        Sube al curso un script llamado  **dados.sh** que obtenga dos números aleatorios entre el 1 y el 6, obtén la suma de los dos dados, Haz que salga por pantalla el numero de tiradas y el porcentaje de veces que sale cada una.

        Haz que el número de tiradas lo reciba como un argumento,  el caso de que no reciba ningún argumento haz que haga 1000 tiradas

        .. code-block:: bash

           $ ./dados.sh
           De 1000 tiradas : 2(1%) 3(7%) 4(10%) 5(12%) 6(14%) 7(17%) 8(14%) 9(12%) 10(10%) 11(7%) 12(1%)

    .. tab:: Solución

        .. literalinclude:: scripts/a.sh
           :language: shell


Gestión de usuarios locales
===========================

.. tabs::

    .. tab:: usuarios.sh

        Crea un script llamado **usuarios.sh**, utiliza para ello un clon enlazado de la "MV Ubuntu Server 24.04"

        .. code-block:: bash

           ./usuarios.sh -help  
             usuarios.sh -addgroup <grupo>         : Crea un grupo si no existe
             usuarios.sh -delgroup <grupo>         : Elimina un grupo si existe
             usuarios.sh -adduser <usuario> [grupo]: Crea un usuario en el grupo especificado
                                                   : Si el grupo no existe lo crea primero
                                                   : Si no damos grupo usa por defecto el grupo usuario1 
             usuarios.sh -deluser <usuario>        : Elimina un usuario si existe
             usuarios.sh -lista                    : Lista todos los grupos y sus usuarios

           En el caso de ejecutar ./usuarios.sh sin argumentos obtendremos el mensaje de ayuda.
       
        Chequea tu script con las siguientes características:

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


.. tabs::

    .. tab:: crear y borrar desde una lista 

        Genera la siguiente lista de usuarios en el archivo **lista.dat**

        .. code-block:: bash
      
           for((i=0;i<40;i++))
           do
             R=$RANDOM
             echo tunombre_$R G$(($R%4))
           done > lista.dat

        1) Crea un script llamado **crear_usuarios_lista.sh** que genere por defecto los usuarios que encuentra en el archivo **lista.dat**, con la contraseña ``cambiame``, haz que si recibe el nombre de otro archivo como lista lo utilice. En el caso de que el grupo no exista haz que lo cree en el sistema

        2) Crea otro script llamado **borrar_usuarios_lista.sh** que borre los usuarios que aparecen en el archivo **lista.dat**, haz que utilice este archivo por defecto en el caso de no recibir ningun archivo.

        3) Crea otro script llamdo **crear_usuarios_grupo_lista.sh** que lea solo la primera columna de un archivo llamado **nombre_grupo.dat**, creará todos los usuarios dentro del grupo llamado **nombre_grupo**, en el caso de que no exista creara primero el grupo.

        4) Crea otro script llamdo **borrar_usuarios_grupo_lista.sh** que lea solo la primera columna de un archivo llamado **nombre_grupo.dat**, borrará todos los usuarios que encuentre en la lista, al final y sólo en el caso de que el grupo se haya quedado bacio se borrará tambien el grupo.

    .. tab:: crear_usuarios_lista.sh

        .. literalinclude:: scripts/crear_usuarios_lista.sh
           :language: shell

    .. tab:: borrar_usuarios_lista.sh

        .. literalinclude:: scripts/borrar_usuarios_lista.sh
           :language: shell

    .. tab:: crear_usuarios_grupo_lista.sh

        .. literalinclude:: scripts/crear_usuarios_grupo_lista.sh
           :language: shell

    .. tab:: borrar_usuarios_grupo_lista.sh

        .. literalinclude:: scripts/borrar_usuarios_grupo_lista.sh
           :language: shell




Gestión de usuarios LDAP
========================


.. tabs::

    .. tab:: usuarios_ldap.sh

        Crea un script llamado **usuarios_ldap.sh**, utiliza para ello un clon enlazado de la 'MV Ubuntu Server 24.04' con un ldap configurado `aqui <https://dgtrabada.github.io/so/GNULinux/13_ldap.html#instalacion-del-servidor-ldap>`_

        .. code-block:: bash

           Uso del script:
           ./usuarios_ldap.sh -addgroup <grupo>         : Crea un grupo si no existe
           ./usuarios_ldap.sh -delgroup <grupo>         : Elimina un grupo si existe
           ./usuarios_ldap.sh -lsgroup                  : Elimina un grupo si existe
           ./usuarios_ldap.sh -adduser <usuario> [grupo]: Crea un usuario en el grupo especificado 
           ./usuarios_ldap.sh -deluser <usuario>        : Elimina un usuario si existe
           ./usuarios_ldap.sh -lista                    : Lista todos los grupos y sus usuarios
           ./usuarios_ldap.sh -lsuser                   : Elimina un grupo si existe

    .. tab:: Solución

        .. literalinclude:: scripts/crear_usuarios_ldap.sh
           :language: shell

.. tabs::

    .. tab:: crear_usuarios_lista_ldap.sh

        Crea un script llamado **crear_usuarios_lista_ldap.sh**, haz que todos los usuarios se lean de un archivo llamado grupo.dat. Haz que todos los usuarios pertenezcan al grupo con el mismo nombre que el archivo sin la extensión .dat. En el caso de que no exista el grupo haz que se cree.

        En el archivo grupo.dat, hay una lista de emails, haz que se creer el usuario correspondiente al email, es decir usuario1@gmail.com creara el usuario usuario1

        .. code-block:: bash

           Uso del script:
           ./crear_usuarios_lista_ldap.sh grupo.dat

           head -2 grupo.dat
           usuario1@gmail.com
           usuario2@gmail.com

    .. tab:: Solución

        .. literalinclude:: scripts/a.sh
           :language: shell

.. tabs::

    .. tab:: borrar_usuarios_lista_ldap.sh

        Crea un script llamado **borrar_usuarios_lista_ldap.sh**, cuando termmine de borrar todos los usuarios del archivo grupo.dat comprobará si el grupo no tiene usuarios, en ese caso lo borrará también.

        .. code-block:: bash

           Uso del script:
           ./crear_usuarios_lista_ldap.sh grupo.dat

           head -2 grupo.dat
           usuario1@gmail.com
           usuario2@gmail.com           
           

    .. tab:: Solución

        .. literalinclude:: scripts/a.sh
           :language: shell
