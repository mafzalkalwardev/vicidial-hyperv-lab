# Creates a Hyper-V VM for VICIdial lab use. Requires Administrator.
#Requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'

$baseDir   = Split-Path $PSScriptRoot -Parent
$vmName    = 'VICIdial-Lab'
$isoPath   = Join-Path $baseDir 'iso\ViciBox_V12.x86_64-12.0.2.iso'
$vmRoot    = Join-Path $baseDir 'vm'
$vhdPath   = Join-Path $vmRoot "$vmName.vhdx"
$switchName = 'VICIdial-External'
$memoryGb  = 4
$vhdSizeGb = 40
$processorCount = 2

function Ensure-ExternalSwitch {
    param([string]$Name)
    $existing = Get-VMSwitch -Name $Name -ErrorAction SilentlyContinue
    if ($existing) { return $existing }

    $adapter = Get-NetAdapter | Where-Object {
        $_.Status -eq 'Up' -and $_.HardwareInterface -eq $true -and $_.ConnectorPresent -eq $true
    } | Sort-Object -Property InterfaceMetric | Select-Object -First 1

    if (-not $adapter) {
        throw 'No active network adapter found. Connect Wi-Fi/Ethernet and retry.'
    }

    Write-Host "Creating external switch '$Name' on adapter: $($adapter.Name)"
    return New-VMSwitch -Name $Name -NetAdapterName $adapter.Name -AllowManagementOS $true
}

if (-not (Test-Path $isoPath)) {
    throw "ISO not found at $isoPath. Run .\scripts\01-download-vicibox.ps1 first."
}

New-Item -ItemType Directory -Force -Path $vmRoot | Out-Null
Ensure-ExternalSwitch -Name $switchName | Out-Null

$vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue
if ($vm) {
    Write-Host "VM '$vmName' already exists. Skipping creation."
} else {
    Write-Host "Creating VM '$vmName' with ${memoryGb}GB RAM and ${vhdSizeGb}GB disk on D:"
    New-VM -Name $vmName `
        -MemoryStartupBytes ($memoryGb * 1GB) `
        -Generation 2 `
        -NewVHDPath $vhdPath `
        -NewVHDSizeBytes ($vhdSizeGb * 1GB) `
        -SwitchName $switchName | Out-Null

    Set-VMProcessor -VMName $vmName -Count $processorCount
    Set-VMMemory -VMName $vmName -DynamicMemoryEnabled $false
    Set-VMFirmware -VMName $vmName -EnableSecureBoot Off
    Add-VMHardDiskDrive -VMName $vmName -Path $vhdPath
}

$dvd = Get-VMDvdDrive -VMName $vmName
if ($dvd) {
    Set-VMDvdDrive -VMName $vmName -ControllerNumber 0 -ControllerLocation 1 -Path $isoPath
} else {
    Add-VMDvdDrive -VMName $vmName -Path $isoPath
}

Set-VMFirmware -VMName $vmName -FirstBootDevice (Get-VMDvdDrive -VMName $vmName)
Start-VM -Name $vmName

Write-Host ""
Write-Host "VM '$vmName' is starting with ISO mounted."
Write-Host "Open Hyper-V Manager -> Connect -> install ViciBox, then run: vicibox-express"
Write-Host "Admin UI will be at: http://<vm-ip>/vicidial/admin.php"
