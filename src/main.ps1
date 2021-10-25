. "$PSScriptRoot\functions.ps1"
. "$PSScriptRoot\config.ps1"

$userList = Import-CSV $csvFileLocation
$distName = Convert-PathToDistinguishedName $rootPath

$ouList = @()

foreach($user in $userList){
    $username = $user.SamAccountName
    $user = Get-ADUser -Filter "SamAccountName -eq '$username'" -SearchBase "$distName,$domain"

    if(-not $user){
        Write-Log "User '$username' cannot be found under '$rootPath'."
        continue
    }

    $userFromPath = $user.DistinguishedName
    $userToPath = $userFromPath -replace $fromOU, $toOU -replace "CN=.*?,OU=" , "OU="

    if(-not $userFromPath -match $fromOU){
        Write-Log "User '$($user.Name)'($username) is not located within the fromOU $fromOU. User located in $($user.DistinguishedName)"
        continue
    }

    if(($userFromPath -replace "CN=.*?,OU=" , "OU=") -eq $userToPath){
        Write-Log "User '$($user.Name)'($username) is already at destination OU location."
        continue
    }

    if(-not ($ouList -contains $userToPath)){
        $ou = $null
        try {
            $ou = Get-ADOrganizationalUnit $userToPath
        } catch {
            Write-Log "Cannot find OU '$userToPath'. Unable to move User '$($user.Name)'($username)"
            continue
        }

        if($ou){
            $ouList += $userToPath
        } 
    }
        
    try {
        Move-ADObject -Identity $userFromPath -TargetPath $userToPath 
        Write-Log "User '$($user.Name)'($username) successfully moved to '$userToPath'"
    } catch {
        Write-Log "An error has occurred moving user '$($user.Name)'($username) to '$userToPath'."
        Write-Log $_
        continue
    }
    
}






