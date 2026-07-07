# informe.ps1

$archivo = "informe.html"

$css = @"
<style>
  body { font-family: sans-serif; margin: 2em; }
  h1, h2 { color: #2c5e92; }
  table { border-collapse: collapse; }
  th, td { border: 1px solid #ccc; padding: 4px 10px; }
  th { background: #2c5e92; color: white; }
</style>
"@

$titulo = "<h1>Informe de $(hostname)</h1><p>Generado el $(Get-Date -Format 'yyyy-MM-dd HH:mm')</p>"

$discos = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used + $_.Free -gt 0 } |
    Select-Object Name,
        @{Name="Usado_GB"; Expression={[math]::Round($_.Used/1GB, 1)}},
        @{Name="Libre_GB"; Expression={[math]::Round($_.Free/1GB, 1)}},
        @{Name="Ocupado";  Expression={"{0}%" -f [math]::Round($_.Used/($_.Used+$_.Free)*100, 0)}} |
    ConvertTo-Html -Fragment -PreContent "<h2>Discos</h2>"

$procesos = Get-Process | Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id,
        @{Name="CPU_s"; Expression={[math]::Round($_.CPU, 1)}},
        @{Name="MB";    Expression={[math]::Round($_.WorkingSet64/1MB, 1)}} |
    ConvertTo-Html -Fragment -PreContent "<h2>Top 5 procesos por CPU</h2>"

$servicios = Get-Service | Where-Object { $_.Status -eq 'Stopped' } |
    Select-Object Name, DisplayName |
    ConvertTo-Html -Fragment -PreContent "<h2>Servicios parados</h2>"

ConvertTo-Html -Title "Informe" -Head $css -Body "$titulo $discos $procesos $servicios" |
    Out-File $archivo

Write-Host "Generado $archivo" -ForegroundColor Green
