<#
.SYNOPSIS
    Create a new Active Directory group objects using ADSI..

.DESCRIPTION
    Create a new Active Directory group objects using ADSI..

.PARAMETER Name
    Name.

.EXAMPLE
    PS C:\> .\New-IADGroup.ps1
    Run the script to perform the described operation.
#>

function New-IADGroup {
    param(
       [string]$Name = $(Throw "Please enter a group name."),
       [string]$ParentContainer = $(Throw "Please enter a parent container DN."),
       [string]$GroupScope,
       [string]$GroupType,
       [string]$Description
     ) 

  


    # validating existance of the parent container
    if( ![ADSI]::Exists("LDAP://$ParentContainer"))
    {
        Throw "Parent container could not be found, please check the value."
    }

    # validating group type values
    if($GroupType -ne "" -or $GroupType)
    {
        if($GroupType -notmatch '^(Security|Distribution)$')
        {
            Throw "GroupType Value must be one of: 'Security' or 'Distribution'"
        }
    }


    # validating group scope values
    if($GroupScope -ne "" -or $GroupScope)
    {
        if($GroupScope -notmatch '^(Universal|Global|DomainLocal)$')
        {
            Throw "GroupScope Value must be one of: 'Universal', 'Global' or 'DomainLocal'"
        }
    }


    switch ($GroupScope)
    {
        "Global" {$GroupTypeAttr = 2}
        "DomainLocal" {$GroupTypeAttr = 4}
        "Universal" {$GroupTypeAttr = 8}
    }


    # modify group type attribute if the group is security enabled
    if ($GroupType -eq 'Security')
    {
        $GroupTypeAttr = $GroupTypeAttr -bor 0x80000000
    }
     
  

    
        if( [ADSI]::Exists("LDAP://CN=$Name,$ParentContainer")) 
        {
            Write-Warning "The group $_ already exists in $ParentContainer."

         }
        else
       {  
           $Container = [ADSI]"LDAP://$ParentContainer"

            $group = $Container.Create("group","CN=$Name")
            $null = $group.put("sAMAccountname",$Name)
            $null = $group.put("grouptype",$GroupTypeAttr)

            if ($Description) {
                $null = $group.put("description",$Description)
            }

  
            # populate the Notes field
            $null = $group.put("info","Created $(Get-Date) by $env:userdomain\$env:username")
            $null = $group.SetInfo() 
            $group 
        }
    }