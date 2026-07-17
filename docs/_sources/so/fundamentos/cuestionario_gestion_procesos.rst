*********************************
Cuestionario gestión de procesos
*********************************

.. raw:: html

   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-card p.qp-sub { font-weight: bold; margin: 1em 0 .3em 0; }
   .qp-card table { border-collapse: collapse; margin: .4em 0; }
   .qp-card th, .qp-card td { border: 1px solid rgba(128,128,128,.5); padding: 3px 7px; text-align: center; }
   .qp-card input { width: 2.6em; padding: 2px 2px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit;
                    font-family: monospace; text-align: center; }
   .qp-card input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   .qp-scroll { overflow-x: auto; }
   </style>

   <p>Leyenda: <b>T<sub>i</sub></b> tiempo de llegada, <b>T<sub>x</sub></b> tiempo de ejecución,
      <b>T<sub>E</sub></b> tiempo de espera, <b>T<sub>R</sub></b> tiempo de respuesta.
      En las tablas escribe <b>x</b> (ejecutándose), <b>-</b> (en espera) o
      <b>deja la casilla en blanco</b> (el proceso no ha llegado o ya ha terminado).</p>

   <div id="qp-ejercicios"></div>

   <script>
   (function () {
     var EJERCICIOS = [
       {
         procesos: [['P1', 1, 4], ['P2', 2, 2], ['P3', 0, 3]],
         algoritmos: [
           { nombre: 'FIFO',
             grid: ['B--xxxxBBB', 'BB-----xxB', 'xxxBBBBBBB'],
             tetr: [[2, 6], [5, 7], [0, 3]], total: [7, 16] },
           { nombre: 'SJF',
             grid: ['B----xxxxB', 'BB-xxBBBBB', 'xxxBBBBBBB'],
             tetr: [[4, 8], [1, 3], [0, 3]], total: [5, 14] },
           { nombre: 'RR (q=2)',
             grid: ['B-xx---xxB', 'BB--xxBBBB', 'xx----xBBB'],
             cola: [['B','P1','P2','P2','P3','P3','P1','B','B','B'],
                    ['B','B','P3','P3','P1','P1','B','B','B','B']],
             tetr: [[4, 8], [2, 4], [4, 7]], total: [10, 19] },
         ]
       },
       {
         procesos: [['P1', 0, 4], ['P2', 1, 3], ['P3', 3, 1], ['P4', 6, 2]],
         algoritmos: [
           { nombre: 'FIFO',
             grid: ['xxxxBBBBBB', 'B---xxxBBB', 'BBB----xBB', 'BBBBBB--xx'],
             tetr: [[0, 4], [3, 6], [4, 5], [2, 4]], total: [9, 19] },
           { nombre: 'SJF',
             grid: ['xxxxBBBBBB', 'B----xxxBB', 'BBB-xBBBBB', 'BBBBBB--xx'],
             tetr: [[0, 4], [4, 7], [1, 2], [2, 4]], total: [7, 17] },
           { nombre: 'RR (q=2)',
             grid: ['xx--xxBBBB', 'B-xx---xBB', 'BBB---xBBB', 'BBBBBB--xx'],
             tetr: [[2, 6], [4, 7], [3, 4], [2, 4]], total: [11, 21] },
         ]
       },
       {
         procesos: [['P1', 2, 2], ['P2', 1, 3], ['P3', 0, 3], ['P4', 5, 1]],
         algoritmos: [
           { nombre: 'FIFO',
             grid: ['BB----xxBB', 'B--xxxBBBB', 'xxxBBBBBBB', 'BBBBB---xB'],
             tetr: [[4, 6], [2, 5], [0, 3], [3, 4]], total: [9, 18] },
           { nombre: 'SJF',
             grid: ['BB-xxBBBBB', 'B-----xxxB', 'xxxBBBBBBB', 'BBBBBxBBBB'],
             tetr: [[1, 3], [5, 8], [0, 3], [0, 1]], total: [6, 15] },
           { nombre: 'RR (q=2)',
             grid: ['BB--xxBBBB', 'B-xx---xBB', 'xx----xBBB', 'BBBBB---xB'],
             tetr: [[2, 4], [4, 7], [4, 7], [3, 4]], total: [13, 22] },
         ]
       },
       {
         procesos: [['P1', 0, 3], ['P2', 2, 4], ['P3', 4, 2], ['P4', 6, 1]],
         algoritmos: [
           { nombre: 'FIFO',
             grid: ['xxxBBBBBBB', 'BB-xxxxBBB', 'BBBB---xxB', 'BBBBBB---x'],
             tetr: [[0, 3], [1, 5], [3, 5], [3, 4]], total: [7, 17] },
           { nombre: 'SJF',
             grid: ['xxxBBBBBBB', 'BB-xxxxBBB', 'BBBB----xx', 'BBBBBB-xBB'],
             tetr: [[0, 3], [1, 5], [4, 6], [1, 2]], total: [6, 16] },
           { nombre: 'RR (q=2)',
             grid: ['xx--xBBBBB', 'BBxx---xxB', 'BBBB-xxBBB', 'BBBBBB---x'],
             tetr: [[2, 5], [3, 7], [1, 3], [3, 4]], total: [9, 19] },
         ]
       },
       {
         procesos: [['P1', 1, 2], ['P2', 0, 4], ['P3', 3, 3], ['P4', 5, 1]],
         algoritmos: [
           { nombre: 'FIFO',
             grid: ['B---xxBBBB', 'xxxxBBBBBB', 'BBB---xxxB', 'BBBBB----x'],
             tetr: [[3, 5], [0, 4], [3, 6], [4, 5]], total: [10, 20] },
           { nombre: 'SJF',
             grid: ['B---xxBBBB', 'xxxxBBBBBB', 'BBB----xxx', 'BBBBB-xBBB'],
             tetr: [[3, 5], [0, 4], [4, 7], [1, 2]], total: [8, 18] },
           { nombre: 'RR (q=2)',
             grid: ['B-xxBBBBBB', 'xx--xxBBBB', 'BBB---xx-x', 'BBBBB---xB'],
             tetr: [[1, 3], [2, 6], [4, 7], [3, 4]], total: [10, 20] },
         ]
       },
       {
         procesos: [['P1', 2, 3], ['P2', 0, 2], ['P3', 1, 4], ['P4', 4, 1]],
         algoritmos: [
           { nombre: 'FIFO',
             grid: ['BB----xxxB', 'xxBBBBBBBB', 'B-xxxxBBBB', 'BBBB-----x'],
             tetr: [[4, 7], [0, 2], [1, 5], [5, 6]], total: [10, 20] },
           { nombre: 'SJF',
             grid: ['BBxxxBBBBB', 'xxBBBBBBBB', 'B-----xxxx', 'BBBB-xBBBB'],
             tetr: [[0, 3], [0, 2], [5, 9], [1, 2]], total: [6, 16] },
           { nombre: 'RR (q=2)',
             grid: ['BB--xx---x', 'xxBBBBBBBB', 'B-xx---xxB', 'BBBB--xBBB'],
             tetr: [[5, 8], [0, 2], [4, 8], [2, 3]], total: [11, 21] },
         ]
       },
     ];

     var cont = document.getElementById('qp-ejercicios');
     EJERCICIOS.forEach(function (ej, n) {
       var card = document.createElement('div');
       card.className = 'qp-card';
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
       h += '<button onclick="qpCorregir(this)">Corregir</button>' +
            '<button onclick="qpSolucion(this)">Solución</button>' +
            '<button onclick="qpLimpiar(this)">Reintentar</button>' +
            '<span class="qp-nota"></span>';
       card.innerHTML = h;
       cont.appendChild(card);
     });
   })();

   function qpCorregir(btn) {
     var card = btn.closest('.qp-card');
     var inputs = card.querySelectorAll('input[data-a]');
     var aciertos = 0;
     inputs.forEach(function (inp) {
       var ok = inp.value.trim().toLowerCase() === inp.dataset.a.toLowerCase();
       inp.className = ok ? 'qp-ok' : 'qp-mal';
       if (ok) aciertos++;
     });
     card.querySelector('.qp-nota').textContent = aciertos + ' / ' + inputs.length;
   }
   function qpSolucion(btn) {
     var card = btn.closest('.qp-card');
     card.querySelectorAll('input[data-a]').forEach(function (inp) {
       inp.value = inp.dataset.a;
       inp.className = 'qp-ok';
     });
     card.querySelector('.qp-nota').textContent = 'Solución';
   }
   function qpLimpiar(btn) {
     var card = btn.closest('.qp-card');
     card.querySelectorAll('input[data-a]').forEach(function (inp) {
       inp.value = '';
       inp.className = '';
     });
     card.querySelector('.qp-nota').textContent = '';
   }
   </script>
