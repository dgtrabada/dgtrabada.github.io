# Script: crear_usuarios_grupos_csv.ps1

# Leer el archivo CSV
$users = Import-Csv -Path "users.csv"

# Recorrer cada usuario en el archivo CSV
foreach ($user in $users) {
    $nombre_usuario = $user.usuario
    $nombre_grupo = $user.grupo
    $password = $user.password
    $entorno_grafico = $user.EntGraf

    # Verificar si el grupo existe
    if (-Not (Get-LocalGroup -Name $nombre_grupo -ErrorAction SilentlyContinue)) {
        Write-Output "El grupo $nombre_grupo no existe, se crea"
        New-LocalGroup -Name $nombre_grupo
    } else {
        Write-Output "El grupo $nombre_grupo existe, no se crea"
    }

    # Verificar si el usuario existe
    $usuarioExiste = Get-LocalUser -Name $nombre_usuario -ErrorAction SilentlyContinue
    if ($usuarioExiste) {
        Write-Output "El usuario $nombre_usuario existe, no se crea"
        
        # Verificar si el usuario está en el grupo
        $miembroDelGrupo = Get-LocalGroupMember -Group $nombre_grupo | Where-Object { $_.Name -eq $nombre_usuario }
        if ($miembroDelGrupo) {
            Write-Output "El usuario $nombre_usuario ya está en el grupo $nombre_grupo, no se hace nada"
        } else {
            Write-Output "El usuario $nombre_usuario no está en el grupo $nombre_grupo, se hace miembro"
            Add-LocalGroupMember -Group $nombre_grupo -Member $nombre_usuario
        }
    } else {
        # Crear el usuario
        Write-Output "El usuario $nombre_usuario con grupo $nombre_grupo no existe, se crea"
        New-LocalUser -Name $nombre_usuario -Password (ConvertTo-SecureString $password -AsPlainText -Force) -PasswordNeverExpires -UserMayNotChangePassword
        Add-LocalGroupMember -Group $nombre_grupo -Member $nombre_usuario
        $logMessage = "El usuario $nombre_usuario con $password en el grupo $nombre_grupo se ha creado"
        $logMessage | Out-File -FilePath "lista_usuarios_creados.dat" -Append
    }

    # Verificar si el usuario debe tener acceso al entorno gráfico
    if ($entorno_grafico -eq "Y") {
        # Verificar si el usuario está en el grupo Usuarios
        $miembroUsuarios = Get-LocalGroupMember -Group "Usuarios" | Where-Object { $_.Name -eq $nombre_usuario }
        if ($miembroUsuarios) {
            Write-Output "El usuario $nombre_usuario ya está en el grupo Usuarios, tiene acceso al entorno gráfico"
        } else {
            Write-Output "El usuario $nombre_usuario no está en el grupo Usuarios, se añade para acceso al entorno gráfico"
            Add-LocalGroupMember -Group "Usuarios" -Member $nombre_usuario
        }
    } else {
        Write-Output "El usuario $nombre_usuario no requiere acceso al entorno gráfico"
    }
}

