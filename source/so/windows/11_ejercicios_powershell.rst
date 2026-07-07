************************
Ejercicios de PowerShell
************************

disk.ps1
""""""""

.. tabs::

    .. tab:: disk.ps1

        Crea un script llamado **disk.ps1** que imprima por pantalla el porcentaje que esta ocupada la partición C:

    .. tab:: Solución

        .. literalinclude:: 10_powershell/disk.ps1
           :language: shell


mem.ps1
"""""""

.. tabs::

    .. tab:: mem.ps1
      
        Crea un script llamado **mem.ps1**, obtiene solamente la memoria en MB ocupada  y se escriban en un archivo llamado free.log cada vez que se ejecute, sin borrar el anterior registro.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mem.ps1
           :language: shell



cpu.ps1
"""""""

.. tabs::

    .. tab:: cpu.ps1
      
        Crea un script llamado **cpu.ps1** que saque por pantalla el nombre del procesador instalado en el equipo

    .. tab:: Solución

        .. literalinclude:: 10_powershell/cpu.ps1
           :language: shell


mac.ps1
"""""""

.. tabs::

    .. tab:: mac.ps1
      
        Crea un script llamado **mac.ps1** que obtiene la MAC de las tarjetas de red que estén en estado Up

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mac.ps1
           :language: shell

    .. tab:: Solución (foreach)

        .. literalinclude:: 10_powershell/mac2.ps1
           :language: shell

edad.ps1
""""""""

.. tabs::

    .. tab:: edad.ps1
      
        Haz un script llamado **edad.ps1** que te pregunte en que año naciste y te diga la edad que tienes

    .. tab:: Solución

        .. literalinclude:: 10_powershell/edad.ps1
           :language: shell

tres_numeros.ps1
""""""""""""""""

.. tabs::

    .. tab:: tres_numeros.ps1
      
        Haz un script llamado **tres_numeros.ps1** que te pregunte al usuario tres numero enteros y devuelva la suma:

    .. tab:: Solución

        .. literalinclude:: 10_powershell/tres_numeros.ps1
           :language: shell

    .. tab:: Solución (usamos decimales)

        .. literalinclude:: 10_powershell/tres_numeros_decimales.ps1
           :language: shell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/tres_numeros_param.ps1
           :language: shell


impar.ps1
"""""""""

.. tabs::

    .. tab:: impar.ps1
      
        Haz un script llamado **impar.ps1** que pide un número al usuario y muestre los números impares hasta ese número

    .. tab:: Solución

        .. literalinclude:: 10_powershell/impar.ps1
           :language: shell

    .. tab:: Solución (args)

        .. literalinclude:: 10_powershell/impar_args.ps1
           :language: shell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/impar_param.ps1
           :language: shell



mult.ps1
""""""""

.. tabs::

    .. tab:: mult.ps1
      
        Haz un script llamado **mult.ps1** que pide un número al usuario y muestre su tabla de multiplicar

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mult.ps1
           :language: shell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/mult_param.ps1
           :language: shell

ext.ps1
"""""""

.. tabs::

    .. tab::  ext.ps1
    
        Crea una carpeta llamada Ejercicio, dentro ejecuta lo siguiente:
      
        .. code-block:: powershell
        
          mkdir Ejercicio
        
          cd .\Ejercicio\ 

          for ($i=0;$i -lt 10;$i++){
            echo archivo $i > archivo_$i.dat
          }

        Si hacemos (C:Users....\Ejercicio ls) veremos que se han creado 10 archivos. 
        Puedes también recorrerlos de la siguiente forma:
        
        .. code-block:: powershell

          foreach ($i In $(Get-ChildItem -Filter *.dat )){
            echo "i = $i"
            }
        
        Haz un script llamado **ext.ps1** que cambie a todos los archivos la extensión .dat por .txt
        

    .. tab:: Solución

        .. literalinclude:: 10_powershell/ext.ps1
           :language: shell


puerta.ps1
""""""""""

.. tabs::

    .. tab:: puerta.ps1
      
        Haz un script llamado **puerta.ps1**, que permite al usuario seleccionar entre cuatro puertas de diferentes colores (roja, azul, verde y amarilla). Si el usuario ingresa un código diferente de 1 a 4, se mostrará un mensaje indicando que la puerta es incorrecta.

    .. tab:: Solución (if)

        .. literalinclude:: 10_powershell/puerta_if.ps1
           :language: shell

    .. tab:: Solución (switch)

        .. literalinclude:: 10_powershell/puerta.ps1
           :language: shell


puerta2.ps1
"""""""""""

.. tabs::

    .. tab:: puerta2.ps1
      
        Haz un script llamado **puerta2.ps1** parecido al anterior, en este caso si el usuario selecciona una puerta que no sea la verde, se muestra un mensaje indicando que ha perdido. Si selecciona la puerta verde, se le permite lanzar una moneda para ver si gana o pierde.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/puerta2.ps1
           :language: shell
           
usuario.ps1
"""""""""""

.. tabs::

    .. tab:: usuario.ps1
      
        Haz un script llamado **usuario.ps1** que reciba los siguientes parámetros:

        .. code-block:: powershell

          usuario.ps1 -Nombre Mario -Apellido López -Usuario mario33 -Nacimiento 2000

        El script debe:

        Calcular la edad del usuario.
            Si el usuario tiene 14 años o más:
                Mostrar el mensaje:
                Se ha creado a [Nombre] [Apellido] el usuario [Usuario]
            Si el usuario tiene menos de 14 años:
                Mostrar el mensaje:
                No se puede crear el usuario [Usuario] a [Nombre] [Apellido] por tener menos de 14

    .. tab:: Solución (args)

        .. literalinclude:: 10_powershell/usuario_args.ps1
           :language: shell

    .. tab:: Solución (args descolocado)

        .. literalinclude:: 10_powershell/usuario_args2.ps1
           :language: shell

    .. tab:: Solución (args desc.+help )

        .. literalinclude:: 10_powershell/usuario_args3.ps1
           :language: shell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/usuario_param.ps1
           :language: shell

    .. tab:: Solución (param+help)

        .. literalinclude:: 10_powershell/usuario_param_help.ps1
           :language: shell

    .. tab:: usuario_csv.ps1
      
        Haz un script llamado **usuario_csv.ps1** que reciba los siguientes parámetros:

        .. code-block:: powershell

          usuario.ps1 -Nombre Mario -Apellido López -Usuario mario33 -Nacimiento 2000

        El script debe:

        * Calcular la **edad del usuario**.

          * Si el usuario tiene **14 años o más**, comprueba el archivo usuarios_medad.csv, si el usuario existe escribe el mensaje: ``No se puede crear el usuario, el usuario existe``

          * Si **no esta en el archivo**, crea la entrada con el usuario y muestra el mensaje: ``Se ha creado [Nombre] [Apellido] el usuario [Usuario] con contraseña [contraseña]``

          * En el caso de que **no exista el archivo**, lo crea y añade la entrada

          * Si el usuario tiene menos de **14 años** muestra el mensaje: ``No se puede crear el usuario [Usuario] a [Nombre] [Apellido] por tener menos de 14``

        2. La opción **-help** muestra la ayuda

        3. La opción **-list** lista todos los usuarios

        4. La opción **-delete [usuario]** borrar el usuario [usuario]

        Puedes probar el script con las siguientes instrucciones:

        .. code-block:: powershell

          rm  usuarios_medad.csv
          .\usuario_csv.ps1 -Nombre Juan -Apellido Gárcia -Nacimiento 2000 -Usuario juan01
          .\usuario_csv.ps1 -Nombre Marta -Apellido López -Nacimiento 1998 -Usuario mlopez98
          # El siguiente usuario no lo crea ya que es menor de 14 años
          .\usuario_csv.ps1 -Nombre Carlos -Apellido Sánchez -Nacimiento 2021 -Usuario csanchez01
          .\usuario_csv.ps1 -Nombre Laura -Apellido Pérez -Nacimiento 1999 -Usuario lperez99
          #El siguiene usuario no lo crea, existe ya en el sistema 
          .\usuario_csv.ps1 -Nombre Laura -Apellido Pérez -Nacimiento 1999 -Usuario lperez99
          .\usuario_csv.ps1 -Nombre David -Apellido Martín -Nacimiento 2000 -Usuario dmartin00
          .\usuario_csv.ps1 -Nombre Ana -Apellido Gómez -Nacimiento 1997 -Usuario agomez97
          .\usuario_csv.ps1 -Nombre Sergio -Apellido Ruiz -Nacimiento 2002 -Usuario sruiz02
          .\usuario_csv.ps1 -Nombre Elena -Apellido Torres -Nacimiento 1996 -Usuario etorres96
          .\usuario_csv.ps1 -Nombre Pablo -Apellido Navarro -Nacimiento 1995 -Usuario pnavarro95
          .\usuario_csv.ps1 -Nombre Cristina -Apellido Morales -Nacimiento 2003 -Usuario cmorales03
          .\usuario_csv.ps1 -Nombre Javier -Apellido Ortega -Nacimiento 1994 -Usuario jortega94
          .\usuario_csv.ps1 -list
          .\usuario_csv.ps1 -delete sruiz02
          # El sigiente usuario no lo borra ya que no existe
          .\usuario_csv.ps1 -delete sruiz02
          .\usuario_csv.ps1 -delete etorres96
          .\usuario_csv.ps1 -list

    .. tab:: Solución (csv)

        .. literalinclude:: 10_powershell/usuario_csv.ps1
           :language: shell


alerta_disco.ps1
""""""""""""""""

.. tabs::

    .. tab:: alerta_disco.ps1

        Crea un script llamado **alerta_disco.ps1** que recorra las unidades de disco y, por cada una que supere un umbral de ocupación, escriba una alerta con la fecha en el archivo ``alertas.log`` y también por pantalla en rojo. El umbral se recibe como parámetro, por defecto será 80.

        .. code-block:: powershell

           .\alerta_disco.ps1 -umbral 50
           2026-07-07 10:30 C:\ está al 57% (umbral 50%)

           cat alertas.log
           2026-07-07 10:30 C:\ está al 57% (umbral 50%)

        Consejos:

        * ``Get-PSDrive -PSProvider FileSystem`` devuelve las unidades con las propiedades ``Used`` y ``Free``, como en **disk.ps1**.
        * ``Add-Content`` añade al final del archivo sin borrar lo anterior, como en **mem.ps1**.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/alerta_disco.ps1
           :language: shell


servicios.ps1
"""""""""""""

.. tabs::

    .. tab:: servicios.ps1

        Crea un script llamado **servicios.ps1** que gestione los servicios del sistema. Si ejecutas el script con ``.\servicios.ps1 -help`` (o sin argumentos), debe mostrar la siguiente ayuda:

        .. code-block:: powershell

           -help                : muestra la ayuda
           -listar <estado>     : Muestra los servicios en ese estado (Running o Stopped)
           -arrancar <servicio> : Arranca un servicio si está parado
           -parar <servicio>    : Para un servicio si está arrancado

        * ``-listar`` mostrará el nombre y la descripción de los servicios en ese estado, y al final cuántos hay.
        * ``-arrancar`` y ``-parar`` comprobarán que el servicio existe y en qué estado está: si ya está arrancado (o parado) lo avisará sin hacer nada.

        .. code-block:: powershell

           .\servicios.ps1 -listar Stopped
           ...
           123 servicios en estado Stopped

           .\servicios.ps1 -parar Spooler
           El servicio Spooler ha sido parado

           .\servicios.ps1 -parar Spooler
           El servicio Spooler ya está parado

        Consejo: ``Get-Service`` devuelve objetos con las propiedades ``Name``, ``DisplayName`` y ``Status``, filtra con ``Where-Object``.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/servicios.ps1
           :language: shell


barrido_red.ps1
"""""""""""""""

.. tabs::

    .. tab:: barrido_red.ps1

        Crea un script llamado **barrido_red.ps1** que compruebe qué equipos de una red responden a ping. Recibirá como parámetros el prefijo de la red (por defecto ``192.168.2``, la red del ejercicio **ip.sh** de GNU/Linux) y el rango de IPs a comprobar (por defecto de 1 a 14), y al final dirá cuántos equipos están activos:

        .. code-block:: powershell

           .\barrido_red.ps1 -red 192.168.2 -desde 1 -hasta 14
           192.168.2.1 responde
           192.168.2.2 no responde
           192.168.2.3 responde
           ...
           5 equipos activos en 192.168.2.1-14

        Consejos:

        * ``Test-Connection <ip> -Count 1 -Quiet`` devuelve directamente ``$true`` o ``$false``.
        * Añade ``-TimeoutSeconds 1`` (PowerShell 7): sin él, cada IP muerta tarda varios segundos y el barrido se hace eterno.
        * ``$desde..$hasta`` genera el rango de números.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/barrido_red.ps1
           :language: shell


monedas.ps1
"""""""""""

.. tabs::

    .. tab:: monedas.ps1
      
        Haz un script llamado **monedas.ps1** que simule el lanzamiento de 3 monedas y calcule la probabilidad de obtener 3 caras

    .. tab:: Solución

        .. literalinclude:: 10_powershell/monedas.ps1
           :language: shell

    .. tab:: Solución (n monedas)

        .. literalinclude:: 10_powershell/n_monedas.ps1
           :language: shell


rnd.ps1
"""""""

.. tabs::

    .. tab:: rnd.ps1
      
        Haz un script llamado **rnd.ps1** que escoja un numero aleatorio entre 1 y 20, pregunte al usuario, le diga si es más pequeño o más grande y que continué hasta que acierte. Cuando el usuario acierte haz que muestre el número de intentos.

    .. tab:: Solución (while)

        .. literalinclude:: 10_powershell/rnd.ps1
           :language: shell

    .. tab:: Solución (do while)

        .. literalinclude:: 10_powershell/rnd_do_while.ps1
           :language: shell

    .. tab:: Solución (do while)

        .. literalinclude:: 10_powershell/rnd_do_until.ps1
           :language: shell

piedra_papel_tijera.ps1
"""""""""""""""""""""""

.. tabs::

    .. tab:: piedra_papel_tijera.ps1
      
        Crea un script de PowerShell llamado **piedra_papel_tijera.ps1** que implemente el clásico juego "Piedra, Papel o Tijeras" donde el usuario compite contra la computadora. 

    .. tab:: Solución (if)

        .. literalinclude:: 10_powershell/piedra_papel_tijera.ps1
           :language: shell

    .. tab:: Solución (switch)

        .. literalinclude:: 10_powershell/piedra_papel_tijera_switch.ps1
           :language: shell



dados.ps1
"""""""""

.. tabs::

    .. tab:: dados.ps1
      
        Haz un script llamado  dados.ps1 que obtenga dos números aleatorios entre el 1 y el 6, haz que la salida se vuelque en un archivo llamado tiradas.csv, en tres columnas, siendo la tercera columna la suma de los dos dados, crea un archivo con al menos 100 tiradas.

        Haz que el número de tiradas lo reciba como un argumento, por ejemplo:
        
        .. code-block:: powershell        
          
          .\dados.ps1 100

        En el caso de que no reciba ningún argumento haz que pregunte cuantas tiradas quieres.

        .. code-block:: text

          .\dados.ps1

          ¿Cuántas tiradas quieres hacer?
          100
   
        En el caso de que reciba el argumento help, muestre la siguiente ayuda:
        
        .. code-block:: powershell      
            
          .\dados.ps1 help
        
          Uso del script dados.ps1:
          .\dados.ps1 <número_de_tiradas>
          Ejemplo: .\dados.ps1 100
          Si no se proporciona ningún argumento, se preguntará cuántas tiradas deseas hacer.
          Si se usa el argumento 'help', se mostrará esta ayuda.

        
    .. tab:: Solución (args)

        .. literalinclude:: 10_powershell/dados.ps1
           :language: shell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/dados_param.ps1
           :language: shell


analisis.ps1
""""""""""""

.. tabs::

    .. tab:: analisis.ps1
      
        Lee el archivo que has generado en el ejercicio anterior y haz que salga por pantalla el numero de tiradas y el porcentaje de veces que sale cada una, por ejemplo
        
        .. code-block:: powershell
        
          $ ./analisis.ps1
          
          De 1000 tiradas : 2(1%) 3(7%) 4(10%) 5(12%) 6(14%) 7(17%) 8(14%) 9(12%) 10(10%) 11(7%) 12(1%)


    .. tab:: Solución (variables)

        .. literalinclude:: 10_powershell/analisis_variables.ps1
           :language: shell

    .. tab:: Solución (arrays)

        .. literalinclude:: 10_powershell/analisis.ps1
           :language: shell


meteo.ps1
"""""""""

.. tabs::

    .. tab:: meteo.ps1

        Crea un script llamado **meteo.ps1** que lea los datos de una estación meteorológica del archivo `meteo.dat <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/windows/10_powershell/meteo.dat>`_, cada línea es un día con cuatro columnas: día, temperatura mínima, temperatura máxima y humedad

        .. code-block:: powershell

           01/06 12.5 22.1 65
           02/06 10.2 24.0 58
           03/06 14.0 26.5 60

        Se pide:

        1) La temperatura mínima media, la máxima media y la humedad media, con un decimal.
        #) El día más caluroso y el día más frío.
        #) El día con mayor amplitud térmica (temperatura máxima - mínima).

        La salida tiene que quedar:

        .. code-block:: powershell

           .\meteo.ps1
           Temperatura mínima media : 12.3 ºC
           Temperatura máxima media : 24.1 ºC
           Humedad media            : 61.5 %
           Día más caluroso         : 06/06 (29.6 ºC)
           Día más frío             : 08/06 (8.7 ºC)
           Día con mayor amplitud   : 09/06 (16.5 ºC)

        Es el mismo ejercicio que **meteo.sh** de GNU/Linux, compara las dos soluciones. Consejos:

        * El archivo no tiene cabecera: ``Import-Csv -Delimiter ' ' -Header dia,t_min,t_max,humedad`` le pone nombre a las columnas.
        * ``Import-Csv`` lee todo como texto: convierte las columnas a número con ``[double]``, si no ``Sort-Object`` ordenará alfabéticamente ("8.7" quedaría después de "10.2").
        * ``Measure-Object -Average`` calcula la media, y para la amplitud puedes ordenar por una expresión: ``Sort-Object { $_.t_max - $_.t_min }``.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/meteo.ps1
           :language: shell


tragaperras.ps1
"""""""""""""""

.. tabs::

    .. tab:: tragaperras.ps1

        Un jugador comienza con 100 € para jugar en una máquina tragamonedas. El funcionamiento de la máquina es el siguiente:

        * Cada partida cuesta 1 €.
        * La máquina tiene 3 rulos. ``$rulos = @('limon', 'manzana', 'platano', 'siete')``

          * Tres frutas iguales (por ejemplo, 3 limones): el jugador gana 1 €.
          * Tres sietes: el jugador gana 100 €.

        * Si el jugador no tiene suficiente dinero para jugar (menos de 1 €), deja de jugar.

        Simula la evolución del dinero del jugador durante 1000 partidas o hasta que su dinero se agote, lo que ocurra primero.

        El objetivo es determinar cuánto dinero tiene el jugador al final de las 1000 partidas y cuántas partidas logró jugar en total.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/tragaperras.ps1
           :language: shell


duplicados.ps1
""""""""""""""

.. tabs::

    .. tab:: duplicados.ps1

        Crea un script llamado **duplicados.ps1** que encuentre los archivos con el mismo contenido dentro de un directorio (aunque tengan nombres distintos), agrupándolos. Si no recibe el directorio como parámetro analizará el directorio actual.

        Para probarlo genera unos archivos con duplicados:

        .. code-block:: powershell

           mkdir ficheros
           foreach ($i in 1..3) { "contenido $i" > ficheros\original_$i.txt }
           cp ficheros\original_1.txt ficheros\copia_1.txt
           cp ficheros\original_1.txt ficheros\otra_copia.txt
           cp ficheros\original_2.txt ficheros\copia_2.txt

           .\duplicados.ps1 -dir ficheros
           Duplicados:
           C:\...\ficheros\copia_1.txt
           C:\...\ficheros\original_1.txt
           C:\...\ficheros\otra_copia.txt
           Duplicados:
           C:\...\ficheros\copia_2.txt
           C:\...\ficheros\original_2.txt

        Es el mismo ejercicio que **duplicados.sh** de GNU/Linux, compara las dos soluciones: lo que allí necesitaba un archivo temporal y varios pases, aquí se resuelve encadenando cuatro cmdlets. Consejos:

        * ``Get-FileHash`` calcula un hash del contenido: dos archivos con el mismo contenido tienen el mismo hash, se llamen como se llamen.
        * ``Group-Object -Property Hash`` agrupa los objetos por su hash, y cada grupo tiene ``Count`` (cuántos hay) y ``Group`` (la lista).

    .. tab:: Solución

        .. literalinclude:: 10_powershell/duplicados.ps1
           :language: shell


csv.ps1
"""""""

.. tabs::

    .. tab:: csv.ps1
      
        Crea un script en PowerShell llamado **csv.ps1** que cumpla con las siguientes características:
        
        .. code-block:: powershell
        
            csv.ps1 -usuario [nombre usuario] -grupo [grupo]
          

        El script debe agregar una entrada al archivo usuarios.csv (si no existe, debe crearlo).
        El archivo usuarios.csv tendrá el siguiente formato:

        .. code-block:: powershell

            usuario,grupo,password
            alice,B,12D7087D61
            bob,A,5CD356CE5

        La contraseña debe generarse de forma aleatoria, haz que sea una cadena alfanumérica de 8 caracteres.

        Al ejecutar el script, debe mostrar un mensaje en la terminal indicando que el usuario ha sido creado. El mensaje debe seguir el formato:

        .. code-block:: powershell

            El usuario [usuario] ha sido creado con la password [password] en el grupo [grupo].
  
        En el caso de que el usuario exista, se cambiará la contraseña

    .. tab:: Solución

        .. literalinclude:: 10_powershell/csv.ps1
           :language: shell


notas.ps1
"""""""""

.. tabs::

    .. tab:: notas.ps1

        Crea un script en PowerShell llamado **notas.ps1** que gestione las notas de los alumnos en un archivo ``notas.csv`` mediante los siguientes parámetros:

        .. code-block:: powershell

          $ ./notas.ps1 -help

          -help: muestra la ayuda.
          -generate: genera 10 alumnos con notas aleatorias entre 0 y 10.
          -add <alumno> -nota <nota>: añade un alumno con su nota.
          -delete <alumno>: elimina un alumno.
          -media: muestra la nota media de la clase.
          -aprobados: muestra los alumnos con nota mayor o igual a 5.

        Si el archivo ``notas.csv`` no existe, debe crearlo; si existe, añade los alumnos.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/notas.ps1
           :language: shell

    .. tab:: Solución (sin duplicados)

        En esta versión, ``-generate`` y ``-add`` no vuelven a añadir un alumno si ya existe en el archivo.

        .. literalinclude:: 10_powershell/notas_sin_duplicados.ps1
           :language: shell


procesos.ps1
""""""""""""

.. tabs::

    .. tab:: procesos.ps1

        Crea un script llamado **procesos.ps1** que gestione los procesos del sistema. Si ejecutas el script con ``.\procesos.ps1 -help`` (o sin argumentos), debe mostrar la siguiente ayuda:

        .. code-block:: powershell

           -help                : muestra la ayuda
           -top <N> [-memoria]  : Muestra los N procesos con más CPU (o memoria)
           -buscar <nombre>     : Muestra los procesos cuyo nombre contiene <nombre>
           -matar <nombre>      : Simula matar los procesos (con -deverdad los mata)

        * ``-top`` mostrará nombre, Id, CPU en segundos y memoria en MB, ordenado por CPU, o por memoria si además se da ``-memoria``:

          .. code-block:: powershell

             .\procesos.ps1 -top 3
             Name    Id  CPU_s     MB
             ----    --  -----     --
             chrome  4523  90,4  350,5
             Teams   2284  52,1   86,2
             svchost 1291  45,6  155,7

        * ``-buscar`` mostrará los procesos cuyo nombre contenga el texto (comodines ``*<nombre>*``), o un aviso si no hay ninguno.
        * ``-matar`` es la parte importante: por defecto **solo simula** lo que haría, usando ``Stop-Process -WhatIf``, y avisa de que hay que añadir ``-deverdad`` para matarlos de verdad. Muchos cmdlets peligrosos aceptan ``-WhatIf``: acostúmbrate a usarlo antes de ejecutar nada destructivo.

          .. code-block:: powershell

             .\procesos.ps1 -matar notepad
             What if: Performing the operation "Stop-Process" on target "notepad (5523)".
             Simulación: añade -deverdad para matarlos de verdad

        Consejos:

        * La CPU y la memoria salen mejor con propiedades calculadas: ``@{Name="MB"; Expression={[math]::Round($_.WorkingSet64/1MB, 1)}}``.
        * Compara con ``cpu.sh``/``mem.sh`` de GNU/Linux: allí se recortaba texto con ``grep`` y ``cut``, aquí se ordenan objetos con ``Sort-Object``.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/procesos.ps1
           :language: shell


backup.ps1
""""""""""

.. tabs::

    .. tab:: backup.ps1

        Crea un script llamado **backup.ps1** que gestione copias de seguridad comprimidas. Si ejecutas el script con ``.\backup.ps1 -help``, debe mostrar la siguiente ayuda:

        .. code-block:: powershell

           -help                : muestra la ayuda
           -directorio <dir>    : Crea backups\backup_<dir>_<fecha>.zip
           -lista               : Muestra los backups con su tamaño
           -limpiar <días>      : Borra los backups con más de <días> días
           -restaurar <archivo> : Extrae el backup en el directorio restaurado

        * Si ejecutas el script sin argumentos ``.\backup.ps1``, también debe mostrar la ayuda (consejo: ``$PSBoundParameters.Count -eq 0``).
        * Si ejecutas ``.\backup.ps1 -directorio <dir>`` creará el directorio ``backups`` si no existe y dentro un ``backup_<dir>_<fecha>.zip``, si ``<dir>`` no existe mostrará un error:

          .. code-block:: powershell

             .\backup.ps1 -directorio ficheros
             Creado backups\backup_ficheros_2026-07-07_1030.zip

        * Si ejecutas ``.\backup.ps1 -lista`` mostrará los backups con su tamaño en KB y su fecha (consejo: ``Format-Table`` con una propiedad calculada).
        * Si ejecutas ``.\backup.ps1 -limpiar <días>`` borrará los backups con más de ``<días>`` días mostrando cuáles borra (consejo: compara ``LastWriteTime`` con ``(Get-Date).AddDays(-$dias)``).
        * Si ejecutas ``.\backup.ps1 -restaurar <archivo>`` lo extraerá dentro del directorio ``restaurado``.

        Es el mismo ejercicio que **backup.sh** de GNU/Linux: ``tar`` y ``find -mtime`` se convierten en ``Compress-Archive``/``Expand-Archive`` y en comparar fechas como objetos. Una vez que funcione, prográmalo cada noche con el Programador de tareas.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/backup.ps1
           :language: shell


eventos.ps1
"""""""""""

.. tabs::

    .. tab:: eventos.ps1

        Crea un script llamado **eventos.ps1** que analice los inicios de sesión fallidos del registro de seguridad de Windows (evento 4625), mostrando cuántos ha habido y un listado ordenado por cuenta atacada y dirección IP de origen. Es el mismo análisis que hacían **lastlog.sh** y **lastlog_ip.sh** en GNU/Linux.

        * Recibirá como parámetros las horas hacia atrás a analizar (por defecto 24) y el id del evento (por defecto 4625).
        * Hay que ejecutarlo como **Administrador** (el registro Security no se puede leer sin privilegios).
        * Para generar eventos que analizar, intenta iniciar sesión varias veces con una contraseña incorrecta.

        .. code-block:: powershell

           .\eventos.ps1 -horas 48
           7 eventos 4625 en las últimas 48 horas

           Count Name
           ----- ----
               5 alumno, 10.2.3.100
               2 Administrador, 10.2.104.100

        Consejos:

        * ``Get-WinEvent -FilterHashtable @{ LogName='Security'; Id=4625; StartTime=$desde }`` filtra en el propio visor (mucho más rápido que filtrar después con ``Where-Object``).
        * Los datos del evento van en ``.Properties``: en el 4625 la cuenta es la propiedad 5 y la IP de origen la 19. Construye un objeto con ``[PSCustomObject]@{...}`` y agrupa con ``Group-Object Cuenta, IP``, como en **duplicados.ps1**.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/eventos.ps1
           :language: shell


informe.ps1
"""""""""""

.. tabs::

    .. tab:: informe.ps1

        Crea un script llamado **informe.ps1** que genere un informe en HTML llamado ``informe.html`` con el estado de la máquina:

        * Un título con el nombre del equipo y la fecha de generación.
        * Una tabla con los discos: GB usados, GB libres y porcentaje de ocupación.
        * Una tabla con los 5 procesos que más CPU consumen.
        * Una tabla con los servicios parados.

        La gracia del ejercicio es que **reutiliza los pipelines que ya has escrito** en `disk.ps1`, `procesos.ps1` y `servicios.ps1`: el mismo ``Get-Process | Sort-Object | Select-Object`` que imprimía una tabla por pantalla ahora produce HTML cambiando solo el final de la tubería. Esa es la ventaja de trabajar con objetos: en GNU/Linux este ejercicio habría supuesto reescribirlo todo.

        Consejos:

        * ``ConvertTo-Html -Fragment`` convierte los objetos en una tabla HTML suelta, y ``-PreContent "<h2>...</h2>"`` le pone el título encima.
        * Genera cada tabla por separado, y móntalas al final con ``ConvertTo-Html -Head $css -Body "$titulo $discos $procesos $servicios"``.
        * El CSS se define cómodamente en una cadena multilínea ``@"..."@`` (here-string).

    .. tab:: Solución

        .. literalinclude:: 10_powershell/informe.ps1
           :language: shell


usuarios_G00.ps1
""""""""""""""""

.. tabs::

    .. tab:: usuarios_G00.ps1

        Crea un script llamado **usuarios_G00.ps1**, que cumpla las siguientes condiciones:

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

        .. literalinclude:: 10_powershell/usuarios_G00.ps1
           :language: shell



crear_usuarios_grupos.ps1
"""""""""""""""""""""""""

.. tabs::

    .. tab:: crear_usuarios_grupos.ps1
      
        Crea un script llamado **crear_usuarios_grupos.ps1** que cree los siguientes grupos:

        * GPWS01
        * GPWS02
        * ...
        * GPWS09

        1) En el caso de que el grupo no exista, haz que lo cree y saque por pantalla:
        
           **El grupo $nombre_grupo no existe, se crea**
        
        #) En el caso de que el grupo exista haz que no lo intente y saque por pantalla:
        
           **El grupo $nombre_grupo existe, no se crea**
        
        ayuda : $nombre_grupo='GPWS03' ;  Get-LocalGroup | Select-String -Pattern $nombre_grupo -Quiet

    .. tab:: Solución

        .. literalinclude:: 10_powershell/crear_usuarios_grupos_ini.ps1
           :language: shell



crear_usuarios_grupos.ps1 (usuarios)
""""""""""""""""""""""""""""""""""""

.. tabs::

    .. tab:: crear_usuarios_grupos.ps1
      
        Haz que el anterior script cree los siguientes usuarios dentro de los grupos correspondientes, con la contraseña alumno.         Además haz que estén dentro del grupo Usuarios para que puedan loguearse utilizando el entorno gráfico

        * GPWS01
        
          * tunombre_gpws01_01
          * tunombre_gpws01_02
          * ...
          * tunombre_gpws01_08
          * tunombre_gpws01_09
          
        * GPWS02
        
          * tunombre_gpws02_01
          * tunombre_gpws02_02
          * ...
          * tunombre_gpws02_08
          * tunombre_gpws02_09

        * ...
          
          * ...
          * ...
          
          
        * GPWS09
        
          * tunombre_gpws09_01
          * tunombre_gpws09_02
          * ...
          * tunombre_gpws09_08
          * tunombre_gpws09_09

        1) En el caso de que el usuario no exista, haz que lo cree  y lo incorpore a su grupo, finalmente saque por pantalla:
          
           **El usuario $nombre_usuario con grupo $nombre_grupo no existe, se crea**
        
        
        #) En el caso de que el usuario exista haz que no lo intente y saque por pantalla:
        
           **El usuario $nombre_usuario existe, no se crea**
        
        
        #) En el caso de que el usuario no este en el grupo, haz que lo menta dentro del grupo y saque por pantalla:
        
           **El usuario $nombre_usuario no esta en el grupo $nombre_grupo, se hace miembro**
        
        
        #) En el caso de que el usuario este en el grupo, haz que saque por pantalla:
        
           **El usuario $nombre_usuario ya esta en el grupo $nombre_grupo no se hace nada**


        ayuda: Puedes borrar los usuarios y grupos :
        
        .. code-block:: powershell
        
          foreach ($i in  $(Get-LocalUser |sls -Pattern "tunombre_")){ 
            Remove-LocalUser -Name $i
            }

          foreach ($i in  $(Get-LocalGroup |sls -Pattern  "GPWS")){      
            Remove-LocalGroup -Name $i
            }

    .. tab:: Solución

        .. literalinclude:: 10_powershell/crear_usuarios_grupos.ps1
           :language: shell




crear_usuarios_grupos_csv.ps1
"""""""""""""""""""""""""""""

.. tabs::

    .. tab:: crear_usuarios_grupos_csv.ps1
      
        Haz un script  llamado **crear_usuarios_grupos_csv.ps1**, que cree los usuarios que encontraras en  el archivo `users.csv <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/master/source/so/windows/10_powershell/users.csv>`_, tiene que cumplir las siguientes condiciones:
        
        #) En el caso de que el grupo no exista, haz que lo cree y saque por pantalla:
        
           **El grupo $nombre_grupo no existe, se crea**
          
        #) En el caso de que el grupo exista haz que no lo intente y saque por pantalla:

           **El grupo $nombre_grupo existe, no se crea**
          
        #) En el caso de que el usuario exista haz que no lo intente y saque por pantalla:

           **El usuario $nombre_usuario existe, no se crea**
           
        #) En el caso de que el usuario no este en el grupo, haz que lo meta dentro del grupo y saque por pantalla:

           **El usuario $nombre_usuario no esta en el grupo $nombre_grupo, se hace miembro**
          
        #) En el caso de que el usuario este en el grupo, haz que saque por pantalla:

           **El usuario $nombre_usuario ya esta en el grupo $nombre_grupo no se hace nada**
          
        #) En el caso de que el usuario no exista, haz que lo cree y lo incorpore a su grupo, finalmente haz que saque por pantalla:

           **El usuario $nombre_usuario con grupo $nombre_grupo no existe, se crea**
          
        #) Además se añada a un archivo el mensaje:

           **El usuario $nombre_usuario con $passwrd en el grupo $nombre_grupo se ha creado >> lista_usuarios_creados.dat**
          
        #) En el caso de que el usuario este en el grupo, haz que saque por pantalla:

           **El usuario $nombre_usuario ya esta en el grupo $nombre_grupo no se hace nada**

    .. tab:: Solución

        .. literalinclude:: 10_powershell/crear_usuarios_grupos_csv.ps1
           :language: shell



usuarios.ps1
""""""""""""

.. tabs::

    .. tab:: usuarios.ps1
      
         Haz un script llamado **usuarios.ps1**, que implementa un menú para gestionar usuarios en el sistema. El script permite listar usuarios, crear y eliminar usuarios, y modificar el nombre de un usuario existente.
         
         Menú de Usuarios:
          
         1) Listar usuarios
         #) Crear usuario
         #) Eliminar usuario
         #) Modificar usuario
         #) Salir

    .. tab:: Solución

        .. literalinclude:: 10_powershell/usuarios.ps1
           :language: shell


grupos.ps1
""""""""""

.. tabs::

    .. tab:: grupos.ps1
      
         Haz el script **grupos.ps1**, que implementa un menú para gestionar grupos y sus miembros en PowerShell. El script permite listar grupos, ver miembros, crear y eliminar grupos, así como agregar y eliminar miembros de los grupos.
          
         Menú de Grupos:
          
         1) Listar grupos
         #) Ver miembros de un grupo
         #) Crear grupo (pide nombre grupo)
         #) Elimina grupo (pide nombre grupo)
         #) Crea miembro de un grupo (pide grupo y usuario)
         #) Elimina miembro de un grupo (pide grupo y usuario)
         #) Salir

    .. tab:: Solución

        .. literalinclude:: 10_powershell/grupo.ps1
           :language: shell


local_users.ps1
"""""""""""""""

.. tabs::

    .. tab:: local_users.ps1
      
         Crea un script llamado **local_users.ps1**, que cumpla las siguientes condiciones
                
         1) Si ejecutamos la ayuda:

            .. image:: imagenes/local_users_01.png

         #) Si creamos un nuevo grupo, y listamos los grupos vemos que aparece. 
            
            Si volvemos a intentar crearlo vemos que no nos deja, recoge el error y sácalo por pantalla como se muestra a continuación.

            .. image:: imagenes/local_users_02.png

            Finalmente crea el grupo grupo_tuapellido  

            En el caso de intentar borrar un grupo que no existe haz que saque el mensaje por pantalla:

            .. image:: imagenes/local_users_03.png

         #) Si creamos un nuevo usuario llamado **tunombre**, se creara con la contraseña ``@lumn0``

            Después crea un usuario llamado **tunombre1** con una contraseña que no cumpla con las políticas de seguridad y haz que saque el error que muestra en el pantallazo sin crear el usuario.

            Vuelve a crear el usuario **tunombre1** con una contraseña que cumpla con las políticas de seguridad

            Crear el usuario **tunombre2** con una contraseña que cumpla con las políticas de seguridad en el grupo que no existe **G2**, en este caso el script deberá crear el grupo de forma automática.

            Crear el usuario **tunombre3** con una contraseña que cumpla con las políticas de seguridad en el grupo que ahora si existe **G2**.

            Por ultimo lista los miembros del grupo **G2**

            .. image:: imagenes/local_users_04.png

         #) Mete al usuario **tunombre3** en grupo **G3** que no existe sin poner **-usuario** ni **-grupo**, haz que salga el mensaje de error.

            Mete al usuario **tunombre3** en grupo **G3** que no existe sin poner  **-grupo**, haz que salga el mensaje de error.

            Mete al usuario **tunombre3** en grupo **G3**  haz que salga el mensaje de error.

            Crea el grupo **G3** y mete finalmente al usuario **tunombre3** en grupo **G3**.

            Lista los usuarios del grupo **G3**

            Elimina el usuario **tunombre3** del grupo **G3** (haz que se recojan los mismo errores cuando eliminamos usuarios de un grupo que cuando los metemos)

            Lista los usuarios del grupo **G3** y **G2**

            .. image:: imagenes/local_users_05.png

         #) Por ultimo ejecuta el script `test_local_users.ps1 <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/windows/10_powershell/test_local_users.ps1>`_. para probar el script

            .. image:: imagenes/local_users_06.png

    .. tab:: Solución

        .. literalinclude:: 10_powershell/local_users.ps1
           :language: shell






AD.ps1
""""""

.. tabs::

    .. tab:: AD.ps1
      
         Crea un script llamado **AD.ps1**, que cumpla las siguientes condiciones
                
         1) Instala el Active directory utiliza como nombre de dominio : **tunombre.local**

            Haz que toda la decencia con el nombre del dominio dentro del script se haga con las siguientes variables: ``$dirAD="DC=tunombre,DC=local"``, ``$mail="@tunombre.local"``

         #) Si ejecutamos:

            .. image:: imagenes/AD_01.png
            
         #) Si ejecutamos:

            .. image:: imagenes/AD_02.png

         #) Haz que cree, borre y liste las unidades organizativas, si intenta crearlas y ya existe haz que salga un error por pantalla, en el caso de que intente eliminarlas y no existan haz que salga otro error por pantalla.

            .. image:: imagenes/AD_03.png

         #) Haz que cree, borre y liste los grupos del AD, si intenta crearlos y ya existe haz que salga un error por pantalla, en el caso de que intente eliminarlas y no existan haz que salga otro error por pantalla.

            .. image:: imagenes/AD_04.png

            .. image:: imagenes/AD_05.png

         #) Haz que cree, borre y liste los usuarios del AD, si intenta crearlos y ya existe haz que salga un error por pantalla, en el caso de que intente eliminarlas y no existan haz que salga otro error por pantalla, al igual que antes si intenta crear usuarios con una contraseña insegura que de te un error, si intenta crearlo en un grupo que no existe que cree el grupo antes:

            .. image:: imagenes/AD_06.png

         #) Por ultimo ejecuta el script `test_AD.ps1 <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/windows/10_powershell/AD.ps1>`_ para probar el script

            .. image:: imagenes/AD_07.png

    .. tab:: Solución

        .. literalinclude:: 10_powershell/AD.ps1
           :language: shell


Administración remota
=====================

remoto.ps1
""""""""""

.. tabs::

    .. tab:: remoto.ps1

        La administración remota es la razón de ser de PowerShell (de hecho su tecnología se llama *PowerShell Remoting*): ejecutar comandos en muchas máquinas a la vez sin tocar sus teclados. Es el equivalente Windows de lo que hicimos en GNU/Linux con **rsync_usuarios.sh** sobre ssh.

        **Este ejercicio necesita un laboratorio de máquinas virtuales**, no se puede hacer en un único equipo:

        * Tres clones enlazados de la "MV Windows Server": ``compute-0-0`` (desde donde administramos) y los clientes ``compute-0-1`` y ``compute-0-2``, en la misma red y que se resuelvan por nombre (o añade sus IPs a ``C:\Windows\System32\drivers\etc\hosts``).
        * En **cada cliente**, habilita WinRM ejecutando como Administrador:

          .. code-block:: powershell

             Enable-PSRemoting -Force

        * Como las máquinas no están en un dominio, en **compute-0-0** hay que declarar los clientes como confiables:

          .. code-block:: powershell

             Set-Item WSMan:\localhost\Client\TrustedHosts -Value "compute-0-1,compute-0-2"

          (si el laboratorio ya está dentro del AD de los ejercicios anteriores, este paso no hace falta: la confianza la da el dominio)

        * Comprueba la conexión con ``Test-WSMan compute-0-1``.

        Con el laboratorio funcionando, crea un script llamado **remoto.ps1** que reciba la lista de equipos como parámetro (por defecto los dos clientes) y:

        * Con ``-info`` muestre de cada equipo su nombre, los GB libres en C: y el número de procesos.
        * Con ``-comando "<comando>"`` ejecute ese comando en todos los equipos, mostrando de cuál es cada salida:

          .. code-block:: powershell

             .\remoto.ps1 -info
             === compute-0-1 ===
             COMPUTE-0-1 : 12,3 GB libres en C:, 87 procesos
             === compute-0-2 ===
             COMPUTE-0-2 : 11,8 GB libres en C:, 92 procesos

             .\remoto.ps1 -comando "Get-LocalUser | Select-Object Name"

        Consejos:

        * ``Get-Credential`` pide las credenciales una sola vez y se reutilizan para todos los equipos.
        * ``Invoke-Command -ComputerName <equipo> -Credential $credencial -ScriptBlock { ... }`` ejecuta el bloque en la máquina remota: todo lo que hay dentro de las llaves corre allí, no en tu equipo.
        * Para convertir el texto de ``-comando`` en código ejecutable: ``[scriptblock]::Create($comando)``.
        * Cuando funcione, piensa en las posibilidades: el script **crear_usuarios_grupos_csv.ps1** ejecutado en 20 equipos a la vez es un ``foreach`` de distancia.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/remoto.ps1
           :language: shell


