# mult_param.ps1

param (
    [Parameter(Mandatory=$true, HelpMessage="Dame un número")]
    [int]$number
)


Write-Host "Tabla de multiplicar de $number"
Write-Host "--------------------------"
for ($i = 1; $i -le 10; $i++) {
    $r = $number * $i
    Write-Host "$number x $i = $r"
}