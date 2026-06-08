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
del /f /s /q %SystemRoot%\Logs\WindowsUpdateMedic\*.* 2>nul
for /d %%x in (%SystemRoot%\Logs\WindowsUpdateMedic\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\Minidump\*.* 2>nul
del /f /s /q %SystemRoot%\LiveKernelReports\*.* 2>nul
for /d %%x in (%SystemRoot%\LiveKernelReports\*) do rd /s /q "%%x" 2>nul
if exist %SystemRoot%\MEMORY.DMP del /f /q %SystemRoot%\MEMORY.DMP 2>nul
del /f /s /q %SystemRoot%\System32\LogFiles\WMI\*.etl 2>nul
del /f /s /q "%SystemRoot%\Downloaded Program Files\*.*" 2>nul
for /d %%x in ("%SystemRoot%\Downloaded Program Files\*") do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\Panther\*.* 2>nul
del /f /s /q %SystemRoot%\Performance\WinSAT\*.* 2>nul
del /f /s /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*.* 2>nul
for /d %%x in (%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.* 2>nul
for /d %%x in (%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp\*.* 2>nul
for /d %%x in (%SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul
del /f /s /q %SystemRoot%\System32\config\systemprofile\AppData\Local\Temp\*.* 2>nul
for /d %%x in (%SystemRoot%\System32\config\systemprofile\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul
if exist %SystemRoot%\SysWOW64\config\systemprofile (
    del /f /s /q %SystemRoot%\SysWOW64\config\systemprofile\AppData\Local\Temp\*.* 2>nul
    for /d %%x in (%SystemRoot%\SysWOW64\config\systemprofile\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul
)
for %%E in ("*.log" "*.tmp" "*.temp" "*.dmp" "*.old" "*.chk" "*.gid" "*.fts" "*.$$$" "*.---" "*.??$" "*.__" "*.~mp" "*._mp" "*.$db" "*.db$" "thumbs.db" "*.??~") do (
    del /f /q "%SystemRoot%\%%~E" 2>nul
)
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

del /f /s /q "%ProgramFiles(x86)%\Steam\appcache\*.*" 2>nul
for /d %%x in ("%ProgramFiles(x86)%\Steam\appcache\*") do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramFiles(x86)%\Steam\logs\*.*" 2>nul
for /d %%x in ("%ProgramFiles(x86)%\Steam\logs\*") do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramFiles(x86)%\Steam\dumps\*.*" 2>nul
for /d %%x in ("%ProgramFiles(x86)%\Steam\dumps\*") do rd /s /q "%%x" 2>nul
for /d %%r in ("%ProgramData%\Razer\*") do del /f /s /q "%%r\Logs\*.*" 2>nul
del /f /s /q "%ProgramData%\Battle.net\Cache\*.*" 2>nul
for /d %%x in ("%ProgramData%\Battle.net\Cache\*") do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramData%\Blizzard Entertainment\Battle.net\Cache\*.*" 2>nul
for /d %%x in ("%ProgramData%\Blizzard Entertainment\Battle.net\Cache\*") do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramData%\GOG.com\Galaxy\logs\*.*" 2>nul
del /f /s /q "%ProgramData%\GOG.com\Galaxy\webcache\*.*" 2>nul
del /f /s /q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache\*.*" 2>nul
for /d %%x in ("%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache\*") do rd /s /q "%%x" 2>nul

del /f /s /q %SystemDrive%\Users\Default\AppData\Local\Temp\*.* 2>nul
for /d %%x in (%SystemDrive%\Users\Default\AppData\Local\Temp\*) do rd /s /q "%%x" 2>nul

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
    for /d %%p in ("%%u\AppData\Local\Packages\*") do (
        del /f /s /q "%%p\AC\Temp\*.*" 2>nul
        del /f /s /q "%%p\TempState\*.*" 2>nul
        del /f /s /q "%%p\LocalCache\*.*" 2>nul
    )
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\Store\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Microsoft\Windows\Store\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Microsoft\Windows\Recent\*.*" 2>nul
    del /f /s /q "%%u\Recent\*.*" 2>nul
    for %%E in ("*.log" "*.tmp" "*.temp" "*.dmp" "*.old" "*.chk" "*.gid" "*.fts" "*.$$$" "*.---" "*.??$" "*.__" "*.~mp" "*._mp" "*.$db" "*.db$" "thumbs.db" "*.??~") do (
        del /f /q "%%u\%%~E" 2>nul
    )
    del /f /s /q "%%u\AppData\Local\Microsoft\CLR_v4.0\UsageLogs\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs\*.*" 2>nul
    del /f /s /q "%%u\AppData\LocalLow\Temp\*.*" 2>nul
    for /d %%x in ("%%u\AppData\LocalLow\Temp\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Google\Chrome\User Data\Default\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Google\Chrome\User Data\Default\GPUCache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Google\Chrome\User Data\Default\GPUCache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*") do rd /s /q "%%x" 2>nul
    for /d %%p in ("%%u\AppData\Local\Mozilla\Firefox\Profiles\*") do (
        del /f /s /q "%%p\cache2\*.*" 2>nul
        for /d %%x in ("%%p\cache2\*") do rd /s /q "%%x" 2>nul
        del /f /s /q "%%p\startupCache\*.*" 2>nul
        for /d %%x in ("%%p\startupCache\*") do rd /s /q "%%x" 2>nul
    )
    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\GameExplorer\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Microsoft\Windows\GameExplorer\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\AppData\Roaming\discord\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\discord\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\discord\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\discord\Code Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\discord\GPUCache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\discord\GPUCache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\discord\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\discord\logs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\discord\Crashpad\reports\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\discord\Crashpad\reports\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\AppData\Roaming\Slack\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Slack\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Slack\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Slack\Code Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Slack\GPUCache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Slack\GPUCache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Slack\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Slack\logs\*") do rd /s /q "%%x" 2>nul
    
    for /d %%r in ("%%u\AppData\Local\Razer\*") do (
        del /f /s /q "%%r\Logs\*.*" 2>nul
        del /f /s /q "%%r\Cache\*.*" 2>nul
    )
    
    for /d %%e in ("%%u\AppData\Local\EpicGamesLauncher\Saved\webcache*") do (
        del /f /s /q "%%e\*.*" 2>nul
        for /d %%x in ("%%e\*") do rd /s /q "%%x" 2>nul
    )
    del /f /s /q "%%u\AppData\Local\EpicGamesLauncher\Saved\Logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\EpicGamesLauncher\Saved\Logs\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\AppData\Local\Google\Play Games\Logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Google\Play Games\Logs\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\AppData\Roaming\npm-cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\npm-cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\.npm\_cacache\*.*" 2>nul
    for /d %%x in ("%%u\.npm\_cacache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\.node-gyp\*.*" 2>nul
    for /d %%x in ("%%u\.node-gyp\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\AppData\Local\pip\cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\pip\cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\.cache\pip\*.*" 2>nul
    for /d %%x in ("%%u\.cache\pip\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\.cargo\registry\cache\*.*" 2>nul
    for /d %%x in ("%%u\.cargo\registry\cache\*") do rd /s /q "%%x" 2>nul
    
    del /f /s /q "%%u\AppData\Local\NuGet\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\NuGet\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\NuGet\v3-cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\NuGet\v3-cache\*") do rd /s /q "%%x" 2>nul
    
    for /d %%v in ("%%u\AppData\Local\Microsoft\VisualStudio\*") do del /f /s /q "%%v\ComponentModelCache\*.*" 2>nul
    for /d %%v in ("%%u\AppData\Local\Microsoft\VSCommon\*") do (
        for /d %%w in ("%%v\*") do del /f /s /q "%%w\Cache\*.*" 2>nul
    )

    del /f /s /q "%%u\AppData\Roaming\Code\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Code\CachedData\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code\CachedData\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Code\CachedExtensionVSIXs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code\CachedExtensionVSIXs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Code\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code\Code Cache\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Roaming\Code - Insiders\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code - Insiders\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Code - Insiders\CachedData\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code - Insiders\CachedData\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Code - Insiders\CachedExtensionVSIXs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code - Insiders\CachedExtensionVSIXs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Code - Insiders\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Code - Insiders\Code Cache\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Yarn\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Yarn\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\.yarn\berry\cache\*.*" 2>nul
    for /d %%x in ("%%u\.yarn\berry\cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\pnpm\cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\pnpm\cache\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Zoom\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Zoom\logs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Zoom\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Zoom\logs\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\WhatsApp\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\WhatsApp\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\WhatsApp\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\WhatsApp\Code Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\WhatsApp\GPUCache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\WhatsApp\GPUCache\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Roaming\Telegram Desktop\tdata\emoji\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Telegram Desktop\tdata\emoji\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Telegram Desktop\tdata\user_data\cache.json" 2>nul

    del /f /s /q "%%u\AppData\Local\Docker\log\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Docker\log\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Spotify\Storage\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Spotify\Storage\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Packages\SpotifyAB.SpotifyMusic_yyg5stzmfk8k0\LocalCache\Spotify\Data\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Packages\SpotifyAB.SpotifyMusic_yyg5stzmfk8k0\LocalCache\Spotify\Data\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Roaming\Microsoft\Teams\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Microsoft\Teams\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Microsoft\Teams\Code Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Microsoft\Teams\Code Cache\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Battle.net\Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Battle.net\Cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Electronic Arts\EA Desktop\Logs\*.*" 2>nul
    del /f /s /q "%%u\AppData\Local\Ubisoft Game Launcher\spool\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Ubisoft Game Launcher\spool\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\LocalLow\Sun\Java\Deployment\cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\LocalLow\Sun\Java\Deployment\cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Microsoft\OneDrive\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Microsoft\OneDrive\logs\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Riot Games\Riot Client\Logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Riot Games\Riot Client\Logs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\VALORANT\Saved\Logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\VALORANT\Saved\Logs\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Overwolf\BrowserCache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Overwolf\BrowserCache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Overwolf\Log\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Overwolf\Log\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Roaming\Adobe\Common\Media Cache Files\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Adobe\Common\Media Cache Files\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\Adobe\Common\Media Cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\Adobe\Common\Media Cache\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Roaming\obs-studio\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\obs-studio\logs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Roaming\obs-studio\crashes\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Roaming\obs-studio\crashes\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\LGHUB\cache\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\LGHUB\cache\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Corsair\CUE4\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Corsair\CUE4\logs\*") do rd /s /q "%%x" 2>nul
    del /f /s /q "%%u\AppData\Local\Corsair\CUE5\logs\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Corsair\CUE5\logs\*") do rd /s /q "%%x" 2>nul

    del /f /s /q "%%u\AppData\Local\Microsoft\Windows\WER\*.*" 2>nul
    for /d %%x in ("%%u\AppData\Local\Microsoft\Windows\WER\*") do rd /s /q "%%x" 2>nul
)

del /f /s /q %ProgramData%\Temp\*.* 2>nul
for /d %%x in (%ProgramData%\Temp\*) do rd /s /q "%%x" 2>nul
del /f /s /q %ProgramData%\Microsoft\Windows\WER\*.* 2>nul
for /d %%x in (%ProgramData%\Microsoft\Windows\WER\*) do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\*.*" 2>nul
for /d %%x in ("%ProgramData%\Microsoft\Windows Defender\Scans\History\*") do rd /s /q "%%x" 2>nul
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\mpcache*" 2>nul
del /f /s /q %ProgramData%\Microsoft\Diagnosis\*.* 2>nul
for /d %%x in (%ProgramData%\Microsoft\Diagnosis\*) do rd /s /q "%%x" 2>nul
del /f /s /q %ProgramData%\USOShared\Logs\*.* 2>nul
del /f /s /q "%ProgramData%\Package Cache\*.*" 2>nul

for %%E in ("*.log" "*.tmp" "*.temp" "*.dmp" "*.old" "*.chk" "*.gid" "*.fts" "*.$$$" "*.---" "*.??$" "*.__" "*.~mp" "*._mp" "*.$db" "*.db$" "thumbs.db" "*.??~") do (
    del /f /q "%SystemDrive%\%%~E" 2>nul
)

if exist %SystemDrive%\Windows.old rd /s /q %SystemDrive%\Windows.old 2>nul
if exist %SystemDrive%\$Windows.~BT rd /s /q %SystemDrive%\$Windows.~BT 2>nul
if exist %SystemDrive%\$Windows.~WS rd /s /q %SystemDrive%\$Windows.~WS 2>nul

powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

cleanmgr /sagerun:1 >nul 2>&1

dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1

vssadmin delete shadows /all /quiet >nul 2>&1

powershell -Command "wevtutil cl Application" 2>nul
powershell -Command "wevtutil cl System" 2>nul
powershell -Command "wevtutil cl Security" 2>nul

ipconfig /flushdns >nul 2>&1

net start "wuauserv" >nul 2>&1
net start "BITS" >nul 2>&1
net start "Cryptographic Services" >nul 2>&1
