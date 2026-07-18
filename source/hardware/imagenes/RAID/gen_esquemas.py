# Genera los diagramas de los esquemas RAID del cuestionario,
# imitando el estilo clásico de los diagramas RAID de la Wikipedia:
# cilindros con bandas de colores por bloque y conectores ortogonales.
# Leaf = lista de bloques (strings); nodo interno = lista de hijos.
import os

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Ellipse

OUT = os.path.dirname(os.path.abspath(__file__)) + '/'

W, GAP = 1.0, 0.4            # ancho de disco y separación
BAND, GRAY_H, RY = 0.32, 0.5, 0.115
EDGE = '#666666'
LINE = dict(color='#333333', lw=1.7, zorder=1)
COLORS = {'A': ('#f6c46a', '#fbe3b5'),      # (banda, tapa clara)
          'B': ('#b9d38a', '#dcebc2'),
          '_': ('#d8d8d8', '#ebebeb')}      # cuerpo gris


def is_leaf(n):
    return all(isinstance(b, str) for b in n)


def depth(n):
    return 1 if is_leaf(n) else 1 + max(depth(c) for c in n)


def iter_leaves(n):
    if is_leaf(n):
        yield n
    else:
        for c in n:
            yield from iter_leaves(c)


def draw_disk(ax, x, blocks, idx):
    """Cilindro con una banda por bloque (arriba) y cuerpo gris (abajo)."""
    n = len(blocks)
    h_total = GRAY_H + n * BAND
    cx = x + W / 2
    # cuerpo gris
    ax.add_patch(Ellipse((cx, 0), W, 2*RY, facecolor=COLORS['_'][0],
                         edgecolor=EDGE, lw=1, zorder=2))
    ax.add_patch(Rectangle((x, 0), W, GRAY_H, facecolor=COLORS['_'][0],
                           edgecolor='none', zorder=3))
    ax.plot([x, x], [0, h_total], color=EDGE, lw=1, zorder=4)
    ax.plot([x+W, x+W], [0, h_total], color=EDGE, lw=1, zorder=4)
    # bandas de bloques, de abajo hacia arriba (última banda = último bloque)
    y = GRAY_H
    for b in reversed(blocks):
        fila = 'B' if b.upper().startswith('B') else 'A'
        cara, tapa = COLORS[fila]
        ax.add_patch(Ellipse((cx, y), W, 2*RY, facecolor=cara,
                             edgecolor=EDGE, lw=1, zorder=3))
        ax.add_patch(Rectangle((x, y), W, BAND, facecolor=cara,
                               edgecolor='none', zorder=3))
        # la banda visible va de y-RY a y+BAND-RY (las elipses de los
        # bordes tapan la parte alta), centramos la etiqueta ahí
        ax.text(cx, y + BAND/2 - RY, b, ha='center', va='center',
                fontsize=11, zorder=6, family='DejaVu Sans')
        y += BAND
    # tapa superior
    tapa = COLORS['B' if blocks[0].upper().startswith('B') else 'A'][1]
    ax.add_patch(Ellipse((cx, y), W, 2*RY, facecolor=tapa,
                         edgecolor=EDGE, lw=1, zorder=5))
    ax.text(cx, -RY - 0.16, 'Disk %d' % idx, ha='center', va='top',
            fontsize=11, family='DejaVu Serif', fontweight='bold')
    return cx, y + RY                       # punto de conexión superior


def y_bar(level, y_disk_top):
    return y_disk_top + 0.30 + (level - 2) * 0.46


def layout(ax, node, cursor, idx, y_disk_top):
    """Dibuja node; devuelve (cx, cy) de su punto de conexión superior."""
    if is_leaf(node):
        x = cursor[0]
        cursor[0] += W + GAP
        cx, cy = draw_disk(ax, x, node, idx[0])
        idx[0] += 1
        return cx, cy
    pts = [layout(ax, c, cursor, idx, y_disk_top) for c in node]
    y = y_bar(depth(node), y_disk_top)
    x0, x1 = pts[0][0], pts[-1][0]
    ax.plot([x0, x1], [y, y], **LINE)                     # barra horizontal
    for px, py in pts:
        ax.plot([px, px], [py + 0.03, y], **LINE)         # bajada a cada hijo
    return (x0 + x1) / 2, y


def render(name, tree):
    n_disks = sum(1 for _ in iter_leaves(tree))
    n_bands = max(len(l) for l in iter_leaves(tree))
    y_disk_top = GRAY_H + n_bands * BAND + RY
    width = n_disks * (W + GAP) - GAP
    top = y_bar(depth(tree), y_disk_top)
    fig, ax = plt.subplots(figsize=((width + 0.5) * 0.78,
                                    (top + 1.05) * 0.78))
    cursor, idx = [0.0], [0]
    cx, cy = layout(ax, tree, cursor, idx, y_disk_top)
    ax.plot([cx, cx], [cy, cy + 0.18], **LINE)
    ax.text(cx, cy + 0.24, '¿RAID?', ha='center', va='bottom',
            fontsize=15, family='DejaVu Serif', fontweight='bold')
    ax.set_xlim(-0.25, width + 0.25)
    ax.set_ylim(-RY - 0.55, top + 0.62)
    ax.set_aspect('equal')
    ax.axis('off')
    fig.savefig(OUT + name, dpi=150, bbox_inches='tight',
                facecolor='white', transparent=False)
    plt.close(fig)
    print('->', name)


L = lambda *b: list(b)   # leaf

ESQUEMAS = {
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

for name, tree in ESQUEMAS.items():
    render(name, tree)
