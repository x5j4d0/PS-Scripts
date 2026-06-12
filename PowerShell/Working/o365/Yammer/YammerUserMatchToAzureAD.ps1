<#
.SYNOPSIS
    PowerShell Script to Compare an Export of Yammer Users Against Azure AD (o365 / Azure AD).

.DESCRIPTION
    PowerShell Script to Compare an Export of Yammer Users Against Azure AD (o365 / Azure
    AD).

.PARAMETER UseExistingConnection
    Use Existing Connection.

.PARAMETER InputFile
    Input File.

.PARAMETER Outputfile
    Outputfile.

.EXAMPLE
    PS C:\> .\YammerUserMatchToAzureAD.ps1
    PowerShell Script to Compare an Export of Yammer Users Against Azure AD (o365 / Azure AD).

.NOTES
    Resources:  http://www.apache.org/licenses/LICENSE-2.0; https://www.yammer.com/YourTenant/data_exports/new_user_export
#>

Param(

   [bool]$UseExistingConnection = $FALSE,

   [string]$InputFile = ".\Users.csv",

   [string]$Outputfile = ".\Results.csv"

  ) 

if(!$UseExistingConnection){

     Write-Host "Creating a new connection. Login with your Office 365 Global Admin Credentials..."

     $msolcred = get-credential

     connect-msolservice -credential $msolcred

 }

 Write-Host "Loading all Office 365 users from Azure AD. This can take a while depending on the number of users..."

 $o365usershash = @{}

 get-msoluser -All | Select userprincipalname,proxyaddresses,objectid,@{Name="licenses";Expression={$_.Licenses.AccountSkuId}} | ForEach-Object {

     $o365usershash.Add($_.userprincipalname.ToUpperInvariant(), $_)

     $_.proxyaddresses | ForEach-Object {

         $email = ($_.ToUpperInvariant() -Replace "SMTP:(\\*)*", "").Trim()

         if(!$o365usershash.Contains($email))

         {

             $o365usershash.Add($email, $_)

         }

     }

 }

 Write-Host "Matching Yammer users to Office 365 users"

 $yammerusers = Import-Csv -Path $InputFile | Where-Object {$_.state -eq "active"}


 $yammerusers | ForEach-Object {

     $o365user = $o365usershash[$_.email.ToUpperInvariant()]

     $exists_in_azure_ad = ($o365user -ne $Null)

     $objectid = if($exists_in_azure_ad) { $o365user.objectid } else { "" }

     $licenses = if($exists_in_azure_ad) { $o365user.licenses } else { "" }



     $_ | Add-Member -MemberType NoteProperty -Name "exists_in_azure_ad" -Value $exists_in_azure_ad

     $_ | Add-Member -MemberType NoteProperty -Name "azure_object_id" -Value $objectid

     $_ | Add-Member -MemberType NoteProperty -Name "azure_licenses" -Value $licenses

 } 


Write-Host "Writting the output csv file..."

$yammerusers | Export-Csv $Outputfile -NoTypeInformation 


Write-Host "Done." 