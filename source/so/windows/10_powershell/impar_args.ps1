# impar_args.ps1

$number = [int] $args[0]


Write-Host "Números impares hasta el $number" -ForegroundColor Green
Write-Host "---------------------------" -ForegroundColor Green
for ($i = 1; $i -le $number; $i++) { 
    if($i%2 -eq 1){
        Write-Host "$i"  -ForegroundColor DarkYellow
    }
}