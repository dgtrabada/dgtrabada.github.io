#tres_numeros_param.ps1

param (
    [Parameter(Mandatory=$true, HelpMessage="Dame un número")]
    [Double]$x,
    [Parameter(Mandatory=$true, HelpMessage="Dame un número")]
    [Double]$y,
    [Parameter(Mandatory=$true, HelpMessage="Dame un número")]
    [Double]$z
)

$suma=$x+$y+$z

echo  $("{0:F2}" -f $suma)