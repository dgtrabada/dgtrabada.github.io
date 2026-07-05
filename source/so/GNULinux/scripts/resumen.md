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
