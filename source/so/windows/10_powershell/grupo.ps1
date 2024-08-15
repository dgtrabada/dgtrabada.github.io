# Script: grupo.ps1

function Listar-Grupos {
    Write-Output "Grupos disponibles:"
    Get-LocalGroup | ForEach-Object { Write-Output $_.Name }
}

function Ver-MiembrosDeGrupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Write-Output "Miembros del grupo $nombreGrupo:"
        Get-LocalGroupMember -Group $nombreGrupo | ForEach-Object { Write-Output $_.Name }
    } else {
        Write-Output "El grupo $nombreGrupo no existe."
    }
}

function Crear-Grupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del nuevo grupo"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Write-Output "El grupo $nombreGrupo ya existe."
    } else {
        New-LocalGroup -Name $nombreGrupo
        Write-Output "El grupo $nombreGrupo ha sido creado."
    }
}

function Eliminar-Grupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo a eliminar"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Remove-LocalGroup -Name $nombreGrupo
        Write-Output "El grupo $nombreGrupo ha sido eliminado."
    } else {
        Write-Output "El grupo $nombreGrupo no existe."
    }
}

function Crear-MiembroDeGrupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo"
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a agregar"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Add-LocalGroupMember -Group $nombreGrupo -Member $nombreUsuario
        Write-Output "El usuario $nombreUsuario ha sido agregado al grupo $nombreGrupo."
    } else {
        Write-Output "El grupo $nombreGrupo no existe."
    }
}

function Eliminar-MiembroDeGrupo {
    $nombreGrupo = Read-Host "Ingrese el nombre del grupo"
    $nombreUsuario = Read-Host "Ingrese el nombre del usuario a eliminar"
    if (Get-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue) {
        Remove-LocalGroupMember -Group $nombreGrupo -Member $nombreUsuario
        Write-Output "El usuario $nombreUsuario ha sido eliminado del grupo $nombreGrupo."
    } else {
        Write-Output "El grupo $nombreGrupo no existe."
    }
}

do {
    Write-Host "`nMenú de Grupos:"
    Write-Host "1. Listar grupos"
    Write-Host "2. Ver miembros de un grupo"
    Write-Host "3. Crear grupo"
    Write-Host "4. Eliminar grupo"
    Write-Host "5. Crear miembro de un grupo"
    Write-Host "6. Eliminar miembro de un grupo"
    Write-Host "7. Salir"
    $opcion = Read-Host "Seleccione opción"

    switch ($opcion) {
        1 { Listar-Grupos }
        2 { Ver-MiembrosDeGrupo }
        3 { Crear-Grupo }
        4 { Eliminar-Grupo }
        5 { Crear-MiembroDeGrupo }
        6 { Eliminar-MiembroDeGrupo }
        7 { Write-Host "Saliendo..." }
        Default { Write-Host "Opción incorrecta. Intente de nuevo." }
    }
} until ($opcion -eq 7)

