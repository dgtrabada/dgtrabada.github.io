# mult_param.ps1

param (
    [Parameter(Mandatory=$true, HelpMessage="Dame un número")]
    [int]$number
)


Write-Host "Números impares hasta el $number" -ForegroundColor Green
Write-Host "---------------------------" -ForegroundColor Green
for ($i = 1; $i -le $number; $i++) { 
    if($i%2 -eq 1){
        Write-Host "$i"  -ForegroundColor DarkYellow
    }
}