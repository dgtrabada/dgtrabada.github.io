# ext.ps1
foreach ($i In $(Get-ChildItem -Filter *.txt )){
    $newName = $_.Name -replace '\.dat$', '.txt'
    Rename-Item $_.FullName $newName
}

