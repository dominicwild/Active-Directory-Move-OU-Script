# Finds all users under a specific OU and outputs them to a CSV. Used for determining what the script will move. 
. "$PSScriptRoot\functions.ps1"
. "$PSScriptRoot\config.ps1"

$distName = Convert-PathToDistinguishedName $rootPath

$users = Get-ADUser -Filter * -SearchBase "$distName,$domain" | Select-Object -Property Name, Surname, SamAccountName

$users | Export-Csv -Path $csvExportFileLocation -NoTypeInformation