********************************
Cuestionario comandos avanzados
********************************

.. cuestionario::

   1. Redireccionamiento:
      - 1. Queremos redireccionar el archivo hostname al archivo hostname.backup, ¿qué comando ejecutamos?
        (x) cat hostname > hostname.backup
        ( ) mv hostname hostname.backup
        ( ) cat hostname < hostname.backup
      - 2. Queremos añadir una línea al final de login.dat sin borrar su contenido, ¿qué operador utilizamos?
        ( ) >
        (x) >>
        ( ) <
      - 3. El archivo test.dat no existe; queremos guardar el mensaje de error en new.dat, ¿qué comando ejecutamos?
        (x) cat test.dat 2> new.dat
        ( ) cat test.dat > new.dat
        ( ) cat test.dat < new.dat
      - 4. ¿Qué operador redirige a la vez la salida estándar y la salida de errores?
        ( ) 2>
        (x) &>
        ( ) >>
      - 5. ¿A dónde redirigimos la salida de un comando cuando queremos descartarla?
        [/dev/null]
      - 6. ¿Qué muestra echo $? si el comando que acabamos de ejecutar no ha dado problemas?
        [0|cero]
      - 7. En orden1 && orden2, ¿cuándo se ejecuta la orden2?
        (x) Solo si la orden1 termina bien (estado de salida 0)
        ( ) Solo si la orden1 falla
        ( ) Siempre, una detrás de otra
      - 8. En orden1 || orden2, ¿cuándo se ejecuta la orden2?
        ( ) Solo si la orden1 termina bien (estado de salida 0)
        (x) Solo si la orden1 falla
        ( ) Siempre, una detrás de otra
      - 9. ¿Qué comando envía la salida a la vez a un fichero y a la pantalla?
        [tee]

   2. Tenemos el archivo cal.dat:
      fichero: cal.dat
         enero 1 pintura
         enero 15 cocina
         enero 20 pintura
         febrero 1 cocina
         febrero 15 baile
         febrero 20 pintura
         marzo 1 baile
         marzo 15 cocina
         marzo 20 pintura
      - 1. ¿Cómo obtendrías solo las líneas del fichero que contienen la cadena enero?
        (x) grep enero cal.dat
        ( ) cat enero cal.dat
        ( ) filter enero cal.dat
      - 2. ¿Cómo obtendrías solo la segunda columna?
        (x) cut -d' ' -f2 cal.dat
        ( ) cut -f" " -d2 cal.dat
        ( ) cut -c2 cal.dat
      - 3. ¿Cómo obtendrías la primera y la tercera columna?
        (x) cut -d' ' -f1,3 cal.dat
        ( ) cut -f" " -d1,3 cal.dat
        ( ) cut -c1,3 cal.dat
      - 4. ¿Cómo obtendrías la tercera columna ordenada y sin líneas duplicadas?
        (x) cut -d' ' -f3 cal.dat | sort | uniq
        ( ) cut -d' ' -f3 | sort | uniq cal.dat
        ( ) cut -d' ' -f3 cal.dat | uniq | sort

   3. Tenemos el archivo linea.dat:
      fichero: linea.dat
         1
         2
         3
         4
         5
         6
         7
         8
         9
         10
         11
         12
         13
         14
         15
      - 1. Utilizando el comando head, ¿cómo verías las 3 primeras líneas?
        (x) head -3 linea.dat
        ( ) cat -n 3 linea.dat
        ( ) head 3 linea.dat
      - 2. ¿Cómo verías solo la tercera línea, utilizando los comandos head y tail?
        (x) head -3 linea.dat | tail -1
        ( ) head -3 | tail -1 linea.dat
        ( ) head -3 | tail -1 | linea.dat
      - 3. ¿Cómo verías la segunda y la tercera línea, utilizando el comando sed?
        (x) sed -n "2,3p" linea.dat
        ( ) sed -line '2,3p' linea.dat
        ( ) sed -y 2,3p linea.dat

   4. Tenemos el archivo hola.txt, con las columnas separadas por un número variable de espacios:
      fichero: hola.txt
         a1             a2                  a3
         e1  e2           e3
         o1                   o2                               o3
      - 1. ¿Cómo se puede obtener la segunda columna? (ayuda: usa el comando tr)
        (x) cat hola.txt | tr -s ' ' | cut -d' ' -f2
        ( ) cat hola.txt | cut -d' ' -f2 hola.txt
        ( ) cat hola.txt | cut -d' ' -f2

   5. Tenemos el archivo phone.dat:
      fichero: phone.dat
         usuario1 304-293-3011 campus
         usuario2 304-123-3122 libraries
         usuario3 304-123-3123 libraries
         usuario4 304-100-1112 administration
         usuario5 304-100-1113 administration
         usuario6 304-100-1114 administration
      - 1. Cambia la palabra administration por administración y redirecciona la salida al archivo telefono.dat:
        (x) sed 's/administration/administración/' phone.dat > telefono.dat
        ( ) tr "administration" "administración" phone.dat > telefono.dat
        ( ) cat phone.dat | tr "administration" "administración" > telefono.dat
      - 2. Lo mismo, pero sustituyendo todas las apariciones de cada línea:
        (x) sed 's/administration/administración/g' phone.dat > telefono.dat
        ( ) tr "administration" "administración" phone.dat > telefono.dat
        ( ) change administration administración/phone.dat/g > telefono.dat
      - 3. ¿Cómo podríamos saber el número de líneas del archivo phone.dat que contienen 100?
        (x) grep -c 100 phone.dat
        ( ) grep '100' phone.dat
        ( ) grep 100" phone.dat | wc
      - 4. Utiliza el comando grep para ver solo los teléfonos que terminan en 3 y escribirlos en un archivo llamado t3fono.dat:
        (x) grep '3 ' phone.dat > t3fono.dat
        ( ) grep 3 phone.dat < t3fono.dat
        ( ) grep -c 3 phone.dat < t3fono.dat

   6. Variables:
      - 1. Tenemos una variable a=3 y otra b=4; si c=$a$b, ¿a qué es igual la variable c?
        (x) 34
        ( ) 7
        ( ) ab
      - 2. Si a=3, b=4 y c=$a ; c=$c:$a:$b, ¿a qué es igual la variable c?
        (x) 3:3:4
        ( ) c:a:b
        ( ) 10
      - 3. Si a=3, b=4 y c=a+b, ¿a qué es igual la variable c?
        (x) a+b
        ( ) 7
        ( ) 0
      - 4. Si a=3, b=4 y c=$((a+b)), ¿a qué es igual la variable c?
        (x) 7
        ( ) 3+4
        ( ) a+b
      - 5. Tenemos a=foto.jpg y queremos que b valga foto.png (imagina que tienes fotos jpg y las quieres cambiar a png). ¿Cómo asignamos b?
        (x) b=$(echo $a | sed 's/jpg/png/g')
        ( ) b=$(echo $a | tr 'jpg' 'png')
      - 6. ¿Cómo podemos ejecutar periódicamente el comando free -m para monitorizar el uso de la memoria?
        (x) watch free -m
        ( ) for free -m
        ( ) while free m
