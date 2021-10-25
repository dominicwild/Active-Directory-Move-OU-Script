$domain = "DC=test,DC=com" # The domain of the AD controller
$fromOU = "Users-win7" # The OU to move users from
$toOU = "Users" # The OU to move users to. Must be a direct child to the same OU that fromOU is.
$rootPath = "Customer" # Where the script will base its search and move operations

$csvFileLocation = "$PSScriptRoot\data\AllUsers.csv" # CSV file containing users. Used by main to move users between OUs
$csvExportFileLocation = "$PSScriptRoot\data\AllUsers.csv" # CSV exported from exportCsv.ps1. Exports all users specified within the rootPath OU variable.


$dev = "dom-local" # Convenience for enabling development behaviour. Should be set to false or deleted when using in a live environment.

switch ($dev) {
    "dom-local" {
        $domain = "DC=test,DC=local"
        $password = ConvertTo-SecureString 'mypassword123' -AsPlainText -Force
        $credential = New-Object System.Management.Automation.PSCredential ('itadminAccount', $password)
        $PSDefaultParameterValues = @{"*-AD*:Server" = 'AD'; "*-AD*:Credential" = $credential }
    }
}

