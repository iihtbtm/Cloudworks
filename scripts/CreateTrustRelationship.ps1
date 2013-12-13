<#
    
Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
The script will create one side of an Active Directory trust relationship.

.DESCRIPTION
The script will create one side of a trust relationship with another domain. Run it on both sides (one Outbound
one Inbound) with the same password to fully establish the trust.

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>

Param (
    [string]$TargetDomainName = "cloudworks.local",
    [System.DirectoryServices.ActiveDirectory.TrustDirection]$Direction,
    [string]$TrustPassword = "Citrix123"  
)

#
# Main.
#
$ErrorActionPreference = "Stop"
$domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$domain.CreateLocalSideOfTrustRelationship($TargetDomainName, $Direction, $TrustPassword)

 



