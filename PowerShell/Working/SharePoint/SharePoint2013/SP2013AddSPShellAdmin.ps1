<#
.SYNOPSIS
    Powershell Script To Assign An Account Access To The SPShell Access Role 'SharePoint_Shell_Access' For A Specific Database.

.DESCRIPTION
    Powershell Script To Assign An Account Access To The SPShell Access Role
    'SharePoint_Shell_Access' For A Specific Database.

.PARAMETER UserAccount
    Change this to match your user name.

.PARAMETER contentDB
    Change your database name here.

.EXAMPLE
    PS C:\> .\SP2013AddSPShellAdmin.ps1
    Edit the variables section and run to powershell Script To Assign An Account Access To The SPShell Access Role 'SharePoint_Shell_Access' For A Specific Database.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://andersrask.sharepointspace.com/Lists/Posts/Post.aspx?ID=12; http://technet.microsoft.com/en-us/library/ff607596(v=office.15).aspx
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$UserAccount = "DOMAIN\YourAccount" #Change this to match your user name
$contentDB = Get-SPDatabase | ?{$_.Name -eq "Your_Database_Name"} #Change your database name here

Add-SPShellAdmin -UserName $UserAccount -database $contentDB