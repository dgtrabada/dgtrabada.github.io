***************************************
Cuestionario arquitectura Von Neumann
***************************************

.. cuestionario::

   1. Responde:
      - 1. ¿Qué caracteriza a la arquitectura Von Neumann?
        (x) Las instrucciones y los datos se guardan en la misma memoria
        ( ) Las instrucciones y los datos se guardan en memorias separadas
      - 2. ¿Qué registro contiene la dirección de la siguiente instrucción que hay que ejecutar?
        (x) CP (contador de programa)
        ( ) RDM (registro de dirección de memoria)
        ( ) RI (registro de instrucción)
      - 3. ¿Qué registro indica la posición de la memoria a la que se va a leer o escribir?
        ( ) CP
        (x) RDM
        ( ) RIM
      - 4. ¿Por qué registro pasa la información que se lee de la memoria o se escribe en ella?
        ( ) RDM
        (x) RIM (registro de intercambio de memoria)
        ( ) RI
      - 5. ¿Dónde se guarda la instrucción que se está ejecutando?
        ( ) En el CP
        (x) En el RI (registro de instrucción)
        ( ) En la ALU
      - 6. ¿Qué parte de la CPU decodifica la instrucción y da las órdenes al resto?
        (x) La unidad de control (UC)
        ( ) La ALU
        ( ) La memoria principal
      - 7. ¿Qué parte de la CPU hace las operaciones aritméticas, como la suma?
        ( ) La unidad de control (UC)
        (x) La ALU (unidad aritmético-lógica)
        ( ) El RIM
      - 8. ¿En qué dos fases se divide el procesamiento de cada instrucción?
        (x) Búsqueda y ejecución
        ( ) Lectura y escritura
        ( ) Carga y suma
      - 9. Al procesar la instrucción LOAD 5 completa (búsqueda y ejecución), ¿cuántas veces se lee la memoria principal?
        ( ) 1
        (x) 2
        ( ) 3

.. image:: imagenes/arquitectura/VN_hoja.png
   :class: vn-fondo
   :alt: Hoja de ejercicios de la arquitectura Von Neumann

.. raw:: html

   <style>
   .vn-plan { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .vn-plan p.vn-enunciado { font-weight: bold; margin-top: 0; }
   .vn-plan table { border-collapse: collapse; margin: .4em 0; }
   .vn-plan th, .vn-plan td { border: 1px solid rgba(128,128,128,.5); padding: 3px 5px; text-align: center; }
   .vn-plan th { white-space: nowrap; text-align: left; }
   .vn-plan td.vn-mp { font-family: monospace; min-width: 6em; }
   .vn-plan input { width: 5.5em; padding: 2px 2px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit;
                    font-family: monospace; text-align: center; }
   .vn-plan input.vn-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .vn-plan input.vn-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .vn-plan button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .vn-plan button:hover { background: rgba(128,128,128,.15); }
   .vn-nota { margin-left: .4em; font-weight: bold; }
   .vn-scroll { overflow-x: auto; }
   .vn-hoja { position: relative; width: 851px; height: 805px; background-repeat: no-repeat; background-color: #fff; }
   .vn-celda { position: absolute; display: flex; align-items: center; justify-content: center;
               font-family: monospace; font-size: 15px; color: #000; }
   .vn-celda input { width: 100%; height: 100%; box-sizing: border-box; font-size: 15px; color: #000;
                     border: 1px solid transparent; border-radius: 2px; background: transparent; }
   .vn-celda input::placeholder { color: #aaa; }
   .vn-celda input:focus { outline: 2px solid #1f5fa8; }
   img.vn-fondo { display: none; }
   .vn-sim { color: #1f5fa8; font-weight: bold; }
   .vn-celda input.vn-mp-in { border-color: rgba(128,128,128,.35); }
   </style>

   <p>En los siguientes ejercicios escribe, en orden, todos los valores que va tomando cada registro mientras se
      ejecuta el programa, como en la <a href="https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/VN_template.pdf">hoja de ejercicios</a>.
      Las instrucciones son: <b>LOAD x</b> (carga en la primera entrada de la ALU el dato de la posición x),
      <b>SUM x</b> (pone en la segunda entrada de la ALU el dato de la posición x y los suma),
      <b>WRITE x</b> (escribe el resultado de la ALU en la posición x) y <b>EOF</b> (fin del programa).
      Las instrucciones se escriben con un espacio, por ejemplo <code>LOAD 5</code>. Las casillas que sobran se dejan en blanco.</p>

   <div id="vn-ejercicios"></div>

   <script>
   // simula el programa de la memoria principal y devuelve los valores que va tomando cada registro
   function vnSimula(mp) {
     var mem = {}, r = { CP: [], RDM: [], DEC: [], RI: [], RIM: [], A: [], B: [], R: [] }, escritas = [];
     for (var k in mp) mem[k] = mp[k];
     var a = 0, res = 0;
     for (var cp = 1; cp < 100; cp++) {
       var ins = String(mem[cp]);
       r.CP.push(cp); r.RDM.push(cp); r.DEC.push(cp); r.RIM.push(ins); r.RI.push(ins);
       var partes = ins.split(' '), op = partes[0], x = +partes[1];
       if (op === 'EOF' || ['LOAD', 'SUM', 'WRITE'].indexOf(op) < 0) break;   // EOF o algo que no es una instrucción
       r.RDM.push(x); r.DEC.push(x);
       if (op === 'LOAD') { a = +mem[x]; r.RIM.push(a); r.A.push(a); }
       else if (op === 'SUM') { var b = +mem[x]; r.RIM.push(b); r.B.push(b); res = a + b; r.R.push(res); }
       else if (op === 'WRITE') { r.RIM.push(res); mem[x] = res; escritas.push(x); }
     }
     return { reg: r, mem: mem, escritas: escritas };
   }

   var VN_NOMBRES = [['CP', 'CP'], ['RDM', 'RDM'], ['DEC', 'DEC'], ['RI', 'RI'], ['RIM', 'RIM'],
                     ['A', 'ALU (entrada 1)'], ['B', 'ALU (entrada 2)'], ['R', 'ALU (resultado)']];

   // celdas de la hoja de ejercicios (VN_hoja.png): x izquierda, x derecha y líneas horizontales
   var VN_CELDAS = {
     A:   [48, 158, [55, 85, 114, 143]],
     B:   [248, 358, [54, 84, 113, 142]],
     R:   [153, 263, [223, 253, 282, 311]],
     CP:  [397, 509, [52, 81, 110, 140, 170, 200, 229, 258, 288]],
     RDM: [555, 666, [40, 70, 99, 128, 158, 188, 218, 247, 277, 306, 336, 365, 395, 424, 453]],
     MP:  [694, 806, [42, 71, 100, 130, 160, 190, 219, 248, 274, 303, 332]],
     RIM: [695, 806, [379, 408, 438, 468, 497, 527, 556, 586, 616, 645, 674, 704, 734, 763, 792]],
     RI:  [83, 195, [374, 404, 434, 463, 493, 522, 552, 582, 612, 641, 670, 700, 730, 760]],
     DEC: [213, 324, [374, 404, 434, 463, 493, 522, 552, 582, 612, 641, 670, 700, 730, 760]]
   };

   function vnCelda(clave, i, contenido) {
     var c = VN_CELDAS[clave], y = c[2];
     return '<div class="vn-celda" style="left:' + (c[0] + 3) + 'px;top:' + (y[i] + 3) + 'px;width:' +
            (c[1] - c[0] - 5) + 'px;height:' + (y[i + 1] - y[i] - 5) + 'px">' + contenido + '</div>';
   }

   function vnTarjeta(mp, num, nota) {
     var s = vnSimula(mp);
     var h = '<p class="vn-enunciado">' + num + '. La memoria principal (MP) contiene el programa que ves en el dibujo. ' +
             'Escribe en orden, de arriba abajo, todos los valores que va tomando cada registro y cómo quedan ' +
             'las posiciones de la MP en las que se escribe.</p>';
     h += '<div class="vn-scroll"><div class="vn-hoja" style="background-image:url(' + vnFondo() + ')">';
     ['A', 'B', 'R', 'CP', 'RDM', 'RIM', 'RI', 'DEC'].forEach(function (k) {
       var n = VN_CELDAS[k][2].length - 1, vals = s.reg[k];
       for (var i = 0; i < n; i++)
         h += vnCelda(k, i, '<input data-a="' + (i < vals.length ? vals[i] : '') + '">');
     });
     for (var p = 1; p <= 10; p++) {
       var ini = mp[p] !== undefined ? String(mp[p]) : '';
       if (s.escritas.indexOf(p) >= 0)
         h += vnCelda('MP', p - 1, '<input data-a="' + s.mem[p] + '" placeholder="' + ini + '">');
       else
         h += vnCelda('MP', p - 1, '<span>' + ini + '</span>');
     }
     h += '</div></div>';
     if (nota) h += '<p><i>' + nota + '</i></p>';
     return h + '<button onclick="vnCorregir(this)">Corregir</button>' +
            '<button onclick="vnSolucion(this)">Solución</button>' +
            '<button onclick="vnLimpiar(this)">Reintentar</button>' +
            '<span class="vn-nota"></span>';
   }

   // el fondo es una imagen normal de Sphinx (oculta) para que se copie al compilar
   function vnFondo() { return document.querySelector('img.vn-fondo').src; }

   function vnAzar(a, b) { return a + Math.floor(Math.random() * (b - a + 1)); }

   // programa aleatorio: LOAD x, SUM y, WRITE z, EOF con los datos detrás del programa
   function vnProgramaNuevo() {
     var pos = [5, 6, 7, 8, 9, 10];
     for (var i = pos.length - 1; i > 0; i--) { var j = vnAzar(0, i), t = pos[i]; pos[i] = pos[j]; pos[j] = t; }
     var x = pos[0], y = pos[1], z = pos[2], mp = { 1: 'LOAD ' + x, 2: 'SUM ' + y, 3: 'WRITE ' + z, 4: 'EOF' };
     mp[x] = vnAzar(1, 50); mp[y] = vnAzar(1, 50);
     return mp;
   }

   function vnNuevo() {
     document.getElementById('vn-azar').innerHTML = vnTarjeta(vnProgramaNuevo(), 4) +
       ' <button onclick="vnNuevo()">Ejercicio nuevo</button>';
   }

   (function () {
     var EJERCICIOS = [
       { mp: { 1: 'LOAD 6', 2: 'SUM 7', 3: 'WRITE 9', 4: 'EOF', 6: 15, 7: 25 } },
       { mp: { 1: 'LOAD 9', 2: 'SUM 10', 3: 'WRITE 9', 4: 'LOAD 9', 5: 'SUM 10', 6: 'WRITE 10', 7: 'EOF', 9: 4, 10: 7 },
         nota: 'Fíjate en que WRITE sobrescribe los datos: la segunda suma usa el resultado de la primera, que se ha guardado en la posición 9. ' +
               'En las posiciones de la MP en las que se escribe aparece en gris el valor que tenían al principio.' },
     ];
     var cont = document.getElementById('vn-ejercicios');
     EJERCICIOS.forEach(function (ej, n) {
       var card = document.createElement('div');
       card.className = 'qp-card vn-plan';
       card.innerHTML = vnTarjeta(ej.mp, n + 2, ej.nota);
       cont.appendChild(card);
     });
     var card = document.createElement('div');
     card.className = 'qp-card vn-plan';
     card.id = 'vn-azar';
     cont.appendChild(card);
     vnNuevo();
     // simulador: se escribe el programa en la MP y se rellenan los registros
     var sim = document.createElement('div');
     sim.className = 'qp-card vn-plan';
     sim.id = 'vn-simulador';
     cont.appendChild(sim);
     vnSimuladorDibuja({ 1: 'LOAD 5', 2: 'SUM 6', 3: 'WRITE 8', 4: 'EOF', 5: 10, 6: 20 });
   })();

   function vnSimuladorDibuja(mp) {
     var h = '<p class="vn-enunciado">5. Simulador: escribe tu propio programa en la memoria principal (MP) y pulsa ' +
             '<b>Ejecutar</b> para ver todos los valores que toman los registros.</p>' +
             '<p>Puedes usar LOAD x, SUM x, WRITE x y EOF (x es una posición de 1 a 10), y números en las posiciones de datos. ' +
             'El programa empieza en la posición 1 y tiene que terminar con EOF.</p>';
     h += '<div class="vn-scroll"><div class="vn-hoja" style="background-image:url(' + vnFondo() + ')">';
     ['A', 'B', 'R', 'CP', 'RDM', 'RIM', 'RI', 'DEC'].forEach(function (k) {
       for (var i = 0; i < VN_CELDAS[k][2].length - 1; i++)
         h += vnCelda(k, i, '<span class="vn-sim" data-r="' + k + '" data-i="' + i + '"></span>');
     });
     for (var p = 1; p <= 10; p++)
       h += vnCelda('MP', p - 1, '<input class="vn-mp-in" data-p="' + p + '" value="' + (mp[p] !== undefined ? mp[p] : '') + '">');
     h += '</div></div>';
     h += '<button onclick="vnEjecutar()">Ejecutar</button>' +
          '<button onclick="vnSimuladorDibuja({})">Borrar la memoria</button>' +
          '<span class="vn-nota" id="vn-sim-msg"></span>';
     document.getElementById('vn-simulador').innerHTML = h;
   }

   function vnEjecutar() {
     var card = document.getElementById('vn-simulador'), msg = document.getElementById('vn-sim-msg');
     var mp = {}, error = '';
     card.querySelectorAll('.vn-sim').forEach(function (e) { e.textContent = ''; });
     card.querySelectorAll('.vn-mp-in').forEach(function (inp) {
       var v = inp.value.trim().toUpperCase().replace(/\s+/g, ' ').replace(/^(LOAD|SUM|WRITE)(\d)/, '$1 $2');
       inp.value = v;
       inp.className = 'vn-mp-in';
       if (v !== '') mp[inp.dataset.p] = /^\d+$/.test(v) ? +v : v;
     });
     // comprobaciones del programa
     for (var cp = 1; cp <= 10; cp++) {
       var ins = mp[cp];
       if (ins === 'EOF') break;
       var m = /^(LOAD|SUM|WRITE) (\d+)$/.exec(String(ins));
       if (!m) { error = 'En la posición ' + cp + ' tiene que haber una instrucción (LOAD x, SUM x, WRITE x o EOF), y hay «' + (ins === undefined ? '' : ins) + '».'; break; }
       var x = +m[2];
       if (x < 1 || x > 10) { error = 'La posición ' + x + ' de la instrucción ' + cp + ' no existe: tiene que estar entre 1 y 10.'; break; }
     }
     if (!error && cp > 10) error = 'Falta EOF: el programa tiene que terminar con EOF.';
     if (error) {
       var mal = card.querySelector('.vn-mp-in[data-p="' + cp + '"]');
       if (mal) mal.className = 'vn-mp-in vn-mal';
       msg.textContent = error;
       return;
     }
     var s = vnSimula(mp), sobra = '';
     // datos que se leen pero no son números
     for (var k = 0; k < s.reg.RIM.length; k++)
       if (typeof s.reg.RIM[k] === 'number' && isNaN(s.reg.RIM[k])) { msg.textContent = 'El programa lee una posición que no contiene un número.'; return; }
     ['A', 'B', 'R', 'CP', 'RDM', 'RIM', 'RI', 'DEC'].forEach(function (r) {
       var n = VN_CELDAS[r][2].length - 1;
       if (s.reg[r].length > n) sobra = 'El programa es demasiado largo para la hoja: no caben todos los valores de ' + r + '.';
       s.reg[r].forEach(function (v, i) {
         var e = card.querySelector('.vn-sim[data-r="' + r + '"][data-i="' + i + '"]');
         if (e) e.textContent = v;
       });
     });
     s.escritas.forEach(function (x) {
       var inp = card.querySelector('.vn-mp-in[data-p="' + x + '"]');
       inp.value = s.mem[x];
       inp.className = 'vn-mp-in vn-ok';
     });
     msg.textContent = sobra || 'Programa ejecutado. En verde, las posiciones de la MP en las que se ha escrito.';
   }

   // se compara sin espacios y sin distinguir mayúsculas
   function vnIgual(valor, esperado) {
     return valor.replace(/\s+/g, '').toUpperCase() === String(esperado).replace(/\s+/g, '').toUpperCase();
   }
   // solo cuentan las casillas que tienen respuesta; si se rellena una que debía quedar vacía, se marca como error
   function vnCorregir(btn) {
     var card = btn.closest('.vn-plan'), aciertos = 0, total = 0, sobran = 0;
     card.querySelectorAll('input[data-a]').forEach(function (inp) {
       var ok = vnIgual(inp.value, inp.dataset.a);
       if (inp.dataset.a !== '') { total++; if (ok) aciertos++; }
       else if (!ok) sobran++;
       inp.className = inp.dataset.a === '' && ok ? '' : (ok ? 'vn-ok' : 'vn-mal');
     });
     card.querySelector('.vn-nota').textContent = aciertos + ' / ' + total +
       (sobran ? ' (' + sobran + ' casilla' + (sobran > 1 ? 's' : '') + ' de más)' : '');
   }
   function vnSolucion(btn) {
     var card = btn.closest('.vn-plan');
     card.querySelectorAll('input[data-a]').forEach(function (inp) { inp.value = inp.dataset.a; inp.className = inp.dataset.a ? 'vn-ok' : ''; });
     card.querySelector('.vn-nota').textContent = 'Solución';
   }
   function vnLimpiar(btn) {
     var card = btn.closest('.vn-plan');
     card.querySelectorAll('input[data-a]').forEach(function (inp) { inp.value = ''; inp.className = ''; });
     card.querySelector('.vn-nota').textContent = '';
   }
   </script>
