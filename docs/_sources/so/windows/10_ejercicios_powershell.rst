************************
Ejercicios de PowerShell
************************

.. tabs::

    .. tab:: disk.ps1
      
        Crea un script llamado **disk.ps1** que imprima por pantalla el porcentaje que esta ocupada la partición C:

    .. tab:: Solución

        .. literalinclude:: 10_powershell/disk.ps1
           :language: powershell


.. tabs::

    .. tab:: mem.ps1
      
        Crea un script llamado **mem.ps1**, obtiene solamente la memoria en MB ocupada  y se escriban en un archivo llamado free.log cada vez que se ejecute, sin borrar el anterior registro.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mem.ps1
           :language: powershell



.. tabs::

    .. tab:: mac.ps1
      
        Crea un script llamado **mac.ps1** que obtiene la MAC de tu tarjeta de red

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mac.ps1
           :language: powershell


.. tabs::

    .. tab:: cpu.ps1
      
        Crea un script llamado **cpu.ps1** que saque por pantalla el nombre del procesador instalado en el equipo

    .. tab:: Solución

        .. literalinclude:: 10_powershell/cpu.ps1
           :language: powershell


.. tabs::

    .. tab:: mult.ps1
      
        Haz un script llamado **mult.ps1** que pide un número al usuario y muestre su tabla de multiplicar

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mult.ps1
           :language: powershell


.. tabs::

    .. tab::  ext.ps1
    
        Crea una carpeta llamada Ejercicio, dentro ejecuta lo siguiente:
      
        .. code-block:: powershell
        
          mkdir Ejercicio
        
          cd .\Ejercicio\ 

          for ($i=0;$i -lt 10;$i++){
            echo archivo $i > archivo_$i.dat
          }

        Si hacemos (C:Users....\Ejercicio ls) veremos que se han creado 10 archivos. 
        Puedes también recorrerlos de la siguiente forma:
        
        .. code-block:: powershell

          foreach ($i In $(Get-ChildItem -Filter *.dat )){
            echo "i = $i"
            }
        
        Haz un script llamado **ext.ps1** que cambie a todos los archivos la extensión .dat por .txt
        

    .. tab:: Solución

        .. literalinclude:: 10_powershell/ext.ps1
           :language: powershell


.. tabs::

    .. tab:: rnd.ps1
      
        Haz un script llamado **rnd.ps1** que escoja un numero aleatorio entre 1 y 20, pregunte al usuario, le diga si es más pequeño o más grande y que continué hasta que acierte. Cuando el usuario acierte haz que muestre el número de intentos.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/rnd.ps1
           :language: powershell


.. tabs::

    .. tab:: dados.ps1
      
        Haz un script llamado  dados.ps1 que obtenga dos números aleatorios entre el 1 y el 6, haz que la salida se vuelque en un archivo llamado tiradas.csv, en tres columnas, siendo la tercera columna la suma de los dos dados, crea un archivo con al menos 100 tiradas.

        Haz que el número de tiradas lo reciba como un argumento, por ejemplo:
        
        .. code-block:: powershell        
          
          .\dados.ps1 100

        En el caso de que no reciba ningún argumento haz que pregunte cuantas tiradas quieres.

        .. code-block:: powershell
        
          .\dados.ps1
  
          ¿Cuántas tiradas quieres hacer?
          100
   
        En el caso de que reciba el argumento help, muestre la siguiente ayuda:
        
        .. code-block:: powershell      
            
          .\dados.ps1 help
        
          Uso del script dados.ps1:
          .\dados.ps1 <número_de_tiradas>
          Ejemplo: .\dados.ps1 100
          Si no se proporciona ningún argumento, se preguntará cuántas tiradas deseas hacer.
          Si se usa el argumento 'help', se mostrará esta ayuda.

        
        
    .. tab:: Solución

        .. literalinclude:: 10_powershell/dados.ps1
           :language: powershell






