**************************************
Cuestionario medida de la información
**************************************

.. raw:: html

   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-card { counter-reset: fila; }
   .qp-card table { border-collapse: collapse; }
   .qp-card table tr td:first-child::before { counter-increment: fila; content: counter(fila) ". "; }
   .qp-card td { padding: 2px 6px; border: none; }
   .qp-card input { width: 13em; padding: 2px 6px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit; font-family: monospace; }
   .qp-card input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   </style>

   <div class="qp-card">
     <p class="qp-enunciado">1. Calcula el resultado, puedes escribirlo en potencia de 2, por ejemplo:<br>
        ¿Cuántos KiB hay en 2GiB? = 2**21, o directamente: ¿Cuántos KiB hay en 2GiB? = 2097152</p>
     <table>
       <tr><td>¿Cuántos bytes hay en 2GiB? =</td><td><input data-a="2**31|2147483648"> B</td></tr>
       <tr><td>¿Cuántos KiB hay en 4TiB? =</td><td><input data-a="2**32|4294967296"> KiB</td></tr>
       <tr><td>¿Cuántos MiB hay en 512GiB? =</td><td><input data-a="2**19|524288"> MiB</td></tr>
       <tr><td>¿Cuántos GiB hay en 2YiB? =</td><td><input data-a="2**51|2251799813685248"> GiB</td></tr>
       <tr><td>¿Cuántos TiB hay en 1EiB? =</td><td><input data-a="2**20|1048576"> TiB</td></tr>
       <tr><td>¿Cuántos GiB hay en 512MiB? =</td><td><input data-a="2**-1|0.5"> GiB</td></tr>
       <tr><td>¿Cuántos PiB hay en 2<sup>33</sup>ZiB? =</td><td><input data-a="2**53|9007199254740992"> PiB</td></tr>
       <tr><td>¿Cuántos YiB hay en 2<sup>88</sup>MiB? =</td><td><input data-a="2**28|268435456"> YiB</td></tr>
       <tr><td>¿Cuántos EiB hay en 2<sup>33</sup>TiB? =</td><td><input data-a="2**13|8192"> EiB</td></tr>
       <tr><td>¿Cuántos GiB hay en 1024MiB? =</td><td><input data-a="2**0|1"> GiB</td></tr>
       <tr><td>¿Cuántos PiB hay en 2<sup>43</sup>ZiB? =</td><td><input data-a="2**63|9223372036854775808"> PiB</td></tr>
       <tr><td>¿Cuántos B hay en 2048 KiB? =</td><td><input data-a="2**21|2097152"> B</td></tr>
       <tr><td>¿Cuántos GiB hay en 2<sup>52</sup>MiB? =</td><td><input data-a="2**42|4398046511104"> GiB</td></tr>
       <tr><td>¿Cuántos TiB hay en 2<sup>33</sup>KiB? =</td><td><input data-a="2**3|8"> TiB</td></tr>
       <tr><td>¿Cuántos YiB hay en 2<sup>33</sup>TiB? =</td><td><input data-a="2**-7|0.0078125"> YiB</td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">2. Calcula el resultado, puedes escribirlo en potencia de 10, por ejemplo:<br>
        ¿Cuántos KB hay en 2GB? = 2*10**6, o directamente: ¿Cuántos KB hay en 2GB? = 2000000</p>
     <table>
       <tr><td>¿Cuántos bytes hay en 2GB? =</td><td><input data-a="2*10**9|2000000000"> B</td></tr>
       <tr><td>¿Cuántos KB hay en 4TB? =</td><td><input data-a="4*10**9|4000000000"> KB</td></tr>
       <tr><td>¿Cuántos MB hay en 500GB? =</td><td><input data-a="5*10**5|500000"> MB</td></tr>
       <tr><td>¿Cuántos GB hay en 10YB? =</td><td><input data-a="10**16|10000000000000000"> GB</td></tr>
       <tr><td>¿Cuántos TB hay en 1EB? =</td><td><input data-a="10**6|1000000"> TB</td></tr>
       <tr><td>¿Cuántos GB hay en 300MB? =</td><td><input data-a="3*10**-1|0.3"> GB</td></tr>
       <tr><td>¿Cuántos ZB hay en 2*10<sup>6</sup> PB? =</td><td><input data-a="2|2*10**0"> ZB</td></tr>
       <tr><td>¿Cuántos GB hay en 1000MB? =</td><td><input data-a="1*10**0|1"> GB</td></tr>
       <tr><td>¿Cuántos B hay en 2000 KB? =</td><td><input data-a="2*10**6|2000000"> B</td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">3. Calcula el resultado. Escríbelo en potencia de 10 y de 2 siguiendo el orden, por ejemplo:<br>
        ¿Cuántos MiB hay en 2GB? = 2*10**9/2**20</p>
     <table>
       <tr><td>¿Cuántos KB hay en 4TiB? =</td><td><input data-a="4*2**40/10**3"> KB</td></tr>
       <tr><td>¿Cuántos MiB hay en 500GB? =</td><td><input data-a="5*10**11/2**20"> MiB</td></tr>
       <tr><td>¿Cuántos GiB hay en 10YB? =</td><td><input data-a="10**25/2**30"> GiB</td></tr>
       <tr><td>¿Cuántos TB hay en 1EiB? =</td><td><input data-a="2**60/10**12"> TB</td></tr>
       <tr><td>¿Cuántos GiB hay en 300MB? =</td><td><input data-a="3*10**8/2**30"> GiB</td></tr>
       <tr><td>¿Cuántos PB hay en 12 ZiB? =</td><td><input data-a="12*2**70/10**15"> PB</td></tr>
       <tr><td>¿Cuántos GB hay en 1GiB? =</td><td><input data-a="2**30/10**9"> GB</td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">4. Resuelve:</p>
     <table>
       <tr><td>Si una película ocupa 1 GB, ¿cuántas películas cabrían en un disco de 2TB? =</td>
           <td><input data-a="2000"></td></tr>
       <tr><td>Si una canción ocupa 4 MiB, ¿cuántas canciones cabrían en una memoria extraíble de 4GiB? =</td>
           <td><input data-a="1024"></td></tr>
       <tr><td>Si un programa ocupa 100 MB, ¿cuántos programas cabrían en una partición de 10 GB? =</td>
           <td><input data-a="100"></td></tr>
       <tr><td>¿Cuántos discos de 512 GiB necesitaría para tener una partición de 2TiB? =</td>
           <td><input data-a="4"></td></tr>
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
