********************************
Cuestionario gestión de memoria
********************************

.. cuestionario::

   1. Responde:
      - 1. ¿Un 1GB de memoria RAM es más caro que 1GB de disco duro?
        (x) Sí
        ( ) No
      - 2. ¿Qué sistema de particiones favorece más la fragmentación interna, las fijas o las dinámicas?
        (x) Fijas
        ( ) Dinámicas
      - 3. Fíjate en la siguiente tabla de páginas: un proceso quiere acceder a la dirección D0000, ¿está en la memoria principal o en la memoria secundaria?
        tabla: Tabla de páginas
           | Dir. virtual | Bit de presencia | Dir. física |
           | 10000 | 1 | 10000 |
           | 20000 | 0 | 10000 |
           | 30000 | 1 | 40000 |
           | 80000 | 1 | 60000 |
           | D0000 | 0 | 60000 |
        (x) En la memoria secundaria
        ( ) En la memoria principal
      - 4. Fíjate en la tabla de páginas anterior: un proceso quiere acceder a la dirección 30000, ¿está en la memoria principal o en la memoria secundaria?
        ( ) En la memoria secundaria
        (x) En la memoria principal
      - 5. Fíjate en la siguiente memoria virtual y rellena la tabla de páginas:
        imagen: imagenes/memoria_virtual_quiz.png 340
        tabla:
           | Dir. virtual | Bit de presencia | Dir. física |
           | 10000 | 0 | [10000] |
           | 20000 | 0 | [20000] |
           | 30000 | [1] | 40000 |
           | [80000] | 1 | [10000] |
           | [D0000] | [0] | [50000] |
      - 6. ¿Qué algoritmo de reemplazo puede dar más fallos al aumentar el número de marcos (anomalía de Belady)?
        (x) FIFO
        ( ) LRU
        ( ) Óptimo

.. raw:: html

   <style>
   .qm-plan { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qm-plan p.qm-enunciado { font-weight: bold; margin-top: 0; }
   .qm-plan p.qm-sub { font-weight: bold; margin: 1em 0 .3em 0; }
   .qm-plan table { border-collapse: collapse; margin: .4em 0; }
   .qm-plan th, .qm-plan td { border: 1px solid rgba(128,128,128,.5); padding: 3px 5px; text-align: center; }
   .qm-plan th { white-space: nowrap; }
   .qm-plan input { width: 2em; padding: 2px 2px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit;
                    font-family: monospace; text-align: center; }
   .qm-plan input.qm-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qm-plan input.qm-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qm-plan button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qm-plan button:hover { background: rgba(128,128,128,.15); }
   .qm-nota { margin-left: .4em; font-weight: bold; }
   .qm-scroll { overflow-x: auto; }
   </style>

   <p>En las tablas escribe en cada marco el número de la página que hay en él (o <b>deja la casilla en blanco</b> si
      el marco está libre) y en la fila <b>Fallo</b> escribe <b>F</b> si hay fallo de página o déjala en blanco si no.
      Los fallos de los marcos vacíos del principio también cuentan. Una página nueva ocupa el primer marco libre
      o, si no hay ninguno, el marco de la página que sale. En <b>Óptimo</b>, si hay empate, sale la que lleva más
      tiempo en memoria.</p>

   <div id="qm-ejercicios"></div>

   <script>
   // simulación de FIFO, LRU y Óptimo; devuelve el contenido de los marcos y los fallos en cada instante
   function qmSimula(ref, n, alg) {
     var marcos = [], carga = {}, uso = {}, cols = [], fallos = 0;
     for (var k = 0; k < n; k++) marcos.push(null);
     ref.forEach(function (p, t) {
       var fallo = marcos.indexOf(p) < 0, sale = null;
       if (fallo) {
         fallos++;
         var i = marcos.indexOf(null);
         if (i < 0) {
           var peor = null, clave = null;
           marcos.forEach(function (q) {
             var c;
             if (alg === 'FIFO') c = [-carga[q], 0];
             else if (alg === 'LRU') c = [-uso[q], 0];
             else { var f = ref.indexOf(q, t + 1); c = [f < 0 ? 999 : f, -carga[q]]; }
             if (clave === null || c[0] > clave[0] || (c[0] === clave[0] && c[1] > clave[1])) { peor = q; clave = c; }
           });
           sale = peor; i = marcos.indexOf(peor);
         }
         marcos[i] = p; carga[p] = t;
       }
       uso[p] = t;
       cols.push({ marcos: marcos.slice(), fallo: fallo, sale: sale });
     });
     return { cols: cols, fallos: fallos };
   }

   // contenido de una tarjeta de reemplazo de páginas: enunciado y una tabla por algoritmo
   function qmTarjeta(ej, num) {
     var NOMBRE = { FIFO: 'FIFO', LRU: 'LRU', OPT: 'Óptimo' };
     var h = '<p class="qm-enunciado">' + num + '. Un proceso pide las siguientes páginas: ' +
             ej.ref.join(',') + '. Los marcos están inicialmente vacíos. Rellena las tablas con ' +
             ej.marcos.join(' y con ') + ' marcos.</p>';
     ej.marcos.forEach(function (n) {
       ['FIFO', 'LRU', 'OPT'].forEach(function (alg) {
         var r = qmSimula(ej.ref, n, alg);
         h += '<p class="qm-sub">' + NOMBRE[alg] + ' con ' + n + ' marcos</p><div class="qm-scroll"><table>';
         h += '<tr><th>Referencia</th>';
         ej.ref.forEach(function (p) { h += '<th>' + p + '</th>'; });
         h += '</tr>';
         for (var k = 0; k < n; k++) {
           h += '<tr><th>Marco ' + (k + 1) + '</th>';
           r.cols.forEach(function (c) {
             var a = c.marcos[k] === null ? '' : c.marcos[k];
             h += '<td><input maxlength="2" data-a="' + a + '"></td>';
           });
           h += '</tr>';
         }
         h += '<tr><th>Fallo</th>';
         r.cols.forEach(function (c) { h += '<td><input maxlength="1" data-a="' + (c.fallo ? 'F' : '') + '"></td>'; });
         h += '</tr></table></div>';
         h += 'Número de fallos: <input maxlength="2" data-a="' + r.fallos + '">';
       });
     });
     if (ej.nota) h += '<p><i>' + ej.nota + '</i></p>';
     return h + qmBotones();
   }

   function qmBotones() {
     return '<br><button onclick="qmCorregir(this)">Corregir</button>' +
            '<button onclick="qmSolucion(this)">Solución</button>' +
            '<button onclick="qmLimpiar(this)">Reintentar</button>' +
            '<span class="qm-nota"></span>';
   }

   function qmAzar(a, b) { return a + Math.floor(Math.random() * (b - a + 1)); }

   // cadena aleatoria de 12 referencias (páginas 0-5) en la que FIFO, LRU y Óptimo dan distinto número de fallos
   function qmCadenaNueva() {
     while (true) {
       var ref = [qmAzar(0, 5)];
       while (ref.length < 12) {
         var p = qmAzar(0, 5);
         if (p !== ref[ref.length - 1]) ref.push(p);
       }
       var f = ['FIFO', 'LRU', 'OPT'].map(function (a) { return qmSimula(ref, 3, a).fallos; });
       if (f[0] !== f[1] && f[0] !== f[2] && f[1] !== f[2]) return ref;
     }
   }

   function qmNuevoMarcos() {
     var card = document.getElementById('qm-marcos-azar');
     card.innerHTML = qmTarjeta({ ref: qmCadenaNueva(), marcos: [3] }, 5) +
       ' <button onclick="qmNuevoMarcos()">Ejercicio nuevo</button>';
   }

   (function () {
     var EJERCICIOS = [
       { ref: [7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3], marcos: [3] },
       { ref: [5, 1, 0, 3, 2, 3, 1, 5, 3, 4, 1, 3], marcos: [3] },
       { ref: [3, 1, 4, 2, 3, 1, 5, 3, 2, 1, 4, 2, 5], marcos: [3, 4],
         nota: 'Compara los fallos con 3 y con 4 marcos: ¿qué algoritmo empeora al tener más marcos?' },
     ];
     var cont = document.getElementById('qm-ejercicios');
     EJERCICIOS.forEach(function (ej, num) {
       var card = document.createElement('div');
       card.className = 'qp-card qm-plan';
       card.innerHTML = qmTarjeta(ej, num + 2);
       cont.appendChild(card);
     });
     // ejercicio 5: cadena aleatoria, cambia con el botón "Ejercicio nuevo"
     var card = document.createElement('div');
     card.className = 'qp-card qm-plan';
     card.id = 'qm-marcos-azar';
     cont.appendChild(card);
     qmNuevoMarcos();
   })();

   // las respuestas pueden tener alternativas separadas por | y se comparan sin espacios ni mayúsculas
   function qmIgual(valor, esperado) {
     var v = valor.replace(/\s+/g, '').toUpperCase();
     return esperado.split('|').some(function (alt) { return v === alt.replace(/\s+/g, '').toUpperCase(); });
   }
   function qmCorregir(btn) {
     var card = btn.closest('.qm-plan'), inputs = card.querySelectorAll('input[data-a]'), aciertos = 0;
     inputs.forEach(function (inp) {
       var ok = qmIgual(inp.value, inp.dataset.a);
       inp.className = ok ? 'qm-ok' : 'qm-mal';
       if (ok) aciertos++;
     });
     card.querySelector('.qm-nota').textContent = aciertos + ' / ' + inputs.length;
   }
   function qmSolucion(btn) {
     var card = btn.closest('.qm-plan');
     card.querySelectorAll('input[data-a]').forEach(function (inp) { inp.value = inp.dataset.a.split('|')[0]; inp.className = 'qm-ok'; });
     card.querySelector('.qm-nota').textContent = 'Solución';
   }
   function qmLimpiar(btn) {
     var card = btn.closest('.qm-plan');
     card.querySelectorAll('input[data-a]').forEach(function (inp) { inp.value = ''; inp.className = ''; });
     card.querySelector('.qm-nota').textContent = '';
   }
   </script>

.. cuestionario::

   6. En la cola se han almacenado, por orden de llegada, las siguientes peticiones de pistas: **20,32,50,2,95**. Inicialmente la cabeza de lectura/escritura está en la **pista 49** y el disco tiene las **pistas de 0 a 99**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,... Fíjate en el rango de pistas del disco de cada ejercicio. En SCAN y C-SCAN la cabeza llega hasta el extremo del disco, y el salto de vuelta de C-SCAN cuenta en el total.
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [20,32,50,2,95] Total de pistas recorridas: [200]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [50,32,20,2,95] Total de pistas recorridas: [142]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero sube hasta el final"
        [50,95,32,20,2|50,95,99,32,20,2] Total de pistas recorridas: [147]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero sube, llega al final, salta al principio y va leyendo subiendo"
        [50,95,2,20,32|50,95,99,0,2,20,32] Total de pistas recorridas: [181]

   7. En la cola se han almacenado, por orden de llegada, las siguientes peticiones de pistas: **20,8,5,18,13**. Inicialmente la cabeza de lectura/escritura está en la **pista 17** y el disco tiene las **pistas de 0 a 99**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,... Fíjate en el rango de pistas del disco de cada ejercicio. En SCAN y C-SCAN la cabeza llega hasta el extremo del disco, y el salto de vuelta de C-SCAN cuenta en el total.
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [20,8,5,18,13] Total de pistas recorridas: [36]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [18,20,13,8,5] Total de pistas recorridas: [18]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero baja hasta el principio"
        [13,8,5,18,20|13,8,5,0,18,20] Total de pistas recorridas: [37]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero baja, llega al principio, salta al final y va leyendo bajando"
        [13,8,5,20,18|13,8,5,0,99,20,18] Total de pistas recorridas: [197]
      - 5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)?
        [SSTF]

   8. En la cola se han almacenado, por orden de llegada, las siguientes peticiones de pistas: **10,70,45,90,25**. Inicialmente la cabeza de lectura/escritura está en la **pista 40** y el disco tiene las **pistas de 0 a 99**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,... Fíjate en el rango de pistas del disco de cada ejercicio. En SCAN y C-SCAN la cabeza llega hasta el extremo del disco, y el salto de vuelta de C-SCAN cuenta en el total.
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [10,70,45,90,25] Total de pistas recorridas: [225]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [45,25,10,70,90] Total de pistas recorridas: [120]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero sube hasta el final"
        [45,70,90,25,10|45,70,90,99,25,10] Total de pistas recorridas: [148]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero sube, llega al final, salta al principio y va leyendo subiendo"
        [45,70,90,10,25|45,70,90,99,0,10,25] Total de pistas recorridas: [183]
      - 5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)?
        [SSTF]

   9. En la cola se han almacenado, por orden de llegada, las siguientes peticiones de pistas: **20,35,8,28,4**. Inicialmente la cabeza de lectura/escritura está en la **pista 18** y el disco tiene las **pistas de 0 a 99**.
      | Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,... Fíjate en el rango de pistas del disco de cada ejercicio. En SCAN y C-SCAN la cabeza llega hasta el extremo del disco, y el salto de vuelta de C-SCAN cuenta en el total.
      - 1. ¿Cómo atendería las peticiones con FIFO?
        [20,35,8,28,4] Total de pistas recorridas: [88]
      - 2. ¿Cómo atendería las peticiones con SSTF?
        [20,28,35,8,4] Total de pistas recorridas: [48]
      - 3. ¿Cómo atendería las peticiones con SCAN? "primero baja hasta el principio"
        [8,4,20,28,35|8,4,0,20,28,35] Total de pistas recorridas: [53]
      - 4. ¿Cómo atendería las peticiones con C-SCAN? "primero baja, llega al principio, salta al final y va leyendo bajando"
        [8,4,35,28,20|8,4,0,99,35,28,20] Total de pistas recorridas: [196]
      - 5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)?
        [SSTF]

.. raw:: html

   <div class="qp-card qm-plan" id="qm-disco-azar"></div>

   <script>
   // planificación del disco (pistas 0-99): devuelve la secuencia recorrida, incluidos los extremos, y el total
   function qmDisco(cabeza, peticiones, alg, sube) {
     var ULTIMA = 99, seq = [];
     if (alg === 'FIFO') seq = peticiones.slice();
     else if (alg === 'SSTF') {
       var pend = peticiones.slice(), pos = cabeza;
       while (pend.length) {
         var mejor = 0;
         for (var k = 1; k < pend.length; k++)
           if (Math.abs(pend[k] - pos) < Math.abs(pend[mejor] - pos)) mejor = k;
         pos = pend.splice(mejor, 1)[0]; seq.push(pos);
       }
     } else {
       var arriba = peticiones.filter(function (p) { return p > cabeza; }).sort(function (a, b) { return a - b; });
       var abajo = peticiones.filter(function (p) { return p < cabeza; }).sort(function (a, b) { return b - a; });
       if (alg === 'SCAN')
         seq = sube ? arriba.concat([ULTIMA], abajo) : abajo.concat([0], arriba);
       else  // C-SCAN: llega al extremo, salta al otro y sigue en el mismo sentido
         seq = sube ? arriba.concat([ULTIMA, 0], abajo.slice().reverse())
                    : abajo.concat([0, ULTIMA], arriba.slice().reverse());
     }
     var total = 0, pos = cabeza;
     seq.forEach(function (p) { total += Math.abs(p - pos); pos = p; });
     return { seq: seq, total: total };
   }

   // datos aleatorios sin ambigüedades: peticiones a los dos lados, sin empates en SSTF y un único algoritmo más rápido
   function qmDiscoNuevo() {
     while (true) {
       var cabeza = qmAzar(10, 89), pet = [];
       while (pet.length < 5) {
         var p = qmAzar(1, 98);
         if (p !== cabeza && pet.indexOf(p) < 0) pet.push(p);
       }
       if (!pet.some(function (p) { return p > cabeza; }) || !pet.some(function (p) { return p < cabeza; })) continue;
       var pend = pet.slice(), pos = cabeza, empate = false;
       while (pend.length) {
         var d = pend.map(function (q) { return Math.abs(q - pos); }), m = Math.min.apply(null, d);
         if (d.filter(function (x) { return x === m; }).length > 1) { empate = true; break; }
         pos = pend.splice(d.indexOf(m), 1)[0];
       }
       if (empate) continue;
       var sube = Math.random() < 0.5;
       var tot = ['FIFO', 'SSTF', 'SCAN', 'C-SCAN'].map(function (a) { return qmDisco(cabeza, pet, a, sube).total; });
       var min = Math.min.apply(null, tot);
       if (tot.filter(function (t) { return t === min; }).length > 1) continue;
       return { cabeza: cabeza, pet: pet, sube: sube };
     }
   }

   function qmNuevoDisco() {
     var ej = qmDiscoNuevo(), ALGS = ['FIFO', 'SSTF', 'SCAN', 'C-SCAN'];
     var h = '<p class="qm-enunciado">10. En la cola se han almacenado, por orden de llegada, las siguientes peticiones de pistas: ' +
             ej.pet.join(',') + '. Inicialmente la cabeza de lectura/escritura está en la pista ' + ej.cabeza +
             ' y el disco tiene las pistas de 0 a 99. En SCAN y C-SCAN la cabeza primero <b>' +
             (ej.sube ? 'sube' : 'baja') + '</b>.</p>' +
             '<p>Responde con las pistas separadas por coma y sin espacios, por ejemplo: 20,32,... ' +
             'En SCAN y C-SCAN la cabeza llega hasta el extremo del disco (puedes escribir el extremo o no), ' +
             'y el salto de vuelta de C-SCAN cuenta en el total.</p>';
     var totales = [];
     ALGS.forEach(function (alg, i) {
       var r = qmDisco(ej.cabeza, ej.pet, alg, ej.sube);
       var sinExtremos = r.seq.filter(function (p) { return ej.pet.indexOf(p) >= 0; }).join(',');
       var conExtremos = r.seq.join(',');
       var alt = sinExtremos === conExtremos ? sinExtremos : sinExtremos + '|' + conExtremos;
       totales.push(r.total);
       h += '<p>' + (i + 1) + '. ¿Cómo atendería las peticiones con ' + alg + '?<br>' +
            '<input style="width:14em" data-a="' + alt + '"> Total de pistas recorridas: ' +
            '<input style="width:3em" data-a="' + r.total + '"></p>';
     });
     var mejor = ALGS[totales.indexOf(Math.min.apply(null, totales))];
     h += '<p>5. ¿Cuál sería el algoritmo más rápido en atender las peticiones (FIFO, SSTF, SCAN o C-SCAN)? ' +
          '<input style="width:5em" data-a="' + mejor + '"></p>';
     document.getElementById('qm-disco-azar').innerHTML = h + qmBotones() +
       ' <button onclick="qmNuevoDisco()">Ejercicio nuevo</button>';
   }
   qmNuevoDisco();
   </script>
