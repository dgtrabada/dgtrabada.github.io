
param (
    [switch]$help,
    [string]$Nombre   = "Nombre",
    [string]$Apellido = "Apellido",
    [string]$Usuario  = "usuario",
    [int]$Nacimiento  = (Get-Date).Year
    )


function help() {
    Write-Host "usuario.ps1 -Nombre [string] -Apellido [string] -Usuario [string] -Nacimiento [int]" -ForegroundColor Green
    }


if ($help){
   help
   }
else{
   $AñoActual = (Get-Date).Year

   $Edad = $AñoActual - $Nacimiento

   if ($Edad -ge 14) {
      Write-Output "Se ha creado a $Nombre $Apellido el usuario $Usuario"
   } else {
      Write-Output "No se puede crear el usuario $Usuario a $Nombre $Apellido por tener menos de 14"
   }
   }
    


