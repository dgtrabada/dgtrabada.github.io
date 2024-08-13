# rnd.ps1

# Generar un número aleatorio entre 1 y 20
$randomNumber = Get-Random -Minimum 1 -Maximum 21

# Inicializar el contador de intentos
$attempts = 0

Write-Output "He generado un número entre 1 y 20. ¡Intenta adivinarlo!"

do {
    # Solicitar al usuario que ingrese su suposición
    $userGuess = Read-Host "Introduce tu suposición"

    # Incrementar el contador de intentos
    $attempts++

    # Convertir la entrada del usuario a un número entero
    $userGuess = [int] $userGuess

    # Comprobar si la suposición es correcta
    if ($userGuess -lt $randomNumber) {
        Write-Output "El número es mayor que $userGuess. Intenta de nuevo."
    } elseif ($userGuess -gt $randomNumber) {
        Write-Output "El nÃºmero es menor que $userGuess. Intenta de nuevo."
    } else {
        Write-Output "¡Felicidades! Has adivinado el nÃºmero."
        Write-Output "Número de intentos: $attempts"
    }
} while ($userGuess -ne $randomNumber)

