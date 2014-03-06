<#
    Copyright © 2014 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will install a script to run at boot time to reset the [static] DNS server configuration
to the correct address. 

.DESCRIPTION

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>
Param ( 
    [Parameter(Mandatory=$true)]
    [string[]]$DnsServers,   
    [string]$MacAddress
)

$ErrorActionPreference = "Stop"

$command = "C:\cfn\scripts\SetDnsConfiguration -DnsServers $DnsServers"
schtasks.exe /create /tn 'DnsReset' /sc onstart /tr $command /ru SYSTEM