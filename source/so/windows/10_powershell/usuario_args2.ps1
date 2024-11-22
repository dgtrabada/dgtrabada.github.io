$Nombre = "Nombre"
$Apellido = "Apellido"
$Usuario = "usuario"
$Nacimiento = (Get-Date).Year

for($i=0;$i -lt $args.Length;$i++){

    if ( $args[$i] -eq '-Nombre'){
        $Nombre = $args[$($i+1)]
        }
    if ( $args[$i] -eq '-Apellido'){
        $Apellido = $args[$($i+1)]
        }
    if ( $args[$i] -eq '-Usuario'){
        $Usuario = $args[$($i+1)]
        }
    if ( $args[$i] -eq '-Nacimiento'){
        $Nacimiento = $args[$($i+1)]
        }

    }


$AñoActual = (Get-Date).Year

$Edad = $AñoActual - $Nacimiento

if ($Edad -ge 14) {
    Write-Output "Se ha creado a $Nombre $Apellido el usuario $Usuario"
} else {
    Write-Output "No se puede crear el usuario $Usuario a $Nombre $Apellido por tener menos de 14"
}