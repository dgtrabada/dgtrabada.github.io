# procesos.ps1

param (
    [switch]$help,
    [int]$top,
    [switch]$memoria, # con -top, ordena por memoria en vez de por CPU
    [string]$buscar,
    [string]$matar,
    [switch]$deverdad # sin esto, -matar solo simula con -WhatIf
)

function Show-Help {
    Write-Host "-help                : muestra la ayuda" -ForegroundColor Green
    Write-Host "-top <N> [-memoria]  : Muestra los N procesos con más CPU (o memoria)" -ForegroundColor Green
    Write-Host "-buscar <nombre>     : Muestra los procesos cuyo nombre contiene <nombre>" -ForegroundColor Green
    Write-Host "-matar <nombre>      : Simula matar los procesos (con -deverdad los mata)" -ForegroundColor Green
}

# propiedades calculadas: CPU en segundos y memoria en MB
$columnas = "Name", "Id",
    @{Name="CPU_s"; Expression={[math]::Round($_.CPU, 1)}},
    @{Name="MB";    Expression={[math]::Round($_.WorkingSet64/1MB, 1)}}

if ($help -or $PSBoundParameters.Count -eq 0) { Show-Help }

if ($top -gt 0) {
    if ($memoria) {
        Get-Process | Sort-Object WorkingSet64 -Descending |
            Select-Object -First $top | Format-Table $columnas
    } else {
        Get-Process | Sort-Object CPU -Descending |
            Select-Object -First $top | Format-Table $columnas
    }
}

if ($buscar) {
    $procesos = Get-Process -Name "*$buscar*" -ErrorAction SilentlyContinue
    if ($procesos) {
        $procesos | Format-Table $columnas
    } else {
        Write-Host "No hay procesos con nombre *$buscar*" -ForegroundColor Red
    }
}

if ($matar) {
    $procesos = Get-Process -Name "*$matar*" -ErrorAction SilentlyContinue
    if (!$procesos) {
        Write-Host "No hay procesos con nombre *$matar*" -ForegroundColor Red
    } elseif ($deverdad) {
        $procesos | Stop-Process
        Write-Host "Procesos *$matar* eliminados" -ForegroundColor Green
    } else {
        $procesos | Stop-Process -WhatIf
        Write-Host "Simulación: añade -deverdad para matarlos de verdad" -ForegroundColor Yellow
    }
}
