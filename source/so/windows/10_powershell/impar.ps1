# impar.ps1

$n = Read-Host "Introduce un número"
$number = [int] $n


Write-Host "Números impares hasta el $number" -ForegroundColor Green
Write-Host "---------------------------" -ForegroundColor Green
for ($i = 1; $i -le $number; $i++) { 
    if($i%2 -eq 1){
        Write-Host "$i"  -ForegroundColor DarkYellow
    }
}