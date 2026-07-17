**************************************
Cuestionario sistemas de codificación
**************************************

.. raw:: html

   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-card table { border-collapse: collapse; }
   .qp-card td { padding: 2px 6px; border: none; }
   .qp-card input { width: 11em; max-width: 100%; padding: 2px 6px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit; font-family: monospace; }
   .qp-card input.qp-l { width: 24em; }
   .qp-card input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   </style>

   <div class="qp-card">
     <p class="qp-enunciado">1. Estándar IEEE 754 de 32 bits:</p>
     <table>
       <tr><td>Escribe -11,625 en IEEE de 32 bits =</td></tr>
       <tr><td><input class="qp-l" data-a="11000001001110100000000000000000"></td></tr>
       <tr><td>Pasar 5,625 al estándar IEEE 754 de 32 bits =</td></tr>
       <tr><td><input class="qp-l" data-a="01000000101101000000000000000000"></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">2. Codificación de imagen:</p>
     <table>
       <tr><td>Tenemos una pantalla con 2x3 píxeles y cada píxel tiene 256 colores, es decir 8 bits,
               ¿cuántos Bytes de información caben en esta pantalla?<br>
               <img src="data:image/png;base64,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" width="87" alt="pantalla de 2x3 píxeles"></td>
           <td><input data-a="6"> B</td></tr>
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
         return valor === alt || (alt.length < 9 && sinCeros === alt);
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
