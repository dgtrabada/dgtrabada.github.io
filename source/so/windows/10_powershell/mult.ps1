# mult.ps1

$number = Read-Host "Introduce un número para mostrar su tabla de multiplicar"
$n = [int] $number

Write-Host "Tabla de multiplicar de $n"
Write-Host "--------------------------"
for ($i = 1; $i -le 10; $i++) {
    $r = $n * $i
    Write-Host "$n x $i = $r"
}
