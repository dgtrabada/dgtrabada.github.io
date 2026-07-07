*****************************
Ejercicios de shell scripting
*****************************

disk.sh
"""""""

.. tabs::

    .. tab:: disk.sh

        Crea un script llamado **disk.sh** que imprima por pantalla el porcentaje que esta ocupada la partición ``/home``. Tiene que quedar:

        ``75% /home``

    .. tab:: Solución

        .. literalinclude:: scripts/disk.sh
           :language: shell

mem.sh
"""""""

.. tabs::

    .. tab:: mem.sh

        Crea un script llamado **mem.sh**, obtiene solamente la memoria en MB ocupada y haz que se escriban en un archivo llamado ``free.log`` cada vez que se ejecute, sin borrar el anterior registro.

    .. tab:: Solución

        .. literalinclude:: scripts/mem.sh
           :language: shell
mac.sh
""""""

.. tabs::

    .. tab:: mac.sh

        Crea un script llamado **mac.sh** que obtiene la MAC de tu tarjeta de red

    .. tab:: Solución

        .. literalinclude:: scripts/mac.sh
           :language: shell

listar_usuario_grupo.sh
"""""""""""""""""""""""

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


lastlog_ip.sh
"""""""""""""

.. tabs::

    .. tab:: lastlog_ip.sh

        Crea un script llamado **lastlog_ip.sh** que muestre un listado ordenado con el nº de veces que se ha logueado cada ip, por ejemplo

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

lastlog.sh
""""""""""

.. tabs::

    .. tab:: lastlog.sh

        Crea un script llamado **lastlog.sh** que muestre un listado ordenado con el nº de veces que se ha logueado cada usuario y el grupo al que pertenecen, por ejemplo

        .. code-block:: bash
          
           44 alumno1 smr1
           32 alumno2 smr1
           14 alumno3 asir1
           4 alumno4 asir2


    .. tab:: Solución

        .. literalinclude:: scripts/lastlog.sh
           :language: shell

tabla_multiplicar_read.sh
"""""""""""""""""""""""""

.. tabs::

    .. tab:: tabla_multiplicar_read.sh

        Crea un script llamado **tabla_multiplicar_read.sh** que pide un número al usuario y muestre su tabla de multiplicar

    .. tab:: Solución

        .. literalinclude:: scripts/tabla_multiplicar_read.sh
           :language: shell


tabla_multiplicar_read.sh
"""""""""""""""""""""""""

.. tabs::

    .. tab:: tabla_multiplicar.sh

        Crea un script llamado **tabla_multiplicar.sh**, ahora no preguntará por el número al usuario y haz muestre su tabla de multiplicar cuando se ejecute por ejemplo ``./tabla_multiplicat.sh <N>`` siendo <N> un numero del 1 al 10.

        * En el caso de ejecutar ``./tabla_multiplicat.sh --help`` mostrara un mensaje de ayuda (consejo utiliza una función)
        * En el caso de ejecutar ``./tabla_multiplicar.sh X Y Z ...`` , es decir con más de un argumento saldrá un mensaje ``No se puede dar más de un argumento``
        * En el caso de ejecutar ``./tabla_multiplicar.sh`` sin argumentos se ejecutara la opción de --help


    .. tab:: Solución

        .. literalinclude:: scripts/tabla_multiplicar.sh
           :language: shell

    .. tab:: Solución (array)

        .. literalinclude:: scripts/tabla_multiplicar_array.sh
           :language: shell

imag.sh
"""""""

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

temperatura.sh
""""""""""""""

.. tabs::

    .. tab:: temperatura.sh

        Crea un script llamado **temperatura.sh**, que lea las temperatura del archivo `temperatura.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/temperatura.dat>`_ y saque por pantalla la temperatura media


    .. tab:: Solución

        .. literalinclude:: scripts/temperatura.sh
           :language: shell

    .. tab:: Solución (awk)

        .. literalinclude:: scripts/temperatura_awk.sh
           :language: shell

    .. tab:: Solución (array)

        .. literalinclude:: scripts/temperatura_array.sh
           :language: shell

meteo.sh
""""""""

.. tabs::

    .. tab:: meteo.sh

        Crea un script llamado **meteo.sh** que lea los datos de una estación meteorológica del archivo `meteo.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/meteo.dat>`_, cada línea es un día con cuatro columnas: día, temperatura mínima, temperatura máxima y humedad

        .. code-block:: bash

           01/06 12.5 22.1 65
           02/06 10.2 24.0 58
           03/06 14.0 26.5 60

        Se pide:

        1) La temperatura mínima media, la máxima media y la humedad media, con un decimal.
        #) El día más caluroso y el día más frío.
        #) El día con mayor amplitud térmica (temperatura máxima - mínima).

        La salida tiene que quedar:

        .. code-block:: bash

           ./meteo.sh
           Temperatura mínima media : 12.3 ºC
           Temperatura máxima media : 24.1 ºC
           Humedad media            : 61.5 %
           Día más caluroso         : 06/06 (29.6 ºC)
           Día más frío             : 08/06 (8.7 ºC)
           Día con mayor amplitud   : 09/06 (16.5 ºC)

        Consejos:

        * ``read`` puede leer varias variables a la vez: ``while read dia tmin tmax hum``, cada columna llega a una variable sin necesidad de ``cut``.
        * Con decimales no se puede comparar con ``-gt`` o ``-lt``, compara con bc: ``$(echo "$tmax > $t_caluroso" | bc -l)`` devuelve 1 si es cierto.

    .. tab:: Solución

        .. literalinclude:: scripts/meteo.sh
           :language: shell

    .. tab:: Solución (awk)

        .. literalinclude:: scripts/meteo_awk.sh
           :language: shell

    .. tab:: Solución (array)

        .. literalinclude:: scripts/meteo_array.sh
           :language: shell

alerta_disco.sh
"""""""""""""""

.. tabs::

    .. tab:: alerta_disco.sh

        Crea un script llamado **alerta_disco.sh** que recorra las particiones montadas y, por cada una que supere un umbral de ocupación, escriba una alerta con la fecha en el archivo ``alertas.log`` y también por pantalla. El umbral se recibe como argumento, por defecto será 80.

        .. code-block:: bash

           ./alerta_disco.sh 50
           2026-07-07 10:30 / está al 57% (umbral 50%)

           cat alertas.log
           2026-07-07 10:30 / está al 57% (umbral 50%)

        Consejos:

        * ``df | tail -n +2`` quita la línea de cabecera, y como en **meteo.sh** puedes leer las columnas con ``while read``.
        * ``tr -d '%'`` elimina el símbolo % para poder comparar con ``-ge``.
        * ``tee -a`` escribe a la vez por pantalla y al final de un archivo.

    .. tab:: Solución

        .. literalinclude:: scripts/alerta_disco.sh
           :language: shell

rnd.sh
""""""

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

    .. tab:: Solución (array)

        .. literalinclude:: scripts/rnd_array.sh
           :language: shell


adivina.sh
""""""""""

.. tabs::

    .. tab:: adivina.sh

        Crea un script llamado **adivina.sh** que escoja un numero aleatorio entre 1 y 20, pregunte al usuario, le diga si es más pequeño o más grande y que continué hasta que acierte.

        Cuando el usuario acierte haz que muestre el número de intentos.

    .. tab:: Solución

        .. literalinclude:: scripts/adivina.sh
           :language: shell

menu.sh
"""""""

.. tabs::

    .. tab:: menu.sh

        Crea un script llamado **menu.sh** que muestre un menú numerado con las opciones **Disco**, **Memoria**, **Usuarios conectados** y **Salir**, ejecute el comando correspondiente y vuelva a preguntar hasta que se escoja Salir. Si se escoge un número que no existe mostrará ``Opción no válida``.

        .. code-block:: bash

           ./menu.sh
           1) Disco                 3) Usuarios conectados
           2) Memoria               4) Salir
           Escoge una opción:

        Consejos:

        * El bucle ``select opcion in ...`` genera el menú numerado él solo y guarda en ``$opcion`` la opción escogida, combínalo con ``case``.
        * La variable ``PS3`` es el mensaje que muestra ``select`` para preguntar.

    .. tab:: Solución

        .. literalinclude:: scripts/menu.sh
           :language: shell

contar_monedas.sh
"""""""""""""""""

.. tabs::

    .. tab:: contar_monedas.sh

        Crea un script llamado **contar_monedas.sh** que lea el número de monedas que hay de un archivo llamado monedas.dat.

        Genera el archivo **monedas.dat** utilizando el siguiente codigo:

        .. code-block:: bash

           for((i=0;i<10;i++)) 
           do 
           echo $((RANDOM%10))
           done > monedas.dat

    .. tab:: Solución

        .. literalinclude:: scripts/contar_monedas.sh
           :language: shell

    .. tab:: Solución (array)

        .. literalinclude:: scripts/contar_monedas_array.sh
           :language: shell

piedra_papel_tijera.sh
""""""""""""""""""""""

.. tabs::

    .. tab:: piedra_papel_tijera.sh

        Crea un script en Bash llamado **piedra_papel_tijera.sh** que simule el juego de (Piedra, Papel o Tijera) entre dos jugadores durante un número dado de partidas.

        Cada jugador debe elegir aleatoriamente entre piedra, papel o tijera. El programa deberá contar cuántas veces gana el Jugador 1, cuántas gana el Jugador 2 y cuántas veces empatan.

        La salida debe ser un resumen con los porcentajes de empate, victoria del Jugador 1 y victoria del Jugador 2, con dos cifras decimales de precisión.

        Una vez creado el script,  muestra los resultados, como sigue:

        .. code-block:: bash

           for i in 10 50 100 1000 10000 100000; 
           do 
             echo $i $(./piedra_papel_tijera.sh $i)
           done

           10 Empate = 40.00 %, Gana 1 = 40.00 %, Gana 2 = 20.00 %
           50 Empate = 36.00 %, Gana 1 = 46.00 %, Gana 2 = 18.00 %
           100 Empate = 31.00 %, Gana 1 = 32.00 %, Gana 2 = 37.00 %
           1000 Empate = 34.30 %, Gana 1 = 34.40 %, Gana 2 = 31.30 %
           10000 Empate = 33.75 %, Gana 1 = 33.01 %, Gana 2 = 33.24 %
           100000 Empate = 33.30 %, Gana 1 = 33.24 %, Gana 2 = 33.44 %


    .. tab:: Solución

        .. literalinclude:: scripts/piedra_papel_tijera.sh
           :language: shell


notas.sh
""""""""

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
        #) El número de alumnos que han suspendido dos módulos.
        #) El número de alumnos que han suspendido tres módulos o más.
        #) Indicar el número de alumnos aprobados/suspensos en porcentaje.

    .. tab:: Solución

        .. literalinclude:: scripts/notas.sh
           :language: shell

    .. tab:: Solución (awk)

        .. literalinclude:: scripts/notas_awk.sh
           :language: shell

    .. tab:: Solución (csv)

        Ahora las calificaciones están en formato csv con cabecera, en el archivo `calificaciones.csv <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/calificaciones.csv>`_:

        .. code-block:: bash

           nombre,mod1,mod2,mod3,mod4,mod5
           Lucía Sánchez,10,6,6,5,8
           María Vargas,9,7,4,4,7

        Fíjate que al separar los campos con ``IFS=','`` y ``read`` el script se simplifica: cada nota llega a una variable sin necesidad de ``cut``.

        .. literalinclude:: scripts/notas_csv.sh
           :language: shell


analizar_cal.sh
"""""""""""""""

.. tabs::

    .. tab:: analizar_cal.sh

        Descarga el archivo `calendario.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/calendario.dat>`_, encontrará 543 citas donde el primer campo es el mes, el segundo campo es el día, el tercer campo es la hora y el cuarto la cita

        Crea un script llamado **analizar_cal.sh** que considere las siguientes entradas:

        
        * Muestra un mensaje de ayuda

          .. code-block:: bash

           ./analizar_cal.sh --help
           salida:
           Uso : analizar [OPCION]
           Options:
           - mes <mes>  muestra el número de citas que hay en un mes
           - d <día> muestra el numero de citas que hay para ese día para todos los meses

        * En el caso de no dar ninguna entrada también mostrará el mensaje de ayuda

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

rep.sh
""""""

.. tabs::

    .. tab:: rep.sh

        Crea un script llamado **rep.sh** que diga el número de veces que están repetidos los siguientes nombres del archivo `nombres.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/GNULinux/scripts/nombres.dat>`_

    .. tab:: Solución

        .. literalinclude:: scripts/rep.sh
           :language: shell

    .. tab:: Solución (array)

        .. literalinclude:: scripts/rep_array.sh
           :language: shell

duplicados.sh
"""""""""""""

.. tabs::

    .. tab:: duplicados.sh

        Crea un script llamado **duplicados.sh** que encuentre los archivos con el mismo contenido dentro de un directorio (aunque tengan nombres distintos), agrupándolos. Si no recibe el directorio como argumento analizará el directorio actual.

        Para probarlo genera unos archivos con duplicados:

        .. code-block:: bash

           mkdir ficheros
           for i in 1 2 3; do echo "contenido $i" > ficheros/original_$i.txt; done
           cp ficheros/original_1.txt ficheros/copia_1.txt
           cp ficheros/original_1.txt ficheros/otra_copia.txt
           cp ficheros/original_2.txt ficheros/copia_2.txt

           ./duplicados.sh ficheros
           Duplicados:
           ficheros/copia_1.txt
           ficheros/original_1.txt
           ficheros/otra_copia.txt
           Duplicados:
           ficheros/copia_2.txt
           ficheros/original_2.txt

        Consejos:

        * ``md5sum`` calcula un hash del contenido: dos archivos con el mismo contenido tienen el mismo hash, se llamen como se llamen.
        * ``find <dir> -type f -exec md5sum {} \;`` calcula el hash de todos los archivos, y con ``sort | uniq -d`` sobre la columna del hash tienes los repetidos (la misma cadena que en **rep.sh**).
        * ``$$`` es el PID del script, útil para crear un archivo temporal (``/tmp/hashes.$$``) que no pise el de otra ejecución.

    .. tab:: Solución

        .. literalinclude:: scripts/duplicados.sh
           :language: shell

monedas.sh
""""""""""

.. tabs::

    .. tab:: monedas.sh

        Sube al curso un script llamado  **monedas.sh** que tire tres monedas y escriba en un archivo el resultado.

        Haz que lea el archivo y obtenga el porcentaje de veces que salen 3 caras.

        En el caso de que no se proporcione el número de tiradas ni el archivo, tomara por defecto el archivo llamado tiradas.dat y hará 100 tiradas.

        En el caso de que no encuentre el archivo cuando lo va a leer, tomara por defecto monedas.dat, si este no existe, mostrará que no existe.

        .. code-block:: bash

           $ ./monedas.sh -help
           -n <tiradas> <archivo>
           -read <archivo>

    .. tab:: Solución

        .. literalinclude:: scripts/monedas.sh
           :language: shell

ip.sh
"""""

.. tabs::

    .. tab:: ip.sh

        Crea un script en Bash llamado **ips.sh** que cumpla con los siguientes requisitos:

        Si ejecutas el script con ``./ips.sh -help``, debe mostrar la siguiente ayuda:

        .. code-block:: bash

           -help                         : muestra la ayuda  
           -file <archivo> <número_ips>  : Crea un archivo llamado <archivo> con <número_ips>.
           -find <archivo> <ip>          : Muestra cuantas veces aparece la <ip>
           -read <archivo>               : Muestra de forma ordenada las IPs por número de conexiones

        * Si ejecutas el script sin argumentos ./ips.sh, también debe mostrar la ayuda.
        * Si ejecutas el ./ips.sh -file sin indicar el <número_ips> tomara por defecto 50, en el caso de no darle el <archivo> tomará por defecto ip.dat.  Cada línea tendrá una IP aleatoria dentro del rango 192.168.2.0/28. La primera IP utilizable es 192.168.2.1 y la última es 192.168.2.14.
        * Si ejecutas el ./ips.sh -find lee el <archivo>, si no existe o no se le indica, mostrará por pantalla "El archivo no existe", en el caso de que no se proporcione <ip> mostrará por pantalla "Proporcionar ip"
        * Si ejecutas el ./ips.sh -read lee el <archivo>, si no existe o no se le indica, mostrará por pantalla "El archivo no existe"

    .. tab:: Solución

        .. literalinclude:: scripts/ip.sh
           :language: shell

    .. tab:: Uso

        Puedes probar todas las opciones con el script **uso_ip.sh**, la función ``run`` imprime el comando antes de ejecutarlo (fíjate en el uso de ``"$@"``):

        .. literalinclude:: scripts/uso_ip.sh
           :language: shell

inventario.sh
"""""""""""""

.. tabs::

    .. tab:: inventario.sh

        Crea un script en Bash llamado **inventario.sh** que gestione un inventario de equipos en formato CSV. Cada línea del archivo tendrá los campos ``hostname,ip,ram_gb,estado``, y la primera línea será la cabecera:

        .. code-block:: bash

           hostname,ip,ram_gb,estado
           pc-01,192.168.1.54,4,mantenimiento
           pc-02,192.168.1.95,4,activo
           pc-03,192.168.1.17,64,activo

        Si ejecutas el script con ``./inventario.sh -help``, debe mostrar la siguiente ayuda:

        .. code-block:: bash

           -help                                        : muestra la ayuda
           -crear <archivo> <N>                         : Crea un csv con N equipos
           -add <archivo> <hostname> <ip> <ram> <estado>: Añade un equipo al csv
           -find <archivo> <hostname>                   : Muestra la información del equipo
           -del <archivo> <hostname>                    : Borra el equipo del csv
           -read <archivo>                              : Muestra el inventario en forma de tabla
           -resumen <archivo>                           : Muestra un resumen del inventario

        * Si ejecutas el script sin argumentos ``./inventario.sh``, también debe mostrar la ayuda.
        * Si ejecutas ``./inventario.sh -crear`` sin indicar ``<N>`` tomará por defecto 20 equipos, en el caso de no darle el ``<archivo>`` tomará por defecto inventario.csv. Los hostname serán pc-01, pc-02..., la IP será aleatoria dentro de 192.168.1.0/24, la RAM se escogerá aleatoriamente entre 4, 8, 16, 32 y 64 GB, y el estado entre activo, apagado y mantenimiento.
        * Si ejecutas ``./inventario.sh -add`` añadirá una línea al final del archivo, si el archivo no existe o faltan campos mostrará un mensaje de error.
        * Si ejecutas ``./inventario.sh -find`` buscará el equipo por su hostname y mostrará sus campos uno por línea (consejo: utiliza ``IFS=','`` con ``read``):

          .. code-block:: bash

             ./inventario.sh -find inventario.csv pc-03
              hostname: pc-03
              ip      : 192.168.1.17
              ram     : 64 GB
              estado  : activo

        * Si ejecutas ``./inventario.sh -del`` borrará la línea del equipo indicado, si el equipo no existe mostrará "No se encuentra el equipo" (consejo: utiliza ``sed -i`` con la dirección ``/^<hostname>,/d``).
        * Si ejecutas ``./inventario.sh -read`` mostrará el inventario alineado en columnas (consejo: mira ``man column``).
        * Si ejecutas ``./inventario.sh -resumen`` mostrará el número de equipos, la RAM total y el número de equipos por estado (consejo: utiliza ``awk -F','`` saltando la cabecera con ``NR>1``):

          .. code-block:: bash

             ./inventario.sh -resumen inventario.csv
             Equipos   : 20
             RAM total : 484 GB
             mantenimiento : 4
             apagado : 6
             activo : 10

        * En todas las opciones que leen el archivo, si este no existe mostrará "El archivo no existe".

    .. tab:: Solución

        .. literalinclude:: scripts/inventario.sh
           :language: shell

    .. tab:: Uso

        Puedes probar todas las opciones con el script **uso_inventario.sh**, la función ``run`` imprime el comando antes de ejecutarlo (fíjate en el uso de ``"$@"``):

        .. literalinclude:: scripts/uso_inventario.sh
           :language: shell

backup.sh
"""""""""

.. tabs::

    .. tab:: backup.sh

        Crea un script en Bash llamado **backup.sh** que gestione copias de seguridad comprimidas. Si ejecutas el script con ``./backup.sh -help``, debe mostrar la siguiente ayuda:

        .. code-block:: bash

           -help                : muestra la ayuda
           <directorio>         : Crea backups/backup_<directorio>_<fecha>.tar.gz
           -lista               : Muestra los backups con su tamaño
           -limpiar <días>      : Borra los backups con más de <días> días, por defecto 7
           -restaurar <archivo> : Extrae el backup en el directorio restaurado

        * Si ejecutas el script sin argumentos ``./backup.sh``, también debe mostrar la ayuda.
        * Si ejecutas ``./backup.sh <directorio>`` creará el directorio ``backups`` si no existe y dentro un ``backup_<directorio>_<fecha>.tar.gz``, si ``<directorio>`` no existe mostrará un error:

          .. code-block:: bash

             ./backup.sh ficheros
             Creado backups/backup_ficheros_2026-07-07_1030.tar.gz

        * Si ejecutas ``./backup.sh -lista`` mostrará los backups con su tamaño (consejo: ``du -h``).
        * Si ejecutas ``./backup.sh -limpiar <días>`` borrará los backups con más de ``<días>`` días mostrando cuáles borra, por defecto 7 días (consejo: ``find -mtime +N``, para probarlo envejece un backup con ``touch -d "10 days ago" <archivo>``).
        * Si ejecutas ``./backup.sh -restaurar <archivo>`` lo extraerá dentro del directorio ``restaurado`` (consejo: ``tar -xzf <archivo> -C restaurado``).

        Consejos:

        * ``date +%F_%H%M`` da la fecha con el formato ``2026-07-07_1030``.
        * ``basename <ruta>`` se queda con el último componente de la ruta, para construir el nombre del backup.

    .. tab:: Solución

        .. literalinclude:: scripts/backup.sh
           :language: shell

dados.sh
""""""""

.. tabs::

    .. tab:: dados.sh

        Sube al curso un script llamado  **dados.sh** que obtenga dos números aleatorios entre el 1 y el 6, obtén la suma de los dos dados, Haz que salga por pantalla el numero de tiradas y el porcentaje de veces que sale cada una.

        Haz que el número de tiradas lo reciba como un argumento,  el caso de que no reciba ningún argumento haz que haga 1000 tiradas

        .. code-block:: bash

           $ ./dados.sh
           De 1000 tiradas : 2(1%) 3(7%) 4(10%) 5(12%) 6(14%) 7(17%) 8(14%) 9(12%) 10(10%) 11(7%) 12(1%)

    .. tab:: Solución

        .. literalinclude:: scripts/dados.sh
           :language: shell

    .. tab:: Solución (general)

        .. literalinclude:: scripts/ndados.sh
           :language: shell

adivina_cpu.sh
""""""""""""""

.. tabs::

    .. tab:: adivina_cpu.sh

        Crea un script en Bash llamado **adivina_cpu.sh** que simule un juego automático de adivinanza en el que la CPU intenta adivinar un número secreto aleatorio, generado al inicio del programa. El número estará comprendido entre 1 y un valor máximo definido por la variable n_max_adivinar. En cada intento, la CPU elige otro número al azar dentro del rango posible, ajustando los límites mínimo y máximo según si el número es menor o mayor al número secreto.

        El script debe cumplir con los siguientes requisitos:

        * No se deben repetir los números ya probados.
        * Tras cada intento, si el número elegido es menor que el número secreto, se actualiza el mínimo.
        * Si el número elegido es mayor, se actualiza el máximo.
        * El proceso se repite hasta que se adivine el número secreto.
        * Al final, se muestra el número total de intentos que necesitó la CPU para adivinar el número.

        Cuando el usuario acierte haz que muestre el número de intentos.

    .. tab:: Solución

        .. literalinclude:: scripts/adivina_cpu.sh
           :language: shell


    .. tab:: Test

        Para testearlo puedes usar:

        .. code-block:: bash
            
            ntot=100
            sum=0
            for((i=0;i<$ntot;i++))
            do 
              n=$(./adivina_cpu.sh) 
              sum=$((sum+n))
            done
            resultado=$(echo "1/($sum/$ntot)" | bc -l)
            printf "%.2f\n" "$resultado"
            0.23

        Como se puede ver, la probabilidad de acertar el número se incrementa notablemente gracias a dos factores clave del algoritmo: evitar repetir números y ajustar dinámicamente los valores máximo y mínimo tras cada intento.

        Si no se evitaran los números repetidos y no se acotara el intervalo con el mínimo y el máximo, cada intento sería completamente aleatorio dentro del rango total (por ejemplo, del 1 al 20). En ese caso, la probabilidad de acertar en un intento sería simplemente: 1/20=0.05 es decir, solo un 5% de probabilidad frente al 23%


tragaperras.sh
""""""""""""""


.. tabs::

    .. tab:: tragaperras.sh

        Crea un script llamado **tragaperras.sh** que simule una máquina tragaperras con tres rodillos. Cada rodillo muestra un número aleatorio del 0 al 9. Las reglas del juego son las siguientes:

        Cada partida cuesta 1 moneda.

        * Si aparecen dos números iguales, el jugador gana 2 monedas.
        * Si aparecen tres números iguales, el jugador gana 3 monedas.
        * Si los tres números son 7, el jugador gana 10 monedas.

        El programa debe simular una cantidad significativa de partidas y calcular:

        * El número total de monedas ganadas.
        * El número total de monedas gastadas.
        * El balance final.

        Y, finalmente, responder a la pregunta: ¿Es rentable esta tragaperras para el jugador?

        Haz que el número de tiradas lo reciba como un argumento,  el caso de que no reciba ningún argumento haz que haga 1000 tiradas

    .. tab:: Solución

        .. literalinclude:: scripts/tragaperras.sh
           :language: shell

flor.sh
"""""""

.. tabs::

    .. tab:: flor.sh

        Crea un script llamado **flor.sh** que juegue a adivinar una palabra letra a letra: con cada fallo la flor pierde un pétalo y al sexto fallo la flor se marchita y se pierde la partida. El script debe utilizar las siguientes palabras como ejemplo:

        .. code-block:: bash

           palabra=("PYTHON" "LINUX" "BASH" "GITHUB" "DOCKER")

           # La flor completa:

             @ @ @
            @ (o) @
               |
              \|/
           =========

           # La flor marchita:

              (o)
                \
              \|/
           =========

    .. tab:: Solución

        .. literalinclude:: scripts/flor.sh
           :language: shell




Gestión de usuarios locales
===========================

usuarios_WSL.sh
"""""""""""""""

.. tabs::

    .. tab:: usuarios_WSL.sh

        Crea un script llamado **usuarios_WSL.sh**, que cumpla las siguientes condiciones:

        .. code-block:: bash

           ./usuarios_WSL.sh -help  
             -help               Mostrar esta ayuda.
             -crear <N>          Crear N usuarios de forma aleatoria dentro de los grupos X, Y o Z.
             -borrar             Borrar todos los usuarios creados por este script.
             -listar             Mostrar los usuarios por grupo creados por este script.
       
        Opción ``-crear <N>``: Creará N usuarios con nombres generados automáticamente con el siguiente formato: uX01, uY23, uZ15, etc., 

        * La letra (X, Y o Z) corresponde a un grupo al que se asignará el usuario.
        * El número es un sufijo aleatorio de dos cifras (01 a 99).
        * Si no tenemos <N> creará por defecto 10 usuarios

    .. tab:: Solución

        .. literalinclude:: scripts/usuarios_WSL.sh
           :language: shell

usuarios.sh
"""""""""""

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

rsync_usuarios.sh
"""""""""""""""""

.. tabs::

    .. tab:: rsync_usuarios.sh

        Crea tres máquinas virtuales con Ubuntu Server:

        * Servidor principal llamado compute-0-0 
        * Clientes compute-0-1 y compute-0-2.

        Permite la conexión desde compute-0-0 al usuario root de compute-0-1 y compute-0-2 sin utilizar contraseña, mediante la exportación de claves SSH públicas.

        Escribe un script para clonar usuarios, el script deberá copiar los usuarios del sistema desde compute-0-0 a compute-0-1 y compute-0-2 utilizando el comando rsync para transferir los siguientes archivos:

        * /etc/passwd
        * /etc/shadow
        * /etc/group

        El script debe comprobar que los directorios /home/usuario existen en los clientes. Si no existen, deberá crearlos y configurar el acceso SSH de los usuarios.

        En los clientes, el script creará el directorio /home/usuario/.ssh para cada usuario (si no existe) y copiará su clave pública desde el servidor compute-0-0, de modo que los usuarios puedan iniciar sesión por SSH sin contraseña."

    .. tab:: Solución

        .. literalinclude:: scripts/sinc.sh
           :language: shell

        Necesitamos los siguientes archivos auxiliares

        .. code-block:: bash 

            root@compute-0-0:~# ls -la  home_usuario_cliente/
            total 32
            drwxr-xr-x 4 root root 4096 may 28 08:05 .
            drwx------ 6 root root 4096 jun  3 09:55 ..
            -rw------- 1 root root   68 may 28 08:05 .bash_history
            -rw-r--r-- 1 root root  220 may 28 08:05 .bash_logout
            -rw-r--r-- 1 root root 3771 may 28 08:05 .bashrc
            drwx------ 2 root root 4096 may 28 08:05 .cache
            -rw-r--r-- 1 root root  807 may 28 08:05 .profile
            drwxr-xr-x 2 root root 4096 may 28 08:15 .ssh
            root@compute-0-0:~# ls -la  home_usuario_server/
            total 28
            drwxr-x--- 3 root root 4096 may 28 08:04 .
            drwx------ 6 root root 4096 jun  3 09:55 ..
            -rw------- 1 root root  163 may 28 08:04 .bash_history
            -rw-r--r-- 1 root root  220 may 28 08:04 .bash_logout
            -rw-r--r-- 1 root root 3771 may 28 08:04 .bashrc
            -rw-r--r-- 1 root root  807 may 28 08:04 .profile
            drwx------ 2 root root 4096 may 28 08:11 .ssh


crear_usuarios_lista.sh
"""""""""""""""""""""""

.. tabs::

    .. tab:: crear_usuarios_lista.sh

        Genera la siguiente lista de usuarios en el archivo **lista.dat**

        .. code-block:: bash
      
           for((i=0;i<40;i++))
           do
             R=$RANDOM
             echo tunombre_$R G$(($R%4))
           done > lista.dat

        1) Crea un script llamado **crear_usuarios_lista.sh** que genere por defecto los usuarios que encuentra en el archivo **lista.dat**, con la contraseña ``cambiame``, haz que si recibe el nombre de otro archivo como lista lo utilice. En el caso de que el grupo no exista haz que lo cree en el sistema

        2) Crea otro script llamado **borrar_usuarios_lista.sh** que borre los usuarios que aparecen en el archivo **lista.dat**, haz que utilice este archivo por defecto en el caso de no recibir ningun archivo.

        3) Crea otro script llamado **crear_usuarios_grupo_lista.sh** que lea solo la primera columna de un archivo llamado **nombre_grupo.dat**, creará todos los usuarios dentro del grupo llamado **nombre_grupo**, en el caso de que no exista creara primero el grupo.

        4) Crea otro script llamdo **borrar_usuarios_grupo_lista.sh** que lea solo la primera columna de un archivo llamado **nombre_grupo.dat**, borrará todos los usuarios que encuentre en la lista, al final y sólo en el caso de que el grupo se haya quedado vacío se borrará tambien el grupo.

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

usuarios_ldap.sh
""""""""""""""""

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


    .. tab:: lista.dat

        .. code-block:: bash

         $ head -4 lista.dat
         tunombre_73 GA
         tunombre_36 GC
         tunombre_82 GC
         tunombre_07 GC

         for((i=0;i<$(wc -l lista.dat | cut -d' ' -f1);i++))
         do 
           ./usuarios_ldap.sh -adduser $(head -$i lista.dat | tail -1)
         done


usuarios_lista_ldap.sh
""""""""""""""""""""""

.. tabs::

    .. tab:: usuarios_lista_ldap.sh

        Crea un script llamado **usuarios_lista_ldap.sh**, haz que todos los usuarios se lean de un archivo llamado grupo.dat. Haz que todos los usuarios pertenezcan al grupo con el mismo nombre que el archivo sin la extensión .dat. En el caso de que no exista el grupo haz que se cree.

        En el archivo grupo.dat, hay una lista de emails, haz que se cree el usuario correspondiente al email, es decir usuario1@gmail.com creara el usuario usuario1. En el caso de -borrar borrara todos los usuarios del archivo, finalmente si no quedan usuarios en el grupo borra el grupo

        .. code-block:: bash

           ./usuarios_lista_ldap.sh -help
           ./usuarios_lista_ldap.sh -crear <archivo.dat> 
           ./usuarios_lista_ldap.sh -borrar <archivo.dat>

           #head -2 grupo.dat
           usuario1@gmail.com
           usuario2@gmail.com

    .. tab:: Solución

        .. literalinclude:: scripts/crear_usuarios_lista_ldap.sh
           :language: shell

#listar y borrar los usuarios de un grupo entero


