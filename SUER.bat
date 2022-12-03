echo off
chcp 65001
SetLocal EnableDelayedExpansion
title SUER
cd /d %~dp0
echo f | xcopy /R/H/K/Y C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.%random%%random%%random%.save
if ERRORLEVEL 1 (
    cls
    echo Warning: Permission denied.
    set /a pd=1
    pause
) else (
    set /a pd=0
)
:c1
tasklist | findstr "caddy.exe"
if %errorlevel% EQU 0 (
    if %pd% EQU 1 (
        cls
        echo Error: Another caddy.exe is already running!
        echo Quitting...
        timeout /t 15 >nul
        goto quit
    ) else (
        cls
        echo Error: Another caddy.exe is already running!
        echo Do you want to fix it by killing the process?
        echo 1. Yes.
        echo 2. No.
        choice /c 12 /n
        if !errorlevel! EQU 1 (
            cls
            taskkill /im caddy.exe /f
            goto c1
        )
        if !errorlevel! EQU 2 goto quit
    )
)

cls
echo ........................................
echo ..............:,::......................
echo ..........:,::,.........................
echo .......:::::............................
echo .....::::......::::.....................
echo ...::::.......::::::.:,:,:,:::::,.......
echo ..::::........::::::::::::::::::::::....
echo .::::........:::::,..::::::::::::::::,..
echo .:::......::.:::::........:::::::::::::.
echo .::,....,....:::::.........::::::::::::.
echo .,::........::::,..........,::::::::::,.
echo ............::::...........:::::::::::..
echo ............::::..........::::::::::,...
echo ...........,:::..........:::::::::::....
echo ..:........::::........:::::::::::......
echo ..,:.......:::......::::::::::::........
echo ...,:,....::::.::::::::::::::,..........
echo ....:::::::::::::::::::::::.............
echo ......:,::::::::::::,:..................
echo .........,::............................
echo .........::,............................
echo .........:..............................
echo ........................................
pause

color 40
cls
echo Do not kill this app.
timeout /t 5 >nul

title "Do not kill this app."
color F0
:nodelagain
cls
echo Double quotes are required if there are spaces.
echo Enter the file path below, and the file will be copied to here.
echo Type "exit" to exit, nothing will be changed.
set /a filepath=0
set /p filepath=PATH: 
if %filepath% EQU 0 (
    goto nodelagain
) else (
    if %filepath% EQU exit goto quit
)

cd files
echo fy | xcopy /J %filepath% file.linshi
if ERRORLEVEL 1 goto nodelagain
ren C:\Windows\System32\drivers\etc\hosts #hosts
echo f | xcopy /R/H/K/Y hosts C:\Windows\System32\drivers\etc\hosts
set adv=1
netsh Advfirewall show currentprofile | findstr "OFF"
IF %errorlevel% EQU 0 set adv=0
netsh Advfirewall set allprofiles state off
ipconfig /flushdns
caddy.exe start
timeout /t 1 /NOBREAK
tasklist | findstr "caddy.exe"
if ERRORLEVEL 1 (
    cls
    echo Error: Failed to start caddy.exe!
    echo Quitting...
    timeout /t 15 >nul
    goto quit
)
cls
echo The hosts file was changed.
echo The Caddy Web Server is running in the background.
echo Now, every request to bj.download.cycore.cn will receive the content of the file.
pause

cls
echo 1. Choose another one.
echo 2. Exit.
choice /c 12 /n
if %errorlevel% EQU 1 (
    goto again
) else (
    cls
    del C:\Windows\System32\drivers\etc\hosts
    ren C:\Windows\System32\drivers\etc\#hosts hosts
    if %adv% EQU 0 goto skipadvon
    netsh Advfirewall set allprofiles state on
    del file.linshi
    caddy.exe stop
    goto quit
)

:again
del file.linshi 
timeout /t 1 /NOBREAK >nul
:nodelagain2
cls
echo Type "exit" to exit, nothing will be changed.
set /a filepath=0
set /p filepath=PATH: 
if %filepath% EQU 0 goto nodelagain2
if %filepath% EQU exit (
    cls
    del C:\Windows\System32\drivers\etc\hosts
    ren C:\Windows\System32\drivers\etc\#hosts hosts
    if %adv% EQU 0 goto skipadvon
    netsh Advfirewall set allprofiles state on
    goto quit
)

echo fy | xcopy /J %filepath% file.linshi
if ERRORLEVEL 1 goto nodelagain2

cls
echo The hosts file was changed.
echo The Caddy Web Server is running in the background.
echo Now, every request to bj.download.cycore.cn will receive the content of the file that you specified.
pause

cls
echo 1. Choose another one.
echo 2. Exit.
choice /c 12 /n
if %errorlevel% EQU 1 (
    goto again
) else (
    cls
    del C:\Windows\System32\drivers\etc\hosts
    ren C:\Windows\System32\drivers\etc\#hosts hosts
    if %adv% EQU 0 goto skipadvon
    netsh Advfirewall set allprofiles state on
    goto quit
)

:skipadvon
del file.linshi
caddy.exe stop
goto quit

:quit