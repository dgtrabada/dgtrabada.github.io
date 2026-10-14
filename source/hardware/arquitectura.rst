**************************
Arquitectura del ordenador
**************************

Fíjate en el siguiente ordenador:

* `zx80 sinclair anuncio pag1 <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/zx80advert.jpg>`_
* `zx80 sinclair anuncio pag2 <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/zx80_advert.jpg>`_
* `zx80 sinclair <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/sinclair.jpg>`_
* `zx80 inside <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/sinclair2.jpg>`_
* `zx80 circuit diagram <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/zx80_circuit.gif>`_



La arquitectura Von Neumann se refiere a las computadoras que utilizan el mismo dispositivo de almacenamiento tanto para las instrucciones como para los datos (a diferencia de la arquitectura Harvard, que los separa).


.. image:: imagenes/arquitectura/VN1.png
  :width: 600

.. image:: imagenes/arquitectura/VN2.png
  :width: 400



.. image:: imagenes/arquitectura/VN3.png

Ejemplo: un programa que suma los números de las posiciones 5 y 6 de la memoria y guarda el resultado en la posición 8. Mueve la barra o usa los botones para verlo paso a paso; en cada paso, en **verde** está el camino que sigue la información (las líneas por las que pasa y el registro o la posición de memoria de donde sale) y en **rojo** los registros que cambian:

.. container:: visor-pasos

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso1.png
         :alt: Arquitectura Von Neumann, paso 1: Estado inicial

      **Paso 1:** Estado inicial: el programa (LOAD 5, SUM 6, WRITE 8 y EOF) está en las posiciones 1 a 4 de la memoria principal (MP) y los datos (10 y 20) en las posiciones 5 y 6. Los registros están vacíos.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso2.png
         :alt: Arquitectura Von Neumann, paso 2: Búsqueda de la instrucción 1 (LOAD 5)

      **Paso 2:** El contador de programa (CP) contiene la dirección de la primera instrucción: CP = 1.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso3.png
         :alt: Arquitectura Von Neumann, paso 3: Búsqueda de la instrucción 1 (LOAD 5)

      **Paso 3:** La dirección del CP pasa por la unidad de control (UC) al registro de dirección de memoria (RDM): RDM = 1.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso4.png
         :alt: Arquitectura Von Neumann, paso 4: Búsqueda de la instrucción 1 (LOAD 5)

      **Paso 4:** La memoria principal (MP) lee la posición 1 y deja su contenido, LOAD 5, en el registro de intercambio de memoria (RIM).

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso5.png
         :alt: Arquitectura Von Neumann, paso 5: Búsqueda de la instrucción 1 (LOAD 5)

      **Paso 5:** La instrucción pasa del RIM al registro de instrucción (RI) y la UC la decodifica: hay que cargar en la ALU el dato de la posición 5.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso6.png
         :alt: Arquitectura Von Neumann, paso 6: Ejecución de la instrucción 1 (LOAD 5)

      **Paso 6:** Para ejecutar LOAD 5, la UC envía la dirección del dato, 5, al RDM.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso7.png
         :alt: Arquitectura Von Neumann, paso 7: Ejecución de la instrucción 1 (LOAD 5)

      **Paso 7:** La MP lee la posición 5 y deja el dato, 10, en el RIM.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso8.png
         :alt: Arquitectura Von Neumann, paso 8: Ejecución de la instrucción 1 (LOAD 5)

      **Paso 8:** El dato pasa del RIM a la primera entrada de la ALU.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso9.png
         :alt: Arquitectura Von Neumann, paso 9: Búsqueda de la instrucción 2 (SUM 6)

      **Paso 9:** Se incrementa el contador de programa (CP) para apuntar a la siguiente instrucción: CP = 2.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso10.png
         :alt: Arquitectura Von Neumann, paso 10: Búsqueda de la instrucción 2 (SUM 6)

      **Paso 10:** La dirección del CP pasa por la unidad de control (UC) al registro de dirección de memoria (RDM): RDM = 2.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso11.png
         :alt: Arquitectura Von Neumann, paso 11: Búsqueda de la instrucción 2 (SUM 6)

      **Paso 11:** La memoria principal (MP) lee la posición 2 y deja su contenido, SUM 6, en el registro de intercambio de memoria (RIM).

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso12.png
         :alt: Arquitectura Von Neumann, paso 12: Búsqueda de la instrucción 2 (SUM 6)

      **Paso 12:** La instrucción pasa del RIM al registro de instrucción (RI) y la UC la decodifica: hay que sumar el dato de la posición 6.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso13.png
         :alt: Arquitectura Von Neumann, paso 13: Ejecución de la instrucción 2 (SUM 6)

      **Paso 13:** Para ejecutar SUM 6, la UC envía la dirección del dato, 6, al RDM.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso14.png
         :alt: Arquitectura Von Neumann, paso 14: Ejecución de la instrucción 2 (SUM 6)

      **Paso 14:** La MP lee la posición 6 y deja el dato, 20, en el RIM.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso15.png
         :alt: Arquitectura Von Neumann, paso 15: Ejecución de la instrucción 2 (SUM 6)

      **Paso 15:** El dato pasa del RIM a la segunda entrada de la ALU.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso16.png
         :alt: Arquitectura Von Neumann, paso 16: Ejecución de la instrucción 2 (SUM 6)

      **Paso 16:** La ALU suma sus dos entradas: 10 + 20 = 30.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso17.png
         :alt: Arquitectura Von Neumann, paso 17: Búsqueda de la instrucción 3 (WRITE 8)

      **Paso 17:** Se incrementa el contador de programa (CP) para apuntar a la siguiente instrucción: CP = 3.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso18.png
         :alt: Arquitectura Von Neumann, paso 18: Búsqueda de la instrucción 3 (WRITE 8)

      **Paso 18:** La dirección del CP pasa por la unidad de control (UC) al registro de dirección de memoria (RDM): RDM = 3.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso19.png
         :alt: Arquitectura Von Neumann, paso 19: Búsqueda de la instrucción 3 (WRITE 8)

      **Paso 19:** La memoria principal (MP) lee la posición 3 y deja su contenido, WRITE 8, en el registro de intercambio de memoria (RIM).

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso20.png
         :alt: Arquitectura Von Neumann, paso 20: Búsqueda de la instrucción 3 (WRITE 8)

      **Paso 20:** La instrucción pasa del RIM al registro de instrucción (RI) y la UC la decodifica: hay que escribir el resultado en la posición 8.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso21.png
         :alt: Arquitectura Von Neumann, paso 21: Ejecución de la instrucción 3 (WRITE 8)

      **Paso 21:** Para ejecutar WRITE 8, la UC envía al RDM la dirección donde hay que escribir, 8.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso22.png
         :alt: Arquitectura Von Neumann, paso 22: Ejecución de la instrucción 3 (WRITE 8)

      **Paso 22:** El resultado de la ALU, 30, pasa al RIM.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso23.png
         :alt: Arquitectura Von Neumann, paso 23: Ejecución de la instrucción 3 (WRITE 8)

      **Paso 23:** La MP escribe el contenido del RIM en la posición 8.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso24.png
         :alt: Arquitectura Von Neumann, paso 24: Búsqueda de la instrucción 4 (EOF)

      **Paso 24:** Se incrementa el contador de programa (CP) para apuntar a la siguiente instrucción: CP = 4.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso25.png
         :alt: Arquitectura Von Neumann, paso 25: Búsqueda de la instrucción 4 (EOF)

      **Paso 25:** La dirección del CP pasa por la unidad de control (UC) al registro de dirección de memoria (RDM): RDM = 4.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso26.png
         :alt: Arquitectura Von Neumann, paso 26: Búsqueda de la instrucción 4 (EOF)

      **Paso 26:** La memoria principal (MP) lee la posición 4 y deja su contenido, EOF, en el registro de intercambio de memoria (RIM).

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso27.png
         :alt: Arquitectura Von Neumann, paso 27: Búsqueda de la instrucción 4 (EOF)

      **Paso 27:** La instrucción pasa del RIM al registro de instrucción (RI) y la UC la decodifica: es el final del programa.

   .. container:: paso

      .. image:: imagenes/arquitectura/VN_sencillo_paso28.png
         :alt: Arquitectura Von Neumann, paso 28: Fin del programa

      **Paso 28:** Fin: el programa ha terminado y el resultado de la suma, 30, ha quedado guardado en la posición 8 de la MP.

.. raw:: html

   <style>
   .pasos-control { display: flex; align-items: center; gap: .6em; flex-wrap: wrap; margin: .6em 0; }
   .pasos-control input[type=range] { flex: 1; min-width: 12em; }
   .pasos-control button { padding: 3px 12px; border-radius: 5px; border: 1px solid rgba(128,128,128,.6);
                           background: transparent; color: inherit; cursor: pointer; }
   .pasos-control button:hover { background: rgba(128,128,128,.15); }
   .pasos-control span { font-weight: bold; min-width: 7em; }
   </style>
   <script>
   // convierte cada bloque .visor-pasos en un visor con barra deslizante (sin JavaScript se ven todos los pasos)
   document.addEventListener('DOMContentLoaded', function () {
     document.querySelectorAll('.visor-pasos').forEach(function (cont) {
       var pasos = cont.querySelectorAll(':scope > .paso'), n = pasos.length;
       var ctrl = document.createElement('div');
       ctrl.className = 'pasos-control';
       ctrl.innerHTML = '<button type="button">&#9664; Anterior</button>' +
         '<input type="range" min="1" max="' + n + '" value="1">' +
         '<button type="button">Siguiente &#9654;</button><span></span>';
       cont.insertBefore(ctrl, cont.firstChild);
       var barra = ctrl.querySelector('input'), botones = ctrl.querySelectorAll('button'), etiqueta = ctrl.querySelector('span');
       function muestra(i) {
         i = Math.max(1, Math.min(n, i));
         barra.value = i;
         pasos.forEach(function (p, k) { p.style.display = k === i - 1 ? '' : 'none'; });
         etiqueta.textContent = 'Paso ' + i + ' de ' + n;
       }
       barra.addEventListener('input', function () { muestra(+barra.value); });
       botones[0].addEventListener('click', function () { muestra(+barra.value - 1); });
       botones[1].addEventListener('click', function () { muestra(+barra.value + 1); });
       muestra(1);
     });
   });
   </script>


`Resumen en 8 pasos (pdf) <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/VN_sencillo.pdf>`_

Instrucciones para hacer los cuestionarios
==========================================

En el caso de que quieras practicar utilizando un papel como haremos en el examen, puedes descargarte la hoja de ejercicios desde `aquí <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/VN_template.pdf>`_; si lo prefieres, puedes descargártela para practicar utilizando LibreOffice desde `aquí <https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/VN_template.ods>`_. Como ejemplo vamos a realizar el siguiente ejercicio:

.. image:: imagenes/arquitectura/Ejemplo_enunciado.png

.. image:: imagenes/arquitectura/Ejemplo_sol.png

Funcionamiento
==============

* `VonNewmann.pdf <https://github.com/dgtrabada/dgtrabada.github.io/blob/9d4cb4a90040e1a2aaef405191bf3de6111d948a/source/hardware/imagenes/arquitectura/VonNewmann.pdf>`_
* `Contador + decodificador <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/hardware/imagenes/arquitectura/contador%2Bdecodificador.sim1>`_
* `Sumador con acarreo <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/hardware/imagenes/arquitectura/ALU.sim1>`_
* `CPU sin direccionamiento <https://raw.githubusercontent.com/dgtrabada/dgtrabada.github.io/refs/heads/master/source/hardware/imagenes/arquitectura/CPU.sim1>`_
         
.. toctree::
   :hidden:

   cuestionario_arquitectura.rst
