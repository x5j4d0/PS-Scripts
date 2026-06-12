<#
.SYNOPSIS
    Get Application Pool User Name (Identity) and Password Using appcmd.

.DESCRIPTION
    Get Application Pool User Name (Identity) and Password Using appcmd.

.PARAMETER AppPoolName
    Provide your application pool name here.

.EXAMPLE
    PS C:\> .\IIS_Get_App_Pool_Credentials.ps1
    Edit the variables section and run to get Application Pool User Name (Identity) and Password Using appcmd.
#>

$AppPoolName = "YourAppPoolName" #Provide your application pool name here

cd "C:\Windows\System32\inetsrv"

./appcmd.exe list apppool "$AppPoolName" /text:*