# remoto.ps1
# Necesita el laboratorio de VMs con WinRM habilitado, ver el enunciado

param (
    [string[]]$equipos = @("compute-0-1", "compute-0-2"),
    [switch]$info,
    [string]$comando
)

# pide la contraseña una sola vez para todos los equipos
$credencial = Get-Credential -UserName "Administrador" -Message "Credenciales del administrador remoto"

if ($info) {
    foreach ($equipo in $equipos) {
        Write-Host "=== $equipo ===" -ForegroundColor Green
        Invoke-Command -ComputerName $equipo -Credential $credencial -ScriptBlock {
            "{0} : {1} GB libres en C:, {2} procesos" -f $env:COMPUTERNAME,
                [math]::Round((Get-PSDrive -Name C).Free/1GB, 1),
                (Get-Process).Count
        }
    }
}

if ($comando) {
    foreach ($equipo in $equipos) {
        Write-Host "=== $equipo ===" -ForegroundColor Green
        # convertimos el texto recibido en un bloque de código ejecutable
        Invoke-Command -ComputerName $equipo -Credential $credencial `
            -ScriptBlock ([scriptblock]::Create($comando))
    }
}
