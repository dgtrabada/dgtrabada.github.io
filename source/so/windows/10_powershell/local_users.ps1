param (
    [string]$password = "@lumn0",
    [string]$nuevo_usuario,
    [string]$grupo, #cuando creamos un nuevo usuario lo metemos dentro de este grupo si existe si no lo creamos, tambien para añadir y quitar usuarios del grupo
    [string]$usuario, #lo usasmos para añadir usuarios y quitar usuarios del grupo 
    [string]$listar_miembros_grupo,
    [string]$nuevo_grupo,
    [string]$eliminar_grupo,
    [string]$eliminar_usuario,
    [switch]$eliminar_usuario_grupo,
    [switch]$meter_usuario_grupo,
    [switch]$help,
    [switch]$listar_usuarios,
    [switch]$listar_grupos
    )
   

function help {
    Write-Host ""
    Write-Host "Mostrar ayuda" -ForegroundColor Gray    
    Write-Host "local_users.ps1  -help"
    Write-Host ""
    Write-Host "Listar los grupos" -ForegroundColor Gray
    Write-Host "local_users.ps1  -listar_grupos"
    Write-Host ""
    Write-Host "Crear un nuevo grupo" -ForegroundColor Gray 
    Write-Host "local_users.ps1 -nuevo_grupo [grupo]"
    Write-Host ""
    Write-Host "Eliminar un grupo" -ForegroundColor Gray 
    Write-Host "local_users.ps1 -eliminar_grupo [grupo]"
    Write-Host ""
    Write-Host "Crear un nuevo usuario" -ForegroundColor Gray 
    Write-Host "local_users.ps1 -nuevo_usuario [usuario]"
    Write-Host "local_users.ps1 -nuevo_usuario [usuario] -password [password]"
    Write-Host "local_users.ps1 -nuevo_usuario [usuario] -password [password] -grupo [Grupo]"
    Write-Host ""
    Write-Host "Eliminar un usuario" -ForegroundColor Gray 
    Write-Host "local_users.ps1 -eliminar_usuario [usuario]"
    Write-Host ""
    Write-Host "Listar los miembros de un grupo" -ForegroundColor Gray 
    Write-Host "local_users.ps1 -listar_miembros_grupo [grupo]"
    Write-Host ""
    Write-Host "Meter un usuario a un grupo" -ForegroundColor Gray 
    Write-Host ".\local_users.ps1 -meter_usuario_grupo -usuario [usuario] -grupo [grupo]"
    Write-Host ""
    Write-Host "Eliminar usuario de un grupo" -ForegroundColor Gray
    Write-Host ".\local_users.ps1 -eliminar_usuario_grupo -usuario [usuario] -grupo [grupo]"
} 

function Listar_Grupos {
    Write-Host "Grupos disponibles:"  -ForegroundColor Green
    Get-LocalGroup | ForEach-Object { Write-Host $_.Name }
}

function Listar_MiembrosDeGrupo {
    if (Get-LocalGroup -Name $listar_miembros_grupo -ErrorAction SilentlyContinue) {
        Write-Host "Miembros del grupo $listar_miembros_grupo :" -ForegroundColor Green
        Get-LocalGroupMember -Group $listar_miembros_grupo | ForEach-Object { Write-Host $_.Name }
    } else {
        Write-Host "El grupo $listar_miembros_grupo no existe." -ForegroundColor Red
    }
}

function Crear_Grupo {
    if (Get-LocalGroup -Name $nuevo_grupo -ErrorAction SilentlyContinue) {
        Write-Host "El grupo $nuevo_grupo ya existe." -ForegroundColor Red
    } else {
        New-LocalGroup -Name $nuevo_grupo
        Write-Host "Creamos el grupo: $nuevo_grupo" -ForegroundColor Green
    }
}

function Eliminar_Grupo {
    if (Get-LocalGroup -Name $eliminar_grupo -ErrorAction SilentlyContinue) {
        Remove-LocalGroup -Name $eliminar_grupo
        Write-Host "El grupo $eliminar_grupo ha sido eliminado." -ForegroundColor Green
    } else {
        Write-Host "El grupo $eliminar_grupo no existe." -ForegroundColor Red
    }
}

function Meter_Usuario_Grupo {
    if ([String]::IsNullOrEmpty($grupo)){
        Write-Host "Necesitamos el parametro -grupo" -ForegroundColor Red
    }elseif ([String]::IsNullOrEmpty($usuario)){
        Write-Host "Necesitamos el parametro -usuario" -ForegroundColor Red
    }elseif (-not (Get-LocalGroup -Name $grupo -ErrorAction SilentlyContinue))  {
        Write-Host "El grupo $grupo no existe" -ForegroundColor Red
    }elseif (-not (Get-LocalUser -Name $usuario -ErrorAction SilentlyContinue)) {
        Write-Host "El usuario $usuario no existe" -ForegroundColor Red
    } else {
        Add-LocalGroupMember -Group $grupo -Member $usuario
        Write-Host "El usuario $usuario ha sido agregado al grupo $grupo" -ForegroundColor Green
    }
}

function Eliminar_Usuario_Grupo {
    if ([String]::IsNullOrEmpty($grupo)){
        Write-Host "Necesitamos el parametro -grupo" -ForegroundColor Red
    }elseif ([String]::IsNullOrEmpty($usuario)){
        Write-Host "Necesitamos el parametro -usuario" -ForegroundColor Red
    }elseif (-not (Get-LocalGroup -Name $grupo -ErrorAction SilentlyContinue))  {
        Write-Host "El grupo $grupo no existe" -ForegroundColor Red
    }elseif (-not (Get-LocalUser -Name $usuario -ErrorAction SilentlyContinue)) {
        Write-Host "El usuario $usuario no existe" -ForegroundColor Red
    } else {
        Remove-LocalGroupMember -Group $grupo -Member $usuario
        Write-Host "El usuario $usuario ha sido eliminado del grupo $grupo." -ForegroundColor Green
    }
}

function Listar_Usuarios {
    Write-Host "Usuarios en el sistema:" -ForegroundColor Green
    Get-LocalUser | ForEach-Object { Write-Host $_.Name }
}

function Crear_Usuario {
    $ErrorActionPreference="Stop"
    if (Get-LocalUser -Name $nuevo_usuario -ErrorAction SilentlyContinue) {
        Write-Host "El usuario $nuevo_usuario ya existe."  -ForegroundColor Red
    } else {
        $usuario_creado=$True
        try{
           $cadena_secure_string = $password | ConvertTo-SecureString -AsPlainText -Force
           New-LocalUser -Name $nuevo_usuario -Password  $cadena_secure_string  -FullName $nuevo_usuario          
           Write-Host "El usuario $nuevo_usuario ha sido creado y añadido al grupo Users."  -ForegroundColor Green
        }catch{
           $usuario_creado=$False
           Write-Host "Error: la contraseña no cumple con los requititos no creamos el usuario $nuevo_usuario "  -ForegroundColor Red
        }
        if($usuario_creado){
           # Para que los usuarios puedan iniciar sesión con entorno gráfico
           # Add-LocalGroupMember -Group "Users" -Member $nuevo_usuario
           if (-not [String]::IsNullOrEmpty($grupo)){
               if (-not (Get-LocalGroup -Name $grupo -ErrorAction SilentlyContinue)) {
                   New-LocalGroup -Name $grupo
                   Write-Host "Creamos el grupo: $grupo" -ForegroundColor Green
                   }
                Add-LocalgroupMember -Group $grupo -Member $nuevo_usuario
                Write-Host "Metemos al usuario $nuevo_usuario en el grupo $grupo"  -ForegroundColor Green
           }
        }
    }
    $ErrorActionPreference="Continue"
}

function Eliminar_Usuario {
    if (Get-LocalUser -Name $eliminar_usuario -ErrorAction SilentlyContinue) {
        Remove-LocalUser -Name $eliminar_usuario
        Write-Host "El usuario $eliminar_usuario ha sido eliminado." -ForegroundColor Green
    } else {
        Write-Host "El usuario $eliminar_usuario no existe." -ForegroundColor Red
    }
}


if ($help){help}
if ($listar_grupos){Listar_Grupos}
if (-not [String]::IsNullOrEmpty($listar_miembros_grupo)){Listar_MiembrosDeGrupo}
if (-not [String]::IsNullOrEmpty($nuevo_grupo)){Crear_Grupo}
if (-not [String]::IsNullOrEmpty($eliminar_grupo)){Eliminar_Grupo}
if ($meter_usuario_grupo){Meter_Usuario_Grupo}
if ($eliminar_usuario_grupo){Eliminar_Usuario_Grupo}
if ($listar_usuarios){Listar_Usuarios}
if (-not [String]::IsNullOrEmpty($nuevo_usuario)){Crear_Usuario}
if (-not [String]::IsNullOrEmpty($eliminar_usuario)){Eliminar_Usuario}

#function prompt { "PS C:\> "}