# dados.ps1

param (
    [string] $Tiradas
)

# Función para mostrar la ayuda
function Show-Help {
    Write-Output "Uso del script dados.ps1:"
    Write-Output ".\dados.ps1 <número_de_tiradas>"
    Write-Output "Ejemplo: .\dados.ps1 100"
    Write-Output "Si no se proporciona ningún argumento, se preguntará cuántas tiradas deseas hacer."
    Write-Output "Si se usa el argumento 'help', se mostrará esta ayuda."
}

# Verificar si el argumento es 'help'
if ($Tiradas -eq 'help') {
    Show-Help
    exit
}

# Si no se proporciona argumento, preguntar cuántas tiradas hacer
if (-not $Tiradas) {
    $Tiradas = Read-Host "¿Cuántas tiradas quieres hacer?"
}

# Convertir el número de tiradas a entero
$Tiradas = [int] $Tiradas

# Inicializar el archivo CSV con los encabezados de las columnas
"Dados 1,Dado 2,Suma" > tiradas.csv

# Generar el número de tiradas especificado
for ($i = 1; $i -le $Tiradas; $i++) {
    # Obtener dos números aleatorios entre 1 y 6
    $dado1 = Get-Random -Minimum 1 -Maximum 7
    $dado2 = Get-Random -Minimum 1 -Maximum 7
    
    # Calcular la suma de los dos dados
    $suma = $dado1 + $dado2
    
    # Escribir la tirada en el archivo CSV
    "$dado1,$dado2,$suma" >> tiradas.csv
}

Write-Output "$Tiradas tiradas generadas y guardadas en tiradas.csv"

