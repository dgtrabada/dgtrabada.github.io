***
BAT
***

Un archivo o programa de procesamiento por lotes es un archivo de texto sin formato que contiene uno o más comandos de MS-DOS y que tiene asignado una extensión BAT. Cuando se escribe el nombre del programa de procesamiento por lotes en la línea de comandos, los comandos se ejecutan como un grupo.

Los siguientes comandos de MS-DOS están diseñados especialmente para programas de procesamiento por lotes:

* **PAUSE** (Pausa): Suspende la ejecución de un programa de procesamiento por lotes y muestra un mensaje indicando al usuario que presione cualquier tecla para continuar.
  Mientras el programa esté detenido a causa de un comando PAUSE, se puede presionar CTRL+C y luego S para suspender la ejecución del programa de procesamiento por lotes.

* **REM** (Comentario): Permite que se incluyan comentarios

* **ECHO [texto]**

  * [ON|OFF]: Especifica si será activada (ON) o desactivada (OFF) la característica de presentar los comandos en la pantalla. Si se desea ver el estado actual del comando ECHO, se debe utilizar dicho comando sin parámetros.
  * [texto]: Especifica el texto que se desea presentar por pantalla. Para impedir que MS-DOS presente una línea determinada en la pantalla debemos colocar ‘@’ delante de ECHO. Si deseamos presentar una línea en blanco en la pantalla debemos escribir ECHO seguido de un punto (ECHO.).
  
    Ejemplo:

    .. code-block:: msdos

     C:\DATOS\compartida2\bat>type hola.bat
     @echo off
     echo Hola Mundo
     pause
     C:\DATOS\compartida2\bat>hola.bat
     Hola Mundo
     Presione una tecla para continuar . . .

* **FOR** (Repite un comando): FOR %%variable IN (conjunto) DO comando [parametros_del_comando]

  * :etiqueta Nombre de una etiqueta.
  *  %número Parámetro del fichero por lotes.
  *  %variable% Variable del entorno.
  *  %%variable Variable de la orden For.
  *  Ejemplo:  
  
     .. code-block:: msdos
     
      C:\DATOS\compartida2\bat>type for.bat
      @echo off
      echo -------------------------------
      echo cuenta hasta 5
      for /L %%j in (1,1,5) do echo hola %%j
      C:\DATOS\compartida2\bat>for.bat
      -------------------------------
      cuenta hasta 5
      hola 1
      hola 2
      hola 3
      hola 4
      hola 5
     
* **IF** (Si condicional): Ejecuta un procesamiento condicional en programas de procesamiento por lotes. Si la condición especificada por un comando IF es verdadera, MS-DOS ejecutará el comando que siga a la condición. Si ésta es falsa, MS-DOS hará caso omiso del comando.

  * IF [NOT] ERRORLEVEL número comando
  * IF [NOT] cadena1==cadena2 comando
  * IF [NOT] EXIST nombre_archivo comando
  * EXIST nombre_archivo:
  * Ejemplo:
  
    .. code-block:: msdos
     
      C:\DATOS\compartida2\bat>type if.bat
      @echo off
      
      set a=3
      set b=3
      echo a = %a% ; b = %b%
      if %a% equ %b% echo %b% y %b% son iguales
      if %a% neq %b% echo %b% y %b% son distintos
      if %a% leq %b% echo %b% es menor o igual que %b%
      if %a% geq %b% echo %b% es mayor o igual que %b%
      if %a% lss %b% echo %b% es menor que %b%
      if %a% gtr %b% echo %b% es mayor que %b%

      set a=3
      set b=5
      echo a = %a% ; b = %b%
      if %a% equ %b% echo %b% y %b% son iguales
      if %a% neq %b% echo %b% y %b% son distintos
      if %a% leq %b% echo %b% es menor o igual que %b%
      if %a% geq %b% echo %b% es mayor o igual que %b%
      if %a% lss %b% echo %b% es menor que %b%
      if %a% gtr %b% echo %b% es mayor que %b%
      
      set a=5
      set b=3
      echo a = %a% ; b = %b%
      if %a% equ %b% echo %b% y %b% son iguales
      if %a% neq %b% echo %b% y %b% son distintos
      if %a% leq %b% echo %b% es menor o igual que %b%
      if %a% geq %b% echo %b% es mayor o igual que %b%
      if %a% lss %b% echo %b% es menor que %b%
      if %a% gtr %b% echo %b% es mayor que %b%
      echo FIN DE PROGRAMA
      C:\DATOS\compartida2\bat>if.bat
      a = 3 ; b = 3
      3 y 3 son iguales
      3 es menor o igual que 3
      3 es mayor o igual que 3
      a = 3 ; b = 5
      5 y 5 son distintos
      5 es menor o igual que 5
      5 es menor que 5
      a = 5 ; b = 3
      3 y 3 son distintos
      3 es mayor o igual que 3
      3 es mayor que 3
      FIN DE PROGRAMA
      
* **GOTO** (Ir a): Dirige a MS-DOS hacia una línea marcada por una etiqueta especificada por el usuario dentro de un programa de procesamiento por lotes.

* **SHIFT** (Cambiar): Cambia la posición de parámetros reemplazables en un programa de procesamiento por lotes,El comando SHIFT cambia los valores de los parámetros reemplazables %0 a %9 copiando cada parámetro en el anterior, es decir, el valor de %1 es copiado en %0, el valor de %2 es copiado en %1 y así sucesivamente.

* **Parámetros**, en la ejecución de una macro puede interesarnos pasarle una serie de parámetros que luego querremos usar dentro de la macro, es decir, parámetros que puedan ser sustituidos por los valores suministrados al ejecutar el archivo .bat. A estos parámetros se les llaman argumentos y se denotan %0, %1, ..., %9.

  Ejemplo:
  
  .. code-block:: msdos

    C:\DATOS\compartida2\bat>type argumentos.bat
    @ECHO OFF
    IF %1 == '' GOTO noarg
    echo argumento 1 = %1
    echo argumento 2 = %2
    echo argumento 3 = %3
    rem vemos como afecta shift
    echo argumento 1 = %1
    shift
    echo argumento 2 = %2
    echo argumento 3 = %3
    GOTO fin
    : noarg
    ECHO No hay argumentos
    :fin

    C:\DATOS\compartida2\bat>argumentos.bat a1 a2 a3 a4 a5 a6
    argumento 1 = a1
    argumento 2 = a2
    argumento 3 = a3
    argumento 1 = a1
    argumento 2 = a3
    argumento 3 = a4
    Entrada por teclado
    Ejemplo:

    C:\DATOS\compartida2\soluciones scripts>type entrada.bat
    @echo off

    rem @
    rem @ entrada.bat
    rem @ introducir un numero por pantalla
    rem @ set /p

    set /p n="introduce un numero "
    echo El numero introducido es %n%


    C:\DATOS\compartida2\soluciones scripts>entrada.bat
    introduce un numero 2
    El numero introducido es 2

