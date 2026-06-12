<#
.SYNOPSIS
    PowerShell Command to Get you Office 365 (o365) Tenant ID Value (GUID).

.DESCRIPTION
    PowerShell Command to Get you Office 365 (o365) Tenant ID Value (GUID).

.PARAMETER TenantPrefix
    Change the prefix here to match your tenant name.

.EXAMPLE
    PS C:\> .\GetMSOnlineTenantID.ps1
    Edit the variables section and run to powerShell Command to Get you Office 365 (o365) Tenant ID Value (GUID).
#>

$TenantPrefix = "YourTenantName" #Change the prefix here to match your tenant name

(Invoke-WebRequest https://login.windows.net/$TenantPrefix.onmicrosoft.com/.well-known/openid-configuration|ConvertFrom-Json).token_endpoint.Split(‘/’)[3]