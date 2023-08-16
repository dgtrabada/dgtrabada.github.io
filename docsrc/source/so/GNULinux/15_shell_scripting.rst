***************
Shell Scripting
***************

Dar permisos de ejecución a un script:

.. code-block:: bash

 $ chmod +x script.sh


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
 
 