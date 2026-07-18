$rulos = @('limon', 'manzana', 'platano', 'siete')
$numero_tiradas=1000

function Girar-Rulos {
    $ganancia = -1
    $rulo1=$rulos[(Get-Random -Minimum 0 -Maximum $rulos.Length)]
    $rulo2=$rulos[(Get-Random -Minimum 0 -Maximum $rulos.Length)]
    $rulo3=$rulos[(Get-Random -Minimum 0 -Maximum $rulos.Length)]

    if( ($rulo1 -eq $rulo2) -and ($rulo1 -eq $rulo3)  ){
        $ganancia+=1
        if($rulo1 -eq "siete"){
            $ganancia+=99
            }
        }
    
    #Write-Output "$rulo1,$rulo2,$rulo3"
    return $ganancia
    }

$jugador=100
$partidas=0
for ($j=0; $j -lt $numero_tiradas; $j++){
    # si no le queda dinero para pagar la partida (1 euro), deja de jugar
    if ($jugador -lt 1){
        Write-Output "se arruina tras $partidas partidas"
        break
        }
    $jugador+=Girar-Rulos
    $partidas++
    #Write-Output $jugador
    }

Write-Output "Ha jugado $partidas partidas y termina con $jugador euros"