<#
.SYNOPSIS
    Functions to store Credentials as Encrypted Secure Strings for re-use in Credential Parameters.

.DESCRIPTION
    Functions to store Credentials as Encrypted Secure Strings for re-use in Credential
    Parameters.

.PARAMETER CredPath
    Cred Path.

.PARAMETER Help
    Help.

.EXAMPLE
    PS C:\> .\EncryptedCredentialsFunctions.ps1
    Functions to store Credentials as Encrypted Secure Strings for re-use in Credential Parameters.
#>

### Start Variables ###
$CredentialFile = "C:\BoxBuild\EncryptedCredentials.xml" #Change this to match your environment
### End Variables ###

#=====================================================================
# Export-Credential
# Usage: Export-Credential $CredentialObject $FileToSaveTo
#=====================================================================
function Export-Credential($cred, $path) {
      $cred = $cred | Select-Object *
      $cred.password = $cred.Password | ConvertFrom-SecureString
      $cred | Export-Clixml $path
}

#=====================================================================
# Get-MyCredential
#=====================================================================
function Get-MyCredential
{
param(
$CredPath,
[switch]$Help
)
$HelpText = @"

    Get-MyCredential
    Usage:
    Get-MyCredential -CredPath `$CredPath

    If a credential is stored in $CredPath, it will be used.
    If no credential is found, Export-Credential will start and offer to
    Store a credential at the location specified.

"@
    if($Help -or (!($CredPath))){write-host $Helptext; Break}
    if (!(Test-Path -Path $CredPath -PathType Leaf)) {
        Export-Credential (Get-Credential) $CredPath
    }
    $cred = Import-Clixml $CredPath
    $cred.Password = $cred.Password | ConvertTo-SecureString
    $Credential = New-Object System.Management.Automation.PsCredential($cred.UserName, $cred.Password)
    Return $Credential
}

Get-MyCredential -CredPath $CredentialFile

