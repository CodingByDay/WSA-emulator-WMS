@ECHO OFF
SETLOCAL
sc config BITS start= delayed-auto
sc config EventLog start= auto
sc config UsoSvc start= auto
sc config wuauserv start= auto
net start BITS
net start EventLog
net start UsoSvc
net start wuauserv
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Set-PSReadLineOption -HistorySaveStyle SaveNothing -MaximumHistoryCount 1}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Write-Output 'Remove-Module PSReadline' | New-Item -Path $PROFILE -Type File -Force}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Install-PackageProvider -Name PowerShellGet -Scope AllUsers -Force}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Install-PackageProvider -Name NuGet -Scope AllUsers -Force}"
powershell -noprofile -ExecutionPolicy Bypass -Command "& {Install-PackageProvider -Name WinGet -Scope AllUsers -Force}"
DISM /Online /Enable-Feature /All /Norestart /FeatureName:Microsoft-Windows-Subsystem-Linux
DISM /Online /Enable-Feature /All /Norestart /FeatureName:VirtualMachinePlatform
DISM /Online /Enable-Feature /All /Norestart /FeatureName:HypervisorPlatform
REM NOTE: If the "Microsoft App Installer" doesn't install, then you have to go into the Microsoft Store ( App ) and hit the "Retry" button.
winget install 9NBLGGH4NNS1 --silent --accept-package-agreements --accept-source-agreements
winget install Microsoft.VCRedist.2015+.x86 --silent --accept-package-agreements --accept-source-agreements
winget install Microsoft.VCRedist.2015+.x64 --silent --accept-package-agreements --accept-source-agreements
winget install Microsoft.DotNet.Runtime.6 --silent --accept-package-agreements --accept-source-agreements
winget install Microsoft.DotNet.Runtime.Preview --silent --accept-package-agreements --accept-source-agreements
winget install 9P3395VX91NR --silent -a x64 --accept-package-agreements --accept-source-agreements
REM Reset / Repair Apps:
REM Settings -> System -> Other troubleshooters -> Windows Store Apps (Run)
REM Settings -> System -> Other troubleshooters -> Windows Update (Run)