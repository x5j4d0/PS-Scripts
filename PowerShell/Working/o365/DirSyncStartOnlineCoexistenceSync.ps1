<#
.SYNOPSIS
    Commandlet to manually start Active Directory Synchronization (Dir Sync) with Office 365.

.DESCRIPTION
    Commandlet to manually start Active Directory Synchronization (Dir Sync) with Office 365.

.EXAMPLE
    PS C:\> .\DirSyncStartOnlineCoexistenceSync.ps1
    Commandlet to manually start Active Directory Synchronization (Dir Sync) with Office 365.

.NOTES
    Requires:   Dirsync
#>

#Add-PSSnapin "Coexistence-Configuration" -ErrorAction SilentlyContinue

Import-Module Dirsync

Start-OnlineCoexistenceSync