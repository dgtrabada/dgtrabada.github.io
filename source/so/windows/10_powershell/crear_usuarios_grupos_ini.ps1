# crear_usuarios_grupos.ps1

# Bucle para crear los grupos GPWS01 a GPWS09
for ($i = 1; $i -le 9; $i++) {
    
    $nombre_grupo = "GPWS{0:D2}" -f $i
    $grupo_existe =  Get-LocalGroup | Select-String -Pattern $nombre_grupo -Quiet

    if ($grupo_existe) {
        Write-Output "El grupo $nombre_grupo existe, no se crea"
    } else {
        # Si el grupo no existe, crear el grupo
        New-LocalGroup -Name $nombre_grupo -Description "Grupo $nombre_grupo creado"
        Write-Output "El grupo $nombre_grupo no existe, se crea"
    }
}

