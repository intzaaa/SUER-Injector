echo off
SetLocal EnableDelayedExpansion
chcp 65001
title SUERv4.0
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
if %errorlevel% == 0 (
    if %pd% == 1 (
        cls
        echo Error: Another caddy.exe is already running!
        echo Quitting...
        timeout /t 15 >nul
        exit
    ) else (
        cls
        echo Error: Another caddy.exe is already running!
        echo Do you want to fix it by killing the process?
        echo 1. Yes.
        echo 2. No.
        choice /c 12 /n
        if !errorlevel! == 1 (
            cls
            taskkill /im caddy.exe /f
            goto c1
        )
        if !errorlevel! == 2 exit
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
echo Do not force quit at any time.
timeout /t 5 >nul

title "Do not force quit at any time."
color F0
:nodelagain
cls
echo Double quotes are required if there are spaces.
echo Enter the file path below, and the file will be copied to here.
echo Type "exit" to exit, nothing will be changed.
set /a filepath=0
set /p filepath=PATH: 
if %filepath% == 0 (
    goto nodelagain
) else (
    if %filepath%==exit exit
)

cd files
echo fy | xcopy /J %filepath% file.linshi
if ERRORLEVEL 1 goto nodelagain
ren C:\Windows\System32\drivers\etc\hosts #hosts
echo f | xcopy /R/H/K/Y hosts C:\Windows\System32\drivers\etc\hosts
netsh Advfirewall show currentprofile | findstr "OFF"
IF %errorlevel% == 0 set /a adv=0
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
    exit
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
if %errorlevel% == 1 goto again
if %errorlevel% == 2 (
    cls
    del C:\Windows\System32\drivers\etc\hosts
    ren C:\Windows\System32\drivers\etc\#hosts hosts
    if %adv%==0 goto skipadvon
    netsh Advfirewall set allprofiles state on
    :skipadvon
    del file.linshi
    caddy.exe stop
    exit
)

:again
del file.linshi 
timeout /t 1 /NOBREAK >nul
:nodelagain2
cls
echo Type "exit" to exit, nothing will be changed.
set /a filepath=0
set /p filepath=PATH: 
if %filepath% == 0 (
    goto nodelagain2
) else (
    if %filepath% == exit (
        cls
        del C:\Windows\System32\drivers\etc\hosts
        ren C:\Windows\System32\drivers\etc\#hosts hosts
        if %adv%==0 goto skipadvon
        netsh Advfirewall set allprofiles state on
        :skipadvon
        caddy.exe stop
        exit
    )
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
if %errorlevel% == 1 goto again
if %errorlevel% == 2 (
    cls
    del C:\Windows\System32\drivers\etc\hosts
    ren C:\Windows\System32\drivers\etc\#hosts hosts
    if %adv%==0 goto skipadvon
    netsh Advfirewall set allprofiles state on
    :skipadvon
    del file.linshi
    caddy.exe stop
    exit
)