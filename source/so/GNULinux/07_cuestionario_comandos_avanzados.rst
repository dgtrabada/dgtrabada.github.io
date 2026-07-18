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
         a1    a2  a3
         e1 e2    e3
         o1    o2         o3
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

   7. Comillas y tratamiento de cadenas:
      - 1. Ejecutamos a=5 y después echo a, ¿qué se muestra?
        (x) a
        ( ) 5
        ( ) error
      - 2. ¿Y con echo $a?
        [5]
      - 3. Ejecutamos a=5 y echo "a = $a" (comillas dobles), ¿qué se muestra?
        (x) a = 5
        ( ) a = $a
      - 4. Ejecutamos a=5 y echo 'a = $a' (comillas simples), ¿qué se muestra?
        ( ) a = 5
        (x) a = $a
      - 5. Con a=www.fsf.org, ¿qué muestra echo ${a::3}?
        [www]
      - 6. ¿Y echo ${a:1:3}?
        [ww.]
      - 7. ¿Y echo ${a:3}?
        [.fsf.org]
      - 8. ¿Y echo ${#a}?
        [11|once]

   8. Operaciones aritméticas:
      - 1. Ejecutamos a=3+4 y echo $a, ¿qué se muestra?
        (x) 3+4
        ( ) 7
        ( ) error
      - 2. ¿Y con echo $((a))?
        [7|siete]
      - 3. Con a=10 y b=4, ¿qué muestra echo $((a/b))? (recuerda que solo opera con enteros)
        [2|dos]
      - 4. ¿Y echo $((a%b)) (módulo o resto)?
        [2|dos]
      - 5. x=$((RANDOM % 10 + 1)) genera números...
        (x) del 1 al 10
        ( ) del 0 al 10
        ( ) del 0 al 9
      - 6. ¿Qué muestra echo 4/5 | bc -l?
        (x) .80000000000000000000
        ( ) 0
        ( ) 4/5
      - 7. ¿Qué hace a=$(whoami)?
        (x) Guarda en a la salida del comando whoami
        ( ) Guarda en a la cadena whoami
        ( ) Da un error

   9. Filtros sobre login.dat:
      fichero: login.dat
         admin      : nombre1
         gerente    : nombre2
         supervisor : nombre3
         empleado   : nombre4
         empleado   : nombre5
      - 1. ¿Qué muestra grep -c empleado login.dat?
        [2|dos]
      - 2. ¿Qué opción de grep selecciona las líneas que NO coinciden?
        [-v|v]
      - 3. ¿Cómo verías las líneas que contienen empleado o admin?
        (x) egrep 'empleado|admin' login.dat
        ( ) grep empleado -o admin login.dat
        ( ) grep empleado+admin login.dat
      - 4. ¿Qué muestra grep empleado login.dat | grep 5?
        (x) empleado   : nombre5
        ( ) Las dos líneas de empleado
        ( ) Nada
      - 5. wc login.dat muestra 5 15 110, ¿qué es el 5?
        (x) El número de líneas
        ( ) El número de palabras
        ( ) El número de caracteres
      - 6. ¿Y el 110?
        ( ) El número de líneas
        ( ) El número de palabras
        (x) El número de caracteres
      - 7. En grep emple login.dat | cut -d' ' -f1 | uniq -c, ¿qué hace la opción -c de uniq?
        (x) Precede cada línea con su número de ocurrencias
        ( ) Cuenta los caracteres de cada línea
        ( ) Compara sin distinguir mayúsculas
      - 8. ¿Qué hace cat login.dat | tr 'a' 'A'?
        (x) Cambia todas las a minúsculas por A mayúsculas
        ( ) Cambia solo la primera a de cada línea
        ( ) Cambia la palabra a por A

   10. Ordenar, editar y comparar. Tenemos el archivo test.dat:
      fichero: test.dat
         2 B
         3 C
         20 D
         1 A
      - 1. ¿Por qué sort test.dat coloca la línea "20 D" antes que "3 C"?
        (x) Porque ordena alfabéticamente y "20" empieza por 2
        ( ) Porque 20 es mayor que 3
        ( ) Es un error de sort
      - 2. ¿Qué opción de sort ordena numéricamente?
        [-n|n]
      - 3. ¿Y numéricamente en orden inverso?
        [-rn|-nr|rn|nr]
      - 4. ¿Qué hace la opción -i de sed (sed -i 's/admin/ADMIN/g' login.dat)?
        (x) Edita el archivo original en su lugar
        ( ) Ignora mayúsculas y minúsculas
        ( ) Pregunta antes de cada sustitución
      - 5. ¿Qué hace sed '/^$/d' archivo.txt?
        (x) Elimina las líneas en blanco
        ( ) Elimina la primera línea
        ( ) Elimina los espacios de cada línea
      - 6. ¿Qué muestra echo "Hola" | sed 's/./_/g'?
        = ____
      - 7. ¿Qué comando une línea a línea el contenido de dos archivos, en columnas?
        [paste]
      - 8. ¿Qué comando combina las líneas de dos archivos que comparten el primer campo?
        [join]
      - 9. ¿Qué comando muestra las diferencias entre dos archivos?
        [diff]

   11. Un poco de todo:
      - 1. Ejecutamos los siguientes comandos, ¿qué contendrá new_file.dat?
        fichero:
           $ tunombre=dani
           $ cat << EOF > new_file.dat
           Mi nombre es $tunombre
           hoy es $(date)
           EOF
        (x) El valor de la variable y la fecha (Mi nombre es dani, hoy es mié 12 oct...)
        ( ) Las líneas escritas literalmente, con $tunombre y $(date) sin evaluar
        ( ) Da un error
      - 2. ¿Qué hace sed -n '3p' archivo?
        (x) Muestra solo la tercera línea
        ( ) Borra la tercera línea
        ( ) Muestra las tres primeras líneas
      - 3. ¿Qué hace sed -i 's/\t/ /g' archivo.txt?
        (x) Cambia las tabulaciones por espacios en el propio archivo
        ( ) Cambia las t por espacios
        ( ) Añade una tabulación al principio de cada línea
      - 4. ¿Qué hace tr -s ' '?
        (x) Comprime las repeticiones consecutivas de espacios en uno solo
        ( ) Quita todos los espacios
        ( ) Cambia los espacios por tabulaciones
      - 5. ¿Qué hace grep -n empleado login.dat?
        (x) Muestra las coincidencias precedidas de su número de línea
        ( ) Muestra solo el número de coincidencias
        ( ) Muestra las líneas que no coinciden
      - 6. ¿Qué opción de egrep no discrimina entre mayúsculas y minúsculas?
        [-i|i]
      - 7. En un archivo con campos separados por dos puntos (campo1:campo2), ¿cómo sacarías el segundo campo?
        (x) cut -d ':' -f2 archivo
        ( ) cut -d2 -f ':' archivo
        ( ) cut -c ':' archivo

   12. paste, join y diff. Tenemos estos dos archivos:
      fichero: login.dat
         usuario1 u1
         usuario2 u2
         usuario3 u3
      fichero: shell.dat
         usuario1 bash
         usuario2 cshell
         usuario3 bash
      - 1. ¿Qué muestra la primera línea de paste login.dat shell.dat?
        (x) usuario1 u1   usuario1 bash
        ( ) usuario1 u1 bash
        ( ) usuario1 bash
      - 2. ¿Y la primera línea de join login.dat shell.dat?
        (x) usuario1 u1 bash
        ( ) usuario1 u1   usuario1 bash
        ( ) u1 bash
      - 3. Ejecutamos sed 's/u3/U3/g' login.dat > login2.dat y después diff login.dat login2.dat, ¿qué señala diff?
        (x) Solo la tercera línea (u3 | U3)
        ( ) Todas las líneas
        ( ) Nada, son iguales
