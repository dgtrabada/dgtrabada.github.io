# Script: puerta.ps1

$codigo = Read-Host " 
1 - puerta roja
2 - puerta azul
3 - puerta verde
4 - puerta amarilla

Seleccione una puerta"

switch ($codigo) {
    1 { Write-Output "Has seleccionado la puerta roja." }
    2 { Write-Output "Has seleccionado la puerta azul." }
    3 { Write-Output "Has seleccionado la puerta verde." }
    4 { Write-Output "Has seleccionado la puerta amarilla." }
    Default { Write-Output "Puerta incorrecta." }
}