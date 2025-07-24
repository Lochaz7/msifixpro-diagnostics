# msifixpro-diagnostics
Diagnostic scripts and recovery tools for fixing MSI installer errors, restoring Windows services, and resolving registry and DLL issues. Built by msifixpro to streamline system troubleshooting and repair.
## 🛠️ Script: msi_fix.ps1
Repairs MSI installer issues on Windows by:
- Checking and starting the Windows Installer service (`msiserver`)
- Cleaning `%TEMP%` and `C:\Windows\Temp` folders
- Re-registering core MSI components
- Logging activity to `C:\msifixpro_msi_log.txt`

### 🚀 Usage
1. Save the script locally as `msi_fix.ps1`
2. Run in PowerShell (Admin) with:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   cd $env:USERPROFILE\Documents
   .\msi_fix.ps1
⚠️ Note: Use at your own discretion. Best run when MSI install issues or Windows Installer service problems arise.
