**************
Scripting .bat
**************

Un archivo o programa de procesamiento por lotes es un archivo de texto sin formato que contiene uno o más comandos de MS-DOS y que tiene asignado una extensión BAT.

Cuando se escribe el nombre del programa de procesamiento por lotes en la línea de comandos, los comandos se ejecutan como un grupo.

* **pause**: suspende la ejecución de un programa de procesamiento por lotes y muestra un mensaje indicando al usuario que presione cualquier tecla para continuar.

* **rem** permite que se incluyan comentarios

* **echo [texto]** muestra el texto por pantalla @(on/off) para presentar los comandos por pantalla en un script
  
  Ejemplo:

  .. code-block:: shell
  
   C:\>type hola.bat
   @echo off
   rem Esto es un comentario
   rem @echo on se presentaran los comandos por pantalla
   echo Hola Mundo
   pause
   C:\>hola.bat
   Hola Mundo
   Presione una tecla para continuar . . .

* **for** (repite un comando)

  FOR %%variable IN (conjunto) DO comando [parametros_del_comando]

  Ejemplo:  
  
  .. code-block:: shell
  
   C:>type for.bat 
   @echo off 
   echo -------------------------------
   echo cuenta hasta 10 de 2 en 2
   for /L %%j in (1,2,10) do echo hola %%j
   
   C:\>for.bat      
   ------------------------------- 
   cuena hasta 10 de 2 en 2
   hola 1
   hola 3
   hola 5
   hola 7
   hola 9
   
  Ejemplo con el parámetro /R ejecuta el comando recursivamente:
  
  .. code-block:: shell
  
   for /R %x in (*) do @echo %x
   
  Visualizamos todas las dll que empiecen por a de C:\Windows\System32 
    
  .. code-block:: shell
  
   for /R C:\Windows\System32 %x in (A*.dll) do @echo %xde C:\WINNT

* **Parámetros de entrada**, los valores suministrados al ejecutar el archivo .bat se les llaman argumentos y se denotan %0, %1, ..., %9.

* **shift** cambia los valores de los parámetros reemplazables %0 a %9 copiando cada parámetro en el anterior, es decir, el valor de %1 es copiado en %0, el valor de %2 es copiado en %1 y así sucesivamente.

* **if** (condicional)

  .. code-block:: shell
     
   C:\>type if.bat
   @echo off 
   set a=%1
   set b=%2
   echo a = %a% ; b = %b%
   if %a% equ %b% echo %b% y %b% son iguales
   if %a% neq %b% echo %b% y %b% son distintos
   if %a% leq %b% echo %b% es menor o igual que %b%
   if %a% geq %b% echo %b% es mayor o igual que %b%
   if %a% lss %b% echo %b% es menor que %b%
   if %a% gtr %b% echo %b% es mayor que %b%
   echo -------------------------------------

   C:\> if.bat 3 3 
   a = 3 ; b = 3 
   3 y 3 son iguales
   3 es menor o igual que 3 
   3 es mayor o igual que 3
   -------------------------------------

   C:\> if.bat 3 5 
   a = 3 ; b = 5 
   5 y 5 son distintos
   5 es menor o igual que 5
   5 es menor que 5
   -------------------------------------

   C:\> if.bat 3 1 
   a = 3 ; b = 1 
   1 y 1 son distintos
   1 es mayor o igual que 1
   1 es mayor que 1
   -------------------------------------
      
* **goto** se va a una línea marcada por una etiqueta especificada por el usuario dentro de un programa de procesamiento por lotes.