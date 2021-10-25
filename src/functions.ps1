function Write-Log($logLine) {
    $dateString = (Get-Date).GetDateTimeFormats("g")[0]
    $log = "[$dateString] $logLine"
    Add-Content "log.log" $log
    Write-Host $log
}

<#
.SYNOPSIS
Creates a distinguished name from a typical path, for searching and filter through AD. It assumes all the nodes are OU's. It will not work if any intermittent ADObject is anything else.

.PARAMETER path
A typical path. e.g., "Client/Users/Win7/Desktop"
#>
function Convert-PathToDistinguishedName($path) {
    $distinguishedName = ""
    foreach ($string in $path.split("/")) {
        if ($distinguishedName) {
            $distinguishedName = "OU=$string,$distinguishedName"
        }
        else {
            $distinguishedName = "OU=$string"
        }
    }
    return $distinguishedName
}

function ConvertTo-HashTable($psCustomObject) { 
    $output = @{}; 
    $psCustomObject | Get-Member -MemberType *Property | % {
        $output.($_.name) = $psCustomObject.($_.name); 
    } 
    return  $output;
}
