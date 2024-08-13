# crear_usuarios_grupos.ps1

$nombre_base = "tunombre_gpws"

#Si da problemas poner una contraseña más compleja
$contraseña = "alumno"

# Bucle para crear los grupos GPWS01 a GPWS09
for ($i = 1; $i -le 9; $i++) {
    # Formatear el nombre del grupo
    $nombre_grupo = "GPWS{0:D2}" -f $i
    
    # Verificar si el grupo ya existe
    $grupo_existe = Get-LocalGroup | Where-Object { $_.Name -eq $nombre_grupo }
    
    if ($grupo_existe) {
        Write-Output "El grupo $nombre_grupo existe, no se crea"
    } else {
        New-LocalGroup -Name $nombre_grupo -Description "Grupo $nombre_grupo creado automáticamente"
        Write-Output "El grupo $nombre_grupo no existe, se crea"
    }

    # Bucle para crear los usuarios tunombre_gpwsXX_01 a tunombre_gpwsXX_09
    for ($j = 1; $j -le 9; $j++) {
        # Formatear el nombre del usuario
        $nombre_usuario = "{0}{1:D2}_{2:D2}" -f $nombre_base, $i, $j
        
        # Verificar si el usuario ya existe
        $usuario_existe = Get-LocalUser | Where-Object { $_.Name -eq $nombre_usuario }
        
        if ($usuario_existe) {
            Write-Output "El usuario $nombre_usuario existe, no se crea"
        } else {
            # Crear el usuario con la contraseña especificada
            New-LocalUser -Name $nombre_usuario -Password (ConvertTo-SecureString $contraseña -AsPlainText -Force) -FullName "$nombre_usuario" 
            Write-Output "El usuario $nombre_usuario con grupo $nombre_grupo no existe, se crea"
        }
        
        # Verificar si el usuario pertenece al grupo específico
        $miembro_del_grupo = Get-LocalGroupMember -Group $nombre_grupo | Where-Object { $_.Name -eq $nombre_usuario }
        
        if ($miembro_del_grupo) {
            Write-Output "El usuario $nombre_usuario ya está en el grupo $nombre_grupo, no se hace nada"
        } else {
            Add-LocalGroupMember -Group $nombre_grupo -Member $nombre_usuario
            Write-Output "El usuario $nombre_usuario no está en el grupo $nombre_grupo, se hace miembro"
        }
        
        # Verificar si el usuario pertenece al grupo Usuarios, para que pueda  tener acceso con entorno gráfico
        $miembro_de_usuarios = Get-LocalGroupMember -Group "Usuarios" | Where-Object { $_.Name -eq $nombre_usuario }
        
        if ($miembro_de_usuarios) {
            Write-Output "El usuario $nombre_usuario ya está en el grupo Usuarios, no se hace nada"
        } else {
            Add-LocalGroupMember -Group "Usuarios" -Member $nombre_usuario
            Write-Output "El usuario $nombre_usuario no está en el grupo Usuarios, se hace miembro"
        }
    }
}

