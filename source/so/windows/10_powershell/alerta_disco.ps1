# alerta_disco.ps1

param (
    [int]$umbral = 80 # umbral en %, por defecto 80
)

$log = "alertas.log"

foreach ($disco in Get-PSDrive -PSProvider FileSystem) {
    $total = $disco.Used + $disco.Free
    if ($total -gt 0) {
        $ocupado = [math]::Round(($disco.Used / $total) * 100, 0)
        if ($ocupado -ge $umbral) {
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
            $alerta = "$timestamp $($disco.Root) está al $ocupado% (umbral $umbral%)"
            Write-Host $alerta -ForegroundColor Red
            Add-Content -Path $log -Value $alerta
        }
    }
}
