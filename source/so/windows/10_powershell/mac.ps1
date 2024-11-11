# mac.ps1

Get-NetAdapter | Where-Object { $_.Status -eq 'Up'} | Format-Table Name,MacAddress

