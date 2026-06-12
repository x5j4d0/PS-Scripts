<#
.SYNOPSIS
    PowerShell Script to Get All MSOnline Users With Admin Roles Access (o365).

.DESCRIPTION
    PowerShell Script to Get All MSOnline Users With Admin Roles Access (o365).

.PARAMETER evidence
    Change this path to match your environment.

.EXAMPLE
    PS C:\> .\GetMSOnlineAdminUsers.ps1
    Edit the variables section and run to powerShell Script to Get All MSOnline Users With Admin Roles Access (o365).

.NOTES
    Requires:   MSOnline, MSOnlineExtended
    Resources:  http://bachtothecloud.com/office-365-admin-accounts-extraction-via-powershell
#>

Import-Module MSOnline
Import-Module MSOnlineExtended
$cred=Get-Credential
Connect-MsolService -Credential $cred

##Get all roles
$AdminGroup = Get-MsolRole
 
Foreach ( $Group in $AdminGroup ) {
   Write-Host "$($Group.Name)" -ForegroundColor Green
   #Return all users with the loop role
   Get-MsolRoleMember -RoleObjectId $Group.ObjectId
}

##Display all Role types, Display names & Email addresses
$AdminGroups = Get-MsolRole
Foreach ( $Group in $AdminGroups ) {
   Write-Host "$($Group.Name)" -ForegroundColor Green
   Get-MsolRoleMember -RoleObjectId $Group.ObjectId | Select-object RoleMemberType,DisplayName,EmailAddress
}

##Create the report file
$evidence = "C:\BoxBuild\o365RoleMembersReport.txt" #Change this path to match your environment

##Add report file headers 
Add-content -path $evidence "Admin Group;Role Membership Type;Display Name;Email Address"
 
##Extraction step
$AdminGroups = Get-MsolRole
#First loop to parse all administration groups
Foreach ( $Group in $AdminGroup ) {
   $AllAdmin = Get-MsolRoleMember -RoleObjectId $Group.ObjectId | Select-object RoleMemberType,DisplayName,EmailAddress
   Write-Host "$($Group.Name)" -ForegroundColor Green
   #Second loop to extract all administrator accounts
   Foreach ( $Admin in $AllAdmin ) {
      Add-content -path $evidence "$($Group.Name);$($Admin.RoleMemberType);$($Admin.DisplayName);$($Admin.EmailAddress)"
   }
}