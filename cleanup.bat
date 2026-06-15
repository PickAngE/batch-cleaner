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
net stop "SysMain" >nul 2>&1
net stop "DiagTrack" >nul 2>&1
net stop "dmwappushservice" >nul 2>&1
net stop "WSearch" >nul 2>&1
net stop "MapsBroker" >nul 2>&1

rd /s /q %SystemRoot%\Temp 2>nul & md %SystemRoot%\Temp 2>nul
del /f /s /q %SystemRoot%\Prefetch\*.* 2>nul
rd /s /q %SystemRoot%\SoftwareDistribution\Download 2>nul & md %SystemRoot%\SoftwareDistribution\Download 2>nul
rd /s /q %SystemRoot%\SoftwareDistribution\DeliveryOptimization 2>nul & md %SystemRoot%\SoftwareDistribution\DeliveryOptimization 2>nul
del /f /s /q %SystemRoot%\Logs\CBS\*.* 2>nul
del /f /s /q %SystemRoot%\Logs\DISM\*.* 2>nul
del /f /s /q %SystemRoot%\Logs\WindowsUpdate\*.* 2>nul
rd /s /q %SystemRoot%\Logs\WindowsUpdateMedic 2>nul & md %SystemRoot%\Logs\WindowsUpdateMedic 2>nul
del /f /s /q %SystemRoot%\Minidump\*.* 2>nul
rd /s /q %SystemRoot%\LiveKernelReports 2>nul & md %SystemRoot%\LiveKernelReports 2>nul
if exist %SystemRoot%\MEMORY.DMP del /f /q %SystemRoot%\MEMORY.DMP 2>nul
del /f /s /q %SystemRoot%\System32\LogFiles\WMI\*.etl 2>nul
rd /s /q "%SystemRoot%\Downloaded Program Files" 2>nul & md "%SystemRoot%\Downloaded Program Files" 2>nul
del /f /s /q %SystemRoot%\Panther\*.* 2>nul
del /f /s /q %SystemRoot%\Performance\WinSAT\*.* 2>nul
rd /s /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp 2>nul & md %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp 2>nul
rd /s /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache 2>nul & md %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache 2>nul
rd /s /q %SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp 2>nul & md %SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp 2>nul
rd /s /q %SystemRoot%\System32\config\systemprofile\AppData\Local\Temp 2>nul & md %SystemRoot%\System32\config\systemprofile\AppData\Local\Temp 2>nul
if exist %SystemRoot%\SysWOW64\config\systemprofile (
    rd /s /q %SystemRoot%\SysWOW64\config\systemprofile\AppData\Local\Temp 2>nul & md %SystemRoot%\SysWOW64\config\systemprofile\AppData\Local\Temp 2>nul
)
for %%E in ("*.log" "*.tmp" "*.temp" "*.dmp" "*.old" "*.chk" "*.gid" "*.fts" "*.$$$" "*.---" "*.??$" "*.__" "*.~mp" "*._mp" "*.$db" "*.db$" "thumbs.db" "*.??~") do (
    del /f /q "%SystemRoot%\%%~E" 2>nul
)
del /f /q %SystemRoot%\System32\FNTCACHE.DAT 2>nul
rd /s /q %SystemRoot%\Installer\$PatchCache$ 2>nul & md %SystemRoot%\Installer\$PatchCache$ 2>nul

for /d %%f in (%SystemRoot%\Microsoft.NET\Framework*) do (
    for /d %%v in ("%%f\v*") do (
        rd /s /q "%%v\Temporary ASP.NET Files" 2>nul & md "%%v\Temporary ASP.NET Files" 2>nul
    )
)

if exist %SystemDrive%\inetpub\logs (
    rd /s /q %SystemDrive%\inetpub\logs 2>nul & md %SystemDrive%\inetpub\logs 2>nul
)

rd /s /q "%ProgramFiles(x86)%\Steam\appcache" 2>nul & md "%ProgramFiles(x86)%\Steam\appcache" 2>nul
rd /s /q "%ProgramFiles(x86)%\Steam\logs" 2>nul & md "%ProgramFiles(x86)%\Steam\logs" 2>nul
rd /s /q "%ProgramFiles(x86)%\Steam\dumps" 2>nul & md "%ProgramFiles(x86)%\Steam\dumps" 2>nul
for /d %%r in ("%ProgramData%\Razer\*") do del /f /s /q "%%r\Logs\*.*" 2>nul
rd /s /q "%ProgramData%\Battle.net\Cache" 2>nul & md "%ProgramData%\Battle.net\Cache" 2>nul
rd /s /q "%ProgramData%\Blizzard Entertainment\Battle.net\Cache" 2>nul & md "%ProgramData%\Blizzard Entertainment\Battle.net\Cache" 2>nul
del /f /s /q "%ProgramData%\GOG.com\Galaxy\logs\*.*" 2>nul
del /f /s /q "%ProgramData%\GOG.com\Galaxy\webcache\*.*" 2>nul
rd /s /q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache" 2>nul & md "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache" 2>nul

rd /s /q %SystemDrive%\Users\Default\AppData\Local\Temp 2>nul & md %SystemDrive%\Users\Default\AppData\Local\Temp 2>nul

for /d %%u in (%SystemDrive%\Users\*) do (
    rd /s /q "%%u\AppData\Local\Temp" 2>nul & md "%%u\AppData\Local\Temp" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Explorer\*.db" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
    rd /s /q "%%u\AppData\Local\Microsoft\Windows\INetCache" 2>nul & md "%%u\AppData\Local\Microsoft\Windows\INetCache" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\INetCookies\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WebCache\*.log" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WebCache\*.tmp" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Notifications\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\History\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Terminal Server Client\Cache\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\CrashDumps\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\IconCache.db" 2>nul
    for /d %%p in ("%%u\AppData\Local\Packages\*") do (
        del /f /s /q "%%p\AC\Temp\*.*" 2>nul
        del /f /s /q "%%p\TempState\*.*" 2>nul
        del /f /s /q "%%p\LocalCache\*.*" 2>nul
    )
    rd /s /q "%%u\AppData\Local\Microsoft\Windows\Store\Cache" 2>nul & md "%%u\AppData\Local\Microsoft\Windows\Store\Cache" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Microsoft\Windows\Recent\*.*" 2>nul
    del /f /s /q "%%u\Recent\*.*" 2>nul
    for %%E in ("*.log" "*.tmp" "*.temp" "*.dmp" "*.old" "*.chk" "*.gid" "*.fts" "*.$$$" "*.---" "*.??$" "*.__" "*.~mp" "*._mp" "*.$db" "*.db$" "thumbs.db" "*.??~") do (
        del /f /q "%%u\%%~E" 2>nul
    )
    del /f /s /q "%%u\AppData\Local\Microsoft\CLR_v4.0\UsageLogs\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs\*.*" 2>nul
    rd /s /q "%%u\AppData\LocalLow\Temp" 2>nul & md "%%u\AppData\LocalLow\Temp" 2>nul
    rd /s /q "%%u\AppData\Local\Google\Chrome\User Data\Default\Cache" 2>nul & md "%%u\AppData\Local\Google\Chrome\User Data\Default\Cache" 2>nul
    rd /s /q "%%u\AppData\Local\Google\Chrome\User Data\Default\Code Cache" 2>nul & md "%%u\AppData\Local\Google\Chrome\User Data\Default\Code Cache" 2>nul
    rd /s /q "%%u\AppData\Local\Google\Chrome\User Data\Default\GPUCache" 2>nul & md "%%u\AppData\Local\Google\Chrome\User Data\Default\GPUCache" 2>nul
    rd /s /q "%%u\AppData\Local\Microsoft\Edge\User Data\Default\Cache" 2>nul & md "%%u\AppData\Local\Microsoft\Edge\User Data\Default\Cache" 2>nul
    for /d %%p in ("%%u\AppData\Local\Mozilla\Firefox\Profiles\*") do (
        rd /s /q "%%p\cache2" 2>nul & md "%%p\cache2" 2>nul
        rd /s /q "%%p\startupCache" 2>nul & md "%%p\startupCache" 2>nul
    )
    rd /s /q "%%u\AppData\Local\Microsoft\Windows\GameExplorer" 2>nul & md "%%u\AppData\Local\Microsoft\Windows\GameExplorer" 2>nul
    
    rd /s /q "%%u\AppData\Roaming\discord\Cache" 2>nul & md "%%u\AppData\Roaming\discord\Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\discord\Code Cache" 2>nul & md "%%u\AppData\Roaming\discord\Code Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\discord\GPUCache" 2>nul & md "%%u\AppData\Roaming\discord\GPUCache" 2>nul
    rd /s /q "%%u\AppData\Roaming\discord\logs" 2>nul & md "%%u\AppData\Roaming\discord\logs" 2>nul
    rd /s /q "%%u\AppData\Roaming\discord\Crashpad\reports" 2>nul & md "%%u\AppData\Roaming\discord\Crashpad\reports" 2>nul
    
    rd /s /q "%%u\AppData\Roaming\Slack\Cache" 2>nul & md "%%u\AppData\Roaming\Slack\Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\Slack\Code Cache" 2>nul & md "%%u\AppData\Roaming\Slack\Code Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\Slack\GPUCache" 2>nul & md "%%u\AppData\Roaming\Slack\GPUCache" 2>nul
    rd /s /q "%%u\AppData\Roaming\Slack\logs" 2>nul & md "%%u\AppData\Roaming\Slack\logs" 2>nul
    
    for /d %%r in ("%%u\AppData\Local\Razer\*") do (
        del /f /s /q "%%r\Logs\*.*" 2>nul
        del /f /s /q "%%r\Cache\*.*" 2>nul
    )
    
    for /d %%e in ("%%u\AppData\Local\EpicGamesLauncher\Saved\webcache*") do (
        rd /s /q "%%e" 2>nul & md "%%e" 2>nul
    )
    rd /s /q "%%u\AppData\Local\EpicGamesLauncher\Saved\Logs" 2>nul & md "%%u\AppData\Local\EpicGamesLauncher\Saved\Logs" 2>nul
    
    rd /s /q "%%u\AppData\Local\Google\Play Games\Logs" 2>nul & md "%%u\AppData\Local\Google\Play Games\Logs" 2>nul
    
    rd /s /q "%%u\AppData\Roaming\npm-cache" 2>nul & md "%%u\AppData\Roaming\npm-cache" 2>nul
    rd /s /q "%%u\.npm\_cacache" 2>nul & md "%%u\.npm\_cacache" 2>nul
    rd /s /q "%%u\.node-gyp" 2>nul & md "%%u\.node-gyp" 2>nul
    
    rd /s /q "%%u\AppData\Local\pip\cache" 2>nul & md "%%u\AppData\Local\pip\cache" 2>nul
    rd /s /q "%%u\.cache\pip" 2>nul & md "%%u\.cache\pip" 2>nul
    
    rd /s /q "%%u\.cargo\registry\cache" 2>nul & md "%%u\.cargo\registry\cache" 2>nul
    
    rd /s /q "%%u\AppData\Local\NuGet\Cache" 2>nul & md "%%u\AppData\Local\NuGet\Cache" 2>nul
    rd /s /q "%%u\AppData\Local\NuGet\v3-cache" 2>nul & md "%%u\AppData\Local\NuGet\v3-cache" 2>nul
    
    for /d %%v in ("%%u\AppData\Local\Microsoft\VisualStudio\*") do del /f /s /q "%%v\ComponentModelCache\*.*" 2>nul
    for /d %%v in ("%%u\AppData\Local\Microsoft\VSCommon\*") do (
        for /d %%w in ("%%v\*") do del /f /s /q "%%w\Cache\*.*" 2>nul
    )

    rd /s /q "%%u\AppData\Roaming\Code\Cache" 2>nul & md "%%u\AppData\Roaming\Code\Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\Code\CachedData" 2>nul & md "%%u\AppData\Roaming\Code\CachedData" 2>nul
    rd /s /q "%%u\AppData\Roaming\Code\CachedExtensionVSIXs" 2>nul & md "%%u\AppData\Roaming\Code\CachedExtensionVSIXs" 2>nul
    rd /s /q "%%u\AppData\Roaming\Code\Code Cache" 2>nul & md "%%u\AppData\Roaming\Code\Code Cache" 2>nul

    rd /s /q "%%u\AppData\Roaming\Code - Insiders\Cache" 2>nul & md "%%u\AppData\Roaming\Code - Insiders\Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\Code - Insiders\CachedData" 2>nul & md "%%u\AppData\Roaming\Code - Insiders\CachedData" 2>nul
    rd /s /q "%%u\AppData\Roaming\Code - Insiders\CachedExtensionVSIXs" 2>nul & md "%%u\AppData\Roaming\Code - Insiders\CachedExtensionVSIXs" 2>nul
    rd /s /q "%%u\AppData\Roaming\Code - Insiders\Code Cache" 2>nul & md "%%u\AppData\Roaming\Code - Insiders\Code Cache" 2>nul

    rd /s /q "%%u\AppData\Local\Yarn\Cache" 2>nul & md "%%u\AppData\Local\Yarn\Cache" 2>nul
    rd /s /q "%%u\.yarn\berry\cache" 2>nul & md "%%u\.yarn\berry\cache" 2>nul
    rd /s /q "%%u\AppData\Local\pnpm\cache" 2>nul & md "%%u\AppData\Local\pnpm\cache" 2>nul

    rd /s /q "%%u\AppData\Local\Zoom\logs" 2>nul & md "%%u\AppData\Local\Zoom\logs" 2>nul
    rd /s /q "%%u\AppData\Roaming\Zoom\logs" 2>nul & md "%%u\AppData\Roaming\Zoom\logs" 2>nul

    rd /s /q "%%u\AppData\Local\WhatsApp\Cache" 2>nul & md "%%u\AppData\Local\WhatsApp\Cache" 2>nul
    rd /s /q "%%u\AppData\Local\WhatsApp\Code Cache" 2>nul & md "%%u\AppData\Local\WhatsApp\Code Cache" 2>nul
    rd /s /q "%%u\AppData\Local\WhatsApp\GPUCache" 2>nul & md "%%u\AppData\Local\WhatsApp\GPUCache" 2>nul

    rd /s /q "%%u\AppData\Roaming\Telegram Desktop\tdata\emoji" 2>nul & md "%%u\AppData\Roaming\Telegram Desktop\tdata\emoji" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Telegram Desktop\tdata\user_data\cache.json" 2>nul

    rd /s /q "%%u\AppData\Local\Docker\log" 2>nul & md "%%u\AppData\Local\Docker\log" 2>nul

    rd /s /q "%%u\AppData\Local\Spotify\Storage" 2>nul & md "%%u\AppData\Local\Spotify\Storage" 2>nul
    rd /s /q "%%u\AppData\Local\Packages\SpotifyAB.SpotifyMusic_yyg5stzmfk8k0\LocalCache\Spotify\Data" 2>nul & md "%%u\AppData\Local\Packages\SpotifyAB.SpotifyMusic_yyg5stzmfk8k0\LocalCache\Spotify\Data" 2>nul

    rd /s /q "%%u\AppData\Roaming\Microsoft\Teams\Cache" 2>nul & md "%%u\AppData\Roaming\Microsoft\Teams\Cache" 2>nul
    rd /s /q "%%u\AppData\Roaming\Microsoft\Teams\Code Cache" 2>nul & md "%%u\AppData\Roaming\Microsoft\Teams\Code Cache" 2>nul

    rd /s /q "%%u\AppData\Local\Battle.net\Cache" 2>nul & md "%%u\AppData\Local\Battle.net\Cache" 2>nul
    del /f /s /q "%%u\AppData\Local\Electronic Arts\EA Desktop\Logs\*.*" 2>nul
    rd /s /q "%%u\AppData\Local\Ubisoft Game Launcher\spool" 2>nul & md "%%u\AppData\Local\Ubisoft Game Launcher\spool" 2>nul

    rd /s /q "%%u\AppData\LocalLow\Sun\Java\Deployment\cache" 2>nul & md "%%u\AppData\LocalLow\Sun\Java\Deployment\cache" 2>nul
    rd /s /q "%%u\AppData\Local\Microsoft\OneDrive\logs" 2>nul & md "%%u\AppData\Local\Microsoft\OneDrive\logs" 2>nul

    rd /s /q "%%u\AppData\Local\Riot Games\Riot Client\Logs" 2>nul & md "%%u\AppData\Local\Riot Games\Riot Client\Logs" 2>nul
    rd /s /q "%%u\AppData\Local\VALORANT\Saved\Logs" 2>nul & md "%%u\AppData\Local\VALORANT\Saved\Logs" 2>nul

    rd /s /q "%%u\AppData\Local\Overwolf\BrowserCache" 2>nul & md "%%u\AppData\Local\Overwolf\BrowserCache" 2>nul
    rd /s /q "%%u\AppData\Local\Overwolf\Log" 2>nul & md "%%u\AppData\Local\Overwolf\Log" 2>nul

    rd /s /q "%%u\AppData\Roaming\Adobe\Common\Media Cache Files" 2>nul & md "%%u\AppData\Roaming\Adobe\Common\Media Cache Files" 2>nul
    rd /s /q "%%u\AppData\Roaming\Adobe\Common\Media Cache" 2>nul & md "%%u\AppData\Roaming\Adobe\Common\Media Cache" 2>nul

    rd /s /q "%%u\AppData\Roaming\obs-studio\logs" 2>nul & md "%%u\AppData\Roaming\obs-studio\logs" 2>nul
    rd /s /q "%%u\AppData\Roaming\obs-studio\crashes" 2>nul & md "%%u\AppData\Roaming\obs-studio\crashes" 2>nul

    rd /s /q "%%u\AppData\Local\LGHUB\cache" 2>nul & md "%%u\AppData\Local\LGHUB\cache" 2>nul
    rd /s /q "%%u\AppData\Local\Corsair\CUE4\logs" 2>nul & md "%%u\AppData\Local\Corsair\CUE4\logs" 2>nul
    rd /s /q "%%u\AppData\Local\Corsair\CUE5\logs" 2>nul & md "%%u\AppData\Local\Corsair\CUE5\logs" 2>nul

    rd /s /q "%%u\AppData\Local\Microsoft\Windows\WER" 2>nul & md "%%u\AppData\Local\Microsoft\Windows\WER" 2>nul
)

rd /s /q %ProgramData%\Temp 2>nul & md %ProgramData%\Temp 2>nul
rd /s /q %ProgramData%\Microsoft\Windows\WER 2>nul & md %ProgramData%\Microsoft\Windows\WER 2>nul
rd /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History" 2>nul & md "%ProgramData%\Microsoft\Windows Defender\Scans\History" 2>nul
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\mpcache*" 2>nul
rd /s /q %ProgramData%\Microsoft\Diagnosis 2>nul & md %ProgramData%\Microsoft\Diagnosis 2>nul
del /f /s /q %ProgramData%\USOShared\Logs\*.* 2>nul
del /f /s /q "%ProgramData%\Package Cache\*.*" 2>nul

for %%E in ("*.log" "*.tmp" "*.temp" "*.dmp" "*.old" "*.chk" "*.gid" "*.fts" "*.$$$" "*.---" "*.??$" "*.__" "*.~mp" "*._mp" "*.$db" "*.db$" "thumbs.db" "*.??~") do (
    del /f /q "%SystemDrive%\%%~E" 2>nul
)

if exist %SystemDrive%\Windows.old rd /s /q %SystemDrive%\Windows.old 2>nul
if exist %SystemDrive%\$Windows.~BT rd /s /q %SystemDrive%\$Windows.~BT 2>nul
if exist %SystemDrive%\$Windows.~WS rd /s /q %SystemDrive%\$Windows.~WS 2>nul

powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

start "" /b cleanmgr /sagerun:1 >nul 2>&1
start "" /b dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1
start "" /b vssadmin delete shadows /all /quiet >nul 2>&1
start "" /b dism /online /Cleanup-Image /StartComponentCleanup /ResetBase /SPSSuperseded >nul 2>&1

powercfg -h off 2>nul

del /f /s /q %SystemRoot%\System32\LogFiles\WMI\RtBackup\*.etl 2>nul
rd /s /q %SystemRoot%\System32\SleepStudy 2>nul & md %SystemRoot%\System32\SleepStudy 2>nul
del /f /s /q %SystemRoot%\System32\sru\*.log 2>nul
del /f /s /q %SystemRoot%\System32\sru\*.tmp 2>nul
del /f /s /q %SystemRoot%\System32\winevt\Logs\*.log 2>nul
rd /s /q "%ProgramData%\Microsoft\Windows\WER\TempReportQueue" 2>nul & md "%ProgramData%\Microsoft\Windows\WER\TempReportQueue" 2>nul
rd /s /q "%ProgramData%\Microsoft\Windows\Caches" 2>nul & md "%ProgramData%\Microsoft\Windows\Caches" 2>nul
del /f /s /q "%ProgramData%\USOPrivate\UpdateStore\*.bin" 2>nul
del /f /s /q "%ProgramData%\USOPrivate\UpdateStore\*.log" 2>nul
if exist %SystemRoot%\WinSxS\ManifestCache rd /s /q %SystemRoot%\WinSxS\ManifestCache 2>nul
rd /s /q %SystemRoot%\ServiceState\EventLog\Data 2>nul & md %SystemRoot%\ServiceState\EventLog\Data 2>nul
rd /s /q %SystemRoot%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache 2>nul & md %SystemRoot%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache 2>nul

for /d %%u in (%SystemDrive%\Users\*) do (
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WebCache\*.dat" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WebCache\*.blob" 2>nul
)

powershell -Command "Get-AppxPackage -AllUsers | Where-Object {$_.PackageUserInformation -like '*Staged*'} | Remove-AppxPackage -ErrorAction SilentlyContinue" 2>nul
wsreset.exe >nul 2>&1

powershell -Command "wevtutil cl Application" 2>nul
powershell -Command "wevtutil cl System" 2>nul
powershell -Command "wevtutil cl Security" 2>nul

ipconfig /flushdns >nul 2>&1

net start "wuauserv" >nul 2>&1
net start "BITS" >nul 2>&1
net start "Cryptographic Services" >nul 2>&1
