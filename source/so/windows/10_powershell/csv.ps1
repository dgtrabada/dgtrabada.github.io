param (
    [Parameter(Mandatory = $true)]
    [string]$usuario,
    
    [Parameter(Mandatory = $true)]
    [string]$grupo
)

$archivoCSV = "usuarios.csv"

function GenerarPassword {
    $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#~$%&"
    $salida=""
    for ($i=0;$i -lt 8;$i++){ 
     $r = Get-Random -Minimum 0 -Maximum $chars.Length
     $salida+=$chars[$r]
    }
    Write-Output $salida
}

# Si no existe crear el encabezado
if (!(Test-Path $archivoCSV)) {
    Write-Output "usuario,grupo,password" >  $archivoCSV 
    #$nuevaEntrada = "$usuario,$grupo,$password"
    #Add-Content -Path $archivoCSV -Value $nuevaEntrada
}

# Si el usuario ya existe
$usuariosExistentes = Import-Csv -Path $archivoCSV

if ($usuariosExistentes | Where-Object { $_.usuario -eq $usuario }) 
{
    Write-Output "El usuario $usuario ya existe, no se puede crear."
}else{
    $password = GenerarPassword
    Write-Output "$usuario,$grupo,$password" >> $archivoCSV
    Write-Output "El usuario $usuario ha sido creado con la password $password en el grupo $grupo."
}
