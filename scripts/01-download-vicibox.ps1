# Downloads official ViciBox 12.0.2 ISO to D:\Vicidail\iso (resumable)
$ErrorActionPreference = 'Stop'

$baseDir = Split-Path $PSScriptRoot -Parent
$isoDir  = Join-Path $baseDir 'iso'
$isoUrl  = 'https://download.vicidial.com/vicibox/server/ViciBox_V12.x86_64-12.0.2.iso'
$md5Url  = 'https://download.vicidial.com/vicibox/server/ViciBox_V12.x86_64-12.0.2.md5'
$isoPath = Join-Path $isoDir 'ViciBox_V12.x86_64-12.0.2.iso'
$md5Path = Join-Path $isoDir 'ViciBox_V12.x86_64-12.0.2.md5'
$minBytes = 1.8GB

New-Item -ItemType Directory -Force -Path $isoDir | Out-Null

if (Test-Path $isoPath) {
    $sizeBytes = (Get-Item $isoPath).Length
    $sizeGb = [math]::Round($sizeBytes / 1GB, 2)
    if ($sizeBytes -ge $minBytes) {
        Write-Host "ISO already present ($sizeGb GB): $isoPath"
        exit 0
    }
    Write-Host "Resuming incomplete download ($sizeGb GB so far)..."
}

Write-Host "Downloading ViciBox 12.0.2 (~2 GB) to $isoPath"
Write-Host "Uses curl with resume. Safe to re-run if interrupted."

$maxAttempts = 5
for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
    try {
        & curl.exe -L --retry 5 --retry-delay 5 -C - -o $isoPath $isoUrl
        if ($LASTEXITCODE -ne 0) { throw "curl exited with code $LASTEXITCODE" }

        $sizeBytes = (Get-Item $isoPath).Length
        if ($sizeBytes -lt $minBytes) {
            throw "Downloaded file is too small ($([math]::Round($sizeBytes/1GB,2)) GB)"
        }

        Invoke-WebRequest -Uri $md5Url -OutFile $md5Path -UseBasicParsing
        Write-Host "Saved MD5 checksum file: $md5Path"
        Write-Host "Download complete: $isoPath"
        exit 0
    }
    catch {
        Write-Warning "Attempt $attempt failed: $_"
        if ($attempt -eq $maxAttempts) { throw }
        Start-Sleep -Seconds (10 * $attempt)
    }
}
