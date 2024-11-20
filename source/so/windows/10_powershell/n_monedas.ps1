$numero_tiradas=1000
$tres_caras=0
$N_monedas=3

$m = @(0)*$N_monedas

for ($j=0; $j -lt $numero_tiradas; $j++){

    for ($i=0;$i -lt $N_monedas;$i++){
        $m[$i]=$(Get-Random -Minimum 0 -Maximum 2)
        }

    $todas_cara=$true

    for ($i=0;$i -lt $N_monedas;$i++){
        if($m[$i] -eq 1) {
            $todas_cara=$false
            }
        }

    if ($todas_cara){
        $tres_caras++
        }
    }

echo "La probabilidad es ($($tres_caras/$numero_tiradas))" 
