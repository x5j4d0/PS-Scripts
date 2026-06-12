<#
.SYNOPSIS
    Script to Search a File Path For All Files by Name Or Type.

.DESCRIPTION
    Script to Search a File Path For All Files by Name Or Type.

.EXAMPLE
    PS C:\> .\FindFilesInDirectory.ps1
    Script to Search a File Path For All Files by Name Or Type.

.NOTES
    Resources:  https://gallery.technet.microsoft.com/scriptcenter/Search-for-Files-Using-340397aa; https://twitter.com/#!/AmanDhally
#>

"`n"
write-Host "---------------------------------------------" -ForegroundColor Yellow
$filePath = Read-Host "Please Enter File Path to Search"
write-Host "---------------------------------------------" -ForegroundColor Green
$fileName = Read-Host "Please Enter File Name to Search"
write-Host "---------------------------------------------" -ForegroundColor Yellow
"`n"

Get-ChildItem -Recurse -Force $filePath -ErrorAction SilentlyContinue | Where-Object { ($_.PSIsContainer -eq $false) -and  ( $_.Name -like "*$fileName*") } | Select-Object Name,Directory| Format-Table -AutoSize *

write-Host "------------END of Result--------------------" -ForegroundColor Magenta

# end of the script