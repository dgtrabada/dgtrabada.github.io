# Resumen de complejidad de los scripts PowerShell

Análisis de los scripts de `source/so/windows/10_powershell/` usados en
`10_powershell_scripting.rst` y `11_ejercicios_powershell.rst` (~1.875 líneas en total,
49 scripts), ordenados por complejidad creciente. La estructura es paralela al
`resumen.md` de los scripts bash de GNULinux.

## Nivel 1 — Cmdlets y tuberías (4–17 líneas)

`mac.ps1`, `ext.ps1`, `cpu.ps1`, `disk.ps1`, `mac2.ps1`, `mem.ps1`

El equivalente a los filtros de bash pero con objetos: `Get-NetAdapter | Where-Object |
Format-Table`, `Get-CimInstance | Select-Object -ExpandProperty`. Ya aparece el formato
`"{0:N2}" -f` (`disk.ps1`) y la escritura en log con `Add-Content` (`mem.ps1`, el gemelo
de `mem.sh`). `ext.ps1` es el gemelo de `imag.sh`: renombrar extensiones con `-replace`.

## Nivel 2 — `Read-Host`, tipos y bucles `for` (9–14 líneas)

`tres_numeros.ps1`, `tres_numeros_decimales.ps1`, `mult.ps1`, `impar.ps1`, `edad.ps1`

Lectura de teclado con conversión de tipo explícita (`[int]`, `[Double]`), primera gran
diferencia con bash. `for ($i=1; $i -le 10; $i++)`, operadores `-eq`/`-le`, formato
decimal `"{0:F2}" -f` y fechas con `(Get-Date).Year`.

## Nivel 3 — Argumentos: `$args` frente a `param()` (11–47 líneas)

`impar_args.ps1`, `mult_param.ps1`, `tres_numeros_param.ps1`, `usuario_args.ps1`,
`impar_param.ps1`, `usuario_param.ps1`, `usuario_args2.ps1`, `usuario_param_help.ps1`,
`usuario_args3.ps1`

El bloque más didáctico del conjunto: la misma tarea (crear un usuario validando la
edad) resuelta con enfoques crecientes. `usuario_args.ps1` usa `$args` posicionales
frágiles, `usuario_args2/3.ps1` parsean los `-flags` a mano con un bucle (lo que en bash
era obligatorio), y `usuario_param.ps1`/`usuario_param_help.ps1` muestran que `param()`
con valores por defecto, `Mandatory` y `[switch]` da gratis lo que en bash costaba una
función `show_help`.

## Nivel 4 — Control de flujo: `switch`, `while`/`do` y azar (13–34 líneas)

`monedas.ps1`, `puerta.ps1`, `piedra_papel_tijera.ps1`, `puerta_if.ps1`, `puerta2.ps1`,
`rnd_do_until.ps1`, `rnd_do_while.ps1`, `rnd.ps1`, `piedra_papel_tijera_switch.ps1`

Tres parejas "misma tarea, dos enfoques": `puerta_if.ps1` (if/elseif) frente a
`puerta.ps1` (switch), `piedra_papel_tijera.ps1` (tabla de 9 ifs) frente a
`piedra_papel_tijera_switch.ps1` (switch anidado), y el juego de adivinar en tres
variantes de bucle (`while`, `do…while`, `do…until`). `Get-Random` sustituye a `$RANDOM`,
incluyendo la forma idiomática `"piedra","papel","tijeras" | Get-Random`.

## Nivel 5 — Arrays, funciones y CSV (25–45 líneas)

`analisis.ps1`, `n_monedas.ps1`, `tragaperras.ps1`, `dados.ps1`, `dados_param.ps1`,
`analisis_variables.ps1`

Arrays con `@(0)*N`, funciones con `return` (`tragaperras.ps1`) y la entrada al mundo
CSV: `dados.ps1` genera `tiradas.csv` y `analisis.ps1` lo lee con `Import-Csv`
accediendo a la columna como propiedad (`$A.Suma`). El contraste estrella es
`analisis_variables.ps1` (11 contadores `$s2…$s12` a mano) frente a `analisis.ps1`
(un array de frecuencias): el equivalente PowerShell de `rep_array.sh` vs `rep.sh`.

## Nivel 6 — Mini-CLI con `param()` + funciones + CSV (67–88 líneas)

`csv.ps1`, `usuarios_G00.ps1`, `usuario_csv.ps1`, `notas.ps1`, `notas_sin_duplicados.ps1`

La estructura de herramienta: un bloque `param()` con `[switch]` para cada subcomando y
una función por acción, despachadas al final (`if ($help) {…}`). Todos hacen CRUD sobre
un CSV con `Import-Csv | Where-Object` y `Export-Csv -NoTypeInformation`, más
generación de contraseñas aleatorias. `notas.ps1` vs `notas_sin_duplicados.ps1` es la
pareja "versión ingenua / versión que valida existencia". `usuarios_G00.ps1` es el
gemelo de `usuarios_WSL.sh` y ya toca usuarios reales.

## Nivel 7 — Administración local y Active Directory (17–216 líneas)

`crear_usuarios_grupos_ini.ps1`, `test_local_users.ps1`, `crear_usuarios_grupos_csv.ps1`,
`crear_usuarios_grupos.ps1`, `usuarios.ps1`, `test_AD.ps1`, `grupo.ps1`,
`local_users.ps1`, `AD.ps1`

Administración real con `New-LocalUser`/`New-LocalGroup`/`Add-LocalGroupMember` y
`ConvertTo-SecureString`. `usuarios.ps1` y `grupo.ps1` son menús interactivos
`do…until` + `switch` (los gemelos de `menu.sh`). `local_users.ps1` (167 líneas) es la
CLI completa de usuarios locales con `try/catch` para contraseñas inválidas, y
`AD.ps1` (216 líneas, el más largo del conjunto) la traslada a Active Directory
añadiendo OUs (`New-ADOrganizationalUnit`, `Get-ADGroup -Filter`). `test_local_users.ps1`
y `test_AD.ps1` son guiones de prueba que ejercitan todas las opciones y limpian al
acabar: el mismo patrón que los `uso_*.sh` de bash.

## Lista completa script a script

### Nivel 1 — Cmdlets y tuberías

| Script | Líneas | Qué introduce |
|---|---|---|
| `mac.ps1` | 4 | `Get-NetAdapter \| Where-Object \| Format-Table` |
| `ext.ps1` | 6 | `Get-ChildItem -Filter`, `-replace`, `Rename-Item` |
| `cpu.ps1` | 8 | `Get-CimInstance`, `Select-Object -ExpandProperty` |
| `disk.ps1` | 11 | `Get-PSDrive`, formato `"{0:N2}" -f` |
| `mac2.ps1` | 13 | `foreach` sobre colección de objetos |
| `mem.ps1` | 17 | `Get-Date -Format`, log con `Add-Content` |

### Nivel 2 — `Read-Host`, tipos y bucles

| Script | Líneas | Qué introduce |
|---|---|---|
| `tres_numeros.ps1` | 9 | `[int] $x = Read-Host` |
| `tres_numeros_decimales.ps1` | 9 | `[Double]`, `"{0:F2}" -f` |
| `mult.ps1` | 11 | `for ($i=1; $i -le 10; $i++)` |
| `impar.ps1` | 12 | `%` y condicional dentro del bucle |
| `edad.ps1` | 14 | `(Get-Date).Year` |

### Nivel 3 — Argumentos: `$args` frente a `param()`

| Script | Líneas | Qué introduce |
|---|---|---|
| `impar_args.ps1` | 11 | `$args[0]` |
| `mult_param.ps1` | 13 | `param()` con `Mandatory` y `HelpMessage` |
| `tres_numeros_param.ps1` | 13 | varios parámetros `Mandatory` |
| `usuario_args.ps1` | 13 | `$args` posicionales (frágil, a propósito) |
| `impar_param.ps1` | 14 | `param()` tipado |
| `usuario_param.ps1` | 16 | valores por defecto en `param()` |
| `usuario_args2.ps1` | 31 | parseo manual de `-flags` con bucle |
| `usuario_param_help.ps1` | 32 | `[switch]$help` + función de ayuda |
| `usuario_args3.ps1` | 47 | parseo manual + funciones |

### Nivel 4 — Control de flujo y azar

| Script | Líneas | Qué introduce |
|---|---|---|
| `monedas.ps1` | 13 | `Get-Random`, `-and` |
| `alerta_disco.ps1` | 20 | umbral con `param`, `Get-PSDrive` + `Add-Content` (gemelo de `alerta_disco.sh`) |
| `barrido_red.ps1` | 22 | `Test-Connection -Quiet`, rango `$desde..$hasta` |
| `puerta.ps1` | 16 | `switch` con `Default` |
| `piedra_papel_tijera.ps1` | 19 | tabla de 9 ifs, `\| Get-Random` sobre lista |
| `puerta_if.ps1` | 24 | `if`/`elseif` (contraste con `puerta.ps1`) |
| `puerta2.ps1` | 26 | `switch` con bloque anidado |
| `rnd_do_until.ps1` | 28 | `do … until` |
| `rnd_do_while.ps1` | 28 | `do … while` |
| `rnd.ps1` | 30 | `while` clásico |
| `piedra_papel_tijera_switch.ps1` | 34 | `switch` anidado |

### Nivel 5 — Arrays, funciones y CSV

| Script | Líneas | Qué introduce |
|---|---|---|
| `duplicados.ps1` | 15 | `Get-FileHash` + `Group-Object` (gemelo de `duplicados.sh`, sin archivo temporal) |
| `analisis.ps1` | 25 | `Import-Csv`, columna como propiedad (`$A.Suma`), array de frecuencias |
| `meteo.ps1` | 28 | `Import-Csv -Header`, `Measure-Object -Average`, `Sort-Object` por expresión (gemelo de `meteo.sh`) |
| `n_monedas.ps1` | 26 | array `@(0)*N`, generaliza `monedas.ps1` |
| `tragaperras.ps1` | 29 | `function` con `return` |
| `dados.ps1` | 33 | funciones + genera `tiradas.csv` |
| `dados_param.ps1` | 36 | lo mismo con `param()` |
| `analisis_variables.ps1` | 45 | 11 contadores a mano (contraste con `analisis.ps1`) |

### Nivel 6 — Mini-CLI con `param()` + funciones + CSV

| Script | Líneas | Qué introduce |
|---|---|---|
| `cuentas_inactivas.ps1` | 29 | `Get-LocalUser` + `LastLogon`, `Disable-LocalUser`, opción `-bloquear` (gemelo de `cuentas_inactivas.sh`) |
| `eventos.ps1` | 30 | `Get-WinEvent -FilterHashtable`, `.Properties`, `[PSCustomObject]` (gemelo de `lastlog_ip.sh`) |
| `informe.ps1` | 37 | `ConvertTo-Html -Fragment`, here-string `@"..."@`, reutiliza los pipelines de disk/procesos/servicios |
| `auditoria.ps1` | 52 | chequeos de seguridad: `Get-LocalGroupMember`, `Get-NetFirewallProfile`, registro RDP, `exit $problemas` (gemelo de `auditoria.sh`) |
| `servicios.ps1` | 47 | `Get-Service`, `Start/Stop-Service` con validación de estado |
| `procesos.ps1` | 56 | `Get-Process`, `Sort-Object`/`Select-Object -First`, `Stop-Process -WhatIf` |
| `backup.ps1` | 66 | `Compress-Archive`/`Expand-Archive`, rotación por `LastWriteTime` (gemelo de `backup.sh`) |
| `csv.ps1` | 67 | CRUD sobre CSV, `Export-Csv`, generador de contraseñas |
| `usuarios_G00.ps1` | 72 | usuarios reales por grupos aleatorios (gemelo de `usuarios_WSL.sh`) |
| `usuario_csv.ps1` | 75 | alta/baja en CSV con validación de edad |
| `notas.ps1` | 78 | subcomandos `-add/-generate/-delete/-media/-aprobados` |
| `notas_sin_duplicados.ps1` | 88 | igual + validación de existencia (pareja didáctica) |

### Nivel 7 — Administración local y Active Directory

| Script | Líneas | Qué introduce |
|---|---|---|
| `crear_usuarios_grupos_ini.ps1` | 17 | `New-LocalGroup`, formato `"GPWS{0:D2}" -f` |
| `test_local_users.ps1` | 53 | guion de pruebas de `local_users.ps1` (patrón `uso_*.sh`) |
| `crear_usuarios_grupos_csv.ps1` | 57 | `Import-Csv` → `New-LocalUser`, idempotente |
| `crear_usuarios_grupos.ps1` | 60 | bucles anidados grupos × usuarios |
| `usuarios.ps1` | 61 | menú `do…until` + `switch` (gemelo de `menu.sh`) |
| `test_AD.ps1` | 66 | guion de pruebas de `AD.ps1` |
| `grupo.ps1` | 82 | menú de grupos, `Get-LocalGroupMember` |
| `remoto.ps1` | 31 | `Invoke-Command -ComputerName`, `Get-Credential`, `[scriptblock]::Create` (necesita laboratorio de VMs con WinRM) |
| `local_users.ps1` | 167 | CLI completa, `try/catch`, `ConvertTo-SecureString` |
| `AD.ps1` | 216 | el más largo: Active Directory con OUs, `Get-ADGroup -Filter` |

Archivos de datos: `users.csv`, `usuarios.csv`, `usuarios_medad.csv` (y `tiradas.csv`,
generado por `dados.ps1`).

## Observaciones transversales

- La progresión es paralela a la de bash: cmdlets → bucles → argumentos → control de
  flujo → arrays/CSV → mini-CLI → administración/AD, lo que permite dar los dos cursos
  con la misma estructura mental.
- La colección de parejas "misma tarea, dos enfoques" es aún más rica que en bash:
  `$args` vs `param()` (×5 con los `usuario_*`), if/elseif vs `switch` (×2),
  `while`/`do…while`/`do…until` (×3), contadores a mano vs array
  (`analisis_variables` vs `analisis`), y versión ingenua vs validada
  (`notas` vs `notas_sin_duplicados`).
- `test_local_users.ps1` y `test_AD.ps1` ya siguen el patrón de los `uso_*.sh` que
  añadimos en bash: ejecutar todas las opciones, incluidos los errores, y limpiar al
  terminar.
- El equivalente de `IFS=','`/`cut` no existe: todo el CSV pasa por
  `Import-Csv`/`Export-Csv` con acceso por propiedades, buen contraste para la
  discusión "CSV simple vs CSV real" (PowerShell sí maneja comillas y comas internas).
- Detalles:
  - `csv.ps1` y `notas*.ps1` usan `Export-Csv -UseQuotes Never`, que requiere
    PowerShell 7; en Windows PowerShell 5.1 falla (avisado con un comentario en los
    propios scripts).
  - `rnd_do_while.ps1` y `rnd_do_until.ps1` son idénticos salvo la condición final
    (intencionado como pareja didáctica).
  - Corregidos en julio de 2026: la variable `$Opcion_usuario` inexistente en
    `piedra_papel_tijera_switch.ps1` (dejaba vacía la opción del usuario),
    `$listar_miembros_grupo` arrastrada en dos mensajes de `usuarios_G00.ps1`,
    `-ForegroundColor Gree` en `usuario_csv.ps1`, y las erratas de `disk.ps1`
    ("ocapada"), `tragaperras.ps1` ("ganacia") y las cabeceras de `impar_param.ps1`
    y `mac2.ps1`.
