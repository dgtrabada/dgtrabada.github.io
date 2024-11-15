# Script: puerta_if.ps1

$codigo = Read-Host " 
1 - puerta roja
2 - puerta azul
3 - puerta verde
4 - puerta amarilla

Seleccione una puerta"

if ($codigo -eq 1) {
    Write-Output "Has seleccionado la puerta roja."
}
elseif ($codigo -eq 2) {
    Write-Output "Has seleccionado la puerta azul."
}
elseif ($codigo -eq 3) {
    Write-Output "Has seleccionado la puerta verde."
}
elseif ($codigo -eq 4) {
    Write-Output "Has seleccionado la puerta amarilla."
}
else {
    Write-Output "Puerta incorrecta."
}