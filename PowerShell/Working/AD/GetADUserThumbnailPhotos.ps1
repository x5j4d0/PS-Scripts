<#
.SYNOPSIS
    Script to Export User Account Thumbnail Photos (thumbnailPhoto) From Active Directory (AD) to Disk.

.DESCRIPTION
    Script to Export User Account Thumbnail Photos (thumbnailPhoto) From Active Directory
    (AD) to Disk.

.PARAMETER Directory
    Change this path to match your environment (Note: Remember to keep the trailing '\' backslash).

.EXAMPLE
    PS C:\> .\GetADUserThumbnailPhotos.ps1
    Edit the variables section and run to script to Export User Account Thumbnail Photos (thumbnailPhoto) From Active Directory (AD) to Disk.

.NOTES
    Requires:   ActiveDirectory
#>

Import-Module "ActiveDirectory" -ErrorAction SilentlyContinue

$list=GET-ADuser –filter * -properties thumbnailphoto

Foreach ($User in $list)

{

$Directory='C:\ztemp\ADPhotos\' #Change this path to match your environment (Note: Remember to keep the trailing '\' backslash)

If ($User.thumbnailphoto)

  {

  $Filename=$Directory+$User.samaccountname+'.jpg'

  [System.Io.File]::WriteAllBytes($Filename, $User.Thumbnailphoto)

  }

}