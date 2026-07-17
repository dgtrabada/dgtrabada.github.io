*************************
Cuestionario de licencias
*************************

.. raw:: html

   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-item { margin: 0 0 1em 0; }
   .qp-item .qp-q { margin: 0 0 .3em 0; }
   .qp-opts { display: flex; flex-direction: column; align-items: flex-start; gap: .3em; }
   .qp-opt { border: 1.5px solid transparent; border-radius: 5px; padding: 2px 10px; cursor: pointer; }
   .qp-opt input { margin-right: .4em; }
   .qp-opt.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-opt.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card table { border-collapse: collapse; }
   .qp-card td { padding: 3px 6px; border: none; }
   .qp-card select { max-width: 100%; padding: 2px 6px; border: 1.5px solid rgba(128,128,128,.6);
                     border-radius: 4px; background: transparent; color: inherit; }
   .qp-card select option { color: initial; }
   .qp-card select.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card select.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .2em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   </style>

   <div class="qp-card">
     <p class="qp-enunciado">1. Selecciona la respuesta correcta:</p>
     <div id="qp-bloque1"></div>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">2. Ejercicio de investigación — busca en Internet la licencia bajo la que se distribuye cada programa y selecciónala:</p>
     <table id="qp-programas"></table>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <div class="qp-card">
     <p class="qp-enunciado">3. Creative Commons:</p>
     <div id="qp-bloque3"></div>
     <button onclick="qpCorregir(this)">Corregir</button>
     <button onclick="qpSolucion(this)">Solución</button>
     <button onclick="qpLimpiar(this)">Reintentar</button>
     <span class="qp-nota"></span>
   </div>

   <script>
   (function () {
     var bloque1 = [
       ['Las licencias RETAIL',
        ['Las puedes poner en cualquier ordenador, pero solo una vez al mismo tiempo', 'Se ligan a la Placa base'], 0],
       ['Las licencias OEM',
        ['Significa Original Equipment Manufacturer', 'Permiten su uso únicamente para actividades educativas y de formación'], 0],
       ['Las licencias RETAIL',
        ['Se ligan a la Placa base', 'va ligada a una cuenta de Microsoft'], 1],
       ['¿Se puede transferir la clave OEM entre tus propios PCs?', ['Sí', 'No'], 1],
       ['¿Podríamos vender legalmente una copia de Xubuntu?', ['Sí', 'No'], 0],
       ['¿Podríamos descargarnos legalmente el código de Windows?', ['Sí', 'No'], 1],
       ['¿Podríamos descargarnos legalmente el código de Debian?', ['Sí', 'No'], 0],
       ['¿Podríamos distribuir legalmente el código de Windows?', ['Sí', 'No'], 1],
       ['¿Podríamos distribuir legalmente el código de Fedora?', ['Sí', 'No'], 0],
       ['De todas las licencias vistas, ¿cuál es la licencia más permisiva?', ['BSD', 'MIT', 'MPL', 'AFL'], 0],
       ['¿Podríamos hacer uso comercial de una obra CC by-nc?', ['Sí', 'No'], 1],
       ['¿Podríamos hacer uso comercial de una obra CC by-sa?', ['Sí', 'No'], 0],
       ['¿Podríamos distribuir una obra CC by-nc?', ['Sí', 'No'], 0],
       ['¿Podríamos distribuir una obra CC by-nd?', ['Sí', 'No'], 0],
       ['¿Podríamos hacer una obra derivada de una obra CC by-nd?', ['Sí', 'No'], 1],
       ['¿Qué significa EULA?',
        ['End-User License Agreement (Acuerdo de Licencia con el Usuario Final)',
         'European User License Association',
         'Extended Use License Application'], 0],
       ['Las licencias VOLUMEN (VLM)',
        ['están enfocadas a empresas y se pueden utilizar en varios ordenadores',
         'solo se pueden usar en un único equipo ligado a la placa base'], 0],
       ['¿Qué significa KMS?',
        ['Key Management Service, un servicio de publicación automática de licencias de Microsoft',
         'Kernel Module System, un módulo del núcleo de Windows',
         'Keyboard and Mouse Support'], 0],
       ['Las licencias MSDN y de educación de Microsoft permiten su uso',
        ['únicamente para desarrollo, evaluación o actividades educativas y de formación',
         'para cualquier actividad comercial de la empresa'], 0],
       ['¿Cuál de las siguientes NO es una de las cuatro libertades del software libre?',
        ['Garantía de funcionamiento del programa', 'Usar el programa con cualquier propósito',
         'Estudiar cómo funciona y modificarlo', 'Distribuir copias del programa'], 0],
       ['Si en un programa mezclamos código GPL con código BSD, el resultado debe licenciarse como',
        ['GPL', 'BSD', 'La que elija el programador', 'Propietario'], 0],
       ['¿Qué licencia obliga a distribuir el código fuente si el software se ejecuta para ofrecer servicios a través de una red?',
        ['AGPL', 'GPL', 'BSD', 'MPL'], 0],
       ['La licencia MPL (Mozilla Public License) se considera de',
        ['copyleft débil', 'copyleft fuerte', 'dominio público'], 0],
       ['Con una licencia OEM, ¿qué componente NO podemos cambiar sin perder la licencia?',
        ['La placa base', 'La memoria RAM', 'La tarjeta gráfica'], 0],
       ['¿Puede el titular del copyright de un software copyleft vender una versión modificada bajo otra licencia?',
        ['Sí, el titular de los derechos puede licenciar su obra como quiera (modelo de negocio de MySQL)',
         'No, una vez copyleft, todas sus versiones deben ser copyleft'], 0],
       ['Un contenido publicado en Internet sin referencia de autoría ni licencia',
        ['tiene derechos de autor igualmente: no se puede usar libremente',
         'es de dominio público y se puede usar libremente'], 0],
       ['¿Qué proyecto de software libre nació cuando Netscape liberó su navegador con la licencia NPL/MPL?',
        ['Mozilla', 'Linux', 'GNU', 'Apache'], 0],
     ];

     var bloque3 = [
       ['¿Qué indica la condición "Reconocimiento (BY / Attribution)"?',
        ['En cualquier explotación de la obra autorizada por la licencia hará falta reconocer la autoría',
         'La explotación de la obra queda limitada a usos no comerciales',
         'La obra no se puede modificar'], 0],
       ['¿Qué indica la condición "No Comercial (NC / Non commercial)"?',
        ['La explotación de la obra queda limitada a usos no comerciales',
         'Hay que reconocer la autoría de la obra',
         'Las obras derivadas deben mantener la misma licencia'], 0],
       ['¿Qué indica la condición "Sin obras derivadas (ND / No Derivate Works)"?',
        ['La autorización para explotar la obra no incluye la transformación para crear una obra derivada',
         'No se puede vender la obra',
         'La obra solo se puede usar con fines educativos'], 0],
       ['¿Qué indica la condición "Compartir Igual (SA / Share alike)"?',
        ['Las obras derivadas deben mantener la misma licencia al ser divulgadas',
         'La obra debe distribuirse gratuitamente',
         'No se pueden hacer obras derivadas'], 0],
       ['¿Qué condición está presente en todas las licencias Creative Commons?',
        ['Reconocimiento (BY)', 'No Comercial (NC)', 'Compartir Igual (SA)', 'Sin obras derivadas (ND)'], 0],
       ['¿Cuál es la licencia Creative Commons más permisiva?',
        ['CC by', 'CC by-sa', 'CC by-nc', 'CC by-nc-nd'], 0],
       ['¿Cuál es la licencia Creative Commons más restrictiva?',
        ['CC by-nc-nd', 'CC by-nd', 'CC by-nc-sa', 'CC by'], 0],
       ['Si una obra es CC by-sa, sus obras derivadas',
        ['deben distribuirse con una licencia igual a la que regula la obra original',
         'pueden distribuirse con cualquier licencia',
         'no están permitidas'], 0],
       ['¿Qué licencia CC permite el uso comercial de la obra pero no la generación de obras derivadas?',
        ['CC by-nd', 'CC by-nc', 'CC by-sa', 'CC by-nc-nd'], 0],
       ['¿Pueden combinarse las condiciones ND y SA en una misma licencia CC?',
        ['No, son incompatibles: SA exige que las derivadas mantengan la licencia y ND prohíbe las derivadas',
         'Sí, por ejemplo en la licencia CC by-nd-sa'], 0],
       ['¿Podríamos crear una obra derivada de una obra CC by-nc y venderla?',
        ['No, la condición No Comercial lo impide',
         'Sí, siempre que citemos al autor original'], 0],
     ];

     function pinta(idDiv, items, prefijo, barajar) {
       var cont = document.getElementById(idDiv);
       items.forEach(function (it, i) {
         var orden = it[1].map(function (_, j) { return j; });
         if (barajar) orden.sort(function () { return Math.random() - 0.5; });
         var div = document.createElement('div');
         div.className = 'qp-item';
         div.dataset.a = orden.indexOf(it[2]);
         var html = '<p class="qp-q">' + (i + 1) + '. ' + it[0] + '</p><div class="qp-opts">';
         orden.forEach(function (k, j) {
           html += '<label class="qp-opt"><input type="radio" name="' + prefijo + i + '" value="' + j + '">' + it[1][k] + '</label>';
         });
         div.innerHTML = html + '</div>';
         cont.appendChild(div);
       });
     }
     pinta('qp-bloque1', bloque1, 'b1_', true);
     pinta('qp-bloque3', bloque3, 'b3_', true);

     var licencias = ['Licencia Apache', 'MIT', 'GPLv2', 'GPL', 'GPLv3', 'MPL', 'BSD', 'Propietario'];
     var programas = [
       ['Android Studio', 'Licencia Apache'], ['Atom', 'MIT'], ['Audacity', 'GPLv2'],
       ['Blender', 'GPL'], ['Cisco Packet Tracer', 'Propietario'], ['FileZilla', 'GPLv2'],
       ['Gimp', 'GPLv3'], ['LibreOffice', 'MPL'], ['Microsoft Office', 'Propietario'],
       ['Mozilla Firefox', 'MPL'],
     ];
     var tabla = document.getElementById('qp-programas');
     var opts = '<option value=""></option>' + licencias.map(function (l) {
       return '<option>' + l + '</option>';
     }).join('');
     programas.forEach(function (p) {
       var tr = document.createElement('tr');
       tr.innerHTML = '<td>' + p[0] + '</td><td><select data-a="' + p[1] + '">' + opts + '</select></td>';
       tabla.appendChild(tr);
     });
   })();

   function qpCorregir(btn) {
     var card = btn.closest('.qp-card');
     var aciertos = 0, total = 0;
     card.querySelectorAll('.qp-item').forEach(function (it) {
       total++;
       it.querySelectorAll('.qp-opt').forEach(function (l) { l.className = 'qp-opt'; });
       var sel = it.querySelector('input:checked');
       if (sel) {
         var ok = sel.value === it.dataset.a;
         sel.closest('.qp-opt').className = 'qp-opt ' + (ok ? 'qp-ok' : 'qp-mal');
         if (ok) aciertos++;
       }
     });
     card.querySelectorAll('select[data-a]').forEach(function (c) {
       total++;
       var ok = c.value === c.dataset.a;
       c.className = ok ? 'qp-ok' : 'qp-mal';
       if (ok) aciertos++;
     });
     card.querySelector('.qp-nota').textContent = aciertos + ' / ' + total;
   }
   function qpSolucion(btn) {
     var card = btn.closest('.qp-card');
     card.querySelectorAll('.qp-item').forEach(function (it) {
       it.querySelectorAll('.qp-opt').forEach(function (l) { l.className = 'qp-opt'; });
       var radios = it.querySelectorAll('input');
       var correcto = radios[parseInt(it.dataset.a, 10)];
       correcto.checked = true;
       correcto.closest('.qp-opt').className = 'qp-opt qp-ok';
     });
     card.querySelectorAll('select[data-a]').forEach(function (c) {
       c.value = c.dataset.a;
       c.className = 'qp-ok';
     });
     card.querySelector('.qp-nota').textContent = 'Solución';
   }
   function qpLimpiar(btn) {
     var card = btn.closest('.qp-card');
     card.querySelectorAll('input[type=radio]').forEach(function (r) { r.checked = false; });
     card.querySelectorAll('.qp-opt').forEach(function (l) { l.className = 'qp-opt'; });
     card.querySelectorAll('select[data-a]').forEach(function (c) { c.value = ''; c.className = ''; });
     card.querySelector('.qp-nota').textContent = '';
   }
   </script>
