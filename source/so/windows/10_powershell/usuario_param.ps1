param (
    # en el caso de que no se lo proporcionemos nos dará estos valores por defecto
    [string]$Nombre = "Nombre",
    [string]$Apellido = "Apellido",
    [string]$Usuario = "usuario",
    [int]$Nacimiento = (Get-Date).Year
    )
    
$AñoActual = (Get-Date).Year

$Edad = $AñoActual - $Nacimiento

if ($Edad -ge 14) {
    Write-Output "Se ha creado a $Nombre $Apellido el usuario $Usuario"
} else {
    Write-Output "No se puede crear el usuario $Usuario a $Nombre $Apellido por tener menos de 14"
}