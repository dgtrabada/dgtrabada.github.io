**************
Scripting .bat
**************

Un archivo o programa de procesamiento por lotes es un archivo de texto sin formato que contiene uno o más comandos de MS-DOS y que tiene asignada la extensión **.bat**.

Cuando se escribe el nombre del programa de procesamiento por lotes en la línea de comandos (cmd), los comandos se ejecutan como un grupo. Es el lenguaje de scripting clásico de MS-DOS y Windows, anterior a PowerShell.

* **pause**: suspende la ejecución de un programa de procesamiento por lotes y muestra un mensaje indicando al usuario que presione cualquier tecla para continuar.

* **rem** permite que se incluyan comentarios

* **echo [texto]** muestra el texto por pantalla. Con **echo on/off** se activa o desactiva que cada comando se muestre por pantalla al ejecutarse, y la ``@`` delante de un comando evita que se muestre ese comando concreto: por eso los scripts suelen empezar con ``@echo off`` (desactiva la presentación de comandos sin mostrarse ni siquiera él mismo).

  Ejemplo:

  .. code-block:: bat

   C:\>type hola.bat
   @echo off
   rem Esto es un comentario
   rem con @echo on se presentarian los comandos por pantalla
   echo Hola Mundo
   pause
   C:\>hola.bat
   Hola Mundo
   Presione una tecla para continuar . . .

* **for** (repite un comando)

  .. code-block:: bat

   FOR %%variable IN (conjunto) DO comando [parametros_del_comando]

  Ojo: dentro de un archivo .bat la variable se escribe con dos porcentajes (``%%j``), pero al usar for directamente en la línea de comandos se escribe con uno solo (``%j``).

  Ejemplo con ``/L``, que genera una lista de números (inicio, paso, fin):

  .. code-block:: bat

   C:\>type for.bat
   @echo off
   echo -------------------------------
   echo cuenta hasta 10 de 2 en 2
   for /L %%j in (1,2,10) do echo hola %%j

   C:\>for.bat
   -------------------------------
   cuenta hasta 10 de 2 en 2
   hola 1
   hola 3
   hola 5
   hola 7
   hola 9

  Con el parámetro ``/R`` el comando se ejecuta recursivamente, recorriendo el directorio y todos sus subdirectorios (aquí en la línea de comandos, por eso la variable lleva un solo ``%``):

  .. code-block:: bat

   for /R %x in (*) do @echo %x

  Visualizamos todas las dll que empiecen por A de C:\\Windows\\System32:

  .. code-block:: bat

   for /R C:\Windows\System32 %x in (A*.dll) do @echo %x

* **Parámetros de entrada**: a los valores suministrados al ejecutar el archivo .bat se les llama argumentos y se denotan %0, %1, ..., %9 (%0 es el propio nombre del script).

* **shift** cambia los valores de los parámetros reemplazables %0 a %9 copiando cada parámetro en el anterior, es decir, el valor de %1 es copiado en %0, el valor de %2 es copiado en %1 y así sucesivamente. Sirve para procesar más de 9 argumentos o para recorrerlos uno a uno.

  .. code-block:: bat

   C:\>type args.bat
   @echo off
   echo el script se llama %0
   echo el primer argumento es %1 y el segundo %2
   shift
   echo tras shift, el primer argumento es %1

   C:\>args.bat uno dos tres
   el script se llama args.bat
   el primer argumento es uno y el segundo dos
   tras shift, el primer argumento es dos

* **if** (condicional)

  .. code-block:: bat

   C:\>type if.bat
   @echo off
   set a=%1
   set b=%2
   echo a = %a% ; b = %b%
   if %a% equ %b% echo %a% y %b% son iguales
   if %a% neq %b% echo %a% y %b% son distintos
   if %a% leq %b% echo %a% es menor o igual que %b%
   if %a% geq %b% echo %a% es mayor o igual que %b%
   if %a% lss %b% echo %a% es menor que %b%
   if %a% gtr %b% echo %a% es mayor que %b%
   echo -------------------------------------

   C:\> if.bat 3 3
   a = 3 ; b = 3
   3 y 3 son iguales
   3 es menor o igual que 3
   3 es mayor o igual que 3
   -------------------------------------

   C:\> if.bat 3 5
   a = 3 ; b = 5
   3 y 5 son distintos
   3 es menor o igual que 5
   3 es menor que 5
   -------------------------------------

   C:\> if.bat 3 1
   a = 3 ; b = 1
   3 y 1 son distintos
   3 es mayor o igual que 1
   3 es mayor que 1
   -------------------------------------

* **goto** salta a una línea marcada por una etiqueta (una línea que empieza por ``:``) dentro del programa de procesamiento por lotes. Combinado con if permite construir bucles:

  .. code-block:: bat

   C:\>type goto.bat
   @echo off
   set /a contador=0
   :inicio
   set /a contador+=1
   echo vuelta %contador%
   if %contador% lss 3 goto inicio
   echo fin

   C:\>goto.bat
   vuelta 1
   vuelta 2
   vuelta 3
   fin