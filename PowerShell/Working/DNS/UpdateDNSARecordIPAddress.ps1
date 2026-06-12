<#
.SYNOPSIS
    PowerShell Script to Update an IP Address for an 'A' Record on a Windows DNS Server.

.DESCRIPTION
    PowerShell Script to Update an IP Address for an 'A' Record on a Windows DNS Server.

.EXAMPLE
    PS C:\> .\UpdateDNSARecordIPAddress.ps1
    PowerShell Script to Update an IP Address for an 'A' Record on a Windows DNS Server.
#>

### Start Variables ###
$DNSName = "YourDNSName"
$DNSZoneName = "YourDomain.com"
$IPAddress = "10.0.0.1"
### End Variables ###

$oldobj = get-dnsserverresourcerecord -name $DNSName -zonename $DNSZoneName -rrtype "A"
$newobj = get-dnsserverresourcerecord -name $DNSName -zonename $DNSZoneName -rrtype "A"
$newobj.recorddata.ipv4address=[System.Net.IPAddress]::parse($IPAddress)
Set-dnsserverresourcerecord -newinputobject $newobj -oldinputobject $oldobj -zonename $DNSZoneName -passthru