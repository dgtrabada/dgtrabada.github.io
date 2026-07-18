# -*- coding: utf-8 -*-
"""
Directiva ``.. cuestionario::`` — cuestionarios interactivos autocorregibles.

Sintaxis del contenido (por indentación):

    1. Enunciado de la tarjeta:              <- línea sin indentar = nueva tarjeta
       | continuación del enunciado          <- se une con salto de línea
       texto: párrafo adicional
       fichero: cal.dat                      <- listado monoespaciado compacto,
          enero 1 pintura                       si se indica nombre añade "$ cat nombre"
          enero 15 cocina
       imagen: imagenes/foto.png 340         <- ruta relativa al .rst y ancho opcional
       tabla: Título opcional                <- tabla con bordes, la 1ª fila es cabecera
          | Col A | Col B |
          | 1     | [respuesta] |            <- [..] crea un hueco a rellenar
       filas: numeradas ancho=13em           <- tabla sin bordes de huecos
          2^{10} = [1024]                    <- ^{ } superíndice, _{ } subíndice
          10_{10)} = [1010] _{2)}
          [B1] _{16)} | = 261_{8)} | ...     <- varias columnas con |
       - ¿Pregunta tipo test?                <- opciones con radio buttons
         (x) opción correcta
         ( ) opción incorrecta
       - ¿Pregunta de respuesta escrita?
         = respuesta | alternativa           <- input en su propia línea
         Texto con hueco [respuesta] en medio

Las respuestas admiten alternativas separadas por ``|``. En el texto se puede
usar ``**negrita**``. La corrección ignora mayúsculas, espacios, ceros a la
izquierda (en respuestas cortas) y admite ``,`` como ``.`` y ``^`` como ``**``.
"""

import base64
import os
import re

from docutils import nodes
from docutils.parsers.rst import Directive

CSS = """
   <style>
   .qp-card { border: 1px solid rgba(128,128,128,.45); border-radius: 8px; padding: 1em 1.2em; margin: 1em 0; }
   .qp-card p.qp-enunciado { font-weight: bold; margin-top: 0; }
   .qp-item { margin: 0 0 1em 0; }
   .qp-item .qp-q, .qp-bloq .qp-q { margin: 0 0 .3em 0; }
   .qp-bloq { margin: 0 0 1em 0; }
   .qp-opts { display: flex; flex-direction: column; align-items: flex-start; gap: .1em; }
   .qp-opt { border: 1.5px solid transparent; border-radius: 5px; padding: 1px 10px; cursor: pointer; }
   .qp-opt input { margin-right: .4em; }
   .qp-opt.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-opt.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card table { border-collapse: collapse; margin: .4em 0; }
   .qp-card table.qp-tabla th, .qp-card table.qp-tabla td { border: 1px solid rgba(128,128,128,.5); padding: 3px 8px; text-align: center; }
   .qp-card table.qp-filas td { border: none; padding: 2px 6px; }
   .qp-card table.qp-num { counter-reset: fila; }
   .qp-card table.qp-num tr td:first-child::before { counter-increment: fila; content: counter(fila) ". "; }
   .qp-card input[type=text] { width: var(--qpw, 11em); max-width: 100%; padding: 2px 6px; border: 1.5px solid rgba(128,128,128,.6);
                    border-radius: 4px; background: transparent; color: inherit; font-family: monospace; }
   .qp-card input.qp-corto { width: 5em; text-align: center; }
   .qp-card input.qp-l { width: 24em; }
   .qp-card input.qp-ok  { border-color: #2e7d32; background: rgba(46,125,50,.12); }
   .qp-card input.qp-mal { border-color: #c62828; background: rgba(198,40,40,.12); }
   .qp-card button { margin-top: .6em; margin-right: .6em; padding: 4px 14px; border-radius: 5px;
                     border: 1px solid rgba(128,128,128,.6); background: transparent; color: inherit; cursor: pointer; }
   .qp-card button:hover { background: rgba(128,128,128,.15); }
   .qp-nota { margin-left: .4em; font-weight: bold; }
   .qp-card pre.qp-pre { margin: .4em 0; padding: 5px 10px; border: 1px solid rgba(128,128,128,.35);
                    border-radius: 5px; font-family: monospace; font-size: .95em; line-height: 1.3;
                    overflow-x: auto; background: rgba(128,128,128,.08); }
   .qp-img { max-width: 100%; height: auto; background: white; border-radius: 4px; padding: 4px; }
   </style>
"""

JS = """
   <script>
   function qpNorm(s) {
     return s.trim().toLowerCase().replace(/\\s+/g, '').replace(/,/g, '.').replace(/\\^/g, '**');
   }
   function qpAcierta(inp) {
     var valor = qpNorm(inp.value);
     var sinCeros = valor.replace(/^0+(?=.)/, '');
     return inp.dataset.a.split('|').some(function (alt) {
       alt = qpNorm(alt);
       return valor === alt || (alt.length < 9 && sinCeros === alt);
     });
   }
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
     card.querySelectorAll('input[type=text][data-a]').forEach(function (inp) {
       total++;
       var ok = qpAcierta(inp);
       inp.classList.remove('qp-ok', 'qp-mal');
       inp.classList.add(ok ? 'qp-ok' : 'qp-mal');
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
     card.querySelectorAll('input[type=text][data-a]').forEach(function (inp) {
       inp.value = inp.dataset.a.split('|')[0];
       inp.classList.remove('qp-mal'); inp.classList.add('qp-ok');
     });
     card.querySelector('.qp-nota').textContent = 'Solución';
   }
   function qpLimpiar(btn) {
     var card = btn.closest('.qp-card');
     card.querySelectorAll('input[type=radio]').forEach(function (r) { r.checked = false; });
     card.querySelectorAll('.qp-opt').forEach(function (l) { l.className = 'qp-opt'; });
     card.querySelectorAll('input[type=text][data-a]').forEach(function (inp) {
       inp.value = ''; inp.classList.remove('qp-ok', 'qp-mal');
     });
     card.querySelector('.qp-nota').textContent = '';
   }
   </script>
"""

BOTONES = ('     <button onclick="qpCorregir(this)">Corregir</button>\n'
           '     <button onclick="qpSolucion(this)">Solución</button>\n'
           '     <button onclick="qpLimpiar(this)">Reintentar</button>\n'
           '     <span class="qp-nota"></span>\n')


def esc(t):
    return t.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


def fmt(t):
    t = esc(t)
    t = re.sub(r'\*\*(.+?)\*\*', r'<b>\1</b>', t)
    t = re.sub(r'\^\{([^}]*)\}', r'<sup>\1</sup>', t)
    t = re.sub(r'_\{([^}]*)\}', r'<sub>\1</sub>', t)
    return t


def input_html(ans, cls=''):
    c = ' class="%s"' % cls if cls else ''
    ans = '|'.join(p.strip() for p in ans.split('|'))
    return '<input type="text"%s data-a="%s">' % (c, esc(ans))


def clase_por_longitud(ans):
    primera = ans.split('|')[0].strip()
    if len(primera) <= 6:
        return 'qp-corto'
    if len(primera) >= 24:
        return 'qp-l'
    return ''


def inline(texto, auto_clase=True):
    """Convierte los huecos [respuesta] en inputs y formatea el resto."""
    partes = re.split(r'\[([^\[\]]+)\]', texto)
    out = []
    for i, p in enumerate(partes):
        if i % 2:
            out.append(input_html(p, clase_por_longitud(p) if auto_clase else ''))
        else:
            out.append(fmt(p))
    return ''.join(out)


def indent_de(linea):
    return len(linea) - len(linea.lstrip())


class Cuestionario(Directive):
    has_content = True

    def run(self):
        env = self.state.document.settings.env
        base = os.path.dirname(str(env.doc2path(env.docname)))
        serial = env.new_serialno('cuestionario')
        lineas = list(self.content)
        html = [CSS]
        self._radio = 0
        i, n = 0, len(lineas)
        while i < n:
            if not lineas[i].strip() or indent_de(lineas[i]) > 0:
                i += 1
                continue
            fin = i + 1
            while fin < n and (not lineas[fin].strip() or indent_de(lineas[fin]) > 0):
                fin += 1
            html.append(self.tarjeta(lineas[i:fin], base, serial, env))
            i = fin
        html.append(JS)
        return [nodes.raw('', '\n'.join(html), format='html')]

    # ----- bloques -----

    def tarjeta(self, lineas, base, serial, env):
        enun = [fmt(lineas[0].strip())]
        cuerpo = []
        i, n = 1, len(lineas)
        # continuación del enunciado
        while i < n and lineas[i].strip().startswith('| ') and not lineas[i].strip().endswith('|'):
            enun.append(fmt(lineas[i].strip()[2:]))
            i += 1
        out = ['   <div class="qp-card">',
               '     <p class="qp-enunciado">%s</p>' % '<br>\n        '.join(enun)]
        out.append(self.bloques(lineas[i:], base, serial, env, nivel_pregunta=True))
        out.append(BOTONES + '   </div>\n')
        return '\n'.join(out)

    def bloques(self, lineas, base, serial, env, nivel_pregunta=False):
        """Procesa texto:, imagen:, tabla:, filas:, preguntas (-) y líneas con huecos."""
        out = []
        i, n = 0, len(lineas)
        while i < n:
            s = lineas[i].strip()
            if not s:
                i += 1
                continue
            ind = indent_de(lineas[i])
            if s.startswith('texto:'):
                out.append('     <p>%s</p>' % fmt(s[len('texto:'):].strip()))
                i += 1
            elif s.startswith('imagen:'):
                out.append(self.imagen(s[len('imagen:'):].strip(), base, env))
                i += 1
            elif s.startswith('tabla:') or s.startswith('filas:') or s.startswith('fichero:'):
                sub = []
                j = i + 1
                while j < n and (not lineas[j].strip() or indent_de(lineas[j]) > ind):
                    if lineas[j].strip():
                        sub.append(lineas[j].strip())
                    j += 1
                if s.startswith('tabla:'):
                    out.append(self.tabla(s[len('tabla:'):].strip(), sub))
                elif s.startswith('filas:'):
                    out.append(self.filas(s[len('filas:'):].strip(), sub))
                else:
                    out.append(self.fichero(s[len('fichero:'):].strip(), sub))
                i = j
            elif nivel_pregunta and s.startswith('- '):
                sub = []
                j = i + 1
                while j < n and (not lineas[j].strip()
                                 or (indent_de(lineas[j]) > ind
                                     and not lineas[j].strip().startswith('- '))):
                    if lineas[j].strip():
                        sub.append(lineas[j])
                    j += 1
                out.append(self.pregunta(s[2:].strip(), sub, base, serial, env))
                i = j
            elif '[' in s and ']' in s:
                out.append('     <p>%s</p>' % inline(s))
                i += 1
            else:
                out.append('     <p>%s</p>' % fmt(s))
                i += 1
        return '\n'.join(out)

    def pregunta(self, texto, lineas, base, serial, env):
        opciones = []       # (correcta, texto)
        respuestas = []     # respuestas '=' consecutivas
        cuerpo = []
        i, n = 0, len(lineas)
        while i < n:
            s = lineas[i].strip()
            if s.startswith('(x)') or s.startswith('( )'):
                opciones.append((s.startswith('(x)'), s[3:].strip()))
                i += 1
            elif s.startswith('= '):
                respuestas.append(s[2:].strip())
                i += 1
            elif s.startswith('texto:') or s.startswith('imagen:') or \
                    s.startswith('tabla:') or s.startswith('filas:') or \
                    s.startswith('fichero:') or \
                    ('[' in s and ']' in s):
                fin = i + 1
                if s.startswith('tabla:') or s.startswith('filas:') or s.startswith('fichero:'):
                    ind = indent_de(lineas[i])
                    while fin < n and (not lineas[fin].strip() or indent_de(lineas[fin]) > ind):
                        fin += 1
                cuerpo.append(self.bloques(lineas[i:fin], base, serial, env))
                i = fin
            else:
                texto += ' ' + s
                i += 1
        out = []
        if opciones:
            correcta = [k for k, (ok, _) in enumerate(opciones) if ok]
            nombre = 'q%d_%d' % (serial, self._radio)
            self._radio += 1
            out.append('     <div class="qp-item" data-a="%d">' % (correcta[0] if correcta else 0))
            out.append('       <p class="qp-q">%s</p>' % fmt(texto))
            out.extend(cuerpo)
            out.append('       <div class="qp-opts">')
            for k, (_, op) in enumerate(opciones):
                out.append('         <label class="qp-opt"><input type="radio" name="%s" value="%d">%s</label>'
                           % (nombre, k, fmt(op)))
            out.append('       </div>')
            out.append('     </div>')
        else:
            out.append('     <div class="qp-bloq">')
            out.append('       <p class="qp-q">%s</p>' % fmt(texto))
            out.extend(cuerpo)
            if respuestas:
                inputs = [input_html(r, 'qp-l' if len(r.split('|')[0].strip()) >= 24 else '')
                          for r in respuestas]
                out.append('       ' + '<br>\n       '.join(inputs))
            out.append('     </div>')
        return '\n'.join(out)

    def imagen(self, resto, base, env):
        partes = resto.rsplit(None, 1)
        ancho = ''
        ruta = resto
        if len(partes) == 2 and partes[1].isdigit():
            ruta, ancho = partes[0], ' width="%s"' % partes[1]
        completa = os.path.join(base, ruta)
        env.note_dependency(completa)
        with open(completa, 'rb') as f:
            b64 = base64.b64encode(f.read()).decode('ascii')
        ext = os.path.splitext(ruta)[1].lstrip('.').lower() or 'png'
        nombre = os.path.splitext(os.path.basename(ruta))[0].replace('_', ' ')
        return ('     <img class="qp-img"%s alt="%s"\n'
                '          src="data:image/%s;base64,%s">' % (ancho, esc(nombre), ext, b64))

    def fichero(self, titulo, lineas):
        cuerpo = []
        if titulo:
            cuerpo.append('$ cat %s' % esc(titulo))
        cuerpo.extend(esc(l) for l in lineas)
        return '     <pre class="qp-pre">%s</pre>' % '\n'.join(cuerpo)

    def tabla(self, titulo, filas):
        out = ['     <table class="qp-tabla">']
        if titulo:
            out.append('       <caption style="caption-side: top; font-weight: bold;">%s</caption>' % fmt(titulo))
        for k, f in enumerate(filas):
            celdas = [c.strip() for c in f.strip().strip('|').split('|')]
            tag = 'th' if k == 0 else 'td'
            fila = ''.join('<%s>%s</%s>' % (tag, inline(c) if c else '&nbsp;', tag) for c in celdas)
            out.append('       <tr>%s</tr>' % fila)
        out.append('     </table>')
        return '\n'.join(out)

    def filas(self, opciones, filas):
        clases = 'qp-filas'
        estilo = ''
        if 'numeradas' in opciones:
            clases += ' qp-num'
        m = re.search(r'ancho=(\S+)', opciones)
        if m:
            estilo = ' style="--qpw:%s"' % m.group(1)
        out = ['     <table class="%s"%s>' % (clases, estilo)]
        for f in filas:
            celdas = self._celdas_con_huecos(f)
            if len(celdas) == 1:
                idx = f.find('[')
                celdas = [f, ''] if idx < 0 else [f[:idx].rstrip(), f[idx:]]
            fila = ''.join('<td>%s</td>' % (inline(c, auto_clase=False) if c else '&nbsp;')
                           for c in celdas)
            out.append('       <tr>%s</tr>' % fila)
        out.append('     </table>')
        return '\n'.join(out)

    @staticmethod
    def _celdas_con_huecos(fila):
        """Divide por | respetando las alternativas dentro de [ ... ]."""
        celdas, actual, dentro = [], '', False
        for ch in fila:
            if ch == '[':
                dentro = True
            elif ch == ']':
                dentro = False
            if ch == '|' and not dentro:
                celdas.append(actual.strip())
                actual = ''
            else:
                actual += ch
        celdas.append(actual.strip())
        return [c for c in celdas]


def setup(app):
    app.add_directive('cuestionario', Cuestionario)
    return {'version': '1.0', 'parallel_read_safe': True}
