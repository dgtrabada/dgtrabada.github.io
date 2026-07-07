# meteo.ps1

# meteo.dat no tiene cabecera, se la damos con -Header
$A = Import-Csv -Path meteo.dat -Delimiter ' ' -Header dia,t_min,t_max,humedad

# Import-Csv lee todo como texto: convertimos las columnas a números,
# si no, Sort-Object ordenaría alfabéticamente ("8.7" quedaría después de "10.2")
foreach ($fila in $A) {
    $fila.t_min   = [double]$fila.t_min
    $fila.t_max   = [double]$fila.t_max
    $fila.humedad = [int]$fila.humedad
}

$media_min = ($A.t_min   | Measure-Object -Average).Average
$media_max = ($A.t_max   | Measure-Object -Average).Average
$media_hum = ($A.humedad | Measure-Object -Average).Average

Write-Output "Temperatura mínima media : $([math]::Round($media_min, 1)) ºC"
Write-Output "Temperatura máxima media : $([math]::Round($media_max, 1)) ºC"
Write-Output "Humedad media            : $([math]::Round($media_hum, 1)) %"

$caluroso = $A | Sort-Object t_max -Descending | Select-Object -First 1
$frio     = $A | Sort-Object t_min             | Select-Object -First 1
$amplitud = $A | Sort-Object { $_.t_max - $_.t_min } -Descending | Select-Object -First 1

Write-Output "Día más caluroso         : $($caluroso.dia) ($($caluroso.t_max) ºC)"
Write-Output "Día más frío             : $($frio.dia) ($($frio.t_min) ºC)"
Write-Output "Día con mayor amplitud   : $($amplitud.dia) ($([math]::Round($amplitud.t_max - $amplitud.t_min, 1)) ºC)"
