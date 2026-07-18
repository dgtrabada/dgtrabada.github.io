# Genera los diagramas RAID de la teoría y del cuestionario con un estilo
# uniforme (inspirado en los diagramas RAID clásicos de la Wikipedia):
# cilindros con bandas de colores por fila de bloques (A/B/C/D), subíndices
# en la paridad (Ap -> A con p subíndice) y conectores ortogonales.
#
# Estructura de un esquema:
#   * disco (hoja)            = lista de bloques:      L('A1', 'B1')
#   * grupo sin etiqueta      = lista de hijos:        [d1, d2]
#   * grupo con etiqueta      = tupla (label, hijos):  ('RAID 5', [d1, d2, d3])
#
# render(nombre, arbol, title='RAID 5+0', sizes='120GB') dibuja el árbol y
# guarda el PNG en el directorio del propio script.
import os
import re

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Ellipse

OUT = os.path.dirname(os.path.abspath(__file__)) + '/'

W, GAP = 1.0, 0.4            # ancho de disco y separación
BAND, GRAY_H, RY = 0.32, 0.5, 0.115
EDGE = '#666666'
LINE = dict(color='#333333', lw=1.7, zorder=1)
SERIF = 'DejaVu Serif'
COLORS = {'A': ('#f6c46a', '#fbe3b5'),      # (banda, tapa clara)
          'B': ('#e9ed77', '#f6f8c4'),
          'C': ('#8de08d', '#d2f2d2'),
          'D': ('#84c9f2', '#cfe9fa'),
          '_': ('#d8d8d8', '#ebebeb')}      # cuerpo gris


def L(*bloques):
    return list(bloques)


def etiqueta(nodo):
    return nodo[0] if isinstance(nodo, tuple) else None


def hijos(nodo):
    return nodo[1] if isinstance(nodo, tuple) else nodo


def es_disco(nodo):
    return not isinstance(nodo, tuple) and all(isinstance(b, str) for b in nodo)


def profundidad(nodo):
    return 1 if es_disco(nodo) else 1 + max(profundidad(h) for h in hijos(nodo))


def discos_de(nodo):
    if es_disco(nodo):
        yield nodo
    else:
        for h in hijos(nodo):
            yield from discos_de(h)


def con_etiquetas(nodo):
    if es_disco(nodo):
        return False
    return etiqueta(nodo) is not None or any(con_etiquetas(h) for h in hijos(nodo))


def texto_bloque(b):
    """Ap -> A con p subíndice; A1 se deja tal cual."""
    m = re.fullmatch(r'([A-Za-z])([pq])', b)
    if m:
        return '%s$_\\mathrm{%s}$' % m.groups()
    return b


class Dibujo:
    def __init__(self, ax, paso_nivel):
        self.ax = ax
        self.paso = paso_nivel
        self.x = 0.0
        self.n_disco = 0
        self.sizes = None

    def y_barra(self, nivel, y_disco_top):
        return y_disco_top + 0.30 + (nivel - 2) * self.paso

    def disco(self, bloques, y_disco_top):
        ax, x = self.ax, self.x
        n = len(bloques)
        h_total = GRAY_H + n * BAND
        cx = x + W / 2
        ax.add_patch(Ellipse((cx, 0), W, 2*RY, facecolor=COLORS['_'][0],
                             edgecolor=EDGE, lw=1, zorder=2))
        ax.add_patch(Rectangle((x, 0), W, GRAY_H, facecolor=COLORS['_'][0],
                               edgecolor='none', zorder=3))
        ax.plot([x, x], [0, h_total], color=EDGE, lw=1, zorder=4)
        ax.plot([x+W, x+W], [0, h_total], color=EDGE, lw=1, zorder=4)
        y = GRAY_H
        for b in reversed(bloques):
            fila = b[0].upper() if b[0].upper() in COLORS else 'A'
            cara, _ = COLORS[fila]
            ax.add_patch(Ellipse((cx, y), W, 2*RY, facecolor=cara,
                                 edgecolor=EDGE, lw=1, zorder=3))
            ax.add_patch(Rectangle((x, y), W, BAND, facecolor=cara,
                                   edgecolor='none', zorder=3))
            # la banda visible va de y-RY a y+BAND-RY (las elipses de los
            # bordes tapan la parte alta), centramos la etiqueta ahí
            ax.text(cx, y + BAND/2 - RY, texto_bloque(b), ha='center',
                    va='center', fontsize=11, zorder=6)
            y += BAND
        tapa = COLORS[bloques[0][0].upper() if bloques[0][0].upper() in COLORS else 'A'][1]
        ax.add_patch(Ellipse((cx, y), W, 2*RY, facecolor=tapa,
                             edgecolor=EDGE, lw=1, zorder=5))
        ax.text(cx, -RY - 0.16, 'Disk %d' % self.n_disco, ha='center',
                va='top', fontsize=11, family=SERIF, fontweight='bold')
        if self.sizes:
            ax.text(cx, -RY - 0.44, self.sizes, ha='center', va='top',
                    fontsize=9, family=SERIF)
        self.n_disco += 1
        self.x += W + GAP
        return cx, y + RY

    def nodo(self, n, y_disco_top):
        """Dibuja n; devuelve (cx, cy) de su punto de conexión superior."""
        if es_disco(n):
            return self.disco(n, y_disco_top)
        pts = [self.nodo(h, y_disco_top) for h in hijos(n)]
        y = self.y_barra(profundidad(n), y_disco_top)
        x0, x1 = pts[0][0], pts[-1][0]
        self.ax.plot([x0, x1], [y, y], **LINE)                # barra horizontal
        for px, py in pts:
            self.ax.plot([px, px], [py + 0.03, y], **LINE)    # bajada a cada hijo
        cx = (x0 + x1) / 2
        if etiqueta(n):
            self.ax.text(cx, y + 0.10, etiqueta(n), ha='center', va='bottom',
                         fontsize=13, family=SERIF)
            return cx, y + 0.46                # el conector del padre no pisa la etiqueta
        return cx, y


def render(name, tree, title=None, sizes=None):
    n_discos = sum(1 for _ in discos_de(tree))
    n_bandas = max(len(d) for d in discos_de(tree))
    y_disco_top = GRAY_H + n_bandas * BAND + RY
    paso = 0.80 if con_etiquetas(tree) else 0.46
    width = n_discos * (W + GAP) - GAP
    alto_pie = 0.75 if sizes else 0.55
    dib_tmp = Dibujo(None, paso)
    top_est = dib_tmp.y_barra(profundidad(tree), y_disco_top) + 0.46
    fig, ax = plt.subplots(figsize=((width + 0.5) * 0.78,
                                    (top_est + alto_pie + 0.55) * 0.78))
    dib = Dibujo(ax, paso)
    dib.sizes = sizes
    cx, cy = dib.nodo(tree, y_disco_top)
    if title:
        ax.plot([cx, cx], [cy - 0.43 if etiqueta(tree) else cy, cy], color='none')
        ax.text(cx, cy + 0.12, title, ha='center', va='bottom',
                fontsize=17, family=SERIF)
    ax.set_xlim(-0.25, width + 0.25)
    ax.set_ylim(-RY - alto_pie, cy + 0.70)
    ax.set_aspect('equal')
    ax.axis('off')
    fig.savefig(OUT + name, dpi=150, bbox_inches='tight',
                facecolor='white', transparent=False)
    plt.close(fig)
    print('->', name)


# ---------------------------------------------------------------- teoría
G5A = [L('A1', 'B1', 'Cp', 'D1'), L('A2', 'Bp', 'C1', 'D2'), L('Ap', 'B2', 'C2', 'Dp')]
G5B = [L('A3', 'B3', 'Cp', 'D3'), L('A4', 'Bp', 'C3', 'D4'), L('Ap', 'B4', 'C4', 'Dp')]
G5C = [L('A5', 'B5', 'Cp', 'D5'), L('A6', 'Bp', 'C5', 'D6'), L('Ap', 'B6', 'C6', 'Dp')]

TEORIA = {
    'raid0.png': ('RAID 0', None,
                  [L('A1', 'A3', 'A5', 'A7'), L('A2', 'A4', 'A6', 'A8')]),
    'raid1.png': ('RAID 1', None,
                  [L('A1', 'A2', 'A3', 'A4'), L('A1', 'A2', 'A3', 'A4')]),
    'raid3.png': ('RAID 3', None,
                  [L('A1', 'B1', 'C1', 'D1'), L('A2', 'B2', 'C2', 'D2'),
                   L('A3', 'B3', 'C3', 'D3'), L('Ap', 'Bp', 'Cp', 'Dp')]),
    'raid5.png': ('RAID 5', None,
                  [L('A1', 'B1', 'C1', 'Dp'), L('A2', 'B2', 'Cp', 'D1'),
                   L('A3', 'Bp', 'C2', 'D2'), L('Ap', 'B3', 'C3', 'D3')]),
    'raid6.png': ('RAID 6', None,
                  [L('A1', 'B1', 'C1', 'Dp'), L('A2', 'B2', 'Cp', 'Dq'),
                   L('A3', 'Bp', 'Cq', 'D1'), L('Ap', 'Bq', 'C2', 'D2'),
                   L('Aq', 'B3', 'C3', 'D3')]),
    'raid01.png': ('RAID 0+1', None,
                   ('RAID 1',
                    [('RAID 0', [L('A1', 'A3', 'A5', 'A7'), L('A2', 'A4', 'A6', 'A8')]),
                     ('RAID 0', [L('A1', 'A3', 'A5', 'A7'), L('A2', 'A4', 'A6', 'A8')])])),
    'raid10.png': ('RAID 1+0', None,
                   ('RAID 0',
                    [('RAID 1', [L('A1', 'A3', 'A5', 'A7'), L('A1', 'A3', 'A5', 'A7')]),
                     ('RAID 1', [L('A2', 'A4', 'A6', 'A8'), L('A2', 'A4', 'A6', 'A8')])])),
    'raid100.png': ('RAID 100', None,
                    ('RAID 0',
                     [('RAID 0',
                       [('RAID 1', [L('A1', 'A5', 'B1', 'B5'), L('A1', 'A5', 'B1', 'B5')]),
                        ('RAID 1', [L('A2', 'A6', 'B2', 'B6'), L('A2', 'A6', 'B2', 'B6')])]),
                      ('RAID 0',
                       [('RAID 1', [L('A3', 'A7', 'B3', 'B7'), L('A3', 'A7', 'B3', 'B7')]),
                        ('RAID 1', [L('A4', 'A8', 'B4', 'B8'), L('A4', 'A8', 'B4', 'B8')])])])),
    'raid50.png': ('RAID 5+0', None,
                   ('RAID 0', [('RAID 5', G5A), ('RAID 5', G5B)])),
    'raid51.png': ('RAID 51', None,
                   ('RAID 1', [('RAID 5', G5A), ('RAID 5', G5A)])),
    'raid50_3.png': ('RAID 5+0', '120GB',
                     ('RAID 0', [('RAID 5', G5A), ('RAID 5', G5B), ('RAID 5', G5C)])),
}

# ------------------------------------------------------------ cuestionario
QUIZ = {
    # RAID (I): 6 discos de 1 TB
    'quiz_raid_i_1.png': [L('A01', 'A07'), L('A02', 'A08'), L('A03', 'A09'),
                          L('A04', 'A10'), L('A05', 'A11'), L('A06', 'A12')],
    'quiz_raid_i_2.png': [L('A1', 'B1'), L('A2', 'B2'), L('A3', 'Bp'),
                          L('A4', 'B3'), L('A5', 'B4'), L('Ap', 'B5')],
    'quiz_raid_i_3.png': [[L('A1', 'A3'), L('A2', 'A4')],
                          [L('A1', 'A3'), L('A2', 'A4')],
                          [L('A1', 'A3'), L('A2', 'A4')]],
    'quiz_raid_i_4.png': [[L('A1', 'A4'), L('A1', 'A4')],
                          [L('A2', 'A5'), L('A2', 'A5')],
                          [L('A3', 'A6'), L('A3', 'A6')]],
    'quiz_raid_i_5.png': [[L('A1', 'A4'), L('A2', 'A5'), L('A3', 'A6')],
                          [L('A1', 'A4'), L('A2', 'A5'), L('A3', 'A6')]],
    'quiz_raid_i_6.png': [[L('A1', 'A3'), L('A1', 'A3'), L('A1', 'A3')],
                          [L('A2', 'A4'), L('A2', 'A4'), L('A2', 'A4')]],
    # RAID (II): 8 discos de 1 TB, tres niveles
    'quiz_raid_ii_1.png': [[[L('A1', 'A5'), L('A1', 'A5')], [L('A2', 'A6'), L('A2', 'A6')]],
                           [[L('A3', 'A7'), L('A3', 'A7')], [L('A4', 'A8'), L('A4', 'A8')]]],
    'quiz_raid_ii_2.png': [[[L('A1', 'A3'), L('A1', 'A3')], [L('A1', 'A3'), L('A1', 'A3')]],
                           [[L('A2', 'A4'), L('A2', 'A4')], [L('A2', 'A4'), L('A2', 'A4')]]],
    'quiz_raid_ii_3.png': [[[L('A1', 'A5'), L('A2', 'A6')], [L('A3', 'A7'), L('A4', 'A8')]],
                           [[L('A1', 'A5'), L('A2', 'A6')], [L('A3', 'A7'), L('A4', 'A8')]]],
    'quiz_raid_ii_4.png': [[[L('A1', 'A3'), L('A1', 'A3')], [L('A2', 'A4'), L('A2', 'A4')]],
                           [[L('A1', 'A3'), L('A1', 'A3')], [L('A2', 'A4'), L('A2', 'A4')]]],
}

for name, (title, sizes, tree) in TEORIA.items():
    render(name, tree, title=title, sizes=sizes)

for name, tree in QUIZ.items():
    render(name, tree, title='¿RAID?')
