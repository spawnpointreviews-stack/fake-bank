@echo off
title System Diagnostics Tool
echo Please wait, analyzing system health...

:: Create the info file and add a header
echo === SCAMMER RECON REPORT === > rand_info.txt
echo Date/Time: %date% %time% >> rand_info.txt
echo User: %username% >> rand_info.txt

:: Collect System Info
echo. >> rand_info.txt
echo [SYSTEM INFO] >> rand_info.txt
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" >> rand_info.txt

:: Collect Network Info (This grabs their real IP if they aren't on a VPN)
echo. >> rand_info.txt
echo [NETWORK CONFIG] >> rand_info.txt
ipconfig /all >> rand_info.txt

:: Collect Active Connections (Finds their IP)
echo. >> rand_info.txt
echo [ACTIVE CONNECTIONS] >> rand_info.txt
netstat -n >> rand_info.txt

echo Analysis Complete. Log saved to rand_info.txt.
pause
