# mac.ps1

# Obtener todos los adaptadores de red en el sistema
$networkAdapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }

# Iterar sobre cada adaptador para obtener la dirección MAC
foreach ($adapter in $networkAdapters) {
    $macAddress = $adapter.MacAddress
    $adapterName = $adapter.Name
    Write-Host "Adaptador: $adapterName"
    Write-Host "MAC: $macAddress"
    Write-Host "---------------------------"
}
