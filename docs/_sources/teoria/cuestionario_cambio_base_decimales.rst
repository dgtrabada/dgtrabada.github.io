*****************************************
Cuestionario cambio de base con decimales
*****************************************

.. raw:: html

   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-card { counter-reset: fila; }
   .qp-card table { border-collapse: collapse; }
   .qp-card table tr td:first-child::before { counter-increment: fila; content: counter(fila) ". "; }
   .qp-card td { padding: 2px 6px; border: none; }
   .qp-card input { width: 11em; max-width: 100%; padding: 2px 6px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit; font-family: monospace; }
   .qp-card input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   </style>

   <div class="qp-card">
     <p class="qp-enunciado">1. Cambios de base con decimales.<br>
        Ayuda: 1/16 = 0.0625 ; 1/32 = 0.03125</p>
     <table>
       <tr><td>Escribe 10,125<sub>10)</sub> en base 2 =</td><td><input data-a="1010.001"> <sub>2)</sub></td></tr>
       <tr><td>Escribe A.A8<sub>16)</sub> en base 10 =</td><td><input data-a="10.65625"> <sub>10)</sub></td></tr>
       <tr><td>Escribe A.08<sub>16)</sub> en base 10 =</td><td><input data-a="10.03125"> <sub>10)</sub></td></tr>
       <tr><td>Escribe EF3.1<sub>16)</sub> en base 10 =</td><td><input data-a="3827.0625"> <sub>10)</sub></td></tr>
       <tr><td>Escribe 14.0F<sub>16)</sub> en base 2 =</td><td><input data-a="10100.00001111"> <sub>2)</sub></td></tr>
       <tr><td>Escribe 125<sub>10)</sub> en base 4 =</td><td><input data-a="1331"> <sub>4)</sub></td></tr>
       <tr><td>Escribe 6,75<sub>10)</sub> en base 2 =</td><td><input data-a="110.11"> <sub>2)</sub></td></tr>
       <tr><td>Escribe 5,375<sub>10)</sub> en base 2 =</td><td><input data-a="101.011"> <sub>2)</sub></td></tr>
       <tr><td>Escribe 13,3125<sub>10)</sub> en base 2 =</td><td><input data-a="1101.0101"> <sub>2)</sub></td></tr>
       <tr><td>Escribe 12,0625<sub>10)</sub> en base 2 =</td><td><input data-a="1100.0001"> <sub>2)</sub></td></tr>
       <tr><td>Escribe 2,25<sub>10)</sub> en base 4 =</td><td><input data-a="2.1"> <sub>4)</sub></td></tr>
       <tr><td>Escribe 0,625<sub>10)</sub> en base 8 =</td><td><input data-a="0.5"> <sub>8)</sub></td></tr>
       <tr><td>Escribe 7,5<sub>10)</sub> en base 16 =</td><td><input data-a="7.8"> <sub>16)</sub></td></tr>
       <tr><td>Escribe B.4<sub>16)</sub> en base 10 =</td><td><input data-a="11.25"> <sub>10)</sub></td></tr>
       <tr><td>Escribe 3.C<sub>16)</sub> en base 10 =</td><td><input data-a="3.75"> <sub>10)</sub></td></tr>
       <tr><td>Escribe 1F.8<sub>16)</sub> en base 10 =</td><td><input data-a="31.5"> <sub>10)</sub></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">2. Utilizando agrupaciones pasar:</p>
     <table>
       <tr><td>1010,10101<sub>2)</sub> a octal =</td><td><input data-a="12.52"> <sub>8)</sub></td></tr>
       <tr><td>1010,10101<sub>2)</sub> a hexadecimal =</td><td><input data-a="A.A8"> <sub>16)</sub></td></tr>
       <tr><td>10100.1001<sub>2)</sub> a hexadecimal =</td><td><input data-a="14.9"> <sub>16)</sub></td></tr>
       <tr><td>1101,011<sub>2)</sub> a octal =</td><td><input data-a="15.3"> <sub>8)</sub></td></tr>
       <tr><td>111,111<sub>2)</sub> a octal =</td><td><input data-a="7.7"> <sub>8)</sub></td></tr>
       <tr><td>11011,0101<sub>2)</sub> a hexadecimal =</td><td><input data-a="1B.5"> <sub>16)</sub></td></tr>
       <tr><td>10011.11<sub>2)</sub> a hexadecimal =</td><td><input data-a="13.C"> <sub>16)</sub></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">3. Realiza las siguientes operaciones en binario:</p>
     <table>
       <tr><td>1110110 + 11101 =</td><td><input data-a="10010011"> <sub>2)</sub></td></tr>
       <tr><td>1100 × 1011 =</td><td><input data-a="10000100"> <sub>2)</sub></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <script>
   function qpNorm(s) {
     return s.trim().toLowerCase().replace(/\s+/g, '').replace(',', '.').replace(/\^/g, '**');
   }
   function qpCorregir(btn) {
     var card = btn.closest('.qp-card');
     var inputs = card.querySelectorAll('input[data-a]');
     var aciertos = 0;
     inputs.forEach(function (inp) {
       var valor = qpNorm(inp.value);
       var sinCeros = valor.replace(/^0+(?=.)/, '');
       var ok = inp.dataset.a.split('|').some(function (alt) {
         alt = qpNorm(alt);
         return valor === alt || sinCeros === alt;
       });
       inp.className = ok ? 'qp-ok' : 'qp-mal';
       if (ok) aciertos++;
     });
     card.querySelector('.qp-nota').textContent = aciertos + ' / ' + inputs.length;
   }
   function qpSolucion(btn) {
     var card = btn.closest('.qp-card');
     card.querySelectorAll('input[data-a]').forEach(function (inp) {
       inp.value = inp.dataset.a.split('|')[0];
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
