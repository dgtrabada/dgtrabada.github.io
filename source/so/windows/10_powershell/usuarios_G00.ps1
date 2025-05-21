param (
    [switch] $help,
    [switch] $listar,
    [switch] $borrar,
    [string] $Password = "@lumn0",
    [int]    $crear
)



function Show-Help {
    Write-Host "-help               Mostrar esta ayuda."  -ForegroundColor Gray
    Write-Host "-crear <N>          Crear N usuarios de forma aleatoria dentro de los grupos X, Y o Z."  -ForegroundColor Gray
    Write-Host "-borrar             Borrar todos los usuarios creados por este script."  -ForegroundColor Gray
    Write-Host "-listar             Mostrar los usuarios creados por este script."  -ForegroundColor Gray
}


function Crear_Usuarios {
    for($i = 0; $i -lt $crear ; $i++){
      $Grupo ="A", "B", "C"| Get-Random 
      $nuevo_usuario="u"+$Grupo+$(Get-Random -Minimum 0 -Maximum 9)+$(Get-Random -Minimum 0 -Maximum 9)
      $cadena_secure_string = $password | ConvertTo-SecureString -AsPlainText -Force

      if (Get-LocalUser -Name $nuevo_usuario -ErrorAction SilentlyContinue) {
        Write-Host "El usuario $nuevo_usuario ya existe."  -ForegroundColor Red
      } else {
        New-LocalUser -Name $nuevo_usuario -Password  $cadena_secure_string  -FullName $nuevo_usuario
        Add-LocalGroupMember -Group $Grupo -Member $nuevo_usuario
        Write-Host "El usuario $nuevo_usuario ha sido creado y añadido al grupo $Grupo."  -ForegroundColor Green
     }
  }
}


function Listar_Usuarios {
  $Grupos = @("A", "B", "C")
  for ($i = 0; $i -lt $Grupos.Length; $i++) {      
    if (Get-LocalGroup -Name $Grupos[$i] -ErrorAction SilentlyContinue) {
      Write-Host "Miembros del grupo $($Grupos[$i]) :" -ForegroundColor Green
      Get-LocalGroupMember -Group $Grupos[$i] | ForEach-Object { Write-Host ($_.Name -split '\\')[-1] }
    } else {
      Write-Host "El grupo $listar_miembros_grupo no existe." -ForegroundColor Red
    }
  }
}


function Borrar_Usuarios {
  $Grupos = @("A", "B", "C")
  for ($i = 0; $i -lt $Grupos.Length; $i++) {      
    if (Get-LocalGroup -Name $Grupos[$i] -ErrorAction SilentlyContinue) {
      $miembros_grupo = Get-LocalGroupMember -Group  $($Grupos[$i])
      Write-Host "Borrando miembros del grupo $($Grupos[$i]) :" -ForegroundColor Green
        foreach ($nombreUsuario in $miembros_grupo){
            Remove-LocalUser -Name ($nombreUsuario  -split '\\')[-1]
            Write-Host "El usuario $nombreUsuario ha sido eliminado."  -ForegroundColor Green
        }               

    } else {
      Write-Host "El grupo $listar_miembros_grupo no existe." -ForegroundColor Red
    }
  }
}

if ($help) {Show-Help}

if ($crear -gt 0 ) {Crear_Usuarios}
 
if ($listar) {Listar_Usuarios}

if ($borrar) {Borrar_Usuarios}
