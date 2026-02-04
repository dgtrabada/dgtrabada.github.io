param (
    [string]$usuario,       
    [string]$grupo="GA",
    [string]$delete,
    [switch]$demo,
    [switch]$help
)

$archivoCSV = "usuarios.csv"

function mostrar_ayuda(){
Write-Host "csv.ps1 -usuario [nombre usuario] -grupo [grupo]" -ForegroundColor Gray
}

function data_demo(){
Write-Host ".\csv.ps1 -usuario usuario1 -grupo GA" -ForegroundColor Gray
Write-Host ".\csv.ps1 -usuario usuario2 -grupo GA" -ForegroundColor Gray
Write-Host ".\csv.ps1 -usuario usuario3 -grupo GB" -ForegroundColor Gray
Write-Host ".\csv.ps1 -usuario usuario4 -grupo GB" -ForegroundColor Gray
Write-Host ".\csv.ps1 -usuario usuario4 -grupo GB" -ForegroundColor Gray
}

function GenerarPassword() {
    $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#~$%&"
    $salida=""
    for ($i=0;$i -lt 8;$i++){ 
     $r = Get-Random -Minimum 0 -Maximum $chars.Length
     $salida+=$chars[$r]
    }
    return $salida
}

function crear_usuario(){ 
 
    if (!(Test-Path $archivoCSV)) { 
    Write-Host "Se crea el archivo $archivoCSV" -ForegroundColor Green
    Write-Output "usuario,grupo,password" >  $archivoCSV 
    }

    $usuariosExistentes = Import-Csv -Path $archivoCSV
    if ($usuariosExistentes | Where-Object { $_.usuario -eq $usuario }){
        Write-Host "El usuario $usuario ya existe, cambiamos la contraseña"  -ForegroundColor Green 
    }else{
        $password = GenerarPassword
        Write-Output "$usuario,$grupo,$password" >> $archivoCSV
        Write-Host "El usuario $usuario ha sido creado con la password $password en el grupo $grupo." -ForegroundColor Green 
        cat $archivoCSV
    }
}

function borrar_usuario(){
    $usuariosExistentes = Import-Csv -Path $archivoCSV
    if ($usuariosExistentes | Where-Object { $_.usuario -eq $delete }) {
        $usuariosActualizados = $usuariosExistentes | Where-Object { $_.usuario -ne $delete }
        #-NoTypeInformationdeja un archivo más limpio
        $usuariosActualizados | Export-Csv -Path $archivoCSV -NoTypeInformation
        Write-Output "El usuario $delete ha sido eliminado del archivo."
    } else {
        Write-Output "El usuario $delete no existe, no se puede eliminar."
    }
    }


if($help) {mostrar_ayuda}
if($demo) {data_demo}
if($usuario){crear_usuario}
if($delete){borrar_usuario}
