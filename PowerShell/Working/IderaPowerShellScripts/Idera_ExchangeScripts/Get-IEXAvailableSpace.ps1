<#
.SYNOPSIS
    Retrieve Available Space.

.DESCRIPTION
    Retrieve Available Space.

.EXAMPLE
    PS C:\> .\Get-IEXAvailableSpace.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 


filter Get-IEXAvailableSpace
{

    if($_ -is [Microsoft.Exchange.Data.Directory.Management.MailboxServer])
    {
        trap {
            Write-Error $_
            continue
        }

        # Convert date to WMI CIM date
        $tc = [System.Management.ManagementDateTimeconverter]
        $Start = $tc::ToDmtfDateTime( (Get-Date).AddDays(-1).Date )
        $End = $tc::ToDmtfDateTime( (Get-Date).Date)

        # Create two calculated properties
        $DB = @{Name="DB";Expression={$_.InsertionStrings[1]}}
        $FreeMB = @{Name="Free(MB)";Expression={[int]$_.InsertionStrings[0]}}

        $filter = "LogFile='Application' AND EventCode=1221 AND TimeWritten>='$Start' AND TimeWritten<='$End'"

        Get-WMIObject Win32_NTLogEvent -ComputerName $_.Name -Filter $filter | Select-Object ComputerName,$DB,$FreeMB
    }
    else
    {
        Write-Warning "Wrong object type, only MailboxServer objects are allowed.`nUsage example: Get-MailboxServer | Get-IEXAvailableSpace."
    }
} 

