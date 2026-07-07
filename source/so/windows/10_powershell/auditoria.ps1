# auditoria.ps1 - chequeo de seguridad básico del sistema
# Ejecutar como Administrador

$problemas = 0

function ok    ($msg) { Write-Host "[ OK ] $msg" -ForegroundColor Green }
function fallo ($msg) { Write-Host "[FALLO] $msg" -ForegroundColor Red; $script:problemas++ }

Write-Host "=== Auditoría de seguridad de $(hostname) ===" -ForegroundColor Cyan

# 1. Miembros del grupo Administradores
Write-Host "--- Miembros de Administradores ---"
$admins = Get-LocalGroupMember -Group "Administradores" -ErrorAction SilentlyContinue
if (!$admins) { $admins = Get-LocalGroupMember -Group "Administrators" } # sistema en inglés
$admins | ForEach-Object { Write-Host "  $($_.Name)" }
if ($admins.Count -le 2) {
    ok "Hay $($admins.Count) administradores"
} else {
    fallo "Hay $($admins.Count) administradores, revisa si son todos necesarios"
}

# 2. Cuentas habilitadas con contraseña que no expira
Write-Host "--- Contraseñas que no expiran ---"
$noexpira = Get-LocalUser | Where-Object { $_.Enabled -and $_.PasswordNeverExpires }
if (!$noexpira) {
    ok "Ninguna cuenta activa tiene contraseña eterna"
} else {
    fallo "Cuentas con contraseña que no expira: $($noexpira.Name -join ', ')"
}

# 3. Estado del firewall
Write-Host "--- Firewall ---"
$perfiles = Get-NetFirewallProfile
foreach ($p in $perfiles) {
    if ($p.Enabled) {
        ok "Firewall $($p.Name) activado"
    } else {
        fallo "Firewall $($p.Name) DESACTIVADO"
    }
}

# 4. Escritorio remoto (RDP)
Write-Host "--- Escritorio remoto ---"
$rdp = (Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Terminal Server").fDenyTSConnections
if ($rdp -eq 1) {
    ok "RDP deshabilitado"
} else {
    fallo "RDP habilitado, asegúrate de que es necesario"
}

Write-Host "=== $problemas problemas encontrados ===" -ForegroundColor Cyan
exit $problemas
