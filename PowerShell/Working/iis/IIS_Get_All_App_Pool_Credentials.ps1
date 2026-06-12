<#
.SYNOPSIS
    Get Application Pool User Names (Identity) and Passwords Using Web Server (IIS) Administration Cmdlets.

.DESCRIPTION
    Get Application Pool User Names (Identity) and Passwords Using Web Server (IIS)
    Administration Cmdlets.

.EXAMPLE
    PS C:\> .\IIS_Get_All_App_Pool_Credentials.ps1
    Get Application Pool User Names (Identity) and Passwords Using Web Server (IIS) Administration Cmdlets.
#>

$appPools = Get-WebConfiguration -Filter '/system.applicationHost/applicationPools/add'
 
foreach($appPool in $appPools)
{
    if($appPool.ProcessModel.identityType -eq "SpecificUser")
    {
        Write-Host $appPool.Name -ForegroundColor Green -NoNewline
        Write-Host " -"$appPool.ProcessModel.UserName"="$appPool.ProcessModel.Password
    }
}