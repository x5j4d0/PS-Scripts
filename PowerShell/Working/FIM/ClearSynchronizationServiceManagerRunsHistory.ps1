<#
.SYNOPSIS
    PowerShell Function To Clear The Synchronization Service Manager Runs History.

.DESCRIPTION
    Clears the FIM Run History for Products like SharePoint Server and Microsoft Online
    Services Directory Synchronization (Microsoft Online Directory Sync) The Synchronization
    Service Manager (miisclient.exe) tool can generally be found in the following locations
    for these products:.

.PARAMETER True
    True.

.PARAMETER true
    true.

.EXAMPLE
    PS C:\> .\ClearSynchronizationServiceManagerRunsHistory.ps1
    PowerShell Function To Clear The Synchronization Service Manager Runs History.

.NOTES
    Resources:  http://social.technet.microsoft.com/wiki/contents/articles/2096.how-to-use-powershell-to-delete-the-run-history-based-on-a-specific-date-en-us.aspx
#>

Function Clear-FIMRunHistory { 
 
 
    [CmdletBinding()] 
    param 
    ( 
        [Parameter( 
       Mandatory=$True, 
        ValueFromPipeline=$true, 
        ValueFromPipelineByPropertyName=$true)] 
        [int]$DaysToKeep             
   ) 
  
 
    Begin { } 
  
 
    Process { 
  
 
        $DeleteDay = Get-Date 
        If($DaysToKeep -gt 0) { 
              
 
            $DayDiff = New-Object System.TimeSpan $DaysToKeep, 0, 0, 0, 0 
            $DeleteDay = $DeleteDay.Subtract($DayDiff) 
           
 
            Write-Output "Deleting run history earlier than or equal to:" $DeleteDay.toString('MM/dd/yyyy') 
            $lstSrv = @(get-wmiobject -class "MIIS_SERVER" -namespace "root\MicrosoftIdentityIntegrationServer" -computer ".")  
            Write-Output "Result: " $lstSrv[0].ClearRuns($DeleteDay.toString('yyyy-MM-dd')).ReturnValue 
              
 
        } 
  
 
        Trap {  
            Write-Output "`nError: $($_.Exception.Message)`n" 
            Exit 
        } 
       
 
    } 
      
 
    End { } 
      
 
} 
