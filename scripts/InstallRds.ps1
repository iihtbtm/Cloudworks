<#
    Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will install the RDS server role.

.DESCRIPTION

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/stackmate
#>
Param (   
    [switch]$Reboot = $true
)
$ErrorActionPreference = "Stop"
Import-Module CloudworksTools
Install-Feature "RDS-RD-Server"
if ($Reboot) {
    Restart-Computer -Force
}