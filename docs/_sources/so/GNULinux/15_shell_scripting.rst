***************
Shell Scripting
***************

Dar permisos de ejecución a un script:

.. code-block:: bash

 $ cat script.sh 
 #!/bin/bash
 nombre=$(whoami)
 echo hola ${nombre}

 $ chmod +x script.sh
 
 $ ./script.sh 
 hola dani


Entrada de datos
****************

* Argumentos de entrada

  .. code-block:: bash
  
   $ cat args.sh
   #!/bin/bash
   X=$1
   Y=$2
   Z=$3
   echo X=$X Y=$Y Z=$Z
   echo "En total hay $# argumentos : $@"
   
   $ ./args.sh uno dos tres
   X=uno Y=dos Z=tres
   En total hay 3 argumentos : uno dos tres
   

* **shift** desplaza los argumentos el número de veces que aparezca

  .. code-block:: bash
  
   $ cat args.sh
   #!/bin/bash
   shift
   X=$1
   Y=$2
   Z=$3
   echo X=$X Y=$Y Z=$Z
   echo "En total hay $# argumentos : $@"
   
   $ ./args.sh uno dos tres
   X=dos Y=tres Z=
   En total hay 2 argumentos : dos tres
   
   $ cat args.sh
   #!/bin/bash
   shift
   shift
   X=$1
   Y=$2
   Z=$3
   echo X=$X Y=$Y Z=$Z
   echo "En total hay $# argumentos : $@"
   
   $ ./args.sh uno dos tres
   X=tres Y= Z=
   En total hay 1 argumentos : tres

* En el caso de que queramos que se tome un argumento por defecto:

  .. code-block:: bash
  
   $ cat args.sh
   #!/bin/bash
   X=${1:-hola}
   Y=${2:-33}
   Z=${3:-$(whoami)}
   echo X=$X Y=$Y Z=$Z
   echo "En total hay $# argumentos : $@"
   
   $ ./args.sh uno dos tres
   X=uno Y=dos Z=tres
   En total hay 3 argumentos : uno dos tres
   
   $ ./args.sh
   X=hola Y=33 Z=dani
   En total hay 0 argumentos :

* En el caso de que queramos que el programa se pare a preguntar por el valor de una variable utilizaremos **read**

  .. code-block:: bash
  
   $ cat args.sh
   #!/bin/bash
   echo "Hola, ¿Cómo te llamas?"
   read X
   echo Hola $X
   
   $ ./args.sh
   Hola, ¿Cómo te llamas?
   dani
   Hola dani

Bucles y condicionales
**********************

* Bucles 

  .. code-block:: bash
   
   $ cat for.sh
   #!/bin/bash
   for ((i=0;i<6;i++))
   do
     echo $i
   done
   
   $ ./for.sh
   0
   1
   2
   3
   4
   5
   
* Bucles y condicionales

  .. code-block:: bash
  
   $ cat for.sh
   #!/bin/bash
   for ((i=1;i<6;i++))
   do
     X=3
     if [ $i -gt $X ]
     then
       echo $i es mayor que $X
     else
       echo $i es menor o igual que $X
     fi
   done
   
   $ ./for.sh
   1 es menor o igual que 3
   2 es menor o igual que 3
   3 es menor o igual que 3
   4 es mayor que 3
   5 es mayor que 3
   
  Podríamos sustituir la linea  if [ $i -gt $X ] por :
  
  .. code-block:: bash

   if [[ $i -gt $X ]]
   if test $i -gt $X
    
* Evaluación de condiciones numéricas
  
  .. code-block:: bash
   
   if test $i -gt $X # -gt grater than
   if test $i -ge $X # -gt grater or equal than
   if test $i -lt $X # -lt less than
   if test $i -eq $X # -eq equal than
   if test $i -ne $X # -ne not equal than

* Comparación de cadenas

  .. code-block:: bash

   $ grep '/bin/bash' file.dat | grep -v root
   
   dani:x:1001:1000:dani,,,:/home/dani:/bin/bash
   ramon:x:1002:1000:ramon,,,:/home/ramon:/bin/bash
   pablo:x:1003:1000:pablo,,,:/home/pablo:/bin/bash
   alvaro:x:1004:1000:alvaro,,,:/home/alvaro:/bin/bash
   cris:x:1005:1000:cris,,,:/home/cris:/bin/bash
   ana:x:1006:1000:ana,,,:/home/ana:/bin/bash
   elvira:x:1007:1000:elvira,,,:/home/elvira:/bin/bash
   
   $ cat for2.sh
   #!/bin/bash
   for i in $(grep '/bin/bash' file.dat | grep -v root|cut -d':' -f1)
   do
     echo $i
   done
   
   $ ./for2.sh
   dani
   ramon
   pablo
   alvaro
   cris
   ana
   elvira

   $ cat for2.sh
   #!/bin/bash
   for i in $(grep '/bin/bash' file.dat | grep -v root|cut -d':' -f1)
   do
     if test $i == "dani"
     then
       echo $i encontrado
     fi
   done

    $ ./for2.sh
    dani encontrado

  Podríamos sustituir la linea if test $i == "dani" por:
  
  .. code-block:: bash
   
   if [ $i == "dani" ]
   if [[ $i == "dani" ]]
   
* Evaluación de condiciones con cadenas de caracteres:

  .. code-block:: bash
  
   Str1 == Str2 # Returns true if the strings are equal
   Str1 != Str2 # Returns true if the strings are not equal
   -n Str1      # Returns true if the string is not null
   -z Str1      # Returns true if the string is null

   #Ejemplo:
   cadena="Hola"
   if [ -n "$cadena" ]     #no olvidar ""
   then  
     echo "La cadena no está vacía"
   else
     echo "La cadena está vacía"
   fi
   La cadena no está vacía


* Otras forma de hacer bucles

  .. code-block:: bash
  
   for i in a b c
   do
     echo $i
   done
   a
   b
   c
   
   i=0
   while [ $i -lt 4 ]
   do
     i=$(($i+1))
   echo $i
   done
   1
   2
   3
   4
   
   #seguirá hasta que el archivo file.dat sea creado
   while ! test -e file.dat
   do
     sleep 1s
     date
   done

* Juntar expresiones **and** y **or**

  .. code-block:: bash

   for i in a b c
   do
     for j in a b c
     do
       if [ $i == $j ] && [ $j == "a" ]    
       then
         echo $i $j ',i j son iguales y j = a'
       fi
       if [ $i == $j ] || [ $j == "a" ]    
       then
         echo $i $j ',i j son iguales o j = a'
       fi
     done
   done
   a a ,i j son iguales y j = a
   a a ,i j son iguales o j = a
   b a ,i j son iguales o j = a
   b b ,i j son iguales o j = a
   c a ,i j son iguales o j = a
   c c ,i j son iguales o j = a

* Estructura básica de **if**, **elif**, **else**

  .. code-block:: bash

   if [ condición1 ]; then
      # Código a ejecutar si condición1 es verdadera
   elif [ condición2 ]; then
      # Código a ejecutar si condición2 es verdadera y condición1 es falsa
   else
      # Código a ejecutar si ninguna de las condiciones anteriores es verdadera
   fi

* Sintaxis básica de **case**

  .. code-block:: bash

   case $variable in
      patrón1)
        # Código a ejecutar si $variable coincide con patrón1
        ;;
      patrón2)
        # Código a ejecutar si $variable coincide con patrón2
        ;;
      *)
        # Código a ejecutar si no coincide con ninguno de los patrones anteriores
        ;; 
   esac

Propiedades de archivos y carpetas
**********************************

.. code-block:: bash

 $ cat file.sh
 #!/bin/bash
 archivo=$1

 if test -e $archivo #True si existe
 then
   if test -d $archivo
   then
     echo "La carpeta $archivo existe"
   fi
   if test -f $archivo
   then
     echo "El archivo $archivo existe" 
   fi
   if test -r $archivo
   then
     echo "tiene permisos de lectura"
   fi
   if test -w $archivo
   then
     echo "tiene permisos de escritura"
   fi
   if test -x $archivo
   then
     echo "tiene permisos de ejecución"
   fi
 else
   echo $archivo" no existe "
 fi
  
 $ echo hola > hola.dat
 $ chmod +rwx hola.dat    
 $ ./file.sh hola.dat
 El archivo hola.dat existe
 tiene permisos de lectura
 tiene permisos de escritura
 tiene permisos de ejecución
  
 $ mkdir dir
 $ chmod +rw dir
 $ chmod -x dir
 $ ./file.sh dir
 La carpeta dir/ existe
 tiene permisos de lectura
 tiene permisos de escritura
 


Funciones
*********

.. code-block:: bash

 function Suma(){
 a=$1
 b=$2
 c=$((a+b))
 echo $c
 }

 $ Suma 1 2
 3


Arrays
******

.. code-block:: bash

  $ palabra=("PYTHON" "LINUX" "BASH" "GITHUB" "DOCKER")
  
  $ echo ${palabra[0]}
  PYTHON
  
  $ echo ${palabra[1]}
  LINUX
  
  $ longitud=${#palabra[@]}
  $ echo $longitud 
  5
  
  $ for((i=0;i<$longitud;i++)) 
  > do 
  > echo palabra[$i]=${palabra[$i]}
  > done
    
  palabra[0]=PYTHON
  palabra[1]=LINUX
  palabra[2]=BASH
  palabra[3]=GITHUB
  palabra[4]=DOCKER

  $ for i in ${palabra[@]}
  > do
  > echo $i
  > done
  PYTHON
  LINUX
  BASH
  GITHUB
  DOCKER


.. code-block:: bash
 
 $ A[0]=1
 $ echo ${A[0]}
 1
 
 $ echo ${A[1]}
 
 $ for i in 1 2 3 4
 > do
 > A[$i]=$i
 > done
 
 $ for i in 1 2 3 4
 > do
 > echo ${A[$i]}
 > done
 1
 2
 3
 4
 
 $ echo $((${A[1]}+${A[2]}))
 3


Escritura de archivos
*********************

.. code-block:: bash

 $ tunombre=dani
 $ cat << EOF > new_file.dat
 Mi nombre es $tunombre
 hoy es $(date)
 EOF
 
 $ cat new_file.dat
 Mi nombre es dani
 hoy es mié 12 oct 2022 16:37:57 CEST
   
Podemos hacer lo mismo:
  
.. code-block:: bash
  
 $ echo "Mi nombre es $tunombre
 hoy es $(date)" >> new_file.dat
 
AWK
***

**awk** es una herramienta de procesamiento de texto y manipulación de datos,  la estructura básica es ``awk 'patrón { acción }' archivo``.

Variables especiales de awk:

* **$0**: Toda la línea actual.
* **$1, $2, ..., $n**: Campos (columnas) de la línea.
* **NR**: Número de línea actual.
* **NF**: Número de campos en la línea actual.
* **FS**: Delimitador de campos (por defecto es espacio).
* **OFS**: Delimitador de salida (por defecto es espacio).

Vemos a continuación ejemplos

.. code-block:: bash
  
 $ cat datos.dat 
 maria    8.9   54.2
 pedro    15.2  20.2 
 ana      7.6   5.6 
 carlos   20.3  8.9
 elena    10.8  43.2
 sergio   3.4   4.4
 laura    6.7   5.5
 david    9.2   6.6

 $ awk '{ print $1 }' datos.dat 
 maria
 pedro
 ana
 carlos
 elena
 sergio
 laura
 david

 $ awk '{ print $1,$3 }' datos.dat 
 maria 54.2
 pedro 20.2
 ana 5.6
 carlos 8.9
 elena 43.2
 sergio 4.4
 laura 5.5
 david 6.6

 #sumar los valores de la columna 3
 $ awk '{ suma += $3 } END { print suma }' datos.dat 
 148.6

 #Calcular promedio
 $ awk '{ suma += $3 } END { print suma/NR }' datos.dat
 18.575

 #contar el número de líneas
 $ awk 'END { print NR }' datos.dat 
 8

 #imprimir lineas con un número específico de campos
 $ awk 'NF == 3 { print }' datos.dat 
 maria    8.9   54.2
 pedro    15.2  20.2 
 ana      7.6   5.6 
 carlos   20.3  8.9
 elena    10.8  43.2
 sergio   3.4   4.4
 laura    6.7   5.5
 david    9.2   6.6

 $ awk 'NF == 2 { print }' datos.dat 

 #agregar texto adicional a la salida
 $ awk '{print "Linea:", $0 }' datos.dat
 Linea: maria    8.9   54.2
 Linea: pedro    15.2  20.2 
 Linea: ana      7.6   5.6 
 Linea: carlos   20.3  8.9
 Linea: elena    10.8  43.2
 Linea: sergio   3.4   4.4
 Linea: laura    6.7   5.5
 Linea: david    9.2   6.6

 #usar condiciones
 $ awk '$2 > 10 { print }' datos.dat
 pedro    15.2  20.2 
 carlos   20.3  8.9
 elena    10.8  43.2

 $ awk '$2 > 10 && $3 > 10 { print }' datos.dat
 pedro    15.2  20.2 
 elena    10.8  43.2

 $ awk '$2 > 10 || $3 > 10 { print }' datos.dat 
 maria    8.9   54.2
 pedro    15.2  20.2 
 carlos   20.3  8.9
 elena    10.8  43.2

 #sumar columnas
 $ awk '{ print $2 + $3 }' datos.dat 
 63.1
 35.4
 13.2
 29.2
 54
 7.8
 12.2
 15.8

 $ awk '{suma=$2+$3 ;  print $1, $2, $3, suma }' datos.dat
 maria 8.9 54.2 63.1
 pedro 15.2 20.2 35.4
 ana 7.6 5.6 13.2
 carlos 20.3 8.9 29.2
 elena 10.8 43.2 54
 sergio 3.4 4.4 7.8
 laura 6.7 5.5 12.2
 david 9.2 6.6 15.8

 #sumar la filas y mostrar solo al final el total
 $ awk '{suma +=$2+$3} END {print "Total:",suma }' datos.dat 
 Total: 230.7

 #mostrar las columnas 1, 3 y 4 de /etc/passwd separadas por - 
 $ cat /etc/passwd | awk 'BEGIN{FS=":";OFS=" - "} {print $1,$3,$4}'
 

