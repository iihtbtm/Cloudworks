<#
    
Copyright © 2014 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will return true if the OS is client based

.DESCRIPTION
TThis script will return true if the OS is client based.

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>

$ErrorActionPreference = "Stop"
Import-Module CloudworksTools

$name = Get-OsName

if ($name.Contains("Server")) {
    exit 1 # Return "false"
}
exit 0 # Return "true"