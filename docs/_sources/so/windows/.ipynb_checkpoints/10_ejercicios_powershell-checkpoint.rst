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

    .. tab:: cpu.ps1
      
        Crea un script llamado **cpu.ps1** que saque por pantalla el nombre del procesador instalado en el equipo

    .. tab:: Solución

        .. literalinclude:: 10_powershell/cpu.ps1
           :language: powershell


.. tabs::

    .. tab:: mac.ps1
      
        Crea un script llamado **mac.ps1** que obtiene la MAC de las tarjetas de red que estén en estado Up

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mac.ps1
           :language: powershell

    .. tab:: Solución (foreach)

        .. literalinclude:: 10_powershell/mac2.ps1
           :language: powershell

.. tabs::

    .. tab:: edad.ps1
      
        Haz un script llamado **edad.ps1** que te pregunte en que año naciste y te diga la edad que tienes

    .. tab:: Solución

        .. literalinclude:: 10_powershell/edad.ps1
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

    .. tab:: puerta.ps1
      
        Haz un script llamado **puerta.ps1**, que permite al usuario seleccionar entre cuatro puertas de diferentes colores (roja, azul, verde y amarilla). Si el usuario ingresa un código diferente de 1 a 4, se mostrará un mensaje indicando que la puerta es incorrecta.

    .. tab:: Solución (if)

        .. literalinclude:: 10_powershell/puerta_if.ps1
           :language: powershell

    .. tab:: Solución (switch)

        .. literalinclude:: 10_powershell/puerta.ps1
           :language: powershell


.. tabs::

    .. tab:: puerta2.ps1
      
        Haz un script llamado **puerta2.ps1** parecido al anterior, en este caso si el usuario selecciona una puerta que no sea la verde, se muestra un mensaje indicando que ha perdido. Si selecciona la puerta verde, se le permite lanzar una moneda para ver si gana o pierde.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/puerta2.ps1
           :language: powershell
           
.. tabs::

    .. tab:: usuario.ps1
      
        Haz un script llamado **usuario.ps1** que reciba los siguientes parámetros:

        .. code-block:: powershell

          usuario.ps1 -Nombre Mario -Apellido López -Usuario mario33 -Nacimiento 200

        El script debe:

        Calcular la edad del usuario.
            Si el usuario tiene 14 años o más:
                Mostrar el mensaje:
                Se ha creado a [Nombre] [Apellido] el usuario [Usuario]
            Si el usuario tiene menos de 14 años:
                Mostrar el mensaje:
                No se puede crear el usuario [Usuario] a [Nombre] [Apellido] por tener menos de 14

    .. tab:: Solución (args)

        .. literalinclude:: 10_powershell/usuario_args.ps1
           :language: powershell

    .. tab:: Solución (args2)

        .. literalinclude:: 10_powershell/usuario_args2.ps1
           :language: powershell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/usuario_param.ps1
           :language: powershell


.. tabs::

    .. tab:: monedas.ps1
      
        Haz un script llamado **monedas.ps1** que simule el lanzamiento de 3 monedas y calcule la probabilidad de obtener 3 caras

    .. tab:: Solución

        .. literalinclude:: 10_powershell/monedas.ps1
           :language: powershell

    .. tab:: Solución (n monedas)

        .. literalinclude:: 10_powershell/n_monedas.ps1
           :language: powershell


.. tabs::

    .. tab:: rnd.ps1
      
        Haz un script llamado **rnd.ps1** que escoja un numero aleatorio entre 1 y 20, pregunte al usuario, le diga si es más pequeño o más grande y que continué hasta que acierte. Cuando el usuario acierte haz que muestre el número de intentos.

    .. tab:: Solución (while)

        .. literalinclude:: 10_powershell/rnd.ps1
           :language: powershell

    .. tab:: Solución (do while)

        .. literalinclude:: 10_powershell/rnd_do_while.ps1
           :language: powershell

    .. tab:: Solución (do while)

        .. literalinclude:: 10_powershell/rnd_do_until.ps1
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

        
    .. tab:: Solución (args)

        .. literalinclude:: 10_powershell/dados.ps1
           :language: powershell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/dados_param.ps1
           :language: powershell


.. tabs::

    .. tab:: analisis.ps1
      
        Lee el archivo que has generado en el ejercicio anterior y haz que salga por pantalla el numero de tiradas y el porcentaje de veces que sale cada una, por ejemplo
        
        .. code-block:: powershell
        
          $ ./analisis.ps1
          
          De 1000 tiradas : 2(1%) 3(7%) 4(10%) 5(12%) 6(14%) 7(17%) 8(14%) 9(12%) 10(10%) 11(7%) 12(1%)


    .. tab:: Solución (variables)

        .. literalinclude:: 10_powershell/analisis_variables.ps1
           :language: powershell

    .. tab:: Solución (arrays)

        .. literalinclude:: 10_powershell/analisis.ps1
           :language: powershell


.. tabs::

    .. tab:: csv.ps1
      
        Crea un script en PowerShell llamado csv.ps1 que cumpla con las siguientes características:
        
        .. code-block:: powershell
        
            csv.ps1 -usuario [nombre usuario] -grupo [grupo]
          
        Funcionalidad:

        El script debe agregar una entrada al archivo usuarios.csv (si no existe, debe crearlo).
        El archivo usuarios.csv tendrá el siguiente formato:

        .. code-block:: powershell

            usuario,grupo,password
            alice,B,12D7087D61
            bob,A,5CD356CE5

        La contraseña debe generarse de forma aleatoria, haz que sea una cadena alfanumérica de 8 caracteres.

        Salida en Pantalla:

        Al ejecutar el script, debe mostrar un mensaje en la terminal indicando que el usuario ha sido creado. El mensaje debe seguir el formato:

        .. code-block:: powershell

            El usuario [usuario] ha sido creado con la password [password] en el grupo [grupo].

            
        En el caso de que el usuario exista, la salida será :

        .. code-block:: powershell

            El usuario [usuario] ya existe, no se puede crear.


    .. tab:: Solución

        .. literalinclude:: 10_powershell/analisis_variables.ps1
           :language: powershell



.. tabs::

    .. tab:: crear_usuarios_grupos.ps1
      
        Crea un script llamado **crear_usuarios_grupos.ps1** que cree los siguientes grupos:

        * GPWS01
        * GPWS02
        * ...
        * GPWS09

        1) En el caso de que el grupo no exista, haz que lo cree y saque por pantalla:
        
           **El grupo $nombre_grupo no existe, se crea**
        
        #) En el caso de que el grupo exista haz que no lo intente y saque por pantalla:
        
           **El grupo $nombre_grupo existe, no se crea**
        
        ayuda : $nombre_grupo='GPWS03' ;  Get-LocalGroup | Select-String -Pattern $nombre_grupo -Quiet

    .. tab:: Solución

        .. literalinclude:: 10_powershell/crear_usuarios_grupos_ini.ps1
           :language: powershell



.. tabs::

    .. tab:: crear_usuarios_grupos.ps1
      
        Haz que el anterior script cree los siguientes usuarios dentro de los grupos correspondientes, con la contraseña alumno.         Además haz que estén dentro del grupo Usuarios para que puedan loguearse utilizando el entorno gráfico

        * GPWS01
        
          * tunombre_gpws01_01
          * tunombre_gpws01_02
          * ...
          * tunombre_gpws01_08
          * tunombre_gpws01_09
          
        * GPWS02
        
          * tunombre_gpws02_01
          * tunombre_gpws02_02
          * ...
          * tunombre_gpws02_08
          * tunombre_gpws02_09

        * ...
          
          * ...
          * ...
          
          
        * GPWS09
        
          * tunombre_gpws09_01
          * tunombre_gpws09_02
          * ...
          * tunombre_gpws09_08
          * tunombre_gpws09_09

        1) En el caso de que el usuario no exista, haz que lo cree  y lo incorpore a su grupo, finalmente saque por pantalla:
          
           **El usuario $nombre_usuario con grupo $nombre_grupo no existe, se crea**
        
        
        #) En el caso de que el usuario exista haz que no lo intente y saque por pantalla:
        
           **El usuario $nombre_usuario existe, no se crea**
        
        
        #) En el caso de que el usuario no este en el grupo, haz que lo menta dentro del grupo y saque por pantalla:
        
           **El usuario $nombre_usuario no esta en el grupo $nombre_grupo, se hace miembro**
        
        
        #) En el caso de que el usuario este en el grupo, haz que saque por pantalla:
        
           **El usuario $nombre_usuario ya esta en el grupo $nombre_grupo no se hace nada**


        ayuda: Puedes borrar los usuarios y grupos :
        
        .. code-block:: powershell
        
          foreach ($i in  $(Get-LocalUser |sls -Pattern "tunombre_")){ 
            Remove-LocalUser -Name $i
            }

          foreach ($i in  $(Get-LocalGroup |sls -Pattern  "GPWS")){      
            Remove-LocalGroup -Name $i
            }

    .. tab:: Solución

        .. literalinclude:: 10_powershell/crear_usuarios_grupos.ps1
           :language: powershell




.. tabs::

    .. tab:: crear_usuarios_grupos_csv.ps1
      
        Haz un script  llamado **crear_usuarios_grupos_csv.ps1**, que cree los usuarios que encontraras en  el archivo `users.csv <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/master/source/so/windows/10_powershell/users.csv>`_, tiene que cumplir las siguientes condiciones:
        
        #) En el caso de que el grupo no exista, haz que lo cree y saque por pantalla:
        
           **El grupo $nombre_grupo no existe, se crea**
          
        #) En el caso de que el grupo exista haz que no lo intente y saque por pantalla:

           **El grupo $nombre_grupo existe, no se crea**
          
        #) En el caso de que el usuario exista haz que no lo intente y saque por pantalla:

           **El usuario $nombre_usuario existe, no se crea**
           
        #) En el caso de que el usuario no este en el grupo, haz que lo meta dentro del grupo y saque por pantalla:

           **El usuario $nombre_usuario no esta en el grupo $nombre_grupo, se hace miembro**
          
        #) En el caso de que el usuario este en el grupo, haz que saque por pantalla:

           **El usuario $nombre_usuario ya esta en el grupo $nombre_grupo no se hace nada**
          
        #) En el caso de que el usuario no exista, haz que lo cree y lo incorpore a su grupo, finalmente haz que saque por pantalla:

           **El usuario $nombre_usuario con grupo $nombre_grupo no existe, se crea**
          
        #) Además se añada a un archivo el mensaje:

           **El usuario $nombre_usuario con $passwrd en el grupo $nombre_grupo se ha creado >> lista_usuarios_creados.dat**
          
        #) En el caso de que el usuario este en el grupo, haz que saque por pantalla:

           **El usuario $nombre_usuario ya esta en el grupo $nombre_grupo no se hace nada**

    .. tab:: Solución

        .. literalinclude:: 10_powershell/crear_usuarios_grupos_csv.ps1
           :language: powershell



.. tabs::

    .. tab:: grupos.ps1
      
         Haz un script llamado **usuarios.ps1**, que implementa un menú para gestionar usuarios en el sistema. El script permite listar usuarios, crear y eliminar usuarios, y modificar el nombre de un usuario existente.
         
         Menú de Usuarios:
          
         1) Listar usuarios
         #) Crear usuario
         #) Eliminar usuario
         #) Modificar usuario
         #) Salir

    .. tab:: Solución

        .. literalinclude:: 10_powershell/usuarios.ps1
           :language: powershell


.. tabs::

    .. tab:: grupos.ps1
      
         Haz el script **grupos.ps1**, que implementa un menú para gestionar grupos y sus miembros en PowerShell. El script permite listar grupos, ver miembros, crear y eliminar grupos, así como agregar y eliminar miembros de los grupos.
          
         Menú de Grupos:
          
         1) Listar grupos
         #) Ver miembros de un grupo
         #) Crear grupo (pide nombre grupo)
         #) Elimina grupo (pide nombre grupo)
         #) Crea miembro de un grupo (pide grupo y usuario)
         #) Elimina miembro de un grupo (pide grupo y usuario)
         #) Salir

    .. tab:: Solución

        .. literalinclude:: 10_powershell/grupo.ps1
           :language: powershell

