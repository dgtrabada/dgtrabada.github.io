# barrido_red.ps1

param (
    [string]$red = "192.168.2",
    [int]$desde = 1,
    [int]$hasta = 14
)

$activas = 0

foreach ($i in $desde..$hasta) {
    $ip = "$red.$i"
    # -TimeoutSeconds requiere PowerShell 7, sin él cada IP muerta tarda varios segundos
    if (Test-Connection $ip -Count 1 -Quiet -TimeoutSeconds 1) {
        Write-Host "$ip responde" -ForegroundColor Green
        $activas++
    } else {
        Write-Host "$ip no responde" -ForegroundColor DarkGray
    }
}

Write-Host "$activas equipos activos en $red.$desde-$hasta" -ForegroundColor Green
