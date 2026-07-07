# eventos.ps1
# Ejecutar como Administrador

param (
    [int]$horas = 24,
    [int]$id = 4625 # 4625 = inicio de sesión fallido
)

$desde = (Get-Date).AddHours(-$horas)

$eventos = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = $id
    StartTime = $desde
} -ErrorAction SilentlyContinue

if (!$eventos) {
    Write-Host "No hay eventos $id en las últimas $horas horas" -ForegroundColor Green
} else {
    Write-Host "$($eventos.Count) eventos $id en las últimas $horas horas" -ForegroundColor Red

    # en el evento 4625 la cuenta es la propiedad 5 y la IP de origen la 19
    $eventos | ForEach-Object {
        [PSCustomObject]@{
            Cuenta = $_.Properties[5].Value
            IP     = $_.Properties[19].Value
        }
    } | Group-Object Cuenta, IP | Sort-Object Count -Descending |
        Format-Table Count, Name
}
