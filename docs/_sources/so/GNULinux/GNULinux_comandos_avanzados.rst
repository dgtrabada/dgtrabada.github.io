******************
Comandos avanzados
******************

* Dar permisos de ejecución a un script

   .. code-block:: bash

   $ chmod +x script.sh

* Caracteres especiales ( *, ?, \, ", > )
* Operadores <, >, >>, <<, 2>, &>, ...
* Pipes, tuberías |

* Variables y cadenas

  .. code-block:: bash
  
   $ a=5
   $ echo a  
   a
   $ echo $a 
   5
   
   $ a=2
   $ b=3
   $ echo $((a+b))   # $((hacer operación))
   5
   $ a=$(whoami)     # $(evaluar comando)
   $ echo $a
   dani
   
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
 

* Editores y visualizadores de archivos

  * **head -n 10** mostrar las primeras 10 lineas
  * **tail -4**  mostrar las 4 ultimas lineas

* Filtros y búsqueda información
    
  * **sort        # ordenar
  * **grep        # filtrar texto de un archivo
                    # grep -c muestra solamente el total de líneas que coinciden,
                    # -n muestra el numero de linea
                    # -v selecciona las líneas que no coinciden
  * **egrep       # OR : egrep 'a|b'
  * **wc          # nº lineas
  * **find        # encontrar;  find -name *dat ; find -not -name *dat
  * **locate      # encontrar
  * **whereis     # encontrar donde esta el comando
  * **uniq        # quitar lineas duplicadas
                    # uniq -c precede a las líneas con el número de ocurrencias
  * **diff        # diferencias entre ficheros y directorios (-r)
  * **tr          # sustituir (tr -s ' ')
  * **cut         # cortar columnas, cut -d' ' -f1
  * **paste       # pegar archivos
  * **join        # parecido a paste pero no duplica los campos
  * **echo        # repetir salida estándar
  * **sed         # reemplazar cadenas, etc ....
                    # sed 's/cadena1/cadena2/g' # Remplaza cadena1 por cadena2
                    # sed -n '1000p' # Listar la línea 1000°
                    # sed -n '10,20p' # Listar de la linea 10 a la 20



    Otros
        bc                # calculadora echo $(echo 4/5 | bc -l)
        $RANDOM           # numero aletorio
        %                 # modulo echo echo $((15%2)), solo nº enteros +-*/
        read              # leer variable
        orden1 && orden2  # la orden2 solo se ejecuta si la orden1 devuelve un estado de salida 0
        orden1 || orden2  # la orden2 solo se ejecuta si la orden1 devuelve un estado de salida distinto de 0

