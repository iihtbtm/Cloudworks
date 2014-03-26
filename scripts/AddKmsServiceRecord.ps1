<#
    
Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
The script will create a SRV record so the KMS server can be located for the specified zone. This script will fail if is not run 
on a DNS server (requires dnscmd)

.DESCRIPTION


.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>
Param (
    [Parameter(Mandatory=$true)]
    [string]$Zone,
    [Parameter(Mandatory=$true)]
    [string]$KmsServerAddress
)

#
# Main.
#
$ErrorActionPreference = "Stop"
dnscmd /recordadd $Zone _VLMCS._TCP SRV 0 100 1688 $KmsServerAddress
 