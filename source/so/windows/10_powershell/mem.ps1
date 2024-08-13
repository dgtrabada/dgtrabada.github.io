# mem.ps1

# Obtener la memoria física total y la memoria libre
$totalMemory = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB
$freeMemory = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB

# Calcular la memoria ocupada
$usedMemory = $totalMemory - $freeMemory

# Obtener la fecha y hora actual para el registro
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Crear el mensaje que se va a escribir en el archivo
$logEntry = "$timestamp - Memoria ocupada: $([math]::round($usedMemory, 2)) MB"

# Escribir la entrada en el archivo free.log, sin borrar el contenido anterior
Add-Content -Path "free.log" -Value $logEntry
