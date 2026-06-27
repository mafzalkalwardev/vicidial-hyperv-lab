param(
    [ValidateSet('start', 'stop', 'status', 'ip', 'connect')]
    [string]$Action = 'status'
)

#Requires -RunAsAdministrator
$vmName = 'VICIdial-Lab'

switch ($Action) {
    'start' {
        Start-VM -Name $vmName
        Write-Host "Started $vmName"
    }
    'stop' {
        Stop-VM -Name $vmName -Force
        Write-Host "Stopped $vmName"
    }
    'status' {
        Get-VM -Name $vmName | Format-List Name, State, Uptime, MemoryStartup, ProcessorCount
    }
    'ip' {
        $ip = (Get-VMNetworkAdapter -VMName $vmName).IPAddresses | Where-Object { $_ -match '^\d+\.\d+\.\d+\.\d+$' -and $_ -notmatch '^169\.254\.' }
        if ($ip) {
            Write-Host "VM IP(s): $($ip -join ', ')"
            Write-Host "Admin:  http://$($ip[0])/vicidial/admin.php"
            Write-Host "Agent:  http://$($ip[0])/agc/vicidial.php"
        } else {
            Write-Host "No IP yet. Start the VM and wait for DHCP, or check IP inside the VM with: ip addr"
        }
    }
    'connect' {
        vmconnect.exe localhost $vmName
    }
}
