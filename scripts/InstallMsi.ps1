<#
    Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will execute the specified file/script and wait for the process to exit.
Useful wrapper for msiexec.exe if you need to wait for the installation to complete.

.DESCRIPTION

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/stackmate
#>
Param ( 
    [Parameter(Mandatory=$true)]
    [string]$MsiPath
)

$ErrorActionPreference = "Stop"
Import-Module CloudworksTools
Start-Logging
$argumentList = "/i $MsiPath /quiet"
$msiexec = "${env:windir}\system32\msiexec.exe"
try {  
    Start-ProcessAndWait -FilePath $msiexec -ArgumentList $argumentList
} 
finally {
    Stop-Logging
}