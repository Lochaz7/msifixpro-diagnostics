# msifixpro-diagnostics: MSI Repair Script
# Author: Charles (msifixpro)

Write-Host "🛠️ Starting MSI diagnostics..." -ForegroundColor Cyan

# Check if Windows Installer service is running
$msiStatus = Get-Service -Name 'msiserver' -ErrorAction SilentlyContinue

if ($msiStatus -eq $null) {
    Write-Host "❌ MSI service not found." -ForegroundColor Red
} elseif ($msiStatus.Status -ne 'Running') {
    Write-Host "⚠️ MSI service is not running. Attempting to start..." -ForegroundColor Yellow
    Start-Service -Name 'msiserver'
    Start-Sleep -Seconds 2
    Write-Host "✅ MSI service started." -ForegroundColor Green
} else {
    Write-Host "✅ MSI service is already running." -ForegroundColor Green
}

# Clear Temp folders (basic cleanup)
$folders = @($env:TEMP, "$env:WINDIR\Temp")
foreach ($folder in $folders) {
    Write-Host "🧹 Cleaning $folder..."
    Get-ChildItem -Path $folder -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
}

# Re-register Windows Installer DLLs
Write-Host "🔄 Re-registering MSI components..."
Start-Process "msiexec.exe" -ArgumentList "/unregister" -Wait
Start-Process "msiexec.exe" -ArgumentList "/regserver" -Wait
Write-Host "✅ MSI re-registration complete." -ForegroundColor Green

# Log timestamp
(Get-Date) | Out-File -FilePath "$env:SystemDrive\msifixpro_msi_log.txt" -Append
Write-Host "🗂️ Log saved to msifixpro_msi_log.txt" -ForegroundColor Cyan
