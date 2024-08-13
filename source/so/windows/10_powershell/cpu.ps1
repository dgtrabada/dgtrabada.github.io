# cpu.ps1

# Obtener el nombre del procesador
$cpuName = Get-CimInstance -ClassName Win32_Processor | Select-Object -ExpandProperty Name

# Mostrar el nombre del procesador en la pantalla
Write-Host "CPU: $cpuName"

