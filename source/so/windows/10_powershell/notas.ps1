param (
    [switch]$help,
    [string]$add,
    [int]$nota,
    [switch]$generate,
    [string]$delete,
    [switch]$media,
    [switch]$aprobados
)

$archivoCSV = "notas.csv"

function mostrar_ayuda(){
    Write-Host "notas.ps1 [-help] [-add <alumno> -nota <nota>] [-generate] [-delete <alumno>] [-media] [-aprobados]" -ForegroundColor Gray
    Write-Host "  -help       Muestra esta ayuda" -ForegroundColor Gray
    Write-Host "  -add        Añade un alumno con su nota (junto a -nota)" -ForegroundColor Gray
    Write-Host "  -generate   Genera 10 alumnos con notas aleatorias entre 0 y 10" -ForegroundColor Gray
    Write-Host "  -delete     Elimina un alumno" -ForegroundColor Gray
    Write-Host "  -media      Muestra la nota media" -ForegroundColor Gray
    Write-Host "  -aprobados  Muestra los alumnos aprobados (nota >= 5)" -ForegroundColor Gray
}

function crear_archivo(){
    if (!(Test-Path $archivoCSV)) {
        Write-Host "Se crea el archivo $archivoCSV" -ForegroundColor Green
        Write-Output "nombre,nota" > $archivoCSV
    }
}

function generar_alumnos(){
    crear_archivo
    $nombres = "Ana", "Luis", "Marta", "Pedro", "Sara", "Juan", "Eva", "Hugo", "Lucia", "Marco"
    foreach ($n in $nombres) {
        $r = Get-Random -Minimum 0 -Maximum 11
        Write-Output "$n,$r" >> $archivoCSV
        Write-Host "Añadido $n con nota $r" -ForegroundColor Green
    }
}

function add_alumno(){
    crear_archivo
    Write-Output "$add,$nota" >> $archivoCSV
    Write-Host "El alumno $add ha sido añadido con nota $nota" -ForegroundColor Green
}

function borrar_alumno(){
    $alumnos = Import-Csv -Path $archivoCSV
    if ($alumnos | Where-Object { $_.nombre -eq $delete }) {
        $alumnos | Where-Object { $_.nombre -ne $delete } |
            Export-Csv -Path $archivoCSV -NoTypeInformation -UseQuotes Never
        Write-Host "El alumno $delete ha sido eliminado" -ForegroundColor Green
    } else {
        Write-Host "El alumno $delete no existe, no se puede eliminar" -ForegroundColor Red
    }
}

function calcular_media(){
    $alumnos = @(Import-Csv -Path $archivoCSV)
    if ($alumnos.Count -eq 0) {
        Write-Host "No hay alumnos en $archivoCSV" -ForegroundColor Red
        return
    }
    $suma = 0
    foreach ($a in $alumnos) { $suma += [int]$a.nota }
    $m = [math]::Round($suma / $alumnos.Count, 2)
    Write-Host "Nota media: $m" -ForegroundColor Green
}

function mostrar_aprobados(){
    Import-Csv -Path $archivoCSV | Where-Object { [int]$_.nota -ge 5 }
}

if ($help) { mostrar_ayuda }
if ($generate) { generar_alumnos }
if ($add) { add_alumno }
if ($delete) { borrar_alumno }
if ($media) { calcular_media }
if ($aprobados) { mostrar_aprobados }
