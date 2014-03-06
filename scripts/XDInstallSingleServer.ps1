<#
    
Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will install a simple "one server" XenDesktop on the local machine

.DESCRIPTION
Installs the XenDesktop Controller, Citrix Studio and Storefront on the local server. Will also install a 
local SQL Server if not already present. Requires access to the XenDeskop DVD image.

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>

Param (
    [string]$InstallerPath = "D:\x64\XenDesktop Setup",
      [switch]$Reboot 
)

function Install-DotNet () {
    try {
       $dotnet351 = "AS-NET-Framework"
       Import-Module ServerManager   
       $feature = Get-WindowsFeature | Where-Object {$_.Name -eq $dotnet351}
       if (-not $feature.Installed) {
           Add-WindowsFeature $dotnet351
       }
    } catch {
      Write-Log "Error attempting to install .NET 3.5.1"
      throw
    }
}

function Install-Storefront ($InstallerPath) {
    try {
		$parent = Split-Path -parent $InstallerPath
        $logdir = "C:\Windows\Temp\Citrix"
        if (-not (Test-Path $logdir)) {
            New-Item -Path $logdir -ItemType Directory
        }
				
		$privSvc =  Join-Path -Path $parent -ChildPath "Citrix Desktop Delivery Controller\CitrixPrivilegedService_x64.msi"
		$msiargs = "/i ""$privSvc"" /quiet"
		$msiexec = "${env:windir}\system32\msiexec.exe"
		Start-ProcessAndWait $msiexec $msiargs

        $installargs = "-noconsole -silent -logfile ${logdir}\StoreFrontLog.txt"     
        $installer = Join-Path -Path $parent -ChildPath "StoreFront\CitrixStoreFront-x64.exe"
        Start-ProcessAndWait $installer $installargs
		

    } catch {
      Write-Log "Error attempting to install Storefront"
      Write-Log $error[0]      
    }
}

#
# Main
#
$ErrorActionPreference = "Stop"
Import-Module CloudworksTools
Start-Logging
try { 
     # Seems to be a problem with the installation of pre-requisites if .NET 3.5.1 not installed.
    Install-DotNet

    # Problem with storefront installation used from the XD installer.
    $installargs = "/components controller,desktopstudio /quiet /configure_firewall /noreboot"
    $installer = Join-Path -Path $InstallerPath -ChildPath "XenDesktopServerSetup.exe"
    Start-ProcessAndWait $installer $installargs
    
    Install-StoreFront $InstallerPath
    if ($Reboot) {
        Restart-Computer -Force
    }
} 
finally {
    Stop-Logging
}