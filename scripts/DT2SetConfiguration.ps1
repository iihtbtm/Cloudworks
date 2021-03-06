<#
    Copyright © 2013-2014 Citrix Systems, Inc. All rights reserved.
	
	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	'Software'), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:
  
	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.
  
	THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.SYNOPSIS
This script will set params in the DT2 web.config file.

.DESCRIPTION

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>
Param ( 
    
    [string]$Path = "C:\inetpub\wwwroot\Citrix\CloudDesktop\Web.config",
    [string]$CloudStackUrl,
    [string]$ApiKey,
    [string]$SecretKey,
    [string]$ZoneId,
    [string]$Hypervisor,
    [string]$XenDesktopAdminAddress,
    [string]$XenDesktopHostingUnitName,
    [string]$PowerShellScriptsFolder,
    [string]$XenDesktopDomain,
    [string]$XenDesktopDDC,
    [string]$XenDesktopAvailabilityZone,
    [string]$XenDesktopStoreFrontUrl = ""
    
)

function SetValue($doc, $name, $value) {
    if (($value -ne $null) -and ($value -ne "")) {
        Write-Host "$name set to value ""$value"""
        $node = $doc.SelectSingleNode("//setting[@name='$name']/value")
        $node."#text" = $value
    }
}

function SetConnectionString($doc, $name, $value) {
    if (($value -ne $null) -and ($value -ne "")) {
        Write-Host "Connection String $name set to value ""$value"""
        $node = $doc.SelectSingleNode("//connectionStrings/add[@name='$name']")       
        
        $attributes = $node.Attributes
        $attr = $attributes.GetNamedItem("connectionString")
        $attr."#text" = $value    
    }
}

$ErrorActionPreference = "Stop"

[xml]$doc = Get-Content $Path

SetValue $doc "CloudStackUrl" $CloudStackUrl
SetValue $doc "CloudStackApiKey" $ApiKey
SetValue $doc "CloudStackSecretKey" $SecretKey
SetValue $doc "CloudStackZoneId" $ZoneId
SetValue $doc "CloudStackHypervisor" $Hypervisor
SetValue $doc "XenDesktopAdminAddress" $XenDesktopAdminAddress
SetValue $doc "XenDesktopHostingUnitName" $XenDesktopHostingUnitName
SetValue $doc "PowerShellScriptsFolder" $PowerShellScriptsFolder
SetValue $doc "XenDesktopDomain" $XenDesktopDomain
SetValue $doc "XenDesktopDDC" $XenDesktopDDC
SetValue $doc "XenDesktopAvailabilityZone" $XenDesktopAvailabilityZone

if ($XenDesktopStoreFrontUrl -ne "") {
    SetValue $doc "XenDesktopStoreFrontUrl" $XenDesktopStoreFrontUrl
}

$domain_parts = $XenDesktopDomain.Split('.')

$LdapPath = "LDAP://CN=Users"
foreach ($part in $domain_parts) {
    $LdapPath += ",DC=$part"
}
SetValue $doc "LdapPath" $LdapPath


$ADConnectionString = "LDAP://${XenDesktopDomain}/CN=Users,"
foreach ($part in $domain_parts) {
    $ADConnectionString += "DC=$part,"
}
$ADConnectionString = $ADConnectionString.TrimEnd(',')
SetConnectionString $doc "ADConnectionString" $ADConnectionString

$doc.Save($Path)
