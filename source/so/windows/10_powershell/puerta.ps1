# Script: puerta.ps1

# Solicitar al usuario que seleccione una puerta ingresando un número del 1 al 4
$codigo = Read-Host "Seleccione una puerta (1 - puerta roja, 2 - puerta azul, 3 - puerta verde, 4 - puerta amarilla)"

# Usar switch para seleccionar la puerta según el código ingresado
switch ($codigo) {
    1 { Write-Output "Has seleccionado la puerta roja." }
    2 { Write-Output "Has seleccionado la puerta azul." }
    3 { Write-Output "Has seleccionado la puerta verde." }
    4 { Write-Output "Has seleccionado la puerta amarilla." }
    Default { Write-Output "Puerta incorrecta." }
}
