# servicios.ps1

param (
    [switch]$help,
    [string]$listar, # Running o Stopped
    [string]$arrancar,
    [string]$parar
)

function Show-Help {
    Write-Host "-help                : muestra la ayuda" -ForegroundColor Green
    Write-Host "-listar <estado>     : Muestra los servicios en ese estado (Running o Stopped)" -ForegroundColor Green
    Write-Host "-arrancar <servicio> : Arranca un servicio si está parado" -ForegroundColor Green
    Write-Host "-parar <servicio>    : Para un servicio si está arrancado" -ForegroundColor Green
}

if ($help -or $PSBoundParameters.Count -eq 0) { Show-Help }

if ($listar) {
    $servicios = Get-Service | Where-Object { $_.Status -eq $listar }
    $servicios | Format-Table Name, DisplayName
    Write-Host "$($servicios.Count) servicios en estado $listar" -ForegroundColor Green
}

if ($arrancar) {
    $servicio = Get-Service -Name $arrancar -ErrorAction SilentlyContinue
    if (!$servicio) {
        Write-Host "El servicio $arrancar no existe" -ForegroundColor Red
    } elseif ($servicio.Status -eq "Running") {
        Write-Host "El servicio $arrancar ya está arrancado" -ForegroundColor Yellow
    } else {
        Start-Service -Name $arrancar
        Write-Host "El servicio $arrancar ha sido arrancado" -ForegroundColor Green
    }
}

if ($parar) {
    $servicio = Get-Service -Name $parar -ErrorAction SilentlyContinue
    if (!$servicio) {
        Write-Host "El servicio $parar no existe" -ForegroundColor Red
    } elseif ($servicio.Status -eq "Stopped") {
        Write-Host "El servicio $parar ya está parado" -ForegroundColor Yellow
    } else {
        Stop-Service -Name $parar
        Write-Host "El servicio $parar ha sido parado" -ForegroundColor Green
    }
}
