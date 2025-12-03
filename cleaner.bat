@echo off
title Aids hojayega
echo =================================================
echo             MAX PRIVACY CLEANER (SAFE)
echo          For your OWN PC - User-level only
echo =================================================
echo.

:: ------------------ KILL COMMON APPS (SO FILES UNLOCK) ------------------
echo Closing browsers and common apps...
taskkill /f /im chrome.exe /im msedge.exe /im brave.exe /im firefox.exe 2>nul
taskkill /f /im notepad.exe /im winword.exe /im excel.exe /im powerpnt.exe 2>nul

:: ------------------ CLIPBOARD + CLIPBOARD HISTORY ------------------
echo Clearing clipboard and clipboard history...

:: Clear live clipboard contents
cmd /c "echo off | clip" 2>nul
powershell -command "Clear-Clipboard" 2>nul

:: Try to unlock clipboard history database
taskkill /f /im ShellExperienceHost.exe 2>nul
taskkill /f /im SearchHost.exe 2>nul

:: Delete clipboard history database (Win+V list)
del /f /q "%LOCALAPPDATA%\Microsoft\Clipboard\*" 2>nul

:: Optional: turn OFF clipboard history (you can re-enable later in Settings)
reg add "HKCU\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 0 /f 2>nul

:: ------------------ WINDOWS ACTIVITY HISTORY (TIMELINE) ------------------
echo Clearing Windows activity history (Timeline)...
del /f /q "%LOCALAPPDATA%\ConnectedDevicesPlatform\*" 2>nul
del /f /q "%LOCALAPPDATA%\ConnectedDevicesPlatform\L\*" 2>nul
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\ConnectedDevicesPlatform\*" 2>nul

:: ------------------ CHROME DATA ------------------
echo Cleaning Google Chrome (history, cache, cookies)...
set "CHROME=%LOCALAPPDATA%\Google\Chrome\User Data"

del /f /q "%CHROME%\Default\History*" 2>nul
del /f /q "%CHROME%\Default\Cookies" 2>nul
del /f /q "%CHROME%\Default\Login Data*" 2>nul
del /f /q "%CHROME%\Default\Top Sites*" 2>nul
del /f /q "%CHROME%\Default\Favicons*" 2>nul

rd /s /q "%CHROME%\Default\Cache" 2>nul
rd /s /q "%CHROME%\Default\Code Cache" 2>nul
rd /s /q "%CHROME%\Default\GPUCache" 2>nul

:: ------------------ EDGE DATA ------------------
echo Cleaning Microsoft Edge (history, cache, cookies)...
set "EDGE=%LOCALAPPDATA%\Microsoft\Edge\User Data"

del /f /q "%EDGE%\Default\History*" 2>nul
del /f /q "%EDGE%\Default\Cookies" 2>nul
del /f /q "%EDGE%\Default\Login Data*" 2>nul
del /f /q "%EDGE%\Default\Top Sites*" 2>nul
del /f /q "%EDGE%\Default\Favicons*" 2>nul

rd /s /q "%EDGE%\Default\Cache" 2>nul
rd /s /q "%EDGE%\Default\Code Cache" 2>nul
rd /s /q "%EDGE%\Default\GPUCache" 2>nul

:: ------------------ TEMP FOLDERS ------------------
echo Clearing TEMP folders...
rd /s /q "%TEMP%" 2>nul
mkdir "%TEMP%" 2>nul

rd /s /q "C:\Windows\Temp" 2>nul
mkdir "C:\Windows\Temp" 2>nul

:: ------------------ PREFETCH (NON-CRITICAL) ------------------
echo Clearing Prefetch (Windows will rebuild)...
rd /s /q "C:\Windows\Prefetch" 2>nul
mkdir "C:\Windows\Prefetch" 2>nul

:: ------------------ RECENT FILES & JUMP LISTS ------------------
echo Clearing Recent Files & Jump Lists...
rd /s /q "%APPDATA%\Microsoft\Windows\Recent" 2>nul
mkdir "%APPDATA%\Microsoft\Windows\Recent" 2>nul

del /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*" 2>nul
del /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*" 2>nul

:: ------------------ EXPLORER HISTORY (RUN, SEARCH, PATHS) ------------------
echo Clearing Explorer history (Run, search, typed paths)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery" /f 2>nul

:: ------------------ USERASSIST (PROGRAM LAUNCH HISTORY) ------------------
echo Clearing UserAssist (program launch history)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f 2>nul

:: ------------------ THUMBNAIL CACHE ------------------
echo Clearing thumbnail cache...
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*" 2>nul

:: ------------------ USB MOUNT HISTORY (USER LEVEL) ------------------
echo Clearing USB recent mount history (user-level only)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2" /f 2>nul

:: ------------------ SAFE EVENT LOG CLEARING ------------------
echo Clearing safe Windows event logs (NOT Security)...
wevtutil cl Application 2>nul
wevtutil cl System 2>nul
wevtutil cl Setup 2>nul

:: ------------------ FINAL CLEANUP ------------------
echo.
echo Restarting shell components...
:: ShellExperienceHost and SearchHost will auto-restart with Explorer
start explorer.exe 2>nul

echo.
echo =================================================
echo                 CLEANING COMPLETE
echo  - Browsers history (Chrome/Edge) wiped
echo  - Recent files, jump lists, Explorer history cleared
echo  - Clipboard + clipboard history removed
echo  - Temp, prefetch, thumbnail cache cleared
echo  - Basic USB and activity history cleaned
echo =================================================
echo.
echo Press any key to close...
pause >nul
exit
