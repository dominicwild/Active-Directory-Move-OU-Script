# Test script for importing users into AD in order to test moving script
. "$PSScriptRoot\config.ps1"
. "$PSScriptRoot\functions.ps1"

$users = Import-CSV "$PSScriptRoot\data\allusers.csv"

foreach ($user in $users) {
    $user = ConvertTo-HashTable $user
    Write-Host "Adding user $($user.SamAccountName)"
    New-ADUser @user -Path "OU=CAP,OU=Users-Win7,OU=Customer,$domain"
}

