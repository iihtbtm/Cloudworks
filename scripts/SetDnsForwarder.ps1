<#
    
Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
The script will set a DNS forwarder for the specified zone. This script will fail if is not run 
on a DNS server (requires dnscmd)

.DESCRIPTION


.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>
Param (
    [string]$DnsZone = "cloudworks.net",
    [Parameter(Mandatory=$true)]
    [string]$DnsServerAddress
)

#
# Main.
#
$ErrorActionPreference = "Stop"
dnscmd /zoneadd $DnsZone /forwarder $DnsServerAddress
 



