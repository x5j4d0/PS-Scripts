<#
.SYNOPSIS
    PowerShell Function to Connect to MS Online and Exchange Online PowerShell Modules (o365).

.DESCRIPTION
    PowerShell Function to Connect to MS Online and Exchange Online PowerShell Modules
    (o365).

.EXAMPLE
    PS C:\> .\ConnectToMSOnlineAndExchangeOnlineFunction.ps1
    PowerShell Function to Connect to MS Online and Exchange Online PowerShell Modules (o365).
#>

Function Connect-O365 {
 
Param (
  [Parameter(Mandatory=$true)]
  $User
  )
 
  $Cred = Get-Credential -Credential $User
 
  $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
 
  Import-Module (Import-PSSession $Session -AllowClobber) -Global
 
  Connect-MSOLService -Credential $Cred
 
}

## Call the function
Connect-O365