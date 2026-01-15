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

    .. tab:: tres_numeros.ps1
      
        Haz un script llamado **tres_numeros.ps1** que te pregunte al usuario tres numero enteros y devuelva la suma:

    .. tab:: Solución

        .. literalinclude:: 10_powershell/tres_numeros.ps1
           :language: powershell

    .. tab:: Solución (usamos decimales)

        .. literalinclude:: 10_powershell/tres_numeros_decimales.ps1
           :language: powershell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/tres_numeros_param.ps1
           :language: powershell


.. tabs::

    .. tab:: impar.ps1
      
        Haz un script llamado **impar.ps1** que pide un número al usuario y muestre los números impares hasta ese número

    .. tab:: Solución

        .. literalinclude:: 10_powershell/impar.ps1
           :language: powershell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/impar_param.ps1
           :language: powershell



.. tabs::

    .. tab:: mult.ps1
      
        Haz un script llamado **mult.ps1** que pide un número al usuario y muestre su tabla de multiplicar

    .. tab:: Solución

        .. literalinclude:: 10_powershell/mult.ps1
           :language: powershell

    .. tab:: Solución (param)

        .. literalinclude:: 10_powershell/mult_param.ps1
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

    .. tab:: piedra_papel_tijera.ps1
      
        Haz un script llamado **piedra_papel_tijera.ps1** que

    .. tab:: Solución (if)

        .. literalinclude:: 10_powershell/piedra_papel_tijera.ps1
           :language: powershell

    .. tab:: Solución (switch)

        .. literalinclude:: 10_powershell/piedra_papel_tijera_switch.ps1
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

    .. tab:: tragaperras.ps1

        Un jugador comienza con 100 € para jugar en una máquina tragamonedas. El funcionamiento de la máquina es el siguiente:

        * Cada partida cuesta 1 €.
        * La máquina tiene 3 rulos. ``$rulos = @('limon', 'manzana', 'platano', 'siete')``

          * Tres frutas iguales (por ejemplo, 3 limones): el jugador gana 1 €.
          * Tres sietes: el jugador gana 100 €.

        * Si el jugador no tiene suficiente dinero para jugar (menos de 1 €), deja de jugar.

        Simula la evolución del dinero del jugador durante 1000 partidas o hasta que su dinero se agote, lo que ocurra primero.

        El objetivo es determinar cuánto dinero tiene el jugador al final de las 1000 partidas y cuántas partidas logró jugar en total.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/tragaperras.ps1
           :language: powershell


.. tabs::

    .. tab:: usuarios_G00.ps1

        Crea un script llamado **usuarios_G00.ps1**, que cumpla las siguientes condiciones:

        .. code-block:: bash

           ./usuarios_WSL.sh -help  
             -help               Mostrar esta ayuda.
             -crear <N>          Crear N usuarios de forma aleatoria dentro de los grupos X, Y o Z.
             -borrar             Borrar todos los usuarios creados por este script.
             -listar             Mostrar los usuarios por grupo creados por este script.
       
        Opción ``-crear <N>``: Creará N usuarios con nombres generados automáticamente con el siguiente formato: uX01, uY23, uZ15, etc., 

        * La letra (X, Y o Z) corresponde a un grupo al que se asignará el usuario.
        * El número es un sufijo aleatorio de dos cifras (01 a 99).
        * Si no tenemos <N> creará por defecto 10 usuarios

    .. tab:: Solución

        .. literalinclude:: 10_powershell/usuarios_G00.ps1
           :language: shell


.. tabs::

    .. tab:: csv.ps1
      
        Crea un script en PowerShell llamado **csv.ps1** que cumpla con las siguientes características:
        
        .. code-block:: powershell
        
            csv.ps1 -usuario [nombre usuario] -grupo [grupo]
          

        El script debe agregar una entrada al archivo usuarios.csv (si no existe, debe crearlo).
        El archivo usuarios.csv tendrá el siguiente formato:

        .. code-block:: powershell

            usuario,grupo,password
            alice,B,12D7087D61
            bob,A,5CD356CE5

        La contraseña debe generarse de forma aleatoria, haz que sea una cadena alfanumérica de 8 caracteres.

        Al ejecutar el script, debe mostrar un mensaje en la terminal indicando que el usuario ha sido creado. El mensaje debe seguir el formato:

        .. code-block:: powershell

            El usuario [usuario] ha sido creado con la password [password] en el grupo [grupo].
  
        En el caso de que el usuario exista, la salida será :

        .. code-block:: powershell

            El usuario [usuario] ya existe, no se puede crear.

    .. tab:: Solución

        .. literalinclude:: 10_powershell/csv.ps1
           :language: powershell

    .. tab:: -delete

        En el caso de que pongamos **-delete** borrara el usuario del archvio csv

        .. code-block:: powershell

            csv.ps1 -usuario [nombre usuario] -delete
            El usuario [usuario] ha sido borrado

    .. tab:: Solución

        .. literalinclude:: 10_powershell/csv_delete.ps1
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

    .. tab:: usuarios.ps1
      
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


.. tabs::

    .. tab:: local_users.ps1
      
         Crea un script llamado **local_users.ps1**, que cumpla las siguientes condiciones
                
         1) Si ejecutamos la ayuda:

            .. image:: imagenes/local_users_01.png

         #) Si creamos un nuevo grupo, y listamos los grupos vemos que aparece. 
            
            Si volvemos a intentar crearlo vemos que no nos deja, recoge el error y sácalo por pantalla como se muestra a continuación.

            .. image:: imagenes/local_users_02.png

            Finalmente crea el grupo grupo_tuapellido  

            En el caso de intentar borrar un grupo que no existe haz que saque el mensaje por pantalla:

            .. image:: imagenes/local_users_03.png

         #) Si creamos un nuevo usuario llamado **tunombre**, se creara con la contraseña ``@lumn0``

            Después crea un usuario llamado **tunombre1** con una contraseña que no cumpla con las políticas de seguridad y haz que saque el error que muestra en el pantallazo sin crear el usuario.

            Vuelve a crear el usuario **tunombre1** con una contraseña que cumpla con las políticas de seguridad

            Crear el usuario **tunombre2** con una contraseña que cumpla con las políticas de seguridad en el grupo que no existe **G2**, en este caso el script deberá crear el grupo de forma automática.

            Crear el usuario **tunombre3** con una contraseña que cumpla con las políticas de seguridad en el grupo que ahora si existe **G2**.

            Por ultimo lista los miembros del grupo **G2**

            .. image:: imagenes/local_users_04.png

         #) Mete al usuario **tunombre3** en grupo **G3** que no existe sin poner **-usuario** ni **-grupo**, haz que salga el mensaje de error.

            Mete al usuario **tunombre3** en grupo **G3** que no existe sin poner  **-grupo**, haz que salga el mensaje de error.

            Mete al usuario **tunombre3** en grupo **G3**  haz que salga el mensaje de error.

            Crea el grupo **G3** y mete finalmente al usuario **tunombre3** en grupo **G3**.

            Lista los usuarios del grupo **G3**

            Elimina el usuario **tunombre3** del grupo **G3** (haz que se recojan los mismo errores cuando eliminamos usuarios de un grupo que cuando los metemos)

            Lista los usuarios del grupo **G3** y **G2**

            .. image:: imagenes/local_users_05.png

         #) Por ultimo ejecuta el script `test_local_users.ps1 <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/windows/10_powershell/test_local_users.ps1>`_. para probar el script

            .. image:: imagenes/local_users_06.png

    .. tab:: Solución

        .. literalinclude:: 10_powershell/local_users.ps1
           :language: powershell






.. tabs::

    .. tab:: AD.ps1
      
         Crea un script llamado **AD.ps1**, que cumpla las siguientes condiciones
                
         1) Instala el Active directory utiliza como nombre de dominio : **tunombre.local**

            Haz que toda la decencia con el nombre del dominio dentro del script se haga con las siguientes variables: ``$dirAD="DC=tunombre,DC=local"``, ``$mail="@tunombre.local"``

         #) Si ejecutamos:

            .. image:: imagenes/AD_01.png
            
         #) Si ejecutamos:

            .. image:: imagenes/AD_02.png

         #) Haz que cree, borre y liste las unidades organizativas, si intenta crearlas y ya existe haz que salga un error por pantalla, en el caso de que intente eliminarlas y no existan haz que salga otro error por pantalla.

            .. image:: imagenes/AD_03.png

         #) Haz que cree, borre y liste los grupos del AD, si intenta crearlos y ya existe haz que salga un error por pantalla, en el caso de que intente eliminarlas y no existan haz que salga otro error por pantalla.

            .. image:: imagenes/AD_04.png

            .. image:: imagenes/AD_05.png

         #) Haz que cree, borre y liste los usuarios del AD, si intenta crearlos y ya existe haz que salga un error por pantalla, en el caso de que intente eliminarlas y no existan haz que salga otro error por pantalla, al igual que antes si intenta crear usuarios con una contraseña insegura que de te un error, si intenta crearlo en un grupo que no existe que cree el grupo antes:

            .. image:: imagenes/AD_06.png

         #) Por ultimo ejecuta el script `test_AD.ps1 <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/so/windows/10_powershell/AD.ps1>`_ para probar el script

            .. image:: imagenes/AD_07.png

    .. tab:: Solución

        .. literalinclude:: 10_powershell/AD.ps1
           :language: powershell


