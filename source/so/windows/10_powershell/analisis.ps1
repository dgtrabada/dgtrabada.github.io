# analisis.ps1

# Leer el archivo tiradas.csv, excluyendo la primera línea de encabezado
$tiradas = Import-Csv -Path "tiradas.csv"

# Crear un diccionario para contar las ocurrencias de cada suma
$sumaConteo = @{}

# Recorrer cada tirada y contar la suma
foreach ($tirada in $tiradas) {
    $suma = [int]$tirada.Suma

    if ($sumaConteo.ContainsKey($suma)) {
        $sumaConteo[$suma]++
    } else {
        $sumaConteo[$suma] = 1
    }
}

# Obtener el número total de tiradas
$totalTiradas = $tiradas.Count

# Mostrar el número total de tiradas
Write-Output "De $totalTiradas tiradas: "

# Calcular y mostrar el porcentaje de cada suma

$salida=''

foreach ($suma in $sumaConteo.Keys | Sort-Object) {
    $conteo = $sumaConteo[$suma]
    $porcentaje = [math]::Round(($conteo / $totalTiradas) * 100, 2)
    $salida=$salida+"$suma($porcentaje%) "
}

Write-Output $salida
