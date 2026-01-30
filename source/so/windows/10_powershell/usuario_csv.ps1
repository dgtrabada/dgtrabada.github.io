param (
    [switch]$help,
    [switch]$list,
    [string]$Nombre   = "Nombre",
    [string]$Apellido = "Apellido",
    [string]$Usuario,
    [string]$delete,
    [int]$Nacimiento  = (Get-Date).Year
    )

$archivo="usuarios_medad.csv"

function Get-RandomPassword {
    param(
        [int]$Length = 12
    )
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*?'
    $randomChar=""
    for($i=0;$i -lt $Length;$i++){
      $randomChar += $chars[$(Get-Random -Maximum $chars.Length)]
      }
    return $randomChar
    }


function help() {
    Write-Host "usuario.ps1 -Nombre [string] -Apellido [string] -Usuario [string] -Nacimiento [int]" -ForegroundColor Gray
    }

function listar_usuarios() {
    Import-Csv $archivo | Format-Table Nombre,Apellido,Nacimiento,usuario
    }
    
function crear_usuario(){
   $AñoActual = (Get-Date).Year
   $Edad = $AñoActual - $Nacimiento
   if ($Edad -ge 14) {
         $password=Get-RandomPassword
         if(Test-Path $archivo) {
             if(sls $usuario $archivo -Quiet){
                 Write-Host "No se crea el usuario $usuario ya que existe" -ForegroundColor Red
             }else{
                 Write-Host "Se ha creado a $Nombre $Apellido el usuario $Usuario" -ForegroundColor Green
                 Write-Output "$Nombre,$Apellido,$Nacimiento,$usuario,$password">> $archivo
             }
         }else{
             Write-Host "Creamos el archivo: $archivo" -ForegroundColor Green
             Write-Output "Nombre,Apellido,Nacimiento,usuario,password" > $archivo
             Write-Output "$Nombre,$Apellido,$Nacimiento,$usuario,$password">> $archivo
         }
      } else {
         Write-Host "No se puede crear el usuario $Usuario a $Nombre $Apellido por tener menos de 14" -ForegroundColor Red
      }
    }

function borrar_usuario(){
    if (Import-Csv $archivo | Where-Object usuario -eq $delete) {
        Write-Host "Borramos el usuario $delete " -ForegroundColor Green
        Get-Content $archivo  | Where-Object { $_ -notmatch $delete } | Set-Content $archivo 
     } else {
        Write-Host "El $delete no existe, no se puede borrar" -ForegroundColor Red
     }
    }
    
if ($help){help} 
if ($list){listar_usuarios}
if (-not [String]::IsNullOrEmpty($Usuario)) { crear_usuario }
# tambien funciona if ($Usuario) { crear_usuario }    
# toma como $false : $null "" (cadena vacía)  0 y    $false
if (-not [String]::IsNullOrEmpty($delete)) { borrar_usuario }



