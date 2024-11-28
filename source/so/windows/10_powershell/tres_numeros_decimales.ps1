echo "Dame un número"
[Double] $x=Read-Host
echo "Dame un número"
[Double] $y=Read-Host
echo "Dame un número"
[Double]$z=Read-Host

$r=$x+$y+$z

echo  $("{0:F2}" -f $r)