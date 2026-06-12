<#
.SYNOPSIS
    PowerShell Function To Hide And Unhide SharePoint List Fields.

.DESCRIPTION
    PowerShell Function To Hide And Unhide SharePoint List Fields.

.EXAMPLE
    PS C:\> .\SP2007HideListField.ps1
    PowerShell Function To Hide And Unhide SharePoint List Fields.
#>

function Hide-SPField([string]$url, [string]$List, [string]$Field) {
  [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

  $SPSite = New-Object Microsoft.SharePoint.SPSite($url)
  $OpenWeb = $SPSite.OpenWeb()

  $OpenList = $OpenWeb.Lists[$List]

  $OpenField = $OpenList.Fields[$Field]
  $OpenField.ShowInNewForm = $False #Change this value to '$True' if you want the field to be visible again
  $OpenField.ShowInEditForm = $False #Change this value to '$True' if you want the field to be visible again
  $OpenField.Update()

  $SPSite.Dispose()
  $OpenWeb.Dispose()
}

#Example:

#Hide-SPField -url "http://moss/site" -List "My Custom List" -Field "UserField"