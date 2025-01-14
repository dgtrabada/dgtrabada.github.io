param (
    [string]$password = "@lumn01234",
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
    [switch]$listar_grupos,
    [switch]$info,
    [string]$nueva_OU ,
    [string]$eliminar_OU,
    [switch]$listar_OU
    )
   
 $dirAD="DC=tunombre,DC=local"
 $mail="@tunombre.local"

function Info { Get-ADComputer -Filter * }

function help {
    Write-Host ""
    Write-Host "Mostrar ayuda" -ForegroundColor Gray    
    Write-Host "AD.ps1  -help"
    Write-Host ""
    Write-Host "Mostrar información del AD" -ForegroundColor Gray    
    Write-Host "AD.ps1  -info"
    Write-Host ""
    Write-Host "Listar las unidades organizativas" -ForegroundColor Gray
    Write-Host "AD.ps1  -listar_OU"
    Write-Host ""
    Write-Host "Crear una nueva unidades organizativas" -ForegroundColor Gray 
    Write-Host "AD.ps1 -nuevo_OU [grupo]"
    Write-Host ""
    Write-Host "Borrar una unidad organizativas" -ForegroundColor Gray 
    Write-Host "AD.ps1 -eliminar_OU [grupo]"
    Write-Host ""
    Write-Host "Listar los grupos" -ForegroundColor Gray
    Write-Host "AD.ps1  -listar_grupos"
    Write-Host ""
    Write-Host "Crear un nuevo grupo" -ForegroundColor Gray 
    Write-Host "AD.ps1 -nuevo_grupo [grupo]"
    Write-Host ""
    Write-Host "Eliminar un grupo" -ForegroundColor Gray 
    Write-Host "AD.ps1 -eliminar_grupo [grupo]"
    Write-Host ""
    Write-Host "Crear un nuevo usuario" -ForegroundColor Gray 
    Write-Host "AD.ps1 -nuevo_usuario [usuario]"
    Write-Host "AD.ps1 -nuevo_usuario [usuario] -password [password]"
    Write-Host "AD.ps1 -nuevo_usuario [usuario] -password [password] -grupo [Grupo]"
    Write-Host ""
    Write-Host "Eliminar un usuario" -ForegroundColor Gray 
    Write-Host "AD.ps1 -eliminar_usuario [usuario]"
    Write-Host ""
    Write-Host "Listar los miembros de un grupo" -ForegroundColor Gray 
    Write-Host "AD.ps1 -listar_miembros_grupo [grupo]"
    Write-Host ""
    Write-Host "Meter un usuario a un grupo" -ForegroundColor Gray 
    Write-Host ".\AD.ps1 -meter_usuario_grupo -usuario [usuario] -grupo [grupo]"
    Write-Host ""
    Write-Host "Eliminar usuario de un grupo" -ForegroundColor Gray
    Write-Host ".\AD.ps1 -eliminar_usuario_grupo -usuario [usuario] -grupo [grupo]"
} 

function Listar_Grupos {
    Write-Host "Grupos disponibles:"  -ForegroundColor Green
    Get-ADGroup -Filter * | ForEach-Object { Write-Host $_.Name }
}

function Listar_MiembrosDeGrupo {
    if (Get-ADGroup -Filter "Name -eq '$listar_miembros_grupo'"){
        Write-Host "Miembros del grupo $listar_miembros_grupo :" -ForegroundColor Green
        Get-ADGroupMember -Identity $listar_miembros_grupo 
    } else {
        Write-Host "El grupo $listar_miembros_grupo no existe." -ForegroundColor Red
    }
}

function Crear_Grupo {
    if (Get-ADGroup -Filter "Name -eq '$nuevo_grupo'") {
        Write-Host "El grupo $nuevo_grupo ya existe." -ForegroundColor Red
    } else {
        New-ADGroup -DisplayName $nuevo_grupo -Name  $nuevo_grupo -GroupScope DomainLocal -GroupCategory Security -Path $dirAD
        Write-Host "Creamos el grupo: $nuevo_grupo" -ForegroundColor Green
    }
}

function Eliminar_Grupo {
    if (Get-ADGroup -Filter "Name -eq '$eliminar_grupo'") {
        Remove-ADGroup -Identity $eliminar_grupo -Confirm:$false
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
    }elseif (-not (Get-ADGroup -Filter "Name -eq '$grupo'"))  {
        Write-Host "El grupo $grupo no existe" -ForegroundColor Red
    }elseif (-not (Get-ADUser -Filter "Name -eq '$usuario'")) {
        Write-Host "El usuario $usuario no existe" -ForegroundColor Red
    } else {
        Add-ADGroupMember -Identity  $grupo -Members $usuario
        Add-LocalGroupMember -Group $grupo -Member $usuario
        Write-Host "El usuario $usuario ha sido agregado al grupo $grupo" -ForegroundColor Green
    }
}

function Eliminar_Usuario_Grupo {
    if ([String]::IsNullOrEmpty($grupo)){
        Write-Host "Necesitamos el parametro -grupo" -ForegroundColor Red
    }elseif ([String]::IsNullOrEmpty($usuario)){
        Write-Host "Necesitamos el parametro -usuario" -ForegroundColor Red
    }elseif (-not (Get-ADGroup -Filter "Name -eq '$grupo'"))  {
        Write-Host "El grupo $grupo no existe" -ForegroundColor Red
    }elseif (-not (Get-ADUser -Filter "Name -eq '$nuevo_usuario'")) {
        Write-Host "El usuario $usuario no existe" -ForegroundColor Red
    } else {
        Remove-ADGroupMember -Identity $grupo -Members $usuario
        Write-Host "El usuario $usuario ha sido eliminado del grupo $grupo." -ForegroundColor Green
    }
}

function Listar_Usuarios {
    Write-Host "Usuarios en el A:" -ForegroundColor Green
    Get-ADUser -Filter * | Select-Object Name
}

function Crear_Usuario {
    $ErrorActionPreference="Stop"
    if (Get-ADUser -Filter "Name -eq '$nuevo_usuario'") {
        Write-Host "El usuario $nuevo_usuario ya existe."  -ForegroundColor Red
    } else {
        $usuario_creado=$True
        try{
           $cadena_secure_string = $password | ConvertTo-SecureString -AsPlainText -Force
           New-AdUser -Name $nuevo_usuario -SamAccountName $nuevo_usuario -UserPrincipalName $nuevo_usuario$mail -GivenName $nuevo_usuario -AccountPassword  $cadena_secure_string  -Enabled $True
           Write-Host "El usuario $nuevo_usuario ha sido creado y añadido al grupo Users."  -ForegroundColor Green
        }catch{
           $usuario_creado=$False
           Write-Host "Error: la contraseña no cumple con los requititos no creamos el usuario $nuevo_usuario "  -ForegroundColor Red
        }
        if($usuario_creado){
           # Para que los usuarios puedan iniciar sesión con entorno gráfico
           # Add-LocalGroupMember -Group "Users" -Member $nuevo_usuario
           if (-not [String]::IsNullOrEmpty($grupo)){
              if(-not (Get-ADGroup -Filter "Name -eq '$grupo'")) {
                New-ADGroup -DisplayName $grupo -Name  $grupo -GroupScope DomainLocal -GroupCategory Security -Path $dirAD                    
                Write-Host "Creamos el grupo: $grupo" -ForegroundColor Green
                }
              Add-ADGroupMember -Identity Group $grupo -Member $nuevo_usuario
              Write-Host "Metemos al usuario $nuevo_usuario en el grupo $grupo"  -ForegroundColor Green
           }
        }
    }
    $ErrorActionPreference="Continue"
}

function Eliminar_Usuario {
    if (Get-ADUser -Filter "Name -eq '$eliminar_usuario'") {
        Remove-ADUser -Identity $eliminar_usuario -Confirm:$false
        Write-Host "El usuario $eliminar_usuario ha sido eliminado." -ForegroundColor Green
    } else {
        Write-Host "El usuario $eliminar_usuario no existe." -ForegroundColor Red
    }
}

function Crear_OU {
    if(Get-ADOrganizationalUnit -Filter "Name -eq '$nueva_OU'"){
        Write-Host "$nueva_OU existe no se crea" -ForegroundColor Red 
    }else{
        New-ADOrganizationalUnit -DisplayName $nueva_OU -Name $nueva_OU -path "DC=tunombre,DC=local"
        Write-Host "$nueva_OU se ha creado" -ForegroundColor Green
    }
}

function Eliminar_OU {
    if(-not (Get-ADOrganizationalUnit -Filter "Name -eq '$eliminar_OU'")){
        Write-Host "$eliminar_OU no existe no se elimina" -ForegroundColor Red 
    }else{
        Set-ADOrganizationalUnit -Identity "OU=$eliminar_OU,DC=tunombre,DC=local" -ProtectedFromAccidentalDeletion $False
        Remove-ADOrganizationalUnit -Identity "OU=$eliminar_OU,DC=tunombre,DC=local" -Recursive -Confirm:$false
        Write-Host "$eliminar_OU se ha eliminado de forma recursiva sin confirmación" -ForegroundColor Green
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
#--AD--
if ($info){Info}
if (-not [String]::IsNullOrEmpty($nueva_OU)){Crear_OU}
if (-not [String]::IsNullOrEmpty($eliminar_OU)){Eliminar_OU}
if ($listar_OU){
    Get-ADOrganizationalUnit -LDAPFilter "(name=*)"  | FT Name,DistinguishedName
    }

#function prompt { "PS C:\> "}