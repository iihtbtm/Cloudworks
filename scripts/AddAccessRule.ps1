<#
    Copyright © 2013 Citrix Systems, Inc. All rights reserved.

.SYNOPSIS
This script will add an Access Rule to the specified folder

.DESCRIPTION

.NOTES
    KEYWORDS: PowerShell, Citrix
    REQUIRES: PowerShell Version 2.0 

.LINK
     http://community.citrix.com/
#>
Param ( 
    [Parameter(Mandatory=$true)]
    [string]$Path,
    [Parameter(Mandatory=$true)]   
    [string]$UserName,
    [System.Security.AccessControl.FileSystemRights]$Rights = "FullControl"
)

$ErrorActionPreference = "Stop"

$acl = Get-Acl -Path $Path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($UserName, $Rights, "Allow")
$acl.SetAccessRule($rule)
Set-Acl -Path $Path -AclObject $acl