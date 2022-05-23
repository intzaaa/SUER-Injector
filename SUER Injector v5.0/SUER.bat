::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyG0+LT9GRRKHfCb6IoM1ydTI2s+1nn4ocdB/UYHR37eaL/Iv2XDBR9YE2HBfm98DHlt0fwaufRsIr2dOs3fLLc6M0w==
::fBE1pAF6MU+EWH3eyG0+LT9GRRKHfCb6IoM1ydTI2s+1nn4ocdB/UYHR37eaL/Iv2XDBR9YE2HBfm98DHlt0fwaufRsI/nQMsmiJVw==
::fBE1pAF6MU+EWH3eyG0+LT9GRRKHfCb6IoM1ydTI2s+1nn4ocdB/UYHR37eaL/Iv2XDBR9YE2HBfm98DHlt0fwaufRsI/nQMs3yAVw==
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBNBTQqFAE+1EbsQ5+n//NYOY5eYijW7oG9fAnkI4CGWNJjoepEi6fORYE3U6VVRfR3L
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF65
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF65
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBNQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFBNBTQqFAE+/Fb4I5/jH/P+CsAMYTOdf
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
SetLocal EnableDelayedExpansion
chcp 65001 >nul
mode con cols=50 lines=10
color F0
title SUER
::cd /d %~dp0
if exist C:\Windows\System32\drivers\etc\#hosts (
    del C:\Windows\System32\drivers\etc\hosts
    ren C:\Windows\System32\drivers\etc\#hosts hosts
)
:c1
tasklist | findstr "caddy.exe" >nul
if %errorlevel% == 0 (
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

cls
7z.exe x -y files.zip -ofiles >nul

title Do not force exit at any time.
:nodelagain
cls
echo Double quotes are required if there are spaces.
echo Enter the file path below.
echo Enter "exit" to exit.
set /a filepath=0
set /p filepath=PATH: 
if %filepath% == 0 (
    goto nodelagain
) else (
    if %filepath%==exit (
        rmdir /S /Q files
        exit
    )
)

cd files
echo fy | xcopy /J %filepath% file.linshi >nul
if ERRORLEVEL 1 goto nodelagain
echo f | xcopy /R/H/K/Y C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.%random%%random%%random%.save >nul
ren C:\Windows\System32\drivers\etc\hosts #hosts >nul
echo f | xcopy /R/H/K/Y hosts C:\Windows\System32\drivers\etc\hosts >nul
netsh Advfirewall show currentprofile | findstr "OFF" >nul
if %errorlevel% == 0 set /a adv=0
netsh Advfirewall set allprofiles state off >nul
caddy.exe start >nul
timeout /t 1 /NOBREAK >nul
cls
tasklist | findstr "caddy.exe" >nul
if ERRORLEVEL 1 (
    cls
    echo Error: Failed to start caddy.exe!
    echo Quitting...
    timeout /t 15 >nul
    call :exitit
) else (
    echo The Caddy Web Server is running in the background.
)
if exist C:\Windows\System32\drivers\etc\#hosts (
    echo The network settings were changed.
) else (
    echo Error: Failed to make hosts!
    echo Quitting...
    timeout /t 15 >nul
    call :exitit
)
ping -n 1 bj.download.cycore.cn | findstr "192.168.137.1" >nul
if %errorlevel% == 0 (
    echo [bj.download.cycore.cn] [running]
) else (
    echo [bj.download.cycore.cn] [not running]
    set /a num=1
)
ping -n 1 mdm-oss.cycore.cn | findstr "192.168.137.1" >nul
if %errorlevel% == 0 (
    echo [mdm-oss.cycore.cn] [running]
) else (
    echo [mdm-oss.cycore.cn] [not running]
    set /a numm=!num! + 1
)
if !numm! equ 2 (
    cls
    echo Error: Failed to configure network settings!
    echo Quitting...
    timeout /t 15 >nul
    call :exitit
)
pause

cls
echo 1. Choose another one.
echo 2. Exit.
choice /c 12 /n
if %errorlevel% == 1 goto again
if %errorlevel% == 2 (
    cls
    call :exitit
)

:again
del file.linshi
timeout /t 1 /NOBREAK >nul
:nodelagain2
cls
echo Enter "exit" to exit.
set /a filepath=0
set /p filepath=PATH: 
if %filepath% == 0 (
    goto nodelagain2
) else (
    if %filepath% == exit (
        cls
        call :exitit
    )
)

echo fy | xcopy /J %filepath% file.linshi
if ERRORLEVEL 1 goto nodelagain2

cls
ping -n 1 bj.download.cycore.cn | findstr "192.168.137.1" >nul
if %errorlevel% == 0 (
    echo [bj.download.cycore.cn] [running]
) else (
    echo [bj.download.cycore.cn] [not running]
    set /a num=1
)
set /a numm=0
ping -n 1 mdm-oss.cycore.cn | findstr "192.168.137.1" >nul
if %errorlevel% == 0 (
    echo [mdm-oss.cycore.cn] [running]
) else (
    echo [mdm-oss.cycore.cn] [not running]
    set /a numm=!num! + 1
)
if !numm! equ 2 (
    tasklist | findstr "caddy.exe" >nul
    if %errorlevel% == 0 (
        caddy.exe stop
        timeout /t 1 /NOBREAK >nul
        caddy.exe start
    ) else (
        echo Error: Failed to configure network settings!
        echo Quitting...
        timeout /t 15 >nul
        call :exitit
    )
)
pause

cls
echo 1. Choose another one.
echo 2. Exit.
choice /c 12 /n
if %errorlevel% == 1 goto again
if %errorlevel% == 2 (
    cls
    call :exitit
)

:exitit
del C:\Windows\System32\drivers\etc\hosts >nul
ren C:\Windows\System32\drivers\etc\#hosts hosts >nul
if %adv%==0 goto skipadvon
netsh Advfirewall set allprofiles state on >nul
:skipadvon
caddy.exe stop >nul
timeout /t 1 /NOBREAK >nul
cd ..
rmdir /S /Q files >nul
exit
goto :eof
