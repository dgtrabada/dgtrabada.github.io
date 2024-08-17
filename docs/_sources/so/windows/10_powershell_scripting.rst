********************
PowerShell Scripting
********************

Habilitar ejecución de scripts 
==============================

.. code-block:: powershell
 
 Set-ExecutionPolicy Unrestricted

Tipos
=====

Los tipos de variables más comunes que puedes encontrar y utilizar en PowerShell son:

* Números enteros **(Integers)**. Un entero es un número sin parte decimal

  .. code-block:: powershell

    PS C:\> $number = 42
    PS C:\Users\Administrador> echo $number.GetType()   
    
    IsPublic IsSerial Name
    -------- -------- ----
    True     True     Int32


* Números de coma flotante **(Floating-Point)**. Los números de coma flotante son números que incluyen una parte decimal

  .. code-block:: powershell

    PS C:\> $number = 3.14
    PS C:\> echo $number.GetType().Name
    Double
    
* Cadenas de texto **(Strings)**. Una cadena es una secuencia de caracteres utilizada para representar texto.
 
  .. code-block:: powershell

    PS C:\>$cadena = "Hola, Mundo!"
    PS C:\> echo $cadena.GetType().Name   
    String
 
* Booleanos (**Booleans**). Un valor booleano puede ser True o False.

  .. code-block:: powershell

    PS C:\>$B=$true
    PS C:\> echo $B.GetType().Name 
    Boolean

* Arreglos **(Arrays)**. Un arreglo es una colección de elementos, que pueden ser de cualquier tipo de dato. Los elementos están indexados comenzando desde cero.

  .. code-block:: powershell

    PS C:\> $numbers = @(1, 2, 3, 4, 5) 
    PS C:\> echo $numbers.GetType().Name
    Object[]
    PS C:\> echo $numbers[0]
    1   
    PS C:\> echo $numbers[0].GetType().Name
    Int32


* Hash Tables **(Tablas hash)**. Una tabla hash es una colección de pares clave-valor. Las claves deben ser únicas dentro de la tabla.

  .. code-block:: powershell

    PS C:\> $person = @{
     Name = "Tutankamón"
     Age = 3358
     City = "Egipto"
    }  
   
    PS C:\> echo $person.Name
    Tutankamón
  
    #Agregar una nueva clave
    PS C:\> $person.Estado = "momificado"
    PS C:\>  $person

    Name                           Value
    ----                           -----
    Estado                         momificado
    Name                           Tutankamón
    Age                            3358
    City                           Egipto

    #eliminar la clave
    PS C:\> $person.Remove("Age")
    PS C:\> $person              

    Name                           Value
    ----                           -----
    Estado                         momificado
    Name                           Tutankamón
    City                           Egipto
  
  
* **ScriptBlocks**. Un ScriptBlock es un bloque de código que se puede ejecutar más tarde o pasar como un parámetro.

  .. code-block:: powershell

    PS C:\>  $script = { param($name) "Hola, $name!" }
    PS C:\> & $script "Tutankamón"
    Hola, Tutankamón!


Asignación y Tipado
===================

* **Asignación Implícita**: En PowerShell, no es necesario declarar explícitamente el tipo de una variable; PowerShell infiere el tipo automáticamente al asignar un valor.

* **Asignación Explícita**: Si necesitas definir explícitamente el tipo de una variable, puedes hacerlo usando la notación [tipo].

.. code-block:: powershell

 PS C:\> [int]$edad = 25
 
 

.. code-block:: powershell

 PS C:\> $a=5  
 PS C:\> echo a 
 a        
 PS C:\> echo $a 
 5 
 
.. code-block:: powershell 

 PS C:\> $a=2 
 PS C:\> $b=3
 PS C:\> $c=$b+$a 
 PS C:\> echo $c
 5
 
.. code-block:: powershell

 PS C:\> $a="cadena"
 PS C:\> echo $a
 cadena
 PS C:\> echo $a.Replace("ca","CC")
 CCdena
 PS C:\> echo $a.split("a")
 c
 den
 
 PS C:\> echo $a.Split("a")[0]
 c
 PS C:\> echo $a
 cadena
 PS C:\> echo $a.Substring(2,4)
 dena
 PS C:\> echo $a.Remove(2,4)
 ca
 PS C:\> echo $a.Contains("a")
 True
 PS C:\> echo $a.IndexOf("a")
 1
 PS C:\> echo $a.Replace("ca","Ca")
 Cadena
 PS C:\> echo $a.Equals("cadena")
 True
 PS C:\> echo $a.Length
 6
 PS C:\> echo $a.Contains("an")
 False
 PS C:\> echo $a.ToLower() 
 cadena
 PS C:\> echo $a.ToUpper()
 CADENA

* **Números aleatorios**

  .. code-block:: powershell

   Get-Random # numero aletorio
   Get-Random -Minimum 1 -Maximum 10

* **Conversiones**

  .. code-block:: powershell

   #si queremos pasar la cadena $Name a un entero:
   $a = $Name -as [int]
   # otra forma:
   $a = [int] $Name
 
   #pasar a binario
   [Convert]::ToString($decimal, 2) 
   
   $a="$pwd" #obtenemos la salida del comando pwd, no es lo mismo que $a=$(pwd)
   
   #Podemos ejecutar un texto como si fuese un comando &
   $a="notepad"
   &$a 

Operadores
==========

.. code-block:: powershell

 PS C:\> $a=11
 PS C:\> $b=5
 PS C:\> $c=$a-$b     # resta
 PS C:\> echo $c 
 6
 PS C:\> $c=$a+$b     # suma
 PS C:\> echo $c 
 16
 PS C:\> $c=$a*$b     # multiplicación
 PS C:\> echo $c
 55
 PS C:\> $c=$a/$b     # división
 PS C:\> echo $c 
 2,2
 PS C:\> $c=$a%$b     # resto o modulo
 PS C:\> echo $c
 1

Operadores de asignación
========================

.. code-block:: powershell

 PS C:\> $a=6
 PS C:\> $a+=2 ; echo $a   # $a=$a+2
 8
 PS C:\> $a-=2 ; echo $a   # $a=$a-2
 6
 PS C:\> $a++  ; echo $a   # $a=$a+1
 7
 PS C:\> $a--  ; echo $a   # $a=$a-1
 6
 PS C:\> $a/=2 ; echo $a   # $a=$a/2
 3
 PS C:\> $a*=3 ; echo $a   # $a=$a*3
 9
 PS C:\> $a%=3 ; echo $a   # $a=$a%3
 0


Argumentos de entrada
=====================

Argumentos de entrada Read-Host 
-------------------------------

.. code-block:: powershell

 PS C:\> cat read_host.ps1   
 echo "Dame un entero"
 $Name=Read-Host
 echo "Sin pasar a int ($Name*$Name) = "
 echo $($Name*$Name)
 echo ""
 $a = [int] $Name
 echo "Pasando a int ($Name*$Name) = "
 echo $($a*$a)
 echo ""
 
 PS C:\> .\read_host.ps1
 Dame un entero 
 2 
 Sin pasar a int (2*2) =  
 22
 
 Pasando a int (2*2) =
 4


Argumentos de entrada Read-Host argst.ps1
-----------------------------------------

.. code-block:: powershell

 PS C:\> cat .\argst.ps1
 echo "tenemos $args parámetros de entrada"
 echo "El argumento 0: $($args[0])"
 echo "El argumento 1: $($args[1])"
 
 PS C:\> .\argst.ps1 1 2 3
 tenemos 1 2 3 parámetros de entrada
 El argumento 0: 1
 El argumento 1: 2

.. code-block:: powershell

 PS C:\> cat .\argst.ps1
 foreach ($i in $args)
 {
 echo $i
 }
 
 PS C:\> .\argst.ps1
 1 dos tres 1 dos tres
  
  
Argumentos de entrada Read-Host param.ps1
-----------------------------------------  

.. code-block:: powershell
  
  PS C:\> cat .\param.ps1
  param (
      [string]$Nombre,
      [int]$Nacimiento
  )
  
  # Calcular la edad
  $Edad = (Get-Date).Year - $Nacimiento
  
  Write-Output "Hola $Nombre, Tienes $Edad"
  
  PS C:\> .\param.ps1 -Nombre Tutankamón -Nacimiento -1334
  Hola Tutankamón, Tienes 3358
  
  PS C:\> .\param.ps1 -Nombre Tutankamón                  
  Hola Tutankamón, Tienes 2024
  
  PS C:\> .\param.ps1                    
  Hola , Tienes 2024

En el caso de que queramos darle un valor por defecto cambiamos:

.. code-block:: powershell
  
  param (
      [string]$Nombre = "Tutankamón",
      [int]$Nacimiento = "-1334"
  )

y cuando lo ejecutamos obtenemos:

.. code-block:: powershell
  
  PS C:\> .\param_def.ps1 -Name Nefertiti -Nacimiento -1370     
  Hola Tutankamón, Tienes 3394
  
  PS C:\Users\Administrador\powershell> .\param_def.ps1 -Name Nefertiti 
  Hola Tutankamón, Tienes 3358

  PS C:\> .\param_def.ps1  
  Hola Tutankamón, Tienes 3358


Podemos completar la declaracion de un parámetro en un script de PowerShell utilizando **[Parameter()]**, el argumento **Mandatory=$true** dentro de la directiva parameter indica que el parámetro es obligatorio. Si el usuario no proporciona un valor para este parámetro al ejecutar el script, PowerShell solicitará que se ingrese uno. Si se omite, PowerShell genera un error pidiendo al usuario que proporcione el valor. **HelpMessage** especifica un mensaje de ayuda que se mostrará al usuario si el parámetro obligatorio no se proporciona.


.. code-block:: powershell
 :emphasize-lines: 3, 6
 
  PS C:\> cat .\param.ps1
  param (
      [Parameter(Mandatory=$true, HelpMessage="Cómo te llamas?")]
      [string]$Nombre,
  
      [Parameter(Mandatory=$true, HelpMessage="¿En qué año naciste?")]
      [int]$Nacimiento
  )

  # Calcular la edad
  $Edad = (Get-Date).Year - $Nacimiento

  Write-Output "Hola $Nombre, Tienes $Edad"

  PS C:\> .\param.ps1 -Nombre Tutankamón -Nacimiento -1334
  Hola Tutankamón, Tienes 3358
  
  PS C:\> .\param.ps1 -Nombre Tutankamón                  
  cmdlet param.ps1 en la posición 1 de la canalización de comandos
  Proporcione valores para los parámetros siguientes:
  (Escriba !? para obtener Ayuda).
  Nacimiento: -1334
  Hola Tutankamón, Tienes 3358
  PS C:\> .\param.ps1                    

  cmdlet param.ps1 en la posición 1 de la canalización de comandos
  Proporcione valores para los parámetros siguientes:
  (Escriba !? para obtener Ayuda).
  Nombre: !?
  Cómo te llamas?
  Nombre: Tutankamón
  Nacimiento: -1334
  Hola Tutankamón, Tienes 3358
 
 
Evaluación de condiciones   
=========================

.. code-block:: powershell

 7 -eq 7 #True
 7 -eq 8 #False
 3 -gt 2 #True

Operadores lógicos
==================

.. code-block:: powershell

 (5 -gt 1) -And (5 -lt 10)  #True
 (5 -gt 1) -And (5 -lt 10)  #True
 (5 -gt 1) -Or (5 -lt 1)    #True
 (5 -gt 1) -Xor (5 -lt 1)   #True
 -Not (5 -lt 1)             #True
 
Comparación de cadenas
======================

.. code-block:: powershell
 
 "hola" -eq "hola"    #True
 "hola" -eq "hoa"     #False
 "hola" -ne "hoa"     #True
 "hola" -ne "hola"    #False

Estructuras condicionales con if
================================

.. code-block:: powershell

 $numero = -10
 If ($numero -gt 0) {
   echo "$numero es mayor que 0"
   }
 If ($numero -gt 0) {
   echo "$numero es mayor que 0"
   }else{
   echo "$numero es negativo"
   }
   
  #-10 es negativo 
   
Bucles con for
==============

.. code-block:: powershell

 for ($i=0;$i -lt 5;$i++){
    Write-Host $i
   }
  
 # 0
 # 1
 # 2
 # 3
 # 4
 
Bucles con While
================ 

.. code-block:: powershell

 $i = 0
 While ($i -lt 5) {
 echo $i
 $i +=1
 }

 # 0
 # 1
 # 2
 # 3
 # 4

Bucles con Until
================

.. code-block:: powershell

 $i = 0;
 do {
    Write-Host $i
 $i +=1
 }
 until ($i -ge 5)
 
 # 0
 # 1
 # 2
 # 3
 # 4

Bucles con Foreach
==================

.. code-block:: powershell

  $items = 0..4
  $items | ForEach-Object {
    $i="$_"
    Write-Host $i     
  }

   # 0
   # 1
   # 2
   # 3
   # 4  



 foreach ($num in 1,2,"hola",4,5) {
 echo $num
 }

Archivos
========

.. code-block:: powershell

 echo "usuario,grupo" > usuarios.csv       
 echo "user01,group01" >> usuarios.csv     
 echo "user02,group02" >> usuarios.csv     
 echo "user03,group03" >> usuarios.csv     
 echo "user04,group04" >> usuarios.csv
 Test-Path usuarios.csv  #True ver si existe

 #Leer el archivo linea a linea
 foreach ($i in get-content usuarios.csv){
   echo $i
   }

 #Podemos importarlo desde un csv
 $A = Import-Csv -Path usuarios.csv
 echo $A.usuario

 #Podemos recorrer los valores
 foreach ($i in  $A){
   $u=$i.usuario ; echo "usuario = $u"
   }

Funciones
=========

.. code-block:: powershell

 function foo($a, $b, $c) {
   "a: $a; b: $b; c: $c"
   }
 foo 1 3 5
 # a: 1; b: 3; c: 5
 

Windows PowerShell ISE
======================

.. image:: imagenes/powersheelISE.png

.. image:: imagenes/powersheelISE1.png

.. image:: imagenes/powersheelISE2.png
