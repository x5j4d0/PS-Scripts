<#
.SYNOPSIS
    PowerShell Script To Warm Up Specified URLs On A SharePoint Farm.

.DESCRIPTION
    PowerShell Script To Warm Up Specified URLs On A SharePoint Farm.

.EXAMPLE
    PS C:\> .\SP2010WarmUpSpecificURLs.ps1
    PowerShell Script To Warm Up Specified URLs On A SharePoint Farm.
#>

$urls= @("http://YourWebSite/1", "http://YourWebSite/2")
## Change your application event log details here
New-EventLog -LogName "Application" -Source "SharePoint Warmup Script" -ErrorAction SilentlyContinue | Out-Null

$urls | % {
    $url = $_
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Credentials = [System.Net.CredentialCache]::DefaultCredentials
        $ret = $wc.DownloadString($url)
        if( $ret.Length -gt 0 ) {
            $s = "Warmup succeeded for url ""$($url)"": $([DateTime]::Now.ToString('dd.MM.yyyy HH:mm:ss'))" 
            $filename=((Split-Path ($MyInvocation.MyCommand.Path))+"\moss_warm_up_log.txt")
            if( Test-Path $filename -PathType Leaf ) {
                $c = Get-Content $filename
                $cl = $c -split '`n'
                $s = ((@($s) + $cl) | select -First 200)
            }
            Out-File -InputObject ($s -join "`r`n") -FilePath $filename
        }
    } catch {
          Write-EventLog -Source "SharePoint Warmup Script"  -Category 0 -ComputerName "." -EntryType Error -LogName "Application" `
            -Message "SharePoint Warmup failed for url ""$($url)""." -EventId 9999 #Change this ID to one of your choice

        $s = "Warmup failed for url ""$($url)"": $([DateTime]::Now.ToString('dd.MM.yyyy HH:mm:ss')) : $($_.Exception.Message)" 
        $filename=((Split-Path ($MyInvocation.MyCommand.Path))+"\moss_warm_up_log.txt")
        if( Test-Path $filename -PathType Leaf ) {
          $c = Get-Content $filename
          $cl = $c -split '`n'
          $s = ((@($s) + $cl) | select -First 200)
        }
        Out-File -InputObject ($s -join "`r`n") -FilePath $filename
    }
}

