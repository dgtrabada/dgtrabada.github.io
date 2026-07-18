***********************
Cuestionario PowerShell
***********************

.. cuestionario::

   1. Cmdlets básicos:
      - 1. El comando ls...
        (x) En PowerShell es un alias de Get-ChildItem
        ( ) Lista los archivos y carpetas en ms-dos
        ( ) En PowerShell es un alias de Get-Location
      - 2. En PowerShell podemos obtener el día actual con:
        (x) Get-Date
        ( ) Get-Day
        ( ) Show-Date
      - 3. ¿Para qué sirve el comando Get-Member en PowerShell?
        (x) Para ver las propiedades y métodos de un objeto
        ( ) Para listar archivos y carpetas del sistema
        ( ) Para listar los miembros de un grupo
      - 4. ¿Cómo se cambia el directorio actual en PowerShell?
        (x) Set-Location
        ( ) Get-Location
        ( ) New-Item
      - 5. ¿Qué cmdlet crea un nuevo directorio (es lo que hay detrás de mkdir)?
        (x) New-Item
        ( ) New-Directory
        ( ) Make-Dir
      - 6. ¿Qué cmdlet mueve archivos o carpetas?
        (x) Move-Item
        ( ) Copy-Item
        ( ) Set-Location
      - 7. ¿Qué comando muestra el contenido de un archivo?
        (x) Get-Content
        ( ) Read-File
        ( ) Show-Item
      - 8. ¿Qué comando limpia la pantalla de la consola?
        (x) Clear-Host
        ( ) Clear-Screen
        ( ) Reset-Host

   2. Ficheros, comodines y redirección:
      - 1. Ejecutamos los siguientes comandos, ¿qué muestra el ls final?
        fichero:
           mkdir A
           cd A
           mkdir B
           cd B
           mkdir D
           ls
        (x) D
        ( ) A
        ( ) B
      - 2. Con los mismos comandos anteriores, ¿qué muestra Test-Path B?
        (x) False
        ( ) True
        ( ) Nada
      - 3. ¿Cómo listar todos los archivos .txt en un directorio?
        (x) Get-ChildItem *.txt
        ( ) Get-ChildItem ?.txt
        ( ) Get-ChildItem *txt.*
      - 4. ¿Qué comando lista archivos cuyo nombre empieza por “l”?
        (x) Get-ChildItem l*
        ( ) Get-ChildItem ?l*
        ( ) Get-ChildItem ?????.*
      - 5. ¿Qué comando lista archivos que empiezan por “a” y terminan en “.exe”?
        (x) Get-ChildItem a*.exe
        ( ) Get-ChildItem a???.exe
        ( ) Get-ChildItem *.exe.a
      - 6. ¿Qué comando lista archivos con exactamente 3 caracteres antes de la extensión?
        (x) Get-ChildItem ???.*
        ( ) Get-ChildItem *???.*
        ( ) Get-ChildItem ????*
      - 7. ¿Qué parámetro abreviado puede utilizarse para mostrar los archivos ocultos?
        (x) -h
        ( ) -x
        ( ) -r
      - 8. ¿Qué comando busca un archivo llamado datos.txt de forma recursiva?
        (x) Get-ChildItem -Recurse -Filter "datos.txt"
        ( ) Get-Process "datos.txt"
        ( ) Select-String "datos.txt"
      - 9. ¿Qué comando busca todos los archivos PDF de forma recursiva?
        (x) Get-ChildItem -Recurse *.pdf
        ( ) Get-Process *.pdf
        ( ) Select-String "*.pdf"
      - 10. ¿Para qué sirve el operador > en PowerShell?
        (x) Redirige la salida de un comando a un archivo sobrescribiéndolo si existe
        ( ) Añade la salida al archivo sin borrar su contenido anterior
        ( ) Muestra la salida en pantalla sin crear ningún archivo

   3. Procesos:
      - 1. ¿Qué comando muestra los procesos en ejecución en PowerShell?
        (x) Get-Process
        ( ) Show-Process
        ( ) List-Process
      - 2. ¿Qué tipo de información devuelve Get-Process?
        (x) Procesos activos del sistema
        ( ) Usuarios conectados
        ( ) Variables de entorno
      - 3. Para mostrar los procesos ordenados por el uso de memoria de mayor a menor:
        (x) Get-Process | Sort-Object WorkingSet -Descending
        ( ) Get-Process | Where-Object {$_.WorkingSet -gt 100MB}
        ( ) Get-Process | Select-Object WorkingSet | Sort-Object Name
      - 4. ¿Qué hace Get-Process | Where-Object { $_.WorkingSet -gt 100MB }?
        (x) Selecciona los procesos que usan más de 100 MB de memoria
        ( ) Muestra todos los procesos sin filtrar por memoria
        ( ) Ordena los procesos por nombre

   4. Contenido de archivos. Tenemos el archivo.dat:
      fichero: archivo.dat
         1 linea
         2 linea
         3 linea
         4 linea
         5 linea
      - 1. Para obtener la tercera línea (3 linea) ejecutamos:
        (x) (Get-Content archivo.dat)[2]
        ( ) Get-Content archivo.dat | Select-Object -First 3
        ( ) Get-Content archivo.dat | Select-Object -Index 3
      - 2. ¿Con qué otra forma obtendríamos también la tercera línea?
        (x) Get-Content -head 3 archivo.dat | select -last 1
        ( ) (Get-Content archivo.dat)[3]
        ( ) Get-Content archivo.dat | Select-Object -Last 3
      - 3. Queremos obtener 1 linea, 3 linea, 4 linea, 5 linea, B linea (en ese orden), ¿qué ejecutamos?
        (x) Get-Content archivo.dat | %{ $_ -replace '2', 'B' } | sort
        ( ) Get-Content archivo.dat | %{ $_ -replace '2', 'B' }
        ( ) Get-Content archivo.dat | sort | %{ $_ -replace '2', 'B' }
      - 4. ¿Qué muestra sls J archivo.dat -Quiet?
        (x) False
        ( ) True
        ( ) archivo.dat:3:3 J

   5. Sistema y configuración:
      - 1. Para ver el espacio que hay en el disco:
        (x) Get-PSDrive
        ( ) Get-Process
        ( ) Get-Content C:\DiskInfo.txt
      - 2. ¿Cómo se mostraría el nombre del procesador?
        (x) (Get-WmiObject Win32_Processor).name
        ( ) wmic cpu get name
        ( ) Get-ProcessorName
      - 3. ¿Qué comando de PowerShell muestra únicamente el número de núcleos físicos del procesador?
        (x) Get-WmiObject -Class Win32_Processor | Select-Object NumberOfCores
        ( ) Get-Process | Where-Object { $_.Name -eq "System" } | Select-Object CPU
        ( ) Get-CimInstance -Class Win32_ComputerSystem | Select-Object Manufacturer
      - 4. ¿Qué comando se utiliza para apagar el sistema local?
        (x) shutdown /s
        ( ) shutdown /h
        ( ) shutdown /r
      - 5. Para cambiar la dirección IP del equipo desde la línea de comandos, ¿qué herramienta debemos utilizar?
        (x) netsh
        ( ) set ip
        ( ) nbtstat
      - 6. ¿Qué comando de PowerShell cambia el nombre del equipo a "WS22tunombre"?
        (x) Rename-Computer -NewName "WS22tunombre"
        ( ) Set-ComputerName -Name "WS22tunombre"
        ( ) Change-ComputerName -ComputerName "WS22tunombre"
      - 7. ¿Qué comando habilita la respuesta al ping (ICMP echo request) entrante a través del firewall?
        (x) netsh advfirewall firewall add rule name="Habilitar respuesta ICMP IPv4" protocol=icmpv4:8,any dir=in action=allow
        ( ) netsh firewall add icmp rule name="Permitir ping" dir=in action=allow
        ( ) netsh advfirewall set global icmp=enable
      - 8. ¿Qué cmdlet se utiliza para agregar una capacidad opcional de Windows (como el servidor OpenSSH)?
        (x) Add-WindowsCapability
        ( ) Add-WindowsPackage
        ( ) Install-WindowsFeature
      - 9. ¿Qué variable automática muestra la ruta del archivo de perfil del usuario actual?
        (x) $PROFILE
        ( ) $PSHOME
        ( ) $MyInvocation
      - 10. ¿Qué comando de PowerShell agrega un usuario a un grupo local del equipo?
        (x) Add-LocalGroupMember -Group "X" -Member "A"
        ( ) Add-GroupMember -GroupName "X" -UserName "A"
        ( ) Net localgroup "X" "A" /add

   6. Objetos y tuberías:
      - 1. Con $date = Get-Date, ¿qué es AddDays en $date.AddDays(5)?
        (x) Un método
        ( ) Una propiedad
        ( ) Un alias
      - 2. ¿Y Day en $date.Day?
        ( ) Un método
        (x) Una propiedad
        ( ) Un cmdlet
      - 3. ¿Qué representa $_ dentro de un bloque como Where-Object { $_.CPU -gt 100 }?
        (x) El objeto actual que llega por la tubería
        ( ) El último comando ejecutado
        ( ) El directorio actual
      - 4. ¿Qué operador añade la salida al final de un archivo sin sobrescribirlo?
        [>>]
      - 5. Get-Process | ______ { $_.Name.ToUpper() } pasa a mayúsculas el nombre de cada proceso, ¿qué cmdlet falta?
        (x) ForEach-Object
        ( ) Select-Object
        ( ) Group-Object
      - 6. ¿Qué cmdlet suma la CPU de todos los procesos en Get-Process | ______ CPU -Sum?
        [Measure-Object]
      - 7. ¿Qué cmdlet agrupa los procesos por su nombre?
        [Group-Object]
      - 8. ¿Cómo vemos las últimas 10 líneas de un archivo en tiempo real (como tail -f en GNU/Linux)?
        (x) Get-Content archivo.dat -tail 10 -wait
        ( ) Get-Content archivo.dat -last 10
        ( ) sls -tail 10 archivo.dat
      - 9. ¿Qué cmdlet da a la salida formato de tabla?
        [Format-Table|ft]
      - 10. ¿Qué cmdlet lista todos los cmdlets, funciones y scripts disponibles?
        [Get-Command]

   7. Servicios y usuarios locales:
      - 1. ¿Cómo consultamos el estado del servicio Spooler?
        = Get-Service -Name Spooler | Get-Service Spooler
      - 2. ¿Qué cmdlet reinicia un servicio?
        [Restart-Service]
      - 3. ¿Cómo hacemos que el servicio sshd arranque automáticamente con el sistema?
        (x) Set-Service -Name sshd -StartupType Automatic
        ( ) Start-Service sshd -Forever
        ( ) Enable-Service sshd
      - 4. ¿Cómo abrimos una PowerShell como administrador desde otra sesión de PowerShell?
        = start-process powershell -verb runas
      - 5. ¿Qué cmdlet lista los usuarios locales?
        [Get-LocalUser]
      - 6. Para guardar la contraseña en una variable sin que la pida por teclado usamos:
        (x) $Password = ConvertTo-SecureString "alumno" -AsPlainText -Force
        ( ) $Password = "alumno"
        ( ) $Password = Read-Host "alumno"
      - 7. ¿Qué cmdlet crea un usuario local?
        [New-LocalUser]
      - 8. ¿Qué cmdlet muestra información de las interfaces de red?
        [Get-NetAdapter]
