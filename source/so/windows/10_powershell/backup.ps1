# backup.ps1

param (
    [switch]$help,
    [string]$directorio,
    [switch]$lista,
    [int]$limpiar,
    [string]$restaurar
)

$backup_dir = "backups"

function Show-Help {
    Write-Host "-help                : muestra la ayuda" -ForegroundColor Green
    Write-Host "-directorio <dir>    : Crea backups\backup_<dir>_<fecha>.zip" -ForegroundColor Green
    Write-Host "-lista               : Muestra los backups con su tamaño" -ForegroundColor Green
    Write-Host "-limpiar <días>      : Borra los backups con más de <días> días" -ForegroundColor Green
    Write-Host "-restaurar <archivo> : Extrae el backup en el directorio restaurado" -ForegroundColor Green
}

# sin argumentos también mostramos la ayuda
if ($help -or $PSBoundParameters.Count -eq 0) { Show-Help }

if ($directorio) {
    if (Test-Path $directorio -PathType Container) {
        if (!(Test-Path $backup_dir)) {
            New-Item -ItemType Directory -Path $backup_dir | Out-Null
        }
        $fecha = Get-Date -Format "yyyy-MM-dd_HHmm"
        $nombre = Join-Path $backup_dir "backup_$(Split-Path $directorio -Leaf)_$fecha.zip"
        Compress-Archive -Path $directorio -DestinationPath $nombre
        Write-Host "Creado $nombre" -ForegroundColor Green
    } else {
        Write-Host "El directorio $directorio no existe" -ForegroundColor Red
    }
}

if ($lista) {
    if (Test-Path $backup_dir) {
        Get-ChildItem -Path $backup_dir -Filter *.zip |
            Format-Table Name, @{Name="KB"; Expression={[math]::Round($_.Length/1KB, 1)}}, LastWriteTime
    } else {
        Write-Host "No hay backups" -ForegroundColor Red
    }
}

if ($limpiar -gt 0) {
    $antiguos = Get-ChildItem -Path $backup_dir -Filter *.zip -ErrorAction SilentlyContinue |
                Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$limpiar) }
    if ($antiguos) {
        $antiguos | ForEach-Object { Write-Output $_.Name }
        $antiguos | Remove-Item
        Write-Host "Borrados" -ForegroundColor Green
    } else {
        Write-Host "No hay backups con más de $limpiar días" -ForegroundColor Red
    }
}

if ($restaurar) {
    if (Test-Path $restaurar -PathType Leaf) {
        Expand-Archive -Path $restaurar -DestinationPath restaurado -Force
        Write-Host "Restaurado $restaurar en restaurado\" -ForegroundColor Green
    } else {
        Write-Host "El archivo $restaurar no existe" -ForegroundColor Red
    }
}
