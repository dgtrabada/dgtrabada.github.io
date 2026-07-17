*************************
Cuestionario de potencias
*************************

.. raw:: html

   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-card table { border-collapse: collapse; }
   .qp-card td { padding: 2px 6px; border: none; }
   .qp-card input { width: 9em; padding: 2px 6px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit; font-family: monospace; }
   .qp-card input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   </style>

   <div class="qp-card">
     <p class="qp-enunciado">1. Calcula y memoriza las siguientes potencias de dos:</p>
     <table>
       <tr><td>2<sup>0</sup> =</td><td><input data-a="1"></td></tr>
       <tr><td>2<sup>1</sup> =</td><td><input data-a="2"></td></tr>
       <tr><td>2<sup>2</sup> =</td><td><input data-a="4"></td></tr>
       <tr><td>2<sup>3</sup> =</td><td><input data-a="8"></td></tr>
       <tr><td>2<sup>4</sup> =</td><td><input data-a="16"></td></tr>
       <tr><td>2<sup>5</sup> =</td><td><input data-a="32"></td></tr>
       <tr><td>2<sup>6</sup> =</td><td><input data-a="64"></td></tr>
       <tr><td>2<sup>7</sup> =</td><td><input data-a="128"></td></tr>
       <tr><td>2<sup>8</sup> =</td><td><input data-a="256"></td></tr>
       <tr><td>2<sup>9</sup> =</td><td><input data-a="512"></td></tr>
       <tr><td>2<sup>10</sup> =</td><td><input data-a="1024"></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">2. Calcula las siguientes potencias de dos (utiliza un punto para escribir los decimales):</p>
     <table>
       <tr><td>2<sup>-1</sup> =</td><td><input data-a="0.5"></td></tr>
       <tr><td>2<sup>-2</sup> =</td><td><input data-a="0.25"></td></tr>
       <tr><td>2<sup>-3</sup> =</td><td><input data-a="0.125"></td></tr>
       <tr><td>2<sup>-4</sup> =</td><td><input data-a="0.0625"></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">3. Calcula el resultado, puedes escribirlo en potencia de 2, por ejemplo:
        2<sup>2</sup>*2<sup>3</sup> = 2**5, o poner el resultado directamente: 2<sup>2</sup>*2<sup>3</sup> = 32</p>
     <table>
       <tr><td>2<sup>9</sup>*2<sup>9</sup> =</td><td><input data-a="2**18|262144"></td></tr>
       <tr><td>2*2<sup>9</sup> =</td><td><input data-a="2**10|1024"></td></tr>
       <tr><td>2<sup>0</sup>*2 =</td><td><input data-a="2**1|2"></td></tr>
       <tr><td>2<sup>9</sup>/2<sup>8</sup> =</td><td><input data-a="2**1|2"></td></tr>
       <tr><td>2<sup>21</sup>/2<sup>9</sup> =</td><td><input data-a="2**12|4096"></td></tr>
       <tr><td>2<sup>9</sup>*2<sup>8</sup>/2<sup>5</sup> =</td><td><input data-a="2**12|4096"></td></tr>
       <tr><td>2<sup>0</sup>*1 =</td><td><input data-a="1|2**0"></td></tr>
       <tr><td>2<sup>3</sup>*2 =</td><td><input data-a="2**4|16"></td></tr>
       <tr><td>2<sup>3</sup>/2<sup>2</sup> =</td><td><input data-a="2**1|2"></td></tr>
       <tr><td>128*2 =</td><td><input data-a="2**8|256"></td></tr>
       <tr><td>1024/2 =</td><td><input data-a="2**9|512"></td></tr>
       <tr><td>32*32 =</td><td><input data-a="2**10|1024"></td></tr>
       <tr><td>64*64 =</td><td><input data-a="2**12|4096"></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">4. Calcula las siguientes potencias de diez (utiliza un punto para escribir los decimales):</p>
     <table>
       <tr><td>10<sup>-4</sup> =</td><td><input data-a="0.0001"></td></tr>
       <tr><td>10<sup>-3</sup> =</td><td><input data-a="0.001"></td></tr>
       <tr><td>10<sup>-2</sup> =</td><td><input data-a="0.01"></td></tr>
       <tr><td>10<sup>-1</sup> =</td><td><input data-a="0.1"></td></tr>
       <tr><td>10<sup>0</sup> =</td><td><input data-a="1"></td></tr>
       <tr><td>10<sup>1</sup> =</td><td><input data-a="10"></td></tr>
       <tr><td>10<sup>2</sup> =</td><td><input data-a="100"></td></tr>
       <tr><td>10<sup>3</sup> =</td><td><input data-a="1000"></td></tr>
       <tr><td>10<sup>4</sup> =</td><td><input data-a="10000"></td></tr>
       <tr><td>10<sup>5</sup> =</td><td><input data-a="100000"></td></tr>
       <tr><td>10<sup>6</sup> =</td><td><input data-a="1000000"></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">5. Calcula el resultado y escríbelo en potencia de 10.<br>
        Ayuda: para escribir 10<sup>11</sup> pon 10**11</p>
     <table>
       <tr><td>10<sup>9</sup>*10<sup>9</sup> =</td><td><input data-a="10**18"></td></tr>
       <tr><td>10*10<sup>9</sup> =</td><td><input data-a="10**10"></td></tr>
       <tr><td>10<sup>0</sup>*10 =</td><td><input data-a="10**1"></td></tr>
       <tr><td>10<sup>9</sup>/10<sup>8</sup> =</td><td><input data-a="10**1"></td></tr>
       <tr><td>10<sup>21</sup>/10<sup>9</sup> =</td><td><input data-a="10**12"></td></tr>
       <tr><td>10<sup>9</sup>*10<sup>8</sup>/10<sup>5</sup> =</td><td><input data-a="10**12"></td></tr>
       <tr><td>10<sup>0</sup>*1 =</td><td><input data-a="1|10**0"></td></tr>
       <tr><td>10<sup>3</sup>*10 =</td><td><input data-a="10**4"></td></tr>
       <tr><td>10<sup>3</sup>/10<sup>2</sup> =</td><td><input data-a="10**1"></td></tr>
       <tr><td>10<sup>7</sup>*10 =</td><td><input data-a="10**8"></td></tr>
       <tr><td>1000/10 =</td><td><input data-a="10**2"></td></tr>
       <tr><td>100*100 =</td><td><input data-a="10**4"></td></tr>
       <tr><td>10*100000 =</td><td><input data-a="10**6"></td></tr>
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
       var ok = inp.dataset.a.split('|').some(function (alt) {
         alt = qpNorm(alt);
         if (valor === alt) return true;
         var na = Number(alt), nv = Number(valor);
         return valor !== '' && !isNaN(na) && !isNaN(nv) && na === nv;
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
