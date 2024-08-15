# Script: puerta.ps1

# Solicitar al usuario que seleccione una puerta ingresando un número del 1 al 4
$codigo = Read-Host "Seleccione una puerta (1 - puerta roja, 2 - puerta azul, 3 - puerta verde, 4 - puerta amarilla)"

# Usar switch para seleccionar la puerta según el código ingresado
switch ($codigo) {
    1 { Write-Output "Has seleccionado la puerta roja. Has perdido." }
    2 { Write-Output "Has seleccionado la puerta azul. Has perdido." }
    3 { 
        Write-Output "Has seleccionado la puerta verde."

        # Solicitar al usuario que seleccione entre cara (0) o cruz (1)
        $moneda = Read-Host "Lanza la moneda: selecciona cara (0) o cruz (1)"

        # Verificar el resultado de la moneda
        if ($moneda -eq "1") {
            Write-Output "Has ganado."
        } else {
            Write-Output "Has perdido."
        }
    }
    4 { Write-Output "Has seleccionado la puerta amarilla. Has perdido." }
    Default { Write-Output "Puerta incorrecta." }
}

