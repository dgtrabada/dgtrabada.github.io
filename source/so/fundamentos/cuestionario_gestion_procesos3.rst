************************************************************
Cuestionario gestión de procesos: ejercicios aleatorios
************************************************************

Cada vez que pulses **Ejercicio nuevo** se genera un ejercicio distinto, con procesos, tiempos de llegada y tiempos de ejecución al azar. Resuélvelo en papel o en las tablas y pulsa **Corregir** para comprobarlo, o **Solución** para ver cómo queda.

.. raw:: html

   <style>
   .qp-plan { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-plan p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-plan p.qp-sub { font-weight: bold; margin: 1em 0 .3em 0; }
   .qp-plan table { border-collapse: collapse; margin: .4em 0; }
   .qp-plan th, .qp-plan td { border: 1px solid rgba(128,128,128,.5); padding: 3px 7px; text-align: center; }
   .qp-plan input { width: 2.6em; padding: 2px 2px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit;
                    font-family: monospace; text-align: center; }
   .qp-plan input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-plan input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-plan button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-plan button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   .qp-scroll { overflow-x: auto; }
   button.qp-nuevo { margin: .4em 0; padding: 6px 16px; border-radius: 5px; font-weight: bold;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   button.qp-nuevo:hover { background: rgba(128,128,128,.15); }
   </style>

   <p>Leyenda: <b>T<sub>i</sub></b> tiempo de llegada, <b>T<sub>x</sub></b> tiempo de ejecución,
      <b>T<sub>E</sub></b> tiempo de espera, <b>T<sub>R</sub></b> tiempo de retorno (T<sub>R</sub> = T<sub>E</sub> + T<sub>x</sub>).
      En las tablas escribe <b>x</b> (ejecutándose), <b>-</b> (en espera) o
      <b>deja la casilla en blanco</b> (el proceso no ha llegado o ya ha terminado).</p>
   <p>En <b>RR</b>, si un proceso llega justo en el instante en que otro agota su quantum,
      el que llega se pone delante en la cola y el que sale del quantum detrás.
      En <b>SJF</b>, si dos procesos necesitan el mismo tiempo, va primero el que llegó antes.
      En las filas de la <b>cola de listos</b> escribe, en cada instante, los procesos que esperan
      en la cola (P1, P2...) empezando por el primero; el que se está ejecutando no está en la cola.</p>

   <button class="qp-nuevo" onclick="qpgNuevo()">Ejercicio nuevo</button>
   <div id="qp-ejercicios"></div>

   <script>
   // simulación de FIFO, SJF y RR (q=2) en 10 instantes
   function qpgSimula(procs, alg, q) {
     var n = procs.length, rest = {}, lleg = {}, fin = {}, cola = [], run = null, usado = 0;
     var grid = {}, colas = [], orden = procs.map(function (p) { return p[0]; });
     procs.forEach(function (p) { rest[p[0]] = p[2]; lleg[p[0]] = p[1]; grid[p[0]] = ''; });
     for (var t = 0; t < 10; t++) {
       var nuevos = orden.filter(function (p) { return lleg[p] === t; });
       var expulsado = null;
       if (run !== null && alg === 'RR' && usado === q && rest[run] > 0) { expulsado = run; run = null; }
       cola = cola.concat(nuevos);              // el que llega va delante...
       if (expulsado !== null) cola.push(expulsado);  // ...y el que agota el quantum detrás
       if (run === null && cola.length) {
         if (alg === 'SJF') {
           var mejor = 0;
           for (var k = 1; k < cola.length; k++)
             if (rest[cola[k]] < rest[cola[mejor]] ||
                 (rest[cola[k]] === rest[cola[mejor]] && lleg[cola[k]] < lleg[cola[mejor]])) mejor = k;
           run = cola.splice(mejor, 1)[0];
         } else run = cola.shift();
         usado = 0;
       }
       orden.forEach(function (p) {
         grid[p] += p === run ? 'x' : (lleg[p] <= t && !(p in fin) ? '-' : 'B');
       });
       colas.push(cola.slice());
       if (run !== null) {
         rest[run]--; usado++;
         if (rest[run] === 0) { fin[run] = t + 1; run = null; }
       }
     }
     if (Object.keys(fin).length < n) return null;   // no cabe en 10 instantes
     var tetr = procs.map(function (p) { var tr = fin[p[0]] - p[1]; return [tr - p[2], tr]; });
     var total = [0, 0];
     tetr.forEach(function (x) { total[0] += x[0]; total[1] += x[1]; });
     var alg_ = { nombre: alg === 'RR' ? 'RR (q=' + q + ')' : alg,
                  grid: orden.map(function (p) { return grid[p]; }), tetr: tetr, total: total };
     if (alg === 'RR') {
       var mx = Math.max.apply(null, colas.map(function (c) { return c.length; }));
       alg_.cola = [];
       for (var f = 0; f < mx; f++)
         alg_.cola.push(colas.map(function (c) { return f < c.length ? c[f] : 'B'; }));
     }
     return alg_;
   }

   function qpgAzar(a, b) { return a + Math.floor(Math.random() * (b - a + 1)); }

   function qpgGenera() {
     for (;;) {
       var n = qpgAzar(3, 4), llegadas = [0];
       while (llegadas.length < n) {
         var t = qpgAzar(1, 6);
         if (llegadas.indexOf(t) < 0) llegadas.push(t);
       }
       // los nombres P1, P2... no van en orden de llegada, como en los ejercicios de clase
       llegadas.sort(function () { return Math.random() - 0.5; });
       var procs = llegadas.map(function (t, i) { return ['P' + (i + 1), t, qpgAzar(1, 4)]; });
       var suma = procs.reduce(function (s, p) { return s + p[2]; }, 0);
       if (suma < 7 || suma > 10) continue;
       var algs = [qpgSimula(procs, 'FIFO', 2), qpgSimula(procs, 'SJF', 2), qpgSimula(procs, 'RR', 2)];
       if (algs.some(function (a) { return a === null; })) continue;
       // que la CPU no se quede parada, que haya esperas y que cada algoritmo dé un resultado distinto
       var parada = false;
       for (var t2 = 0; t2 < suma; t2++)
         if (!algs[0].grid.some(function (f) { return f[t2] === 'x'; })) parada = true;
       if (parada || algs[0].total[0] < 3) continue;
       var g = algs.map(function (a) { return a.grid.join(); });
       if (g[0] === g[1] || g[0] === g[2] || g[1] === g[2]) continue;
       return { procesos: procs, algoritmos: algs };
     }
   }

   function qpgDibuja(ej, n, cont) {
       var card = document.createElement('div');
       card.className = 'qp-card qp-plan';
       var h = '<p class="qp-enunciado">' + (n + 1) + '. Tenemos los siguientes procesos:</p>';
       h += '<table><tr><th>Proceso</th><th>T<sub>i</sub></th><th>T<sub>x</sub></th></tr>';
       ej.procesos.forEach(function (p) {
         h += '<tr><td><b>' + p[0] + '</b></td><td>' + p[1] + '</td><td>' + p[2] + '</td></tr>';
       });
       h += '</table>';
       ej.algoritmos.forEach(function (alg) {
         h += '<p class="qp-sub">Algoritmo ' + alg.nombre + '</p>';
         h += '<div class="qp-scroll"><table><tr><th>Procesos</th>';
         for (var t = 0; t < 10; t++) h += '<th>' + t + '</th>';
         h += '</tr>';
         alg.grid.forEach(function (fila, i) {
           h += '<tr><td><b>' + ej.procesos[i][0] + '</b></td>';
           for (var t = 0; t < 10; t++) {
             var esp = fila[t] === 'B' ? '' : fila[t];
             h += '<td><input maxlength="1" data-a="' + esp + '"></td>';
           }
           h += '</tr>';
         });
         if (alg.cola) {
           h += '<tr><td rowspan="' + alg.cola.length + '"><b>Cola de<br>listos</b></td>';
           alg.cola.forEach(function (fila, i) {
             if (i > 0) h += '<tr>';
             fila.forEach(function (c) {
               var esp = c === 'B' ? '' : c;
               h += '<td><input maxlength="2" style="width:3em" data-a="' + esp + '"></td>';
             });
             h += '</tr>';
           });
         }
         h += '</table></div>';
         h += 'Finalmente queda:';
         h += '<table><tr><th>Proceso</th><th>T<sub>E</sub></th><th>T<sub>R</sub></th></tr>';
         alg.tetr.forEach(function (par, i) {
           h += '<tr><td><b>' + ej.procesos[i][0] + '</b></td>' +
                '<td><input maxlength="2" data-a="' + par[0] + '"></td>' +
                '<td><input maxlength="2" data-a="' + par[1] + '"></td></tr>';
         });
         h += '<tr><td><b>TOTAL (SUMA)</b></td>' +
              '<td><input maxlength="3" data-a="' + alg.total[0] + '"></td>' +
              '<td><input maxlength="3" data-a="' + alg.total[1] + '"></td></tr>';
         h += '</table>';
       });
       h += '<button onclick="qpgCorregir(this)">Corregir</button>' +
            '<button onclick="qpgSolucion(this)">Solución</button>' +
            '<button onclick="qpgLimpiar(this)">Reintentar</button>' +
            '<span class="qp-nota"></span>';
       card.innerHTML = h;
       cont.appendChild(card);
   }

   function qpgNuevo() {
     var cont = document.getElementById('qp-ejercicios');
     cont.innerHTML = '';
     qpgDibuja(qpgGenera(), 0, cont);
   }
   qpgNuevo();

   function qpgCorregir(btn) {
     var card = btn.closest('.qp-plan');
     var inputs = card.querySelectorAll('input[data-a]');
     var aciertos = 0;
     inputs.forEach(function (inp) {
       var ok = inp.value.trim().toLowerCase() === inp.dataset.a.toLowerCase();
       inp.className = ok ? 'qp-ok' : 'qp-mal';
       if (ok) aciertos++;
     });
     card.querySelector('.qp-nota').textContent = aciertos + ' / ' + inputs.length;
   }
   function qpgSolucion(btn) {
     var card = btn.closest('.qp-plan');
     card.querySelectorAll('input[data-a]').forEach(function (inp) {
       inp.value = inp.dataset.a;
       inp.className = 'qp-ok';
     });
     card.querySelector('.qp-nota').textContent = 'Solución';
   }
   function qpgLimpiar(btn) {
     var card = btn.closest('.qp-plan');
     card.querySelectorAll('input[data-a]').forEach(function (inp) {
       inp.value = '';
       inp.className = '';
     });
     card.querySelector('.qp-nota').textContent = '';
   }
   </script>
