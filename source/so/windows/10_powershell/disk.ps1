# disk.ps1

# Obtener la información de la partición C:
$disk = Get-PSDrive -Name C

# Calcular el porcentaje de espacio usado
$porcentaje = ($disk.Used / ($disk.Used + $disk.Free)) * 100

# Mostrar el porcentaje de espacio usado
Write-Output ("C: ocapada al {0:N2}%" -f $porcentaje)

