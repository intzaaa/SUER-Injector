echo off
chcp 65001
title= SUERv3.3
tasklist | findstr "caddy.exe"
if %errorlevel%==0 goto alcaddy
cd /d %~dp0
echo f | xcopy /R/H/K/Y C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.%random%.%random%.save
if ERRORLEVEL 1  goto warning
:startit

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

:nodelagain
cls
echo Double quotes are required if there are spaces.
echo Enter the file path below, and the file will be copied to here.
set /a filepath=0
set /p filepath=PATH: 
if %filepath%==empty goto nodelagain

cd files
echo fy | xcopy %filepath% file.linshi
if ERRORLEVEL 1 goto nodelagain
ren C:\Windows\System32\drivers\etc\hosts #hosts
echo f | xcopy /R/H/K/Y hosts C:\Windows\System32\drivers\etc\hosts
netsh Advfirewall show currentprofile | findstr "OFF"
IF %errorlevel%==0 set /a adv=0
netsh Advfirewall set allprofiles state off
ipconfig /flushdns
caddy.exe start
timeout /t 1 /NOBREAK
cls
echo The hosts file was changed.
echo The Caddy Web Server is running in the background.
echo Now, every request to bj.download.cycore.cn will receive the content of the file.
pause

cls
echo 1. Do it again.
echo 2. Exit.
choice /c 12 /n
if %errorlevel%==1 goto again
if %errorlevel%==2 goto exitit

:exitit
cls
del C:\Windows\System32\drivers\etc\hosts
ren C:\Windows\System32\drivers\etc\#hosts hosts
if %adv%==0 goto skipadvon
netsh Advfirewall set allprofiles state on
:skipadvon
del file.linshi
caddy.exe stop
goto finish

:warning
cls
echo Warning: Permission denied.
pause
goto startit

:alcaddy
cls
echo Error: Another caddy.exe is already running! 
echo Quitting...
timeout /t 15 >nul
exit

:again
del file.linshi 
timeout /t 3 /NOBREAK >nul
:nodelagain2
cls
echo Double quotes are required if there is are spaces.
echo Enter the file path below, and the file will be copied to here.
set /a filepath=0
set /p filepath=PATH: 
if %filepath%==0 goto nodelagain2

echo fy | xcopy %filepath% file.linshi
if ERRORLEVEL 1 goto nodelagain2

cls
echo The hosts file was changed.
echo The Caddy Web Server is running in the background.
echo Now, every request to bj.download.cycore.cn will receive the content of the file that you specified.
pause

cls
echo 1. Do it again.
echo 2. Exit.
choice /c 12 /n
if %errorlevel%==1 goto again
if %errorlevel%==2 goto exitit

:finish