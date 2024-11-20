$numero_tiradas=1000
$tres_caras=0
for ($i=0;$i -lt $numero_tiradas;$i++){
    $m1=$(Get-Random -Minimum 0 -Maximum 2)
    $m2=$(Get-Random -Minimum 0 -Maximum 2)
    $m3=$(Get-Random -Minimum 0 -Maximum 2)
    
    if (($m1 -eq 0) -and ($m2 -eq 0) -and ($m3 -eq 0)){
        $tres_caras++
        }
}

echo "La probabilidad es ($($tres_caras/$numero_tiradas))" 
