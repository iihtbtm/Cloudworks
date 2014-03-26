<#
    
Copyright © 2014 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will return the Windows Operating System Name

.DESCRIPTION
TThis script will return the Windows Operating System Name.

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>

$ErrorActionPreference = "Stop"
Import-Module CloudworksTools

Get-OsName
 



