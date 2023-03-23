******************
Comandos avanzados
******************

* Dar permisos de ejecución a un script

  .. code-block:: bash

   $ chmod +x script.sh

* Caracteres especiales ( *, ?, \, ", ' )
* Operadores <,  <<, 2>, &>, ...

* **echo** muestra el valor de una variable o repite la salida estándar

  .. code-block:: bash
  
   $ echo Hola Mundo
   Hola Mundo
 
   $ a=5
   $ echo a  
   a
   $ echo $a 
   5
   $ echo "a = $a"
   a = 5
   $ echo 'a = $a'
   a = $a
   
* **Operaciones**

  .. code-block:: bash

   $ a=10
   $ b=4
   $ echo $((a+b))
   14
   $ echo $((a*b))
   40
   $ echo $((a/b)) #solo nº enteros
   2
   $ echo $((a-b))
   6
   $ echo $((a%b)) #modulo o resto
   2

* **Evaluación de comandos**

  .. code-block:: bash

   $ a=$(whoami)
   $ echo $a
   dani
   
   $ a=$RANDOM
   $ echo $a
   805
   $ b=$((a%2)) #obtenemos 0 o 1
   $ echo $b
   1
   

* **Tratamiento de candenas**

  .. code-block:: bash

   $ a=www.fsf.org
   $ echo ${a:3}
   .fsf.org
   $ echo ${a::3}
   www
   $ echo ${a:1:3}
   ww.
   $ echo ${a::2}
   ww
   $ echo ${#a}
   11  
   $ echo ${a:$((${#a}-3))}
   org
   $ echo ${a::$((${#a}-3))}
   www.fsf. 
  
* **Redireccionamiento ">" ">>"**

  .. code-block:: bash

   $ echo c 1 linea > linea.dat
   $ echo c 2 linea >> linea.dat
   $ echo a 3 linea >> linea.dat
   $ echo a 4 linea >> linea.dat
   $ cat linea.dat 
   c 1 linea
   c 2 linea
   a 3 linea
   a 4 linea
   
* **head y tail** head muestra las primeras lineas y tail las ultimas, por defecto muestran 10 lineas

  .. code-block:: bash

   $ head -n 3 linea.dat 
   c 1 linea
   c 2 linea
   a 3 linea
   $ tail -n 3 linea.dat 
   c 2 linea
   a 3 linea
   a 4 linea
   
* **Pipes, tuberías "|"** la salida del primer comando se toma como la entrada del siguiente.
   
  .. code-block:: bash

   $ head -n 3 linea.dat | tail -n 1
   a 3 linea
   
   #El comando bc se utiliza como calculadora
   $echo 4/5 | bc -l
   .80000000000000000000

* **cut** corta columnas (-f) usando como delimitador (-d)

  .. code-block:: bash

   $ cut -d' ' -f1 linea.dat 
   c
   c
   a
   a
   $ cut -d' ' -f1,3 linea.dat 
   c linea
   c linea
   a linea
   a linea

* **sort** ordena
   
  .. code-block:: bash

   $ sort linea.dat 
   a 3 linea
   a 4 linea
   c 1 linea
   c 2 linea


* **uniq** quita las lineas duplicadas, con la opción (-c) precede a las líneas con el número de ocurrencias

  .. code-block:: bash

   $ cut -d' ' -f1 linea.dat | sort
   a
   a
   c
   c
   $ cut -d' ' -f1 linea.dat | sort | uniq
   a
   c
   $ cut -d' ' -f1 linea.dat | sort | uniq -c
   2 a
   2 c
   
* **wc** te dice el nº de lineas, palabras y caracteres que tiene el archivo

  .. code-block:: bash

   $ wc linea.dat 
    4 12 40 linea.dat
   $ wc linea.dat | cut -d' ' -f2
   4
   $ nlineas=$(wc linea.dat | cut -d' ' -f2)
   $ echo $nlineas 
   4

* **grep** filtra texto de un archivo, con la opción c muestra solo el nº de lineas que coinciden, con la opción -n muestra el número de lineas y con -v selecciona las lineas que no coinciden

  .. code-block:: bash

   $ grep c linea.dat 
   c 1 linea
   c 2 linea
   $ grep -c c linea.dat    
   2   
   $ grep c linea.dat | grep 1
   c 1 linea
   
* **egrep** es el comando gerp extendido, este comando permite el uso de expreiones regulares más complejas que grep

  .. code-block:: bash

   $ egrep 'c|1' linea.dat #OR
   c 1 linea
   c 2 linea

   $ egrep -i Linea linea.dat  #-i no distingue entre mayúscular y minúsculas
   c 1 linea
   c 2 linea
   a 3 linea
   a 4 linea

* **tr** sustituye caracteres, con la opción -s quita los caracteres duplicados (tr -s ' ')

   $ cat linea.dat | tr 'a' 'A'
   c 1 lineA
   c 2 lineA
   A 3 lineA
   A 4 lineA
   $ cat linea.dat | tr 'linea' 'LINEA'
   c 1 LINEA
   c 2 LINEA
   A 3 LINEA
   A 4 LINEA

   $ cat linea_copia.dat | tr -s ' ' 
   c       linea
   c linea
   a    linea
   a      linea
   
   $ cat linea_copia.dat | cut -d' ' -f2

   linea


   $ cat linea_copia.dat | tr -s ' ' 
   c linea
   c linea
   a linea
   a linea
   $ cat linea_copia.dat | tr -s ' '  | cut -d' ' -f2
   linea
   linea
   linea
   linea

* **sed** stream editor, realiza operaciones de edición de texto en archivos de texto, de manera automatizada y en línea.

  .. code-block:: bash

   $ sed -n '2,3p' linea.dat   
   c 2 linea
   a 3 linea
   $ sed -n '3p' linea.dat 
   a 3 linea

   $ sed 's/linea/LINEA/g' linea.dat 
   c 1 LINEA
   c 2 LINEA
   a 3 LINEA
   a 4 LINEA
   
   #si utilizamos la opción -i el archivo original se editará en su lugar
   $ sed -i 's/linea/LINEA/g' linea.dat
   $ cat linea.dat
   c 1 LINEA  
   c 2 LINEA
   a 3 LINEA
   a 4 LINEA
  
   #eliminar lineas en blanco de un archivo
   sed '/^$/d' archivo.txt


* **paste** muestra por pantalla el contenido de dos archivos

  .. code-block:: bash

   $ cat login.dat
   usuario1 u1
   usuario2 u2
   usuario3 u3
   usuario4 u4
   
   $ cat edad.dat
   usuario1 20
   usuario2 21
   usuario3 20
   usuario4 22

   $ paste login.dat edad.dat
   usuario1 u1     usuario1 20
   usuario2 u2     usuario2 21
   usuario3 u3     usuario3 20
   usuario4 u4     usuario4 22

* **join** mezcla el contenido de dos archivos

  .. code-block:: bash

   $ join login.dat edad.dat
   usuario1 u1 20
   usuario2 u2 21
   usuario3 u3 20
   usuario4 u4 22


* **diff** obtiene la diferencia entre dos archivos

   $ sed 's/u3/U3/g' login.dat > login2.dat
   
   $ diff login.dat login2.dat
   3c3
   < usuario3 u3
   ---
   > usuario3 U3
   
   #-y muestra dos columnas
   #-W numero de columnas, 130 por defecto
   $ diff -yW60  login.dat login2.dat
   usuario1 u1                     usuario1 u1
   usuario2 u2                     usuario2 u2
   usuario3 u3                  |  usuario3 U3
   usuario4 u4                     usuario4 u4




    Otros
        read              # leer variable
        orden1 && orden2  # la orden2 solo se ejecuta si la orden1 devuelve un estado de salida 0
        orden1 || orden2  # la orden2 solo se ejecuta si la orden1 devuelve un estado de salida distinto de 0

