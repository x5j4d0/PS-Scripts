<#
.SYNOPSIS
    PowerShell Script To Add MIME Types As File Types For Display In The Browser.

.DESCRIPTION
    This script adds new MIME type to "AllowedInlineDownloadedMimeTypes" property list of
    defined SharePoint 2010 Web Application. Script prompts you for the Web Application URL
    and MIME type. Code shall run in context of Farm Administrators group member. Resource:
    http://gallery.technet.microsoft.com/scriptcenter/Add-new-MIME-type-open-PDF-f6c57c32.

.EXAMPLE
    PS C:\> .\SP2010AddFileTypesToInlineBrowsing.ps1
    PowerShell Script To Add MIME Types As File Types For Display In The Browser.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://gallery.technet.microsoft.com/scriptcenter/Add-new-MIME-type-open-PDF-f6c57c32
#>

If ( (Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null ) { 
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" 
} 
 
Get-SPWebApplication 
 
$WebApp = Get-SPWebApplication $(Read-Host "`nEnter Web Application URL") 
 
Write-Host `n"Mime Type Examples:"`n"application/pdf, text/html, text/xml"`n 
 
If ($WebApp.AllowedInlineDownloadedMimeTypes -notcontains ($MimeType = Read-Host "Enter a required mime type")) 
{ 
  Write-Host -ForegroundColor White `n"Adding" $MimeType "MIME Type to defined Web Application"$WebApp.url 
  $WebApp.AllowedInlineDownloadedMimeTypes.Add($MimeType) 
  $WebApp.Update() 
  Write-Host -ForegroundColor Green `n"The" $MimeType "MIME type has been successfully added." 
} Else { 
  Write-Host -ForegroundColor Red `n"The" $MimeType "MIME type has already been added." 
}