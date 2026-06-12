<#
.SYNOPSIS
    PowerShell Function that Measures Page Load Times and HTTP Protocol Status Codes.

.DESCRIPTION
    PowerShell Function that Measures Page Load Times and HTTP Protocol Status Codes.

.PARAMETER URL
    URL.

.PARAMETER Times
    Times.

.EXAMPLE
    PS C:\> .\WebPageLoadTimesTest.ps1
    PowerShell Function that Measures Page Load Times and HTTP Protocol Status Codes.

.NOTES
    Resources:  https://google.com"
#>

Function MeasurePageLoad {

param($URL, $Times)
$i = 1
While ($i -lt $Times)
{$Request = New-Object System.Net.WebClient
$Request.UseDefaultCredentials = $true
$Start = Get-Date
$PageRequest = $Request.DownloadString($URL)
$TimeTaken = ((Get-Date) – $Start).Totalseconds
$StatusCode = [int][system.net.httpstatuscode]::ok
$Request.Dispose()
Write-Host Request $i took $TimeTaken Seconds with a $StatusCode  HTTP Status Code -ForegroundColor Green
$i ++}
}