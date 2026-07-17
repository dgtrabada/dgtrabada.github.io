*************************************************
Cuestionario representación de la información (I)
*************************************************

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
     <p class="qp-enunciado">1. Pasar a binario los siguientes números en decimal:</p>
     <table>
       <tr><td>10<sub>10)</sub> =</td><td><input data-a="1010"> <sub>2)</sub></td></tr>
       <tr><td>235<sub>10)</sub> =</td><td><input data-a="11101011"> <sub>2)</sub></td></tr>
       <tr><td>223<sub>10)</sub> =</td><td><input data-a="11011111"> <sub>2)</sub></td></tr>
       <tr><td>146<sub>10)</sub> =</td><td><input data-a="10010010"> <sub>2)</sub></td></tr>
       <tr><td>177<sub>10)</sub> =</td><td><input data-a="10110001"> <sub>2)</sub></td></tr>
       <tr><td>111<sub>10)</sub> =</td><td><input data-a="1101111"> <sub>2)</sub></td></tr>
       <tr><td>62<sub>10)</sub> =</td><td><input data-a="111110"> <sub>2)</sub></td></tr>
       <tr><td>102<sub>10)</sub> =</td><td><input data-a="1100110"> <sub>2)</sub></td></tr>
       <tr><td>143<sub>10)</sub> =</td><td><input data-a="10001111"> <sub>2)</sub></td></tr>
       <tr><td>17<sub>10)</sub> =</td><td><input data-a="10001"> <sub>2)</sub></td></tr>
       <tr><td>58<sub>10)</sub> =</td><td><input data-a="111010"> <sub>2)</sub></td></tr>
       <tr><td>20<sub>10)</sub> =</td><td><input data-a="10100"> <sub>2)</sub></td></tr>
       <tr><td>54<sub>10)</sub> =</td><td><input data-a="110110"> <sub>2)</sub></td></tr>
       <tr><td>49<sub>10)</sub> =</td><td><input data-a="110001"> <sub>2)</sub></td></tr>
       <tr><td>123<sub>10)</sub> =</td><td><input data-a="1111011"> <sub>2)</sub></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">2. Pasar a decimal los siguientes números en binario:</p>
     <table>
       <tr><td>11101001<sub>2)</sub> =</td><td><input data-a="233"> <sub>10)</sub></td></tr>
       <tr><td>10001000<sub>2)</sub> =</td><td><input data-a="136"> <sub>10)</sub></td></tr>
       <tr><td>10111011<sub>2)</sub> =</td><td><input data-a="187"> <sub>10)</sub></td></tr>
       <tr><td>111000<sub>2)</sub> =</td><td><input data-a="56"> <sub>10)</sub></td></tr>
       <tr><td>1110001<sub>2)</sub> =</td><td><input data-a="113"> <sub>10)</sub></td></tr>
       <tr><td>1111100<sub>2)</sub> =</td><td><input data-a="124"> <sub>10)</sub></td></tr>
       <tr><td>11110100<sub>2)</sub> =</td><td><input data-a="244"> <sub>10)</sub></td></tr>
       <tr><td>11000011<sub>2)</sub> =</td><td><input data-a="195"> <sub>10)</sub></td></tr>
       <tr><td>10110111<sub>2)</sub> =</td><td><input data-a="183"> <sub>10)</sub></td></tr>
       <tr><td>1100100<sub>2)</sub> =</td><td><input data-a="100"> <sub>10)</sub></td></tr>
       <tr><td>11000100<sub>2)</sub> =</td><td><input data-a="196"> <sub>10)</sub></td></tr>
       <tr><td>101011<sub>2)</sub> =</td><td><input data-a="43"> <sub>10)</sub></td></tr>
       <tr><td>10111001<sub>2)</sub> =</td><td><input data-a="185"> <sub>10)</sub></td></tr>
       <tr><td>1000001<sub>2)</sub> =</td><td><input data-a="65"> <sub>10)</sub></td></tr>
       <tr><td>11011110<sub>2)</sub> =</td><td><input data-a="222"> <sub>10)</sub></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">3. Conversiones entre decimal, hexadecimal y octal:</p>
     <p><b>Pasar de decimal a hexadecimal:</b></p>
     <table>
       <tr><td>63<sub>10)</sub> =</td><td><input data-a="3F"> <sub>16)</sub></td></tr>
       <tr><td>45<sub>10)</sub> =</td><td><input data-a="2D"> <sub>16)</sub></td></tr>
       <tr><td>108<sub>10)</sub> =</td><td><input data-a="6C"> <sub>16)</sub></td></tr>
       <tr><td>179<sub>10)</sub> =</td><td><input data-a="B3"> <sub>16)</sub></td></tr>
       <tr><td>206<sub>10)</sub> =</td><td><input data-a="CE"> <sub>16)</sub></td></tr>
     </table>
     <p><b>Pasar de hexadecimal a decimal:</b></p>
     <table>
       <tr><td>2A<sub>16)</sub> =</td><td><input data-a="42"> <sub>10)</sub></td></tr>
       <tr><td>6F<sub>16)</sub> =</td><td><input data-a="111"> <sub>10)</sub></td></tr>
       <tr><td>C2<sub>16)</sub> =</td><td><input data-a="194"> <sub>10)</sub></td></tr>
       <tr><td>6D<sub>16)</sub> =</td><td><input data-a="109"> <sub>10)</sub></td></tr>
       <tr><td>90<sub>16)</sub> =</td><td><input data-a="144"> <sub>10)</sub></td></tr>
     </table>
     <p><b>Pasar de decimal a octal:</b></p>
     <table>
       <tr><td>139<sub>10)</sub> =</td><td><input data-a="213"> <sub>8)</sub></td></tr>
       <tr><td>152<sub>10)</sub> =</td><td><input data-a="230"> <sub>8)</sub></td></tr>
       <tr><td>106<sub>10)</sub> =</td><td><input data-a="152"> <sub>8)</sub></td></tr>
       <tr><td>136<sub>10)</sub> =</td><td><input data-a="210"> <sub>8)</sub></td></tr>
       <tr><td>231<sub>10)</sub> =</td><td><input data-a="347"> <sub>8)</sub></td></tr>
     </table>
     <p><b>Pasar de octal a decimal:</b></p>
     <table>
       <tr><td>13<sub>8)</sub> =</td><td><input data-a="11"> <sub>10)</sub></td></tr>
       <tr><td>331<sub>8)</sub> =</td><td><input data-a="217"> <sub>10)</sub></td></tr>
       <tr><td>227<sub>8)</sub> =</td><td><input data-a="151"> <sub>10)</sub></td></tr>
       <tr><td>171<sub>8)</sub> =</td><td><input data-a="121"> <sub>10)</sub></td></tr>
       <tr><td>265<sub>8)</sub> =</td><td><input data-a="181"> <sub>10)</sub></td></tr>
     </table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">4. Utilizando la técnica de agrupaciones vista en clase completa las siguientes igualdades:</p>
     <table>
       <tr><td><input data-a="B1"> <sub>16)</sub></td><td>= 261<sub>8)</sub></td><td>= 10110001<sub>2)</sub></td></tr>
       <tr><td>F4<sub>16)</sub></td><td>= <input data-a="364"> <sub>8)</sub></td><td>= 11110100<sub>2)</sub></td></tr>
       <tr><td>73<sub>16)</sub></td><td>= 163<sub>8)</sub></td><td>= <input data-a="1110011"> <sub>2)</sub></td></tr>
       <tr><td><input data-a="30"> <sub>16)</sub></td><td>= 60<sub>8)</sub></td><td>= <input data-a="110000"> <sub>2)</sub></td></tr>
       <tr><td>1A<sub>16)</sub></td><td>= <input data-a="32"> <sub>8)</sub></td><td>= 11010<sub>2)</sub></td></tr>
       <tr><td>5B<sub>16)</sub></td><td>= 133<sub>8)</sub></td><td>= <input data-a="1011011"> <sub>2)</sub></td></tr>
       <tr><td><input data-a="2B"> <sub>16)</sub></td><td>= 53<sub>8)</sub></td><td>= <input data-a="101011"> <sub>2)</sub></td></tr>
       <tr><td>2E<sub>16)</sub></td><td>= <input data-a="56"> <sub>8)</sub></td><td>= 101110<sub>2)</sub></td></tr>
       <tr><td>AE<sub>16)</sub></td><td>= 256<sub>8)</sub></td><td>= <input data-a="10101110"> <sub>2)</sub></td></tr>
       <tr><td><input data-a="25"> <sub>16)</sub></td><td>= 45<sub>8)</sub></td><td>= <input data-a="100101"> <sub>2)</sub></td></tr>
       <tr><td>7F<sub>16)</sub></td><td>= <input data-a="177"> <sub>8)</sub></td><td>= 1111111<sub>2)</sub></td></tr>
       <tr><td>1D<sub>16)</sub></td><td>= <input data-a="35"> <sub>8)</sub></td><td>= 11101<sub>2)</sub></td></tr>
       <tr><td><input data-a="73"> <sub>16)</sub></td><td>= 163<sub>8)</sub></td><td>= <input data-a="1110011"> <sub>2)</sub></td></tr>
       <tr><td>63<sub>16)</sub></td><td>= <input data-a="143"> <sub>8)</sub></td><td>= 1100011<sub>2)</sub></td></tr>
       <tr><td><input data-a="66"> <sub>16)</sub></td><td>= 146<sub>8)</sub></td><td>= <input data-a="1100110"> <sub>2)</sub></td></tr>
       <tr><td>E6<sub>16)</sub></td><td>= <input data-a="346"> <sub>8)</sub></td><td>= 11100110<sub>2)</sub></td></tr>
       <tr><td>C5<sub>16)</sub></td><td>= 305<sub>8)</sub></td><td>= <input data-a="11000101"> <sub>2)</sub></td></tr>
       <tr><td><input data-a="D6"> <sub>16)</sub></td><td>= 326<sub>8)</sub></td><td>= <input data-a="11010110"> <sub>2)</sub></td></tr>
       <tr><td>C6<sub>16)</sub></td><td>= 306<sub>8)</sub></td><td>= <input data-a="11000110"> <sub>2)</sub></td></tr>
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
