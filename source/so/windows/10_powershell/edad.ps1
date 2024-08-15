# Script: edad.ps1

# Solicitar al usuario que ingrese su año de nacimiento
$añoNacimiento = Read-Host "Ingrese el año en que naciste"

# Obtener el año actual
$añoActual = (Get-Date).Year

# Calcular la edad
$edad = $añoActual - $añoNacimiento

# Mostrar la edad
Write-Output "Tienes $edad años."

