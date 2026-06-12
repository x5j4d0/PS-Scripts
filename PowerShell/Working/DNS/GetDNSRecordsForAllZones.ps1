<#
.SYNOPSIS
    PowerShell Script to List All DNS Records in Each Zone on a Windows DNS Server.

.DESCRIPTION
    PowerShell Script to List All DNS Records in Each Zone on a Windows DNS Server.

.PARAMETER DNSServer
    Provide your DNS Server Name or IP address here.

.EXAMPLE
    PS C:\> .\GetDNSRecordsForAllZones.ps1
    Edit the variables section and run to powerShell Script to List All DNS Records in Each Zone on a Windows DNS Server.

.NOTES
    Resources:  http://sigkillit.com/2015/10/27/list-all-dns-records-with-powershell
#>

$DNSServer = "YourServerName" #Provide your DNS Server Name or IP address here
$Zones = @(Get-DnsServerZone -ComputerName $DNSServer)
ForEach ($Zone in $Zones) {
	Write-Host "`n$($Zone.ZoneName)" -ForegroundColor "Green"
	$Results = $Zone | Get-DnsServerResourceRecord -ComputerName $DNSServer
    echo $Results >  "C:\BoxBuild\DNS\$($Zone.ZoneName).txt"
	#echo $Results | Export-Csv "C:\BoxBuild\DNS\$($Zone.ZoneName).csv" -NoTypeInformation
}