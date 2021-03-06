<#

    Copyright � 2013 Citrix Systems, Inc. All rights reserved.
	
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
Internal reboot processing script to remove a scheduled task and execute the
[script file containing the] script block specified.

.DESCRIPTION

.NOTES
    KEYWORDS: PowerShell
    REQUIRES: PowerShell Version 2.0

.LINK
     http://community.citrix.com/
#>
Param (
    [string]$Script,
    [string]$Task
)
$ErrorActionPreference = "Continue"
Import-Module CloudworksTools

Start-Logging
try {
    Write-Output "Deleting RunOnce task $Task"
    Remove-Task $Task
    $dir = Split-Path -parent $MyInvocation.MyCommand.Path
    Set-Location $dir
    Write-Output "Invoking script $Script"
    Invoke-Expression "$Script" 
    Write-Output "Script $Script completed "
}
catch {
     Write-Output "Caught exception"
     $error[0]
}
finally {
    Write-Output "End of reboot task"
    Stop-Logging
}