# dados.ps1
param (
    [string] $Tiradas
)

function Tirar_dados([int] $Tiradas){
    "dado1,dado2,suma" > tiradas.csv
    for ($i = 1; $i -le $Tiradas; $i++) {
        $dado1 = Get-Random -Minimum 1 -Maximum 7
        $dado2 = Get-Random -Minimum 1 -Maximum 7
        $suma = $dado1 + $dado2
        "$dado1,$dado2,$suma" >> tiradas.csv
        }
        Write-Output "$Tiradas tiradas generadas y guardadas en tiradas.csv"
    }

function Show-Help {
    Write-Output "Uso del script dados.ps1:"
    Write-Output ".\dados.ps1 <número_de_tiradas>"
    Write-Output "Ejemplo: .\dados.ps1 100"
    Write-Output "Si no se proporciona ningún argumento, se preguntará cuántas tiradas deseas hacer."
    Write-Output "Si se usa el argumento 'help', se mostrará esta ayuda."
}


if (-not $Tiradas) {

    $Tiradas = Read-Host "¿Cuántas tiradas quieres hacer?"
    Tirar_dados($Tiradas)

    }elseif ($Tiradas -eq "help"){
        Show-Help        
    }else{
        Tirar_dados($Tiradas)
    }

