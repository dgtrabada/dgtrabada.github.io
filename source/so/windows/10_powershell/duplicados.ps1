# duplicados.ps1

param (
    [string]$dir = "." # directorio a analizar, por defecto el actual
)

# dos archivos con el mismo contenido tienen el mismo hash:
# agrupamos por hash y nos quedamos con los grupos de más de uno
$grupos = Get-ChildItem -Path $dir -File -Recurse | Get-FileHash |
          Group-Object -Property Hash | Where-Object { $_.Count -gt 1 }

foreach ($g in $grupos) {
    Write-Output "Duplicados:"
    $g.Group | ForEach-Object { Write-Output $_.Path }
}
