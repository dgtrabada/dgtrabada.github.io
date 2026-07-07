# Resumen de complejidad de los scripts

Análisis de los scripts de `source/so/GNULinux/scripts/` usados como soluciones en
`15_ejercicios_shell_scripting.rst` (~1.600 líneas en total), ordenados por complejidad creciente.

## Nivel 1 — Tuberías y filtros (3–6 líneas)

`disk.sh`, `mem.sh`, `mac.sh`, `rep.sh`

Una sola línea efectiva: comando de sistema (`df`, `free`, `ip link`) encadenado con
`grep | tr -s | cut`. Introducen la redirección `>>` (`mem.sh`) y la cadena clásica
`sort | uniq -c | sort -rn` (`rep.sh`). Sin variables ni control de flujo.

## Nivel 2 — Bucle `for` sobre salida de comandos (5–10 líneas)

`listar_usuario_grupo.sh`, `lastlog_ip.sh`, `lastlog.sh`, `imag.sh`

Primer bucle: `for i in $(comando | filtros)`. Combinan iteración con los filtros del
nivel 1 y añaden el patrón de ordenar la salida de todo el bucle (`done | sort -rn`).

## Nivel 3 — Variables, `read`, aritmética y decimales (10–17 líneas)

`tabla_multiplicar_read.sh`, `temperatura.sh` (y variantes), `rnd.sh`

For estilo C `for((i=1;i<11;i++))`, aritmética entera `$(( ))`, lectura de teclado con
`read`, y `bc -l` para decimales. Aparece el patrón (poco eficiente pero didáctico) de
leer línea a línea con `head -$i fichero | tail -1`.

## Nivel 4 — Argumentos, funciones y condicionales (14–42 líneas)

`tabla_multiplicar.sh`, `adivina.sh`, `monedas.sh`, `dados.sh`, `contar_monedas.sh`, `notas.sh`

Se introduce todo el manejo de la línea de comandos: `$#`, `$1`, valores por defecto
`${1:-1000}`, función `show_help()`, `--help`, `test -f`. En `adivina.sh` aparece el
`while` interactivo, y en `notas.sh` el parsing de campos con `cut` multinivel y
colores ANSI.

## Nivel 5 — Arrays y bucles anidados (17–60 líneas)

Variantes `*_array.sh`, `piedra_papel_tijera.sh`, `tragaperras.sh`, `dados.sh`/`ndados.sh`,
`adivina_cpu.sh`

Los más interesantes algorítmicamente:

- `rep_array.sh` — cuenta repetidos "a mano" con tres pases de bucles anidados,
  complejidad **O(n²)** (frente a la versión `rep.sh` de una línea; buen contraste didáctico).
- `adivina_cpu.sh` — búsqueda aleatoria acotada (una especie de búsqueda binaria
  estocástica) con `while` anidado para evitar repetidos y ajuste dinámico de mínimo/máximo.
- `ndados.sh` — generaliza `dados.sh` a N dados con parsing de opciones mediante `shift`,
  funciones y array de frecuencias.
- `notas_awk.sh` — el programa awk más completo del conjunto: `BEGIN/END`, separador
  múltiple `-F'[:,]'`, contadores y `printf`.

## Nivel 6 — Mini-CLI con subcomandos (49–72 líneas)

`analizar_cal.sh`, `ip.sh`, `usuarios_WSL.sh`, `usuarios.sh`

Estructura de "herramienta" con varias opciones (`-file`, `-find`, `-read`, `-addgroup`…),
validación de entradas y valores por defecto encadenados. `usuarios.sh` ya toca
administración real (`useradd`, `groupadd`, `mkpasswd`).

## Nivel 7 — Administración de sistemas y LDAP (37–160 líneas)

`sinc.sh`, `crear/borrar_usuarios_(grupo_)lista.sh`, `crear_usuarios_ldap.sh`,
`crear_usuarios_lista_ldap.sh`

Los más complejos del conjunto: `sinc.sh` orquesta `rsync`/`scp`/`ssh` entre varias
máquinas con `sed -i` sobre claves SSH; los de LDAP (141 y 160 líneas) combinan
**heredocs** para generar `.ldif`, `ldapsearch/ldapadd/ldapdelete`, cálculo automático
de uid/gid y anidamiento de condicionales de 4–5 niveles.

## Lista completa script a script

Todos los scripts ordenados por complejidad creciente, con su nivel, número de líneas
y el concepto principal que introduce cada uno. Incluye cuatro no clasificados arriba:
`cpu.sh` (nivel 1), `if.sh` (nivel 2), `calc.sh` (nivel 6) y `flor.sh` (nivel 5).

### Nivel 1 — Tuberías y filtros

| Script | Líneas | Qué introduce |
|---|---|---|
| `rep.sh` | 3 | `sort \| uniq -c \| sort -rn` |
| `disk.sh` | 4 | `df` + `grep`/`tr`/`cut` |
| `mac.sh` | 5 | `ip link` filtrado |
| `cpu.sh` | 6 | `/proc/cpuinfo` + filtros |
| `mem.sh` | 6 | `free` y redirección `>>` |
| `temperatura_awk.sh` | 7 | primer contacto con `awk` |

### Nivel 2 — Bucle `for` sobre salida de comandos

| Script | Líneas | Qué introduce |
|---|---|---|
| `listar_usuario_grupo.sh` | 6 | `for i in $(comando)` |
| `if.sh` | 14 | condicional básico `[ ]` vs `test` |
| `lastlog_ip.sh` | 8 | bucle + filtros |
| `lastlog.sh` | 9 | ordenar la salida del bucle |
| `imag.sh` | 10 | `done \| sort -rn` |

### Nivel 3 — Variables, `read`, aritmética y decimales

| Script | Líneas | Qué introduce |
|---|---|---|
| `tabla_multiplicar_read.sh` | 10 | `read`, `$(( ))` |
| `temperatura.sh` | 10 | `bc -l`, leer fichero con `head \| tail` |
| `rnd.sh` | 14 | `$RANDOM` |
| `temperatura_array.sh` | 17 | primera aparición de arrays |
| `rnd_array.sh` | 19 | array de frecuencias |
| `meteo.sh` (y variantes) | 48 | varias columnas: `read` multivariable, comparar decimales con `bc` |

### Nivel 4 — Argumentos, funciones y condicionales

| Script | Líneas | Qué introduce |
|---|---|---|
| `alerta_disco.sh` | 13 | umbral con argumento, `date`, `tee -a`, `while read` sobre `df` |
| `dados.sh` | 23 | simulación con contadores |
| `menu.sh` | 25 | menú interactivo con `select` + `case`, `PS3` |
| `adivina.sh` | 26 | `while` interactivo |
| `tabla_multiplicar.sh` | 29 | `$#`, `$1`, `show_help()`, `--help` |
| `contar_monedas_array.sh` | 30 | fichero → array |
| `tabla_multiplicar_array.sh` | 33 | argumentos + arrays |
| `contar_monedas.sh` | 40 | `test -f`, valores por defecto |
| `monedas.sh` | 42 | `${1:-1000}` |
| `notas.sh` | 54 | `cut` multinivel, colores ANSI |
| `notas_csv.sh` | 41 | mismo ejercicio sobre csv: `IFS=','` + `read` sustituye a los `cut` |

### Nivel 5 — Arrays, bucles anidados y juegos

| Script | Líneas | Qué introduce |
|---|---|---|
| `duplicados.sh` | 14 | hashes con `md5sum`, `find -exec`, archivo temporal con `$$` |
| `tragaperras.sh` | 37 | arrays + azar |
| `rep_array.sh` | 42 | contar repetidos a mano, **O(n²)** (contraste con `rep.sh`) |
| `adivina_cpu.sh` | 52 | búsqueda aleatoria acotada, `while` anidado |
| `piedra_papel_tijera.sh` | 58 | `case` sobre entrada del usuario |
| `notas_awk.sh` | 65 | awk completo: `BEGIN/END`, `-F'[:,]'`, `printf` |
| `flor.sh` | 106 | manipulación de cadenas (`${secreta:$i:1}`, `sed`), estado del juego (antes `ahorcado.sh`) |

### Nivel 6 — Mini-CLI con subcomandos

| Script | Líneas | Qué introduce |
|---|---|---|
| `analizar_cal.sh` | 49 | opciones `-file`, `-find`… |
| `usuarios_WSL.sh` | 56 | subcomandos + validación |
| `ip.sh` | 59 | opciones encadenadas |
| `ndados.sh` | 59 | parsing con `shift`, generaliza `dados.sh` |
| `calc.sh` | 61 | `shift 2` + `case`, operaciones encadenadas (`2 -sum 4 -sum 7`) |
| `backup.sh` | 65 | `tar`, `date +%F`, `find -mtime -delete`, `basename`, `du -h` |
| `usuarios.sh` | 72 | administración real: `useradd`, `groupadd`, `mkpasswd` |
| `inventario.sh` | 134 | CSV con cabecera: `IFS=','` + `read`, `sed -i` para borrar, `column -t -s','`, `awk -F','` con `NR>1` |

### Nivel 7 — Administración de sistemas y LDAP

| Script | Líneas | Qué introduce |
|---|---|---|
| `borrar_usuarios_lista.sh` | 18 | borrado masivo desde fichero |
| `crear_usuarios_lista.sh` | 27 | alta masiva desde fichero |
| `crear_usuarios_grupo_lista.sh` | 33 | + gestión de grupos |
| `borrar_usuarios_grupo_lista.sh` | 35 | + limpieza de grupos |
| `sinc.sh` | 37 | orquesta `rsync`/`scp`/`ssh` entre máquinas |
| `crear_usuarios_ldap.sh` | 141 | heredocs `.ldif`, `ldapsearch/ldapadd`, cálculo de uid/gid |
| `crear_usuarios_lista_ldap.sh` | 160 | el más complejo: todo lo anterior + anidamiento de 4–5 niveles |

Los scripts de listas de usuarios del nivel 7 son cortos en líneas pero se mantienen ahí
porque requieren privilegios y tocan el sistema real. Quedan fuera `a.sh` (vacío) y
`cpu-Copy1.sh` (duplicado de checkpoint de Jupyter).

## Observaciones transversales

- La progresión de conceptos es clara: tuberías → bucles → variables/aritmética →
  argumentos/funciones → arrays → subcomandos → administración remota/LDAP.
- Hay parejas "misma tarea, dos enfoques" muy útiles (`rep.sh` vs `rep_array.sh`,
  `temperatura` en bc/awk/array, `dados` vs `ndados`) que muestran el salto de
  complejidad entre usar filtros de Unix y programarlo a mano.
- Detalles menores revisables: `contar_monedas.sh` itera 1000 veces sobre un fichero de
  10 líneas, `contar_monedas_array.sh` empieza en `i=1` y se salta la primera línea,
  `a.sh` está vacío y `cpu-Copy1.sh` parece un duplicado de checkpoint de Jupyter, y
  varios `grep -c $usuario /etc/passwd` darían falsos positivos con nombres que son
  subcadenas de otros (p. ej. `ana` y `mariana`).
