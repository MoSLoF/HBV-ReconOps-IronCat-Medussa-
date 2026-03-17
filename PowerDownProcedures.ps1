# Power down procedures for vSphere/vCenter environment.
# Requires PowerCLI: Install-Module VMware.PowerCLI

# Allow the script to work with PowerCLI commands
# Add-PSSnapin is legacy — use Import-Module for PowerCLI 6.5+
# Add-PSSnapin VMware.VimAutomation.Core

# Set Variables
$VIserver = "10.101.1.142"

[array]$DbServer     = "test1", "test2", "test3"
[array]$Esxi         = "10.101.1.142"

# Define VM groups — populate as needed
$NonEssentials = @()
$VDI           = @()
$fileServers   = @()
$Backups       = @()

# Input vCenter credential
$cred = Get-Credential

# Connect to vCenter before executing commands
Connect-VIServer $VIserver -Credential $cred

# Stop sets of servers in dependency order (not vCenter itself)
if ($NonEssentials) { Stop-VMGuest $NonEssentials -Confirm:$false }
if ($VDI)           { Stop-VMGuest $VDI           -Confirm:$false }
if ($fileServers)   { Stop-VMGuest $fileServers   -Confirm:$false }
if ($DbServer)      { Stop-VMGuest $DbServer      -Confirm:$false }
if ($Backups)       { Stop-VMGuest $Backups       -Confirm:$false }

# Find which ESXi host vCenter is running on
$VCHost        = (Get-VM vcenter | Select-Object VMHost).VMHost.Name
$HostsToTurn   = Get-VMHost | Where-Object { $_.Name -ne $VCHost }

# Put all non-vCenter hosts into maintenance mode
foreach ($esxiHost in $HostsToTurn) {
    Set-VMHost -VMHost $esxiHost -State Maintenance
    Start-Sleep 20
}

# Shut down all non-vCenter hosts
foreach ($esxiHost in $HostsToTurn) {
    Stop-VMHost -VMHost $esxiHost -Force -Confirm:$false
    Start-Sleep 20
}

# All machines except the one running vCenter are now off.
Write-Host "Power-down sequence complete. vCenter host ($VCHost) still running." -ForegroundColor Green
