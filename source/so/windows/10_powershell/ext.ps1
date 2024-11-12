# ext.ps1
foreach ($i In $(Get-ChildItem -Filter *.dat )){
  $newName = $i.Name -replace '\.dat$', '.txt'
  Rename-Item $i.Name $newName
  }

