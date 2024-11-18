# analisis.ps1

$A = Import-Csv -Path tiradas.csv
$total=$A.Count
echo "leemos $total tiradas"

$s2=0
$s3=0
$s4=0
$s5=0
$s6=0
$s7=0
$s8=0
$s9=0
$s10=0
$s11=0
$s12=0

foreach ($i in $A.Suma){
  if ($i -eq 2) {$s2++}
  if ($i -eq 3) {$s3++}
  if ($i -eq 4) {$s4++}
  if ($i -eq 5) {$s5++}
  if ($i -eq 6) {$s6++}
  if ($i -eq 7) {$s7++}
  if ($i -eq 8) {$s8++}
  if ($i -eq 9) {$s9++}
  if ($i -eq 10) {$s10++}
  if ($i -eq 11) {$s11++}
  if ($i -eq 12) {$s12++}

}

$salida="2 ($([math]::Round(($s2 / $total) * 100, 0))%), "
$salida+="3 ($([math]::Round(($s3 / $total) * 100, 0))%), "
$salida+="4 ($([math]::Round(($s4 / $total) * 100, 0))%), "
$salida+="5 ($([math]::Round(($s5 / $total) * 100, 0))%), "
$salida+="6 ($([math]::Round(($s6 / $total) * 100, 0))%), "
$salida+="7 ($([math]::Round(($s7 / $total) * 100, 0))%), "
$salida+="8 ($([math]::Round(($s8 / $total) * 100, 0))%), "
$salida+="9 ($([math]::Round(($s9 / $total) * 100, 0))%), "
$salida+="10 ($([math]::Round(($s10 / $total) * 100, 0))%), "
$salida+="11 ($([math]::Round(($s11 / $total) * 100, 0))%), "
$salida+="12 ($([math]::Round(($s12 / $total) * 100, 0))%)"

echo $salida 