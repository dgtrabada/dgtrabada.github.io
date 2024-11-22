$Nombre = $args[0]
$Apellido = $args[1]
$Usuario = $args[2]
$Nacimiento = [int]$args[3]

$AñoActual = (Get-Date).Year

$Edad = $AñoActual - $Nacimiento

if ($Edad -ge 14) {
    Write-Output "Se ha creado a $Nombre $Apellido el usuario $Usuario"
} else {
    Write-Output "No se puede crear el usuario $Usuario a $Nombre $Apellido por tener menos de 14"
}