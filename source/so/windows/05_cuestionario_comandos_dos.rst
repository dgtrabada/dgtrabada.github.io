****************************
Cuestionario comandos MS-DOS
****************************

.. cuestionario::

   1. Navegación:
      - 1. ¿Qué comando muestra la ruta en la que te encuentras?
        = cd
      - 2. ¿Cómo subes al directorio padre?
        = cd ..
      - 3. ¿Qué comando limpia la pantalla?
        [cls]
      - 4. ¿Cómo cambias a la unidad E:?
        (x) Escribiendo E: (o cd /d E:)
        ( ) cd E:
        ( ) unidad E:
      - 5. ¿Cuál es el equivalente en Windows del ls de GNU/Linux?
        [dir]

   2. dir y atributos:
      - 1. ¿Cómo listas los archivos ocultos?
        = dir /ah
      - 2. ¿Cómo listas los archivos ordenados por tamaño, el más pequeño primero?
        = dir /os
      - 3. ¿Y ordenados por fecha, el más antiguo primero?
        = dir /od
      - 4. ¿Qué comando hace oculta la carpeta A?
        = attrib +h A
      - 5. ¿Qué atributo activa attrib +r sobre un archivo?
        (x) Solo lectura
        ( ) Archivo listo para copia de seguridad
        ( ) Archivo de sistema
      - 6. ¿Cómo le quitas el atributo de oculto a la carpeta A?
        = attrib -h A

   3. Carpetas y archivos:
      - 1. ¿Qué comando crea un directorio?
        [md|mkdir]
      - 2. ¿Qué hace mkdir A B C?
        (x) Crea tres directorios: A, B y C
        ( ) Crea el directorio C dentro de B, dentro de A
        ( ) Da un error
      - 3. ¿Cómo borras el directorio A con todos sus subdirectorios y sin que pregunte?
        = rd /Q /S A | rd /S /Q A | rmdir /Q /S A | rmdir /S /Q A
      - 4. ¿Qué comando cambia el nombre de un archivo o directorio?
        [ren|rename]
      - 5. ¿Cómo copias el directorio A al directorio B con todas sus subcarpetas (incluso vacías) y archivos ocultos?
        (x) xcopy A B /E /H /C /K
        ( ) copy A B
        ( ) move A B /E
      - 6. ¿Qué comando muestra el árbol de directorios?
        [tree]
      - 7. ¿Qué comando muestra el contenido de un fichero de texto?
        [type]
      - 8. ¿Qué comando compara dos archivos?
        [fc]

   4. Redirección y variables:
      - 1. ¿Cómo añades la palabra adios al final de salida.txt sin borrar su contenido?
        = echo adios >> salida.txt
      - 2. ¿Qué muestra echo %COMPUTERNAME%?
        (x) El nombre del equipo
        ( ) El nombre del usuario
        ( ) El dominio
      - 3. ¿Qué variable contiene el nombre del usuario actual?
        [%USERNAME%|USERNAME]
      - 4. Con a=1 y b=3, ¿qué muestra set /a sum=a+b seguido de echo %sum%?
        [4]
      - 5. ¿Y set str=%a%+%b% seguido de echo %str%?
        [1+3]
      - 6. ¿Qué opción de find muestra solo el número de líneas que contienen la cadena?
        [/C|C]
      - 7. ¿Y cuál ignora mayúsculas y minúsculas?
        [/I|I]
      - 8. ¿Qué comando ordena el contenido de un archivo?
        [sort]

   5. Red y sistema:
      - 1. ¿Cómo compruebas la conectividad con 8.8.8.8?
        = ping 8.8.8.8
      - 2. ¿Qué comando muestra la configuración de red TCP/IP?
        [ipconfig]
      - 3. ¿Qué comando muestra la versión del sistema operativo?
        [ver]
      - 4. ¿Qué comando lista los procesos en ejecución?
        [tasklist]
      - 5. ¿Cómo matas el proceso bloc.exe por su nombre?
        = taskkill /IM bloc.exe | taskkill /im bloc.exe
      - 6. ¿Qué comando comprueba y repara los archivos del sistema?
        = sfc /scannow
      - 7. ¿Cómo reinicias el equipo inmediatamente desde la terminal?
        = shutdown /r /t 0 | shutdown -r -t 0
      - 8. ¿Qué comando muestra la ruta que siguen los paquetes hasta un destino?
        [tracert]
