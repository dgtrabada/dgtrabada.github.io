*****************************
Cuestionario comandos básicos
*****************************

.. cuestionario::

   1. Copiar, mover y crear carpetas:
      - 1. Queremos copiar la carpeta B a una nueva carpeta llamada C, ¿qué comando ejecutamos?
        (x) cp -r B C
        ( ) cp B C
        ( ) copy B C
      - 2. Queremos renombrar la carpeta B a una nueva carpeta que no existe llamada C, ¿qué comando ejecutamos?
        (x) mv B C
        ( ) rename B C
        ( ) rm B C
      - 3. En el caso anterior, si la carpeta C existiese:
        (x) La carpeta B se mueve dentro de la carpeta C
        ( ) La carpeta B sobreescribe la carpeta C
        ( ) No se puede hacer, da un error ya que la carpeta C existe
      - 4. La carpeta A contiene las carpetas B y C. Ejecutamos **mv A/B/ A/C/** y después **ls A/C**, obtenemos:
        (x) B
        ( ) no se puede acceder
        ( ) C
      - 5. Ejecutamos: **mkdir A1; cd A1; mkdir B1; cd B1; mkdir C1; mkdir ../B2; mkdir ../B2/E1; cd ..; cd ..; ls A1/B2** y obtenemos:
        (x) E1
        ( ) B2
        ( ) no se puede acceder
      - 6. ¿Qué opción se utiliza con el comando mkdir para crear varios directorios anidados en una sola ejecución?
        (x) -p
        ( ) -m
        ( ) -d
        ( ) -r

   2. Listar y comodines:
      - 1. ¿Cómo listarías todos los archivos que empiecen por t?
        (x) ls t*
        ( ) ls all t
        ( ) ls t
      - 2. ¿Cómo listarías todos los archivos que terminan en odt y odg?
        (x) ls *odt *odg
        ( ) ls odf odg
        ( ) ls od*
      - 3. ¿Qué comando ejecutarías para hacer la carpeta dir1 oculta?
        (x) mv dir1 .dir1
        ( ) hide dir1
        ( ) cover dir1
      - 4. ¿Cómo listarías las carpetas y archivos ocultos de la carpeta actual?
        (x) ls -la
        ( ) ls
        ( ) ls -hide
      - 5. ¿Cuál es el propósito del comando ls -l?
        ( ) Mostrar solo los nombres de los archivos en un directorio
        (x) Mostrar una lista detallada de archivos y directorios
        ( ) Mostrar los archivos ocultos en un directorio
        ( ) Mostrar el tamaño en bytes de los archivos en un directorio
      - 6. ¿Qué comando nos muestra la hora actual?
        (x) date
        ( ) clock
        ( ) hour
      - 7. ¿Qué comando nos muestra el calendario sin utilizar el entorno gráfico?
        (x) cal
        ( ) calendar
        ( ) day

   3. Empaquetar con tar:
      - 1. Tenemos el directorio casas, ¿cómo hacemos casas.tar?
        (x) tar -cf casas.tar casas
        ( ) tar -xvf casas.tar casas
        ( ) tar -cf casas casas.tar
      - 2. Tenemos casas.tar, ¿cómo obtenemos el directorio casas?
        (x) tar -xvf casas.tar
        ( ) tar -cf casas.tar
        ( ) tar -xvf casas

   4. Rutas y navegación:
      - 1. El comando pwd se utiliza para:
        (x) Imprimir el nombre del directorio actual
        ( ) Cambiar de directorio
        ( ) Salir del directorio actual
      - 2. Soy el usuario X y me encuentro en /bin, ¿cuál de los siguientes comandos NO nos llevaría a nuestro home?
        (x) cd X
        ( ) cd
        ( ) cd /home/X
        ( ) cd $HOME
      - 3. Tenemos el usuario X, ¿dónde se encontrará su home por defecto?
        (x) /home/X
        ( ) /home
        ( ) /X
      - 4. Una vez situados en nuestro $HOME, ¿cómo podríamos ver lo que ocupa?
        (x) du -skh
        ( ) free
        ( ) df -h
      - 5. Es una ruta absoluta:
        (x) /home/user1/Desktop
        ( ) ~/Desktop
        ( ) ../Desktop
      - 6. No es una ruta absoluta:
        ( ) /home/user1/Desktop
        ( ) /
        (x) ../Desktop
      - 7. ¿Cuál es el comando utilizado para cambiar el directorio actual?
        (x) cd
        ( ) change
        ( ) dir
        ( ) chdir

   5. Manejo de archivos y búsquedas:
      - 1. ¿Cuál es el comando para mover el archivo "archivo.txt" al directorio "destino" y cambiar su nombre a "nuevo_archivo.txt"?
        (x) mv archivo.txt destino/nuevo_archivo.txt
        ( ) rename archivo.txt nuevo_archivo.txt destino
        ( ) cp archivo.txt destino/nuevo_archivo.txt
        ( ) move archivo.txt destino/nuevo_archivo.txt
      - 2. ¿Cuál es el propósito del comando cp -r?
        ( ) Cambiar la ubicación actual en el sistema de archivos
        (x) Copiar un directorio completo con todos sus contenidos
        ( ) Renombrar un archivo o directorio
        ( ) Mostrar una lista detallada de archivos y directorios
      - 3. ¿Qué opción se utiliza con el comando rm para eliminar un directorio y su contenido de forma recursiva?
        ( ) -f
        (x) -r
        ( ) -d
      - 4. ¿Cuál es el propósito del comando find?
        ( ) Mostrar una lista detallada de archivos en un directorio
        (x) Buscar archivos y directorios en el sistema de archivos
        ( ) Cambiar el directorio actual
        ( ) Mostrar la ubicación actual en el sistema de archivos
      - 5. ¿Qué opción se utiliza con el comando find para buscar archivos con un nombre específico?
        ( ) -n
        (x) -name
        ( ) -f
        ( ) -file
      - 6. ¿Qué opción se utiliza con el comando find para buscar archivos según su tamaño?
        ( ) -s
        (x) -size
        ( ) -b
        ( ) -blocks
      - 7. ¿Qué comando se utiliza para encontrar la ubicación de un archivo binario y sus fuentes?
        ( ) find
        ( ) locate
        (x) whereis
        ( ) search

   6. Visualizadores de archivos:
      - 1. ¿Cuál es el propósito principal del comando cat?
        ( ) Mostrar una lista de archivos en un directorio
        (x) Mostrar el contenido de un archivo
        ( ) Copiar archivos y directorios
        ( ) Mover archivos y directorios
      - 2. ¿Qué opción se utiliza con el comando cat para numerar las líneas de un archivo?
        ( ) -l
        (x) -n
        ( ) -nl
        ( ) -c
      - 3. ¿Cuál es el propósito del comando more?
        (x) Mostrar el contenido de un archivo página por página
        ( ) Mostrar una lista de archivos en un directorio
        ( ) Editar el contenido de un archivo
        ( ) Buscar archivos y directorios en el sistema de archivos
      - 4. ¿Qué tecla se utiliza con more para avanzar una página?
        ( ) q
        ( ) exit
        ( ) next
        (x) espacio
      - 5. ¿Cuál es el propósito del comando more +n archivo?
        ( ) Mostrar el contenido de un archivo de manera interactiva
        (x) Mostrar el contenido de un archivo a partir de la línea n
        ( ) Mostrar el contenido de un archivo con números de línea
        ( ) Editar el contenido de un archivo

   7. Editor vi:
      - 1. ¿Cuál es el propósito del comando vi?
        ( ) Mostrar el contenido de un archivo
        ( ) Copiar archivos y directorios
        ( ) Mover archivos y directorios
        (x) Editar el contenido de un archivo
      - 2. ¿Qué se utiliza en el modo de comandos para guardar los cambios y salir del editor?
        ( ) q
        ( ) exit
        (x) :wq
        ( ) save
      - 3. ¿Qué tecla se utiliza para cambiar al modo de inserción antes de la posición del cursor?
        (x) i
        ( ) a
        ( ) o
        ( ) r
      - 4. ¿Cuál es el propósito del comando :q!?
        ( ) Guardar los cambios y salir del editor
        (x) Salir del editor sin guardar los cambios
        ( ) Guardar los cambios y guardar una copia de seguridad
        ( ) Volver al modo de comandos después de editar
      - 5. ¿Cuál es el propósito del comando :w?
        (x) Guardar los cambios realizados en el archivo
        ( ) Salir del editor
        ( ) Buscar una palabra específica en el archivo
        ( ) Cambiar al modo de inserción
      - 6. ¿Cuál es el propósito del comando :set nu?
        ( ) Guardar los cambios y salir del editor
        ( ) Cambiar al modo de inserción
        (x) Mostrar los números de línea en el archivo
      - 7. ¿Qué tecla se utiliza en el modo de comandos para eliminar el carácter bajo el cursor?
        ( ) d
        (x) x
        ( ) del
      - 8. ¿Qué tecla se utiliza en el modo de comandos para deshacer el último cambio realizado?
        (x) u
        ( ) x
        ( ) r
        ( ) d
      - 9. ¿Qué tecla se utiliza en el modo de comandos para copiar una línea completa?
        ( ) c
        ( ) v
        (x) yy
        ( ) cc
      - 10. ¿Qué comando se utiliza para buscar y reemplazar texto en todo el archivo?
        ( ) /replace/nuevo/g
        ( ) :replace/texto/nuevo
        (x) :%s/texto/nuevo/g
        ( ) replace
      - 11. ¿Cuál es el propósito del comando :e?
        ( ) Salir del editor
        ( ) Guardar los cambios realizados en el archivo
        ( ) Cambiar al modo de inserción
        (x) Abrir un nuevo archivo para edición
