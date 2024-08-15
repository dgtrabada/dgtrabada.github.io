# Script: usuarios.ps1

function Listar-Usuarios {
    Write-Output "Usuarios en el sistema:"
    Get-LocalUser | ForEach-Object { Write-Output $_.Name }
}

function Crear-Usuario {
    $nombreUsuario = Read-Host "Ingrese el nombre del nuevo usuario"
    $password = Read-Host "Ingrese la contraseña del nuevo usuario" -AsSecureString

    if (Get-LocalUser -Name $nombreUsuario -ErrorAction SilentlyContinue) {
        Write-Output "El usuario $nombreUsuario ya existe."
    } else {
        New-LocalUser -Name $nombreUsuario -Password $password -FullName $nombreUsuario
        Write-Output "El usuario $nombreUsuario ha sido creado."
    }
}

function Eliminar-Usuario {
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a eliminar"

    if (Get-LocalUser -Name $nombreUsuario -ErrorAction SilentlyContinue) {
        Remove-LocalUser -Name $nombreUsuario
        Write-Output "El usuario $nombreUsuario ha sido eliminado."
    } else {
        Write-Output "El usuario $nombreUsuario no existe."
    }
}

function Modificar-Usuario {
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a modificar"
    $nuevoNombre = Read-Host "Ingrese el nuevo nombre para el usuario"

    if (Get-LocalUser -Name $nombreUsuario -ErrorAction SilentlyContinue) {
        Rename-LocalUser -Name $nombreUsuario -NewName $nuevoNombre
        Write-Output "El usuario $nombreUsuario ha sido renombrado a $nuevoNombre."
    } else {
        Write-Output "El usuario $nombreUsuario no existe."
    }
}

do {
    Write-Host "`nMenú de Usuarios:"
    Write-Host "1. Listar usuarios"
    Write-Host "2. Crear usuario"
    Write-Host "3. Eliminar usuario"
    Write-Host "4. Modificar usuario"
    Write-Host "5. Salir"
    $opcion = Read-Host "Seleccione opción"

    switch ($opcion) {
        1 { Listar-Usuarios }
        2 { Crear-Usuario }
        3 { Eliminar-Usuario }
        4 { Modificar-Usuario }
        5 { Write-Host "Saliendo..." }
        Default { Write-Host "Opción incorrecta. Intente de nuevo." }
    }
} until ($opcion -eq 5)

