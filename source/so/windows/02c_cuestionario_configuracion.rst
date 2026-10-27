************************************
Cuestionario configuración Windows
************************************

.. cuestionario::

   1. Información del sistema y rendimiento:
      - 1. ¿Con qué combinación de teclas se abre directamente el Administrador de tareas?
        ( ) Ctrl+Alt+Supr
        (x) Ctrl+Mayús+Esc
        ( ) Win+R
        ( ) Alt+F4
      - 2. ¿En qué pestaña del Administrador de tareas ves el uso de la CPU, la memoria, el disco y la red durante el último minuto?
        ( ) Procesos
        (x) Rendimiento
        ( ) Usuarios
        ( ) Servicios
      - 3. ¿Qué comando abre la información del sistema, donde aparecen el procesador, la versión de la BIOS y la memoria física?
        = msinfo32
      - 4. ¿Qué comando abre la herramienta de diagnóstico de DirectX?
        = dxdiag
      - 5. ¿Para qué sirve WinDirStat?
        ( ) Para medir la velocidad del procesador
        (x) Para ver qué es lo que más ocupa en las unidades de disco
        ( ) Para desfragmentar el disco
        ( ) Para hacer copias de seguridad

   2. Escritorio y explorador:
      - 1. ¿Qué comando abre la calculadora?
        = calc.exe | calc
      - 2. En el explorador, ¿qué búsqueda encuentra los archivos de más de 100 MB?
        (x) System.Size: > 100 MB
        ( ) size > 100
        ( ) *.100MB
        ( ) dir /s 100MB
      - 3. En el explorador, ¿qué búsqueda encuentra los archivos que empiezan por An y acaban por dat?
        ( ) An?dat
        (x) "An*dat"
        ( ) An+dat
        ( ) System.Name: An dat
      - 4. ¿Qué pasa si borras una carpeta con Mayús+Supr?
        ( ) Va a la papelera, como con Supr
        (x) Se borra sin pasar por la papelera, así que no se puede restaurar desde ella
        ( ) Se mueve a la unidad E:
        ( ) Se oculta, pero no se borra

   3. Equipo, usuarios y red:
      - 1. ¿Qué comando muestra el nombre del equipo?
        = hostname
      - 2. ¿Qué hay que hacer después de cambiar el nombre del equipo para que se aplique?
        ( ) Cerrar la sesión
        (x) Reiniciar el equipo
        ( ) Nada, se aplica al momento
        ( ) Ejecutar ipconfig
      - 3. En los grupos de trabajo, ¿cómo se gestionan los usuarios y los permisos?
        ( ) De forma centralizada, en un servidor
        (x) De forma local, en cada uno de los equipos del grupo
        ( ) Desde el router
        ( ) No hay usuarios en un grupo de trabajo
      - 4. ¿Qué modo de red tiene que tener la máquina virtual para estar en la misma red que los ordenadores de clase?
        ( ) NAT
        (x) Adaptador puente
        ( ) Red interna
        ( ) No conectado
      - 5. ¿Qué comando muestra las sesiones abiertas en el equipo, por ejemplo la del escritorio remoto?
        = query session

   4. Discos y copias de seguridad:
      - 1. ¿Qué comando abre la Administración de discos?
        = diskmgmt.msc
      - 2. ¿Qué herramienta de línea de comandos se usa para crear y formatear particiones?
        = diskpart
      - 3. ¿Qué hace el Historial de archivos?
        ( ) Copia todo el sistema operativo en una imagen
        (x) Hace copias de los archivos personales en otra unidad para poder recuperarlos
        ( ) Guarda el historial de navegación
        ( ) Crea puntos de restauración
      - 4. ¿Qué controladores exporta DISM con /export-driver?
        ( ) Todos los controladores del sistema
        ( ) Solo los de Microsoft
        (x) Solo los de terceros, no los de Microsoft
        ( ) Solo los de la tarjeta gráfica

   5. Recuperación y registro:
      - 1. ¿Los puntos de restauración afectan a los archivos personales?
        ( ) Sí, los borran
        ( ) Sí, los devuelven a la fecha del punto
        (x) No, solo devuelven el sistema (programas, controladores y registro) a la fecha del punto
      - 2. ¿Qué comando abre el asistente para restaurar el sistema a un punto anterior?
        = rstrui | rstrui.exe
      - 3. ¿Qué rama del registro guarda la configuración del usuario que tiene la sesión iniciada?
        ( ) HKEY_LOCAL_MACHINE
        (x) HKEY_CURRENT_USER
        ( ) HKEY_CLASSES_ROOT
        ( ) HKEY_CURRENT_CONFIG
      - 4. ¿Qué rama del registro guarda la configuración del equipo, para todos los usuarios?
        (x) HKEY_LOCAL_MACHINE
        ( ) HKEY_CURRENT_USER
        ( ) HKEY_USERS
        ( ) HKEY_CLASSES_ROOT
      - 5. ¿Cómo se hace una copia de seguridad del registro en regedit?
        ( ) Archivo / Importar
        (x) Archivo / Exportar
        ( ) Edición / Buscar
        ( ) Ver / Actualizar
      - 6. ¿Qué valor del registro guarda la imagen de fondo de escritorio?
        = WallPaper
