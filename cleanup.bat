@echo off
setlocal enabledelayedexpansion
cls

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul 2>&1
    exit /b 0
)

call :stop_services
call :clean_system
call :clean_program_data
call :clean_program_files
call :clean_users
call :clean_windows_components
call :start_services

exit /b 0

:stop_services
call :stopservice "BITS"
call :stopservice "wuauserv"
call :stopservice "Cryptographic Services" "CryptSvc"
call :stopservice "Themes"
call :stopservice "SysMain"
call :stopservice "DiagTrack"
call :stopservice "dmwappushservice"
call :stopservice "WSearch"
call :stopservice "MapsBroker"
goto :eof

:start_services
call :startservice "Cryptographic Services" "CryptSvc"
call :startservice "BITS"
call :startservice "wuauserv"
call :startservice "Themes"
goto :eof

:clean_system
call :cleandir "%SystemRoot%\Temp"
del /f /s /q "%SystemRoot%\Prefetch\*.*" 2>nul
call :cleandir "%SystemRoot%\SoftwareDistribution\Download"
call :cleandir "%SystemRoot%\SoftwareDistribution\DeliveryOptimization"
del /f /s /q "%SystemRoot%\Logs\CBS\*.*" 2>nul
del /f /s /q "%SystemRoot%\Logs\DISM\*.*" 2>nul
del /f /s /q "%SystemRoot%\Logs\WindowsUpdate\*.*" 2>nul
call :cleandir "%SystemRoot%\Logs\WindowsUpdateMedic"
del /f /s /q "%SystemRoot%\Minidump\*.*" 2>nul
call :cleandir "%SystemRoot%\LiveKernelReports"
del /f /q "%SystemRoot%\MEMORY.DMP" 2>nul
del /f /s /q "%SystemRoot%\System32\LogFiles\WMI\*.etl" 2>nul
call :cleandir "%SystemRoot%\Downloaded Program Files"
del /f /s /q "%SystemRoot%\Panther\*.*" 2>nul
del /f /s /q "%SystemRoot%\Performance\WinSAT\*.*" 2>nul
call :cleandir "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp"
call :cleandir "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache"
call :cleandir "%SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp"
call :cleandir "%SystemRoot%\System32\config\systemprofile\AppData\Local\Temp"
if exist "%SystemRoot%\SysWOW64\config\systemprofile" call :cleandir "%SystemRoot%\SysWOW64\config\systemprofile\AppData\Local\Temp"
del /f /q "%SystemRoot%\System32\FNTCACHE.DAT" 2>nul
call :cleandir "%SystemRoot%\Installer\$PatchCache$"
for /d %%f in ("%SystemRoot%\Microsoft.NET\Framework*") do call :clean_aspnet_temp "%%f"
if exist "%SystemDrive%\inetpub\logs" call :cleandir "%SystemDrive%\inetpub\logs"
del /f /s /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\*.etl" 2>nul
call :cleandir "%SystemRoot%\System32\SleepStudy"
del /f /s /q "%SystemRoot%\System32\sru\*.log" 2>nul
del /f /s /q "%SystemRoot%\System32\sru\*.tmp" 2>nul
rd /s /q "%SystemRoot%\WinSxS\ManifestCache" 2>nul
call :cleandir "%SystemRoot%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache"
goto :eof

:clean_program_data
call :cleandir "%ProgramData%\Temp"
call :cleandir "%ProgramData%\Microsoft\Windows\WER"
call :cleandir "%ProgramData%\Microsoft\Windows\WER\TempReportQueue"
call :cleandir "%ProgramData%\Microsoft\Windows\Caches"
call :cleandir "%ProgramData%\Microsoft\Windows Defender\Scans\History"
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\mpcache*" 2>nul
call :cleandir "%ProgramData%\Microsoft\Diagnosis"
del /f /s /q "%ProgramData%\USOShared\Logs\*.*" 2>nul
del /f /s /q "%ProgramData%\Package Cache\*.*" 2>nul
del /f /s /q "%ProgramData%\USOPrivate\UpdateStore\*.bin" 2>nul
del /f /s /q "%ProgramData%\USOPrivate\UpdateStore\*.log" 2>nul
for /d %%r in ("%ProgramData%\Razer\*") do del /f /s /q "%%r\Logs\*.*" 2>nul
call :cleandir "%ProgramData%\Battle.net\Cache"
call :cleandir "%ProgramData%\Blizzard Entertainment\Battle.net\Cache"
del /f /s /q "%ProgramData%\GOG.com\Galaxy\logs\*.*" 2>nul
del /f /s /q "%ProgramData%\GOG.com\Galaxy\webcache\*.*" 2>nul
goto :eof

:clean_program_files
call :cleandir "%ProgramFiles(x86)%\Steam\appcache"
call :cleandir "%ProgramFiles(x86)%\Steam\logs"
call :cleandir "%ProgramFiles(x86)%\Steam\dumps"
call :cleandir "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache"
goto :eof

:clean_users
call :cleandir "%SystemDrive%\Users\Default\AppData\Local\Temp"
for /d %%u in ("%SystemDrive%\Users\*") do (
    if /i not "%%~nxu"=="Default" if /i not "%%~nxu"=="Default User" if /i not "%%~nxu"=="Public" if /i not "%%~nxu"=="All Users" call :clean_one_user "%%u"
)
goto :eof

:clean_one_user
set "U=%~1"
call :cleandir "%U%\AppData\Local\Temp"
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\Explorer\*.db" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
call :cleandir "%U%\AppData\Local\Microsoft\Windows\INetCache"
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\INetCookies\*.*" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\WebCache\*.log" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\WebCache\*.tmp" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\WebCache\*.dat" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\WebCache\*.blob" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\Notifications\*.*" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Windows\History\*.*" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\Terminal Server Client\Cache\*.*" 2>nul
del /f /s /q "%U%\AppData\Local\CrashDumps\*.*" 2>nul
del /f /q "%U%\AppData\Local\IconCache.db" 2>nul
for /d %%p in ("%U%\AppData\Local\Packages\*") do (
    del /f /s /q "%%p\AC\Temp\*.*" 2>nul
    del /f /s /q "%%p\TempState\*.*" 2>nul
    del /f /s /q "%%p\LocalCache\*.*" 2>nul
)
call :cleandir "%U%\AppData\Local\Microsoft\Windows\Store\Cache"
del /f /s /q "%U%\AppData\Roaming\Microsoft\Windows\Recent\*.*" 2>nul
del /f /s /q "%U%\Recent\*.*" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\CLR_v4.0\UsageLogs\*.*" 2>nul
del /f /s /q "%U%\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs\*.*" 2>nul
call :cleandir "%U%\AppData\LocalLow\Temp"
call :cleandir "%U%\AppData\Local\Google\Chrome\User Data\Default\Cache"
call :cleandir "%U%\AppData\Local\Google\Chrome\User Data\Default\Code Cache"
call :cleandir "%U%\AppData\Local\Google\Chrome\User Data\Default\GPUCache"
call :cleandir "%U%\AppData\Local\Microsoft\Edge\User Data\Default\Cache"
for /d %%p in ("%U%\AppData\Local\Mozilla\Firefox\Profiles\*") do (
    call :cleandir "%%p\cache2"
    call :cleandir "%%p\startupCache"
)
call :cleandir "%U%\AppData\Local\Microsoft\Windows\GameExplorer"
call :cleandir "%U%\AppData\Roaming\discord\Cache"
call :cleandir "%U%\AppData\Roaming\discord\Code Cache"
call :cleandir "%U%\AppData\Roaming\discord\GPUCache"
call :cleandir "%U%\AppData\Roaming\discord\logs"
call :cleandir "%U%\AppData\Roaming\discord\Crashpad\reports"
call :cleandir "%U%\AppData\Roaming\Slack\Cache"
call :cleandir "%U%\AppData\Roaming\Slack\Code Cache"
call :cleandir "%U%\AppData\Roaming\Slack\GPUCache"
call :cleandir "%U%\AppData\Roaming\Slack\logs"
for /d %%r in ("%U%\AppData\Local\Razer\*") do (
    del /f /s /q "%%r\Logs\*.*" 2>nul
    del /f /s /q "%%r\Cache\*.*" 2>nul
)
for /d %%e in ("%U%\AppData\Local\EpicGamesLauncher\Saved\webcache*") do call :cleandir "%%e"
call :cleandir "%U%\AppData\Local\EpicGamesLauncher\Saved\Logs"
call :cleandir "%U%\AppData\Local\Google\Play Games\Logs"
call :cleandir "%U%\AppData\Roaming\npm-cache"
call :cleandir "%U%\.npm\_cacache"
call :cleandir "%U%\.node-gyp"
call :cleandir "%U%\AppData\Local\pip\cache"
call :cleandir "%U%\.cache\pip"
call :cleandir "%U%\.cargo\registry\cache"
call :cleandir "%U%\AppData\Local\NuGet\Cache"
call :cleandir "%U%\AppData\Local\NuGet\v3-cache"
for /d %%v in ("%U%\AppData\Local\Microsoft\VisualStudio\*") do del /f /s /q "%%v\ComponentModelCache\*.*" 2>nul
for /d %%v in ("%U%\AppData\Local\Microsoft\VSCommon\*") do for /d %%w in ("%%v\*") do del /f /s /q "%%w\Cache\*.*" 2>nul
call :cleandir "%U%\AppData\Roaming\Code\Cache"
call :cleandir "%U%\AppData\Roaming\Code\CachedData"
call :cleandir "%U%\AppData\Roaming\Code\CachedExtensionVSIXs"
call :cleandir "%U%\AppData\Roaming\Code\Code Cache"
call :cleandir "%U%\AppData\Roaming\Code - Insiders\Cache"
call :cleandir "%U%\AppData\Roaming\Code - Insiders\CachedData"
call :cleandir "%U%\AppData\Roaming\Code - Insiders\CachedExtensionVSIXs"
call :cleandir "%U%\AppData\Roaming\Code - Insiders\Code Cache"
call :cleandir "%U%\AppData\Local\Yarn\Cache"
call :cleandir "%U%\.yarn\berry\cache"
call :cleandir "%U%\AppData\Local\pnpm\cache"
call :cleandir "%U%\AppData\Local\Zoom\logs"
call :cleandir "%U%\AppData\Roaming\Zoom\logs"
call :cleandir "%U%\AppData\Local\WhatsApp\Cache"
call :cleandir "%U%\AppData\Local\WhatsApp\Code Cache"
call :cleandir "%U%\AppData\Local\WhatsApp\GPUCache"
call :cleandir "%U%\AppData\Roaming\Telegram Desktop\tdata\emoji"
del /f /s /q "%U%\AppData\Roaming\Telegram Desktop\tdata\user_data\cache.json" 2>nul
call :cleandir "%U%\AppData\Local\Docker\log"
call :cleandir "%U%\AppData\Local\Spotify\Storage"
for /d %%s in ("%U%\AppData\Local\Packages\SpotifyAB.SpotifyMusic_*") do call :cleandir "%%s\LocalCache\Spotify\Data"
call :cleandir "%U%\AppData\Roaming\Microsoft\Teams\Cache"
call :cleandir "%U%\AppData\Roaming\Microsoft\Teams\Code Cache"
call :cleandir "%U%\AppData\Local\Battle.net\Cache"
del /f /s /q "%U%\AppData\Local\Electronic Arts\EA Desktop\Logs\*.*" 2>nul
call :cleandir "%U%\AppData\Local\Ubisoft Game Launcher\spool"
call :cleandir "%U%\AppData\LocalLow\Sun\Java\Deployment\cache"
call :cleandir "%U%\AppData\Local\Microsoft\OneDrive\logs"
call :cleandir "%U%\AppData\Local\Riot Games\Riot Client\Logs"
call :cleandir "%U%\AppData\Local\VALORANT\Saved\Logs"
call :cleandir "%U%\AppData\Local\Overwolf\BrowserCache"
call :cleandir "%U%\AppData\Local\Overwolf\Log"
call :cleandir "%U%\AppData\Roaming\Adobe\Common\Media Cache Files"
call :cleandir "%U%\AppData\Roaming\Adobe\Common\Media Cache"
call :cleandir "%U%\AppData\Roaming\obs-studio\logs"
call :cleandir "%U%\AppData\Roaming\obs-studio\crashes"
call :cleandir "%U%\AppData\Local\LGHUB\cache"
call :cleandir "%U%\AppData\Local\Corsair\CUE4\logs"
call :cleandir "%U%\AppData\Local\Corsair\CUE5\logs"
call :cleandir "%U%\AppData\Local\Microsoft\Windows\WER"
goto :eof

:clean_windows_components
call :forcedir "%SystemDrive%\$Windows.~BT"
call :forcedir "%SystemDrive%\$Windows.~WS"
powershell -Command "Get-AppxPackage -AllUsers | Where-Object {($_.PackageUserInformation | Where-Object {$_.InstallState -eq 'Staged'})} | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
goto :eof

:stopservice
set "SVCKEY=%~2"
if "%SVCKEY%"=="" set "SVCKEY=%~1"
sc query "%SVCKEY%" | find "RUNNING" >nul 2>&1
if %errorlevel%==0 net stop "%~1" >nul 2>&1
goto :eof

:startservice
net start "%~1" >nul 2>&1
goto :eof

:cleandir
set "TARGETDIR=%~1"
del /f /s /q "%TARGETDIR%\*" >nul 2>&1
for /d %%x in ("%TARGETDIR%\*") do rd /s /q "%%x" >nul 2>&1
goto :eof

:clean_aspnet_temp
for /d %%v in ("%~1\v*") do rd /s /q "%%v\Temporary ASP.NET Files" 2>nul
goto :eof

:forcedir
takeown /f "%~1" /r /d y >nul 2>&1
icacls "%~1" /grant *S-1-5-32-544:F /t /c /q >nul 2>&1
rd /s /q "%~1" 2>nul
goto :eof
