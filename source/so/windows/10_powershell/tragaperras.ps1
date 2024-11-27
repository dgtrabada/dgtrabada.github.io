$rulos = @('limon', 'manzana', 'platano', 'siete')
$numero_tiradas=1000

function Girar-Rulos {
    $ganacia = -1
    $rulo1=$rulos[(Get-Random -Minimum 0 -Maximum $rulos.Length)]
    $rulo2=$rulos[(Get-Random -Minimum 0 -Maximum $rulos.Length)]
    $rulo3=$rulos[(Get-Random -Minimum 0 -Maximum $rulos.Length)]

    if( ($rulo1 -eq $rulo2) -and ($rulo1 -eq $rulo3)  ){
        $ganacia+=1
        if($rulo1 -eq "siete"){
            $ganacia+=99
            }
        }
    
    #Write-Output "$rulo1,$rulo2,$rulo3"
    return $ganacia
    }

$jugador=10
for ($j=0; $j -lt $numero_tiradas; $j++){
    $jugador+=Girar-Rulos
    Write-Output $jugador
    if ($jugador -lt 0){
        Write-Output "se arruina con $j tiradas "
        #exit
        $j=$numero_tiradas
        }
    }