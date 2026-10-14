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

.. raw:: html

   <style>
   .vn-plan { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .vn-plan p.vn-enunciado { font-weight: bold; margin-top: 0; }
   .vn-plan button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .vn-plan button:hover { background: rgba(128,128,128,.15); }
   .vn-nota { margin-left: .4em; font-weight: bold; }
   .vn-scroll { overflow-x: auto; }
   .vn-hoja { position: relative; background: #fff; }
   .vn-hoja svg { position: absolute; left: 0; top: 0; }
   .vn-celda { position: absolute; display: flex; align-items: center; justify-content: center;
               font-family: monospace; font-size: 15px; color: #000; }
   .vn-celda input { width: 100%; height: 100%; box-sizing: border-box; padding: 0; text-align: center;
                     font-family: monospace; font-size: 15px; color: #000;
                     border: 1px solid transparent; border-radius: 2px; background: transparent; }
   .vn-celda input::placeholder { color: #aaa; }
   .vn-celda input:focus { outline: 2px solid #1f5fa8; }
   .vn-celda input.vn-ok  { border-color: #2e7d32; background: rgba(46,125,50,.15); }
   .vn-celda input.vn-mal { border-color: #c62828; background: rgba(198,40,40,.15); }
   .vn-celda input.vn-mp-in { border-color: rgba(128,128,128,.35); }
   .vn-sim { color: #1f5fa8; font-weight: bold; }
   </style>

   <p>En los siguientes ejercicios escribe, en orden y de arriba abajo, todos los valores que va tomando cada registro
      mientras se ejecuta el programa, como en la <a href="https://github.com/dgtrabada/dgtrabada.github.io/blob/master/source/hardware/imagenes/arquitectura/VN_template.pdf">hoja de ejercicios</a>.
      Las instrucciones son: <b>LOAD x</b> (carga en la primera entrada de la ALU el dato de la posición x),
      <b>SUM x</b> y <b>REST x</b> (ponen en la segunda entrada de la ALU el dato de la posición x y suman o restan),
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
       if (['LOAD', 'SUM', 'REST', 'WRITE'].indexOf(op) < 0) break;   // EOF o algo que no es una instrucción
       r.RDM.push(x); r.DEC.push(x);
       if (op === 'LOAD') { a = +mem[x]; r.RIM.push(a); r.A.push(a); }
       else if (op === 'SUM' || op === 'REST') {
         var b = +mem[x]; r.RIM.push(b); r.B.push(b);
         res = op === 'SUM' ? a + b : a - b; r.R.push(res);
       }
       else if (op === 'WRITE') { r.RIM.push(res); mem[x] = res; if (escritas.indexOf(x) < 0) escritas.push(x); }
     }
     return { reg: r, mem: mem, escritas: escritas };
   }

   // dibuja la hoja de ejercicios con el tamaño justo: n = número de casillas de cada columna
   var VN_H = 29.6;
   function vnPlano(n) {
     var c = {}, h = VN_H;
     c.A = [48, 158, 55, 3]; c.B = [248, 358, 55, 3]; c.R = [153, 263, 223, 3];
     c.CP = [397, 509, 52, n.CP];
     c.RDM = [555, 666, 40, n.RDM];
     c.MP = [694, 806, 42, n.MP];
     c.RIM = [695, 806, 42 + n.MP * h + 47, n.RIM];
     var uc = Math.max(346, 52 + n.CP * h + 58);
     c.RI = [83, 195, uc + 28, n.RI]; c.DEC = [213, 324, uc + 28, n.RI];
     var ucFin = c.RI[2] + n.RI * h + 12, cpuFin = ucFin + 10;
     var alto = Math.max(cpuFin, c.RIM[2] + n.RIM * h, c.RDM[2] + n.RDM * h) + 15;
     var g = '#555', svg = '<svg width="851" height="' + alto + '" font-family="sans-serif" fill="none" stroke="' + g + '" stroke-width="2.5">';
     svg += '<rect x="40" y="25" width="484" height="' + (cpuFin - 25) + '" stroke="#333"/>';
     svg += '<rect x="67" y="' + uc + '" width="273" height="' + (ucFin - uc) + '" stroke="#000" stroke-width="5"/>';
     svg += '<path d="M48 143 L153 311 M158 143 L205 222 L248 142 M358 142 L263 311"/>';
     for (var k in c) {
       var x0 = c[k][0], x1 = c[k][1], y0 = c[k][2];
       for (var i = 0; i < c[k][3]; i++)
         svg += '<rect x="' + x0 + '" y="' + (y0 + i * h) + '" width="' + (x1 - x0) + '" height="' + h + '"/>';
     }
     svg += '<g fill="#888" stroke="none" font-size="19">' +
       '<text x="205" y="153" text-anchor="middle">ALU</text><text x="498" y="44" text-anchor="end">CP</text>' +
       '<text x="663" y="29" text-anchor="end" font-size="15">RDM</text><text x="806" y="32" text-anchor="end">MP</text>' +
       '<text x="803" y="' + (c.RIM[2] - 10) + '" text-anchor="end">RIM</text>' +
       '<text x="335" y="' + (uc - 8) + '" text-anchor="end">UC</text>' +
       '<text x="190" y="' + (c.RI[2] - 6) + '" text-anchor="end" font-size="17">RI</text>' +
       '<text x="322" y="' + (c.RI[2] - 6) + '" text-anchor="end" font-size="17">DEC</text>' +
       '<text x="508" y="' + (cpuFin - 14) + '" text-anchor="end">CPU</text>';
     for (var p = 1; p <= n.MP; p++)
       svg += '<text x="812" y="' + (c.MP[2] + (p - 0.5) * h + 4) + '" font-size="11">' + p + '</text>';
     svg += '</g></svg>';
     return { celdas: c, svg: svg, alto: alto };
   }

   function vnCelda(plano, clave, i, contenido) {
     var c = plano.celdas[clave], y = c[2] + i * VN_H;
     return '<div class="vn-celda" style="left:' + (c[0] + 3) + 'px;top:' + (y + 3) + 'px;width:' +
            (c[1] - c[0] - 5) + 'px;height:' + (VN_H - 5) + 'px">' + contenido + '</div>';
   }

   // casillas necesarias: las de la hoja (8 CP, 14 RDM, 13 RI y DEC, 14 RIM, 10 MP) o más si hace falta
   function vnTamanos(mp, s) {
     var maxPos = Math.max.apply(null, Object.keys(mp).map(Number).concat(s ? s.escritas : [], [10]));
     return { CP: Math.max(8, s ? s.reg.CP.length : 0), RDM: Math.max(14, s ? s.reg.RDM.length : 0),
              RI: Math.max(13, s ? s.reg.DEC.length : 0), RIM: Math.max(14, s ? s.reg.RIM.length : 0), MP: maxPos };
   }

   var VN_REGS = ['A', 'B', 'R', 'CP', 'RDM', 'RIM', 'RI', 'DEC'];

   function vnTarjeta(mp, num, nota) {
     var s = vnSimula(mp), plano = vnPlano(vnTamanos(mp, s));
     var h = '<p class="vn-enunciado">' + num + '. La memoria principal (MP) contiene el programa que ves en el dibujo. ' +
             'Escribe en orden, de arriba abajo, todos los valores que va tomando cada registro y cómo quedan ' +
             'las posiciones de la MP en las que se escribe.</p>';
     h += '<div class="vn-scroll"><div class="vn-hoja" style="width:851px;height:' + plano.alto + 'px">' + plano.svg;
     VN_REGS.forEach(function (k) {
       var vals = s.reg[k];
       for (var i = 0; i < plano.celdas[k][3]; i++)
         h += vnCelda(plano, k, i, '<input data-a="' + (i < vals.length ? vals[i] : '') + '">');
     });
     for (var p = 1; p <= plano.celdas.MP[3]; p++) {
       var ini = mp[p] !== undefined ? String(mp[p]) : '';
       if (s.escritas.indexOf(p) >= 0)
         h += vnCelda(plano, 'MP', p - 1, '<input data-a="' + s.mem[p] + '" placeholder="' + ini + '">');
       else
         h += vnCelda(plano, 'MP', p - 1, '<span>' + ini + '</span>');
     }
     h += '</div></div>';
     if (nota) h += '<p><i>' + nota + '</i></p>';
     return h + '<button onclick="vnCorregir(this)">Corregir</button>' +
            '<button onclick="vnSolucion(this)">Solución</button>' +
            '<button onclick="vnLimpiar(this)">Reintentar</button>' +
            '<span class="vn-nota"></span>';
   }

   function vnAzar(a, b) { return a + Math.floor(Math.random() * (b - a + 1)); }

   // programa aleatorio: LOAD x, SUM o REST y, WRITE z, EOF con los datos detrás del programa
   function vnProgramaNuevo() {
     var pos = [5, 6, 7, 8, 9, 10];
     for (var i = pos.length - 1; i > 0; i--) { var j = vnAzar(0, i), t = pos[i]; pos[i] = pos[j]; pos[j] = t; }
     var op = Math.random() < 0.5 ? 'SUM' : 'REST', d1 = vnAzar(1, 50), d2 = vnAzar(1, 50);
     if (op === 'REST' && d2 > d1) { var t2 = d1; d1 = d2; d2 = t2; }   // que la resta no dé negativa
     var mp = { 1: 'LOAD ' + pos[0], 2: op + ' ' + pos[1], 3: 'WRITE ' + pos[2], 4: 'EOF' };
     mp[pos[0]] = d1; mp[pos[1]] = d2;
     return mp;
   }

   function vnNuevo() {
     document.getElementById('vn-azar').innerHTML = vnTarjeta(vnProgramaNuevo(), 7) +
       ' <button onclick="vnNuevo()">Ejercicio nuevo</button>';
   }

   (function () {
     var EJERCICIOS = [
       { mp: { 1: 'LOAD 7', 2: 'SUM 9', 3: 'WRITE 8', 4: 'EOF', 7: 10, 9: 1 } },
       { mp: { 1: 'LOAD 8', 2: 'SUM 7', 3: 'WRITE 6', 4: 'EOF', 7: 10, 8: 45 } },
       { mp: { 1: 'LOAD 7', 2: 'REST 9', 3: 'WRITE 8', 4: 'EOF', 7: 10, 9: 4 } },
       { mp: { 1: 'LOAD 8', 2: 'REST 9', 3: 'WRITE 8', 4: 'LOAD 8', 5: 'SUM 9', 6: 'WRITE 10', 7: 'EOF', 8: 40, 9: 23 },
         nota: 'Fíjate en que WRITE 8 sobrescribe el dato de la posición 8, así que el segundo LOAD 8 ya carga el resultado de la resta. ' +
               'En las posiciones de la MP en las que se escribe aparece en gris el valor que tenían al principio.' },
       { mp: { 1: 'LOAD 11', 2: 'SUM 11', 3: 'WRITE 11', 4: 'LOAD 11', 5: 'SUM 11', 6: 'WRITE 11',
               7: 'LOAD 11', 8: 'SUM 11', 9: 'WRITE 11', 10: 'EOF', 11: 1 },
         nota: 'Este programa es más largo, así que la hoja tiene más casillas: la MP llega hasta la posición 11 y las columnas son más largas.' },
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
     vnSimuladorDibuja({ 1: 'LOAD 5', 2: 'SUM 6', 3: 'WRITE 8', 4: 'EOF', 5: 10, 6: 20 }, null);
   })();

   // dibuja el simulador; si se le pasa el resultado de una ejecución (s), escribe los valores de los registros
   function vnSimuladorDibuja(mp, s) {
     var tam = vnTamanos(mp, s); tam.MP = Math.max(12, tam.MP);
     var plano = vnPlano(tam);
     var h = '<p class="vn-enunciado">8. Simulador: escribe tu propio programa en la memoria principal (MP) y pulsa ' +
             '<b>Ejecutar</b> para ver todos los valores que toman los registros.</p>' +
             '<p>Puedes usar LOAD x, SUM x, REST x, WRITE x y EOF (x es una posición de 1 a 12), y números en las posiciones de datos. ' +
             'El programa empieza en la posición 1 y tiene que terminar con EOF. Si hace falta, la hoja se alarga.</p>';
     h += '<div class="vn-scroll"><div class="vn-hoja" style="width:851px;height:' + plano.alto + 'px">' + plano.svg;
     VN_REGS.forEach(function (k) {
       for (var i = 0; i < plano.celdas[k][3]; i++) {
         var v = s && i < s.reg[k].length ? s.reg[k][i] : '';
         h += vnCelda(plano, k, i, '<span class="vn-sim">' + v + '</span>');
       }
     });
     for (var p = 1; p <= plano.celdas.MP[3]; p++) {
       var v = s && s.escritas.indexOf(p) >= 0 ? s.mem[p] : (mp[p] !== undefined ? mp[p] : '');
       var cls = s && s.escritas.indexOf(p) >= 0 ? 'vn-mp-in vn-ok' : 'vn-mp-in';
       h += vnCelda(plano, 'MP', p - 1, '<input class="' + cls + '" data-p="' + p + '" value="' + v + '">');
     }
     h += '</div></div>';
     h += '<button onclick="vnEjecutar()">Ejecutar</button>' +
          '<button onclick="vnSimuladorDibuja({}, null)">Borrar la memoria</button>' +
          '<span class="vn-nota" id="vn-sim-msg"></span>';
     document.getElementById('vn-simulador').innerHTML = h;
   }

   function vnEjecutar() {
     var card = document.getElementById('vn-simulador');
     var mp = {}, error = '', malPos = 0;
     card.querySelectorAll('.vn-mp-in').forEach(function (inp) {
       var v = inp.value.trim().toUpperCase().replace(/\s+/g, ' ').replace(/^(LOAD|SUM|REST|WRITE)(\d)/, '$1 $2');
       if (v !== '') mp[inp.dataset.p] = /^-?\d+$/.test(v) ? +v : v;
     });
     var maxPos = card.querySelectorAll('.vn-mp-in').length;
     for (var cp = 1; cp <= maxPos; cp++) {
       var ins = mp[cp];
       if (ins === 'EOF') break;
       var m = /^(LOAD|SUM|REST|WRITE) (\d+)$/.exec(String(ins));
       if (!m) { error = 'En la posición ' + cp + ' tiene que haber una instrucción (LOAD x, SUM x, REST x, WRITE x o EOF), y hay «' + (ins === undefined ? '' : ins) + '».'; malPos = cp; break; }
       if (+m[2] < 1 || +m[2] > maxPos) { error = 'La posición ' + m[2] + ' de la instrucción ' + cp + ' no existe: tiene que estar entre 1 y ' + maxPos + '.'; malPos = cp; break; }
     }
     if (!error && cp > maxPos) error = 'Falta EOF: el programa tiene que terminar con EOF.';
     if (!error) {
       var s = vnSimula(mp);
       if (s.reg.RIM.some(function (v) { return typeof v === 'number' && isNaN(v); }))
         error = 'El programa lee una posición que no contiene un número.';
     }
     if (error) {
       vnSimuladorDibuja(mp, null);
       var mal = document.querySelector('#vn-simulador .vn-mp-in[data-p="' + malPos + '"]');
       if (mal) mal.className = 'vn-mp-in vn-mal';
       document.getElementById('vn-sim-msg').textContent = error;
       return;
     }
     vnSimuladorDibuja(mp, s);
     document.getElementById('vn-sim-msg').textContent = 'Programa ejecutado. En verde, las posiciones de la MP en las que se ha escrito.';
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
