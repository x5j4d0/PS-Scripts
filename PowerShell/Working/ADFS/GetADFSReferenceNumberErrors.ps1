<#
.SYNOPSIS
    PowerShell Script to find AD FS 2.0 Errors by their Reference Number.

.DESCRIPTION
    PowerShell Script to find AD FS 2.0 Errors by their Reference Number.

.PARAMETER ADFSServers
    Leave this line in place if you want to search for the error on the current machine.

.EXAMPLE
    PS C:\> .\GetADFSReferenceNumberErrors.ps1
    Edit the variables section and run to powerShell Script to find AD FS 2.0 Errors by their Reference Number.
#>

$ADFSServers = @($env:computername) #Leave this line in place if you want to search for the error on the current machine
#$ADFSServers = @("","") #Provide the host names here if you want to search across multiple ADFS Servers

Write-Host "Type or paste the reference number from an AD FS 2.0 error web page"
Write-Host "  this should be a string such as: 6906F0A7-BDF5-4EDB-B624-DE9CDAE7938F"
$userinput = Read-Host "Reference Number"

$CorrelationActivityID = $userinput.Trim()

$FilterXPath = "*[System/Correlation[@ActivityID='{" + $CorrelationActivityID + "}']]"
$LogName = "AD FS 2.0/Admin"
$DebugLogName = "AD FS 2.0 Tracing/Debug"
foreach ($ComputerName in $ADFSServers)
{

    try { #this requires "-ErrorAction Stop" on the commands
        $ADFSevent = Get-WinEvent -ComputerName $ComputerName -LogName $LogName `
            -FilterXPath $FilterXPath -ErrorAction Stop
        $ADFSevent | Format-list Id, MachineName, LogName, TimeCreated, Message

    }
    catch [Exception] {
        if ($_.Exception -match
            "No events were found that match the specified selection criteria") {
            # do nothing, it just means no events were found in this log
        }
        else
        {
            # Some other error happened so rethrow it so the user will see it
            Throw $_
        }
    }

    try { #this requires "-ErrorAction Stop" on the commands
        # You need to specify -Oldest when looking in Analytical and Debug/Trace logs
        $ADFSevent = Get-WinEvent -ComputerName $ComputerName -Oldest -LogName $DebugLogName `
            -FilterXPath $FilterXPath -ErrorAction Stop
        $ADFSevent | Format-list Id, MachineName, LogName, TimeCreated, Message
    }
    catch [Exception] {
        if ($_.Exception -match
            "No events were found that match the specified selection criteria") {
            # do nothing, it just means no events were found in this log
        }
        else
        {
            # Some other error happened so rethrow it so the user will see it
            Throw $_
        }
    }
}