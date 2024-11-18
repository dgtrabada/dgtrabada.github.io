# analisis.ps1

$A = Import-Csv -Path tiradas.csv
$total=$A.Count
echo "leemos $total tiradas"

#inicializamos la matriz con 13 elementos
$s = @(0)*13

for ($i=2;$i -lt 13;$i++){
    $s[$i]=0
    }

foreach ($i in $A.Suma){
    $s[$i]++
    }

$salida=""

for ($i=2;$i -lt 13;$i++){
    $salida+="$i ($([math]::Round(($s[$i] / $total) * 100, 0))%)"
    if($i -lt 12) {
        $salida+=", "
        }
    }
echo $salida  