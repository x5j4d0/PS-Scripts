<#
.SYNOPSIS
    Deploy patches and updates to VMware ESXi host servers using PowerCLI.

.DESCRIPTION
    Connects to an ESXi host, copies a patch bundle to a designated datastore, places the
    host in maintenance mode, installs the patch via esxcli, then returns the host to
    connected state and cleans up the datastore.

.PARAMETER esxcli
    Path to the local vSphere CLI installation (esxcli.exe).

.PARAMETER server
    IP address or hostname of the ESXi host to patch.

.PARAMETER patch
    Filename of the patch bundle to apply (e.g. ESXi500-201207001.zip).

.PARAMETER patchLocation
    Local path to the directory containing the patch bundle.

.PARAMETER datastore
    Name of the ESXi datastore used as a staging area for the patch.

.EXAMPLE
    PS C:\> .\DeployESXiPatch.ps1
    Edit the variables section and run to deploy the configured patch to the target ESXi host.

.NOTES
    Requires:   VMware.VimAutomation.Core, VMware.VumAutomation
    Resources:  http://geauxvirtual.wordpress.com/2011/12/02/applying-patches-to-esxi-5-with-the-help-of-powercli
#>

Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Add-PSSnapin VMware.VumAutomation -ErrorAction SilentlyContinue

$esxcli = "C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\esxcli.exe" #Path to your local workstation vSphere CLI installation
$server = "172.19.150.16" #ESXi host you want to patch
$patch = "ESXi500-201207001.zip" #patch file you want to apply
$patchLocation = "C:\Users\Administrator\Downloads\" #local path to patch file location
$datastore = "SPNotJuno11-1" #datastore where we want to store the patch
$remoteLocation = "/vmfs/volumes/" + $datastore + "/" + $patch + "/metadata.zip" #remote location of patch

#Mount the datastore to your local workstation

Connect-VIServer $server
New-PSDrive -name "mounteddatastore" -Root \ -PSProvider VimDatastore -Datastore (Get-Datastore $datastore)

#Now copy the patch to the datastore

Copy-Datastoreitem -Item ($patchLocation + $patch) -Destination mounteddatastore:

#Set the host state to maintenance mode

Set-VMHost -VMHost $server -State Maintenance

#Now deploy the patch

& $esxcli --server $server software vib install -d $remoteLocation

#Install-VMHostPatch -VMHost $server -HostPath $remoteLocation #-WhatIf

#Set the host state back to connected

Set-VMHost -VMHost $server -State Connected

#Now delete the patch from the datastore and remove the mounted datastore from your local workstation

del mounteddatastore:$patch
Remove-PSDrive -name "mounteddatastore" -PSProvider VimDatastore
