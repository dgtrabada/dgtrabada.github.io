param (
#   [Parameter(Mandatory=$true, HelpMessage="Que eliges piedra papel o tijeras?: ")]
    [string]$Opcion_usuario = "tijeras"
)

$Opcion_CPU ="piedra", "papel", "tijeras"| Get-Random 

$Opcion_usuario=$Opcion_usuario.ToLower() 
Write-Output "CPU: $Opcion_CPU "
Write-Output "Usuario : $Opcion_usuario"

if($Opcion_usuario -eq "piedra"   -And $Opcion_CPU -eq "tijeras" ){ Write-Host "Gana usuario"}
if($Opcion_usuario -eq "piedra"   -And $Opcion_CPU -eq "papel"   ){ Write-Host "Gana CPU"}
if($Opcion_usuario -eq "piedra"   -And $Opcion_CPU -eq "piedra"  ){ Write-Host "Empate"}
if($Opcion_usuario -eq "papel"    -And $Opcion_CPU -eq "tijeras" ){ Write-Host "Gana CPU"}
if($Opcion_usuario -eq "papel"    -And $Opcion_CPU -eq "papel"   ){ Write-Host "Empate" }
if($Opcion_usuario -eq "papel"    -And $Opcion_CPU -eq "piedra"  ){ Write-Host "Gana usuario" }
if($Opcion_usuario -eq "tijeras"  -And $Opcion_CPU -eq "tijeras" ){ Write-Host "Empate" }
if($Opcion_usuario -eq "tijeras"  -And $Opcion_CPU -eq "papel"   ){ Write-Host "Gana usuario"}
if($Opcion_usuario -eq "tijeras"  -And $Opcion_CPU -eq "piedra"  ){ Write-Host "Gana CPU"}