# rnd.ps1

# Generar un número aleatorio entre 1 y 20
$NumeroAleatorio = Get-Random -Minimum 1 -Maximum 21

# Inicializar el contador de intentos
$contador = 0

Write-Output "He generado un número entre 1 y 20. ¡Intenta adivinarlo!"

# Inicializar la respuesta fuera del rango válido para entrar al bucle
[int] $respuesta = -1

while ($respuesta -ne $NumeroAleatorio) {

    [int] $respuesta = Read-Host "Introduce tu suposición"
    $contador++

    if ($respuesta -lt $NumeroAleatorio) {
        Write-Output "El número es mayor que $respuesta. Intenta de nuevo."
    }
    
    if ($respuesta -gt $NumeroAleatorio) {
        Write-Output "El número es menor que $respuesta. Intenta de nuevo."
    }
    
    if ($respuesta -eq $NumeroAleatorio) {
        Write-Output "¡Felicidades! Has adivinado el número."
        Write-Output "Número de intentos: $contador"
    }
}