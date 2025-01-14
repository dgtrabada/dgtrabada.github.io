param (
    [string]$Nombre = "Nombre",
    [string]$Password = "Password",
    [string]$Apellido="Apellido",


    [string]$nuevo_usuario="usuario",

    [string]$listar_miembros_grupo,

    [string]$nuevo_grupo,



    [switch]$listar_usuarios,
    [switch]$listar_grupos
    )
    
function Listar_Grupos {
    Write-Host "Grupos disponibles:"  -ForegroundColor Green
    Get-LocalGroup | ForEach-Object { Write-Host $_.Name }
}

function Listar_MiembrosDeGrupo {
     echo $listar_miembros_grupo
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
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo a eliminar"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Remove-LocalGroup -Name $nombreGrupo
        Write-Host "El grupo $nombreGrupo ha sido eliminado."
    } else {
        Write-Host "El grupo $nombreGrupo no existe."
    }
}

function Crear_MiembroDeGrupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo"
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a agregar"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Add-LocalGroupMember -Group $nombreGrupo -Member $nombreUsuario
        Write-Host "El usuario $nombreUsuario ha sido agregado al grupo $nombreGrupo."
    } else {
        Write-Host "El grupo $nombreGrupo no existe."
    }
}

function Eliminar_MiembroDeGrupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo"
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a eliminar"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Remove-LocalGroupMember -Group $nombreGrupo -Member $nombreUsuario
        Write-Host "El usuario $nombreUsuario ha sido eliminado del grupo $nombreGrupo."
    } else {
        Write-Host "El grupo $nombreGrupo no existe."
    }
}

function Listar_Usuarios {
    Write-Host "Usuarios en el sistema:" -ForegroundColor Green
    Get-LocalUser | ForEach-Object { Write-Host $_.Name }
}

function Crear_Usuario {
    #$nombreUsuario = Read-Host "Ingrese el nombre del nuevo usuario"
    #$password = Read-Host "Ingrese la password del nuevo usuario" -AsSecureString

    $cadena_secure_string = $password | ConvertTo-SecureString -AsPlainText -Force

    if (Get-LocalUser -Name $nuevo_usuario -ErrorAction SilentlyContinue) {
        Write-Host "El usuario $nuevo_usuario ya existe."  -ForegroundColor Red
    } else {
        New-LocalUser -Name $Nombre -Password  $nuevo_usuario  -FullName $Nombre
        Write-Host "El usuario $nuevo_usuario ha sido creado."  -ForegroundColor Green
    }
}

function Eliminar_Usuario {
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a eliminar"

    if (Get-LocalUser -Name $nombreUsuario -ErrorAction SilentlyContinue) {
        Remove-LocalUser -Name $nombreUsuario
        Write-Host "El usuario $nombreUsuario ha sido eliminado."
    } else {
        Write-Host "El usuario $nombreUsuario no existe."
    }
}

function Modificar_Usuario {
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a modificar"
    $nuevoNombre = Read-Host "Ingrese el nuevo nombre para el usuario"

    if (Get-LocalUser -Name $nombreUsuario -ErrorAction SilentlyContinue) {
        Rename-LocalUser -Name $nombreUsuario -NewName $nuevoNombre
        Write-Host "El usuario $nombreUsuario ha sido renombrado a $nuevoNombre."
    } else {
        Write-Host "El usuario $nombreUsuario no existe."
    }
}



if ($listar_usuarios){Listar_Usuarios}
if ($listar_grupos){Listar_Grupos}

#Cabiar da problemas ...
if ($listar_miembros_grupo.Length -gt 0){Listar_MiembrosDeGrupo}
if ($nuevo_grupo.Length -gt 0){Crear_Grupo}
if ($nuevo_usuario.Length -gt 0){Crear_Usuario}
