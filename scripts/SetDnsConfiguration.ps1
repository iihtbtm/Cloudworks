<#
    Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will set the DNS serverIP addresses on either
a) all the NICs on the computer
b) the NIC with the specified MAC address

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

$filter = "IPEnabled=true"
if (-not [string]::IsNullOrEmpty($MacAddress)) {
    $filter += " and MacAddress='$MacAddress'"
}

$adapters = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter $filter 

foreach ($adapter in $adapters) {
    $result = $adapter.SetDNSServerSearchOrder($DnsServers)
}