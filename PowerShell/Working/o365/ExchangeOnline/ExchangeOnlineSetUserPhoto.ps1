<#
.SYNOPSIS
    PowerShell Script to Add / Update a User Photo in Exchange Online (o365).

.DESCRIPTION
    PowerShell Script to Add / Update a User Photo in Exchange Online (o365).

.PARAMETER UserName
    Change this to match your User Name.

.PARAMETER PhotoPath
    Change this path to match your environment.

.EXAMPLE
    PS C:\> .\ExchangeOnlineSetUserPhoto.ps1
    Edit the variables section and run to powerShell Script to Add / Update a User Photo in Exchange Online (o365).
#>

### Start Variables ###
$UserName = "Johnny Smith" #Change this to match your User Name
$PhotoPath = "C:\BoxBuild\JSmith.jpg" #Change this path to match your environment
### End Variables ###

Import-PSSession $(New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Authentication Basic -AllowRedirection -Credential $(Get-Credential))

Get-UserPhoto $UserName

Remove-UserPhoto $UserName

Set-UserPhoto $UserName –PictureData ([System.IO.File]::ReadAllBytes($PhotoPath))

Get-UserPhoto $UserName