. "$PSScriptRoot\functions.ps1"
. "$PSScriptRoot\config.ps1"

$distName = Convert-PathToDistinguishedName $rootPath

$users = Get-ADUser -Filter * -SearchBase "$distName,$domain" | Select-Object -Property Name, Surname, SamAccountName

$users | Export-Csv -Path $csvExportFileLocation -NoTypeInformation