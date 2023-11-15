******************
Comandos avanzados
******************

* **echo** muestra el valor de una variable o repite la salida estándar

  Las variables se dividen en dos tipos, locales y de entorno (globales), Las variables de entorno global son visibles desde una sesión de shell y en cualquier proceso secundario que genera el shell. En cambio, las variables locales solo pueden estar disponibles en el shell en el que se crean.

  .. code-block:: bash
  
   $ echo "Hola Mundo"   # repite salida estándar
   Hola Mundo
 
   $ a=5
   $ echo a  
   a
   
   $ echo $a             # valor de una variable local 
   5
   
   $ echo "a = $a"       # utiliza " para que evalue la variable
   a = 5
   
   $ echo 'a = $a'       # utiliza ' para que no evalue la variable
   a = $a
   
   $ echo $HOME           # valor de una variable global  
   /home/dani
   

* **Evaluación de comandos y operaciones**

  .. code-block:: bash

   $ a=3+4
   $ echo $a              # repite salida estándar
   3+4
   
   $ echo $((a))          # doble parentesis realiza la operación
   7
   
   $ a=$(whoami)          # un parentesis toma el valor del comando
   $ echo $a
   dani


* **Operaciones**

  .. code-block:: bash

   $ a=10
   $ b=4
   $ echo $((a+b))
   14
   $ echo $((a*b))
   40
   $ echo $((a/b))        # solo nº enteros
   2
   $ echo $((a-b))
   6
   $ echo $((a%b))        # modulo o resto
   2
   
   # Ejemplo de modulo:
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
   
   $ echo ${a:1:4}
   ww.f
   
   $ echo ${#a}
   11  
   
   $ echo ${a:$((${#a}-3))}
   org
   
   $ echo ${a::$((${#a}-3))}
   www.fsf. 
  
* **Redireccionamiento > , >> , > , &> , <**

  .. code-block:: bash
  
   $ echo 'admin      : nombre1 ' > login.dat 
   $ echo 'gerente    : nombre2 ' >> login.dat
   $ echo 'supervisor : nombre3 ' >> login.dat
   $ echo 'empleado   : nombre4 ' >> login.dat
   $ echo 'empleado   : nombre5 ' >> login.dat

   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5

   
   $ cat test.dat                    # da un error al no existir el archivo
   cat: test.dat: No such file or directory
   
   $ cat test.dat > new.dat          # crea un archivo vacío
   cat: test.dat: No such file or directory
   
   $ cat new.dat                     # comprobamos que esta vacío
   
   $ cat test.dat 2> new.dat         # 2> recoge el error
   $ cat new.dat
   cat: test.dat: No such file or directory

   $ tunombre=dani
   $ cat << EOF > new_file.dat
   Mi nombre es $tunombre
   hoy es $(date)
   EOF
   
   $ cat new_file.dat
   Mi nombre es dani
   hoy es mié 12 oct 2022 16:37:57 CEST
   
   #Podemos hacer lo mismo:
   $ echo "Mi nombre es $tunombre
   hoy es $(date)" >> new_file.dat

  * **tee** ambos a fichero y a pantalla
  
  * **/dev/null** descarta la salida
  
  *  **echo $?** devuelve 0 si el comando que se acaba de ejecutar no ha dado problemas
  
  *  **&>** combina los operadores 2> (redirigir stderr) y > (redirigir stdout) en uno solo.

  * **orden1 && orden2** La orden2 solo se ejecuta si la orden1 devuelve un estado de salida 0

  * **orden1 || orden2** la orden2 solo se ejecuta si la orden1 devuelve un estado de   salida distinto de 0

* **head y tail** head muestra las primeras lineas y tail las ultimas, por defecto muestran 10 lineas

  .. code-block:: bash
  
   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5
   
   $ head -n 3 login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   
   $ tail -n 3 login.dat
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5

* **Pipes, tuberías "|"** la salida del primer comando se toma como la entrada del siguiente.
   
  .. code-block:: bash

   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5

   $ head -n 3 login.dat | tail -n 1
   supervisor : nombre3
   
   #El comando bc se utiliza como calculadora
   $ echo 4/5 | bc -l
   .80000000000000000000

* **cut** corta columnas (-f) usando como delimitador (-d)

  .. code-block:: bash
  
   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5
   
   $ cut -d ' ' -f1 login.dat
   admin
   gerente
   supervisor
   empleado
   empleado

   
   $ cut -d ' ' -f2 login.dat
   
   
   :
   
   
   $ cut -d ':' -f2 login.dat
   nombre1
   nombre2
   nombre3
   nombre4
   nombre5

* **grep** filtra texto de un archivo, con la opción c muestra solo el nº de lineas que coinciden,  y con -v selecciona las lineas que no coinciden

  .. code-block:: bash

   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5

   $ grep empleado login.dat 
   empleado   : nombre4 
   empleado   : nombre5 
   
   # con la opción -c muestra solo el nº de lineas
   $ grep -c empleado login.dat
   2
   
   # con la opción -n muestra el número de lineas
   $ grep -n empleado login.dat # muestra solo el nº de lineas
   4:empleado   : nombre4
   5:empleado   : nombre5


   # con la opción -v selecciona las lineas que no coinciden
   $ grep -v empleado login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   
   #AND
   $ grep  empleado login.dat | grep 5
   empleado   : nombre5

   
* **egrep** es el comando gerp extendido, este comando permite el uso de expreiones regulares más complejas que grep

  .. code-block:: bash
  
   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5

   # OR
   $ egrep  'empleado|admin' login.dat
   admin      : nombre1 
   empleado   : nombre4 
   empleado   : nombre5 

   # con la opción -i no discrimina entre Mayúsculas y Minúsculas
   $ egrep  -i EM login.dat            
   empleado   : nombre4 
   empleado   : nombre5 

* **uniq** quita las lineas duplicadas

  .. code-block:: bash
  
   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5
   
   $ grep emple login.dat | cut -d' ' -f1
   empleado
   empleado
   
   $ grep emple login.dat | cut -d' ' -f1 | uniq
   empleado
   
   # con la opción -c precede a las líneas con el número de ocurrencias
   $ grep emple login.dat | cut -d' ' -f1 | uniq -c
   2 empleado


* **sort** ordena

  .. code-block:: bash

   $ sort login.dat
   admin      : nombre1
   empleado   : nombre4
   empleado   : nombre5
   gerente    : nombre2
   supervisor : nombre3
   
   $ cat test.dat 
   2 B
   3 C
   20 D
   1 A
   $ sort test.dat 
   1 A
   2 B
   20 D
   3 C
   $ sort -n test.dat #--numeric-sort
   1 A
   2 B
   3 C
   20 D
   $ sort -rn test.dat #--reverse
   20 D
   3 C
   2 B
   1 A

* **wc** te dice el nº de lineas, palabras y caracteres que tiene el archivo

  .. code-block:: bash

   $ wc login.dat 
    5 15 110 login.dat
    
   $ wc login.dat | cut -d' ' -f2
   5
   
   $ nlineas=$(wc login.dat | cut -d' ' -f2)
   $ echo $nlineas 
   5


   
* **tr** sustituye caracteres

  .. code-block:: bash
  
   $ cat login.dat
   admin      : nombre1
   gerente    : nombre2
   supervisor : nombre3
   empleado   : nombre4
   empleado   : nombre5
  
   $ cat login.dat | tr 'a' 'A'
   Admin      : nombre1 
   gerente    : nombre2 
   supervisor : nombre3 
   empleAdo   : nombre4 
   empleAdo   : nombre5 
   
   $ cat login.dat | tr 'admin' 'ADMIN'
   ADMIN      : NoMbre1 
   gereNte    : NoMbre2 
   supervIsor : NoMbre3 
   eMpleADo   : NoMbre4 
   eMpleADo   : NoMbre5 
   
   $ cut -d' ' -f3 login.dat 
   
   
   nombre3
   
   
   # con la opción -s quita los caracteres duplicados (tr -s ' ')
   
   $ cat login.dat | tr -s ' ' 
   admin : nombre1 
   gerente : nombre2 
   supervisor : nombre3 
   empleado : nombre4 
   empleado : nombre5 

   $ cat login.dat | tr -s ' ' | cut -d' ' -f3 
   nombre1
   nombre2
   nombre3
   nombre4
   nombre5

* **sed** stream editor, realiza operaciones de edición de texto en archivos de texto, de manera automatizada y en línea.

  .. code-block:: bash

   $ sed -n '2,3p' login.dat  
   gerente    : nombre2 
   supervisor : nombre3 
   
   $ sed -n '3p' login.dat
   supervisor : nombre3

   $ sed 's/admin/ADMIN/g' login.dat 
   ADMIN      : nombre1 
   gerente    : nombre2 
   supervisor : nombre3 
   empleado   : nombre4 
   empleado   : nombre5
   
   #si utilizamos la opción -i el archivo original se editará en su lugar
   $ sed -i 's/admin/ADMIN/g' login.dat
   $ cat linea.dat
   ADMIN      : nombre1 
   gerente    : nombre2 
   supervisor : nombre3 
   empleado   : nombre4 
   empleado   : nombre5
  
   #eliminar lineas en blanco de un archivo
   sed '/^$/d' archivo.txt


* **paste** muestra por pantalla el contenido de dos archivos

  .. code-block:: bash

   $ head login.dat shell.dat 
   ==> login.dat <==
   usuario1 u1
   usuario2 u2
   usuario3 u3
   
   ==> shell.dat <==
   usuario1 bash
   usuario2 cshell
   usuario3 bash
 
   $ paste login.dat shell.dat 
   usuario1 u1   usuario1 bash
   usuario2 u2   usuario2 cshell
   usuario3 u3   usuario3 bash


* **join** mezcla el contenido de dos archivos

  .. code-block:: bash

   $ join login.dat shell.dat 
   usuario1 u1 bash
   usuario2 u2 cshell
   usuario3 u3 bash

* **diff** obtiene la diferencia entre dos archivos

  .. code-block:: bash

   $ sed 's/u3/U3/g' login.dat > login2.dat
   $ diff login.dat  login2.dat 
   3c3
   < usuario3 u3
   ---
   > usuario3 U3
   
   $ diff -yW60 login.dat  login2.dat 
   usuario1 u1            usuario1 u1
   usuario2 u2            usuario2 u2
   usuario3 u3         |  usuario3 U3




