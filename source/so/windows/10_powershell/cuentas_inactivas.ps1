# cuentas_inactivas.ps1 - detecta (y opcionalmente bloquea) cuentas sin uso
# Ejecutar como Administrador

param (
    [int]$dias = 90,      # días de inactividad, por defecto 90
    [switch]$bloquear     # sin esto solo lista; con -bloquear las deshabilita
)

$limite = (Get-Date).AddDays(-$dias)

Write-Host "=== Usuarios sin acceso desde hace más de $dias días ===" -ForegroundColor Cyan

Get-LocalUser | Where-Object { $_.Enabled } | ForEach-Object {
    # LastLogon puede estar vacío si el usuario nunca ha entrado
    $ultimo = $_.LastLogon
    if ($null -eq $ultimo -or $ultimo -lt $limite) {
        $cuando = if ($ultimo) { $ultimo.ToString('yyyy-MM-dd') } else { "nunca" }
        if ($bloquear) {
            Disable-LocalUser -Name $_.Name
            Write-Host "$($_.Name) deshabilitado (último acceso: $cuando)" -ForegroundColor Red
        } else {
            Write-Host "$($_.Name) inactivo (último acceso: $cuando)" -ForegroundColor Yellow
        }
    }
}

if (!$bloquear) {
    Write-Host "Añade -bloquear para deshabilitar las cuentas listadas" -ForegroundColor Gray
}
