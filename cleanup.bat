@echo off
setlocal enabledelayedexpansion
cls

whoami /groups | find "S-1-16-12288" >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b 0
)

net stop "BITS" >nul 2>&1
net stop "wuauserv" >nul 2>&1
net stop "Cryptographic Services" >nul 2>&1
net stop "Themes" >nul 2>&1

del /f /s /q %SystemRoot%\Temp\*.* 2>nul
for /d %%x in (%SystemRoot%\Temp\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\Prefetch\*.* 2>nul
del /f /s /q %SystemRoot%\SoftwareDistribution\Download\*.* 2>nul
for /d %%x in (%SystemRoot%\SoftwareDistribution\Download\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\SoftwareDistribution\DeliveryOptimization\*.* 2>nul
for /d %%x in (%SystemRoot%\SoftwareDistribution\DeliveryOptimization\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\Logs\CBS\*.* 2>nul
del /f /s /q %SystemRoot%\Logs\DISM\*.* 2>nul
del /f /s /q %SystemRoot%\Logs\WindowsUpdate\*.* 2>nul
del /f /s /q %SystemRoot%\Minidump\*.* 2>nul
del /f /s /q %SystemRoot%\Panther\*.* 2>nul
del /f /s /q %SystemRoot%\Performance\WinSAT\*.* 2>nul
del /f /s /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*.* 2>nul
for /d %%x in (%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp\*.* 2>nul
for /d %%x in (%SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul
del /f /q %SystemRoot%\*.log 2>nul
del /f /q %SystemRoot%\*.tmp 2>nul
del /f /q %SystemRoot%\System32\FNTCACHE.DAT 2>nul
del /f /s /q %SystemRoot%\Installer\$PatchCache$\*.* 2>nul
for /d %%x in (%SystemRoot%\Installer\$PatchCache$\*) do rd /s /q "%%x" 2>nul

for /d %%f in (%SystemRoot%\Microsoft.NET\Framework*) do (
    for /d %%v in ("%%f\v*") do (
        del /f /s /q "%%v\Temporary ASP.NET Files\*.*" 2>nul
        for /d %%x in ("%%v\Temporary ASP.NET Files\*") do rd /s /q "%%x" 2>nul
    )
)

if exist %SystemDrive%\inetpub\logs (
    del /f /s /q %SystemDrive%\inetpub\logs\*.* 2>nul
    for /d %%x in (%SystemDrive%\inetpub\logs\*) do rd /s /q "%%x" 2>nul
)

for /d %%u in (%SystemDrive%\Users\*) do (
    del /f /s /q "%%u\AppData\Local\Temp\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Temp\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Explorer\*.db" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
    del /f /s /q "%%u\AppData\Local\D3DSCache\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\INetCache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Microsoft\Windows\INetCache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\INetCookies\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WebCache\*.log" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WebCache\*.tmp" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Notifications\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\History\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Terminal Server Client\Cache\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\CrashDumps\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\IconCache.db" 2>nul
    del /f /s /q "%%u\AppData\Local\Packages\*\AC\Temp\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Packages\*\TempState\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Packages\*\LocalCache\*.*" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Microsoft\Windows\Recent\*.*" 2>nul
    del /f /s /q "%%u\Recent\*.*" 2>nul
    del /f /q "%%u\*.tmp" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\CLR_v4.0\UsageLogs\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs\*.*" 2>nul
    del /f /s /q "%%u\AppData\LocalLow\Temp\*.*" 2>nul
    for /d %%x in ("%%u\AppData\LocalLow\Temp\*") do rd /s /q "%%x" 2>nul
)

del /f /s /q %ProgramData%\Microsoft\Windows\WER\*.* 2>nul
for /d %%x in (%ProgramData%\Microsoft\Windows\WER\*) do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\*.*" 2>nul
for /d %%x in ("%ProgramData%\Microsoft\Windows Defender\Scans\History\*") do rd /s /q "%%x" 2>nul
del /f /s /q %ProgramData%\Microsoft\Diagnosis\*.* 2>nul
for /d %%x in (%ProgramData%\Microsoft\Diagnosis\*) do rd /s /q "%%x" 2>nul
del /f /s /q %ProgramData%\USOShared\Logs\*.* 2>nul
del /f /s /q "%ProgramData%\Package Cache\*.*" 2>nul

del /f /q %SystemDrive%\*.log 2>nul
del /f /q %SystemDrive%\*.tmp 2>nul
del /f /q %SystemDrive%\*.dmp 2>nul
del /f /q %SystemDrive%\*.old 2>nul
del /f /q %SystemDrive%\*.chk 2>nul

powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

powershell -Command "wevtutil cl Application" 2>nul
powershell -Command "wevtutil cl System" 2>nul
powershell -Command "wevtutil cl Security" 2>nul

ipconfig /flushdns >nul 2>&1

net start "wuauserv" >nul 2>&1
net start "BITS" >nul 2>&1
net start "Cryptographic Services" >nul 2>&1