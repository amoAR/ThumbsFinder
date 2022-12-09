@echo off
setlocal enableDelayedExpansion
setlocal enableExtensions

::menu
:menu
title thumbs finder - amoAR ^| Step 1
set command=
cls
color 07
echo:
:::    /$$    /$$                            /$$                      /$$$$$$$$/$$               /$$
:::   | $$   | $$                           | $$                     | $$_____|__/              | $$
:::  /$$$$$$ | $$$$$$$ /$$   /$$/$$$$$$/$$$$| $$$$$$$  /$$$$$$$      | $$      /$$/$$$$$$$  /$$$$$$$ /$$$$$$  /$$$$$$
::: |_  $$_/ | $$__  $| $$  | $| $$_  $$_  $| $$__  $$/$$_____/      | $$$$$  | $| $$__  $$/$$__  $$/$$__  $$/$$__  $$
:::   | $$   | $$  \ $| $$  | $| $$ \ $$ \ $| $$  \ $|  $$$$$$       | $$__/  | $| $$  \ $| $$  | $| $$$$$$$| $$  \__/
:::   | $$ /$| $$  | $| $$  | $| $$ | $$ | $| $$  | $$\____  $$      | $$     | $| $$  | $| $$  | $| $$_____| $$
:::   |  $$$$| $$  | $|  $$$$$$| $$ | $$ | $| $$$$$$$//$$$$$$$/      | $$     | $| $$  | $|  $$$$$$|  $$$$$$| $$
:::    \___/ |__/  |__/\______/|__/ |__/ |__|_______/|_______/       |__/     |__|__/  |__/\_______/\_______|__/

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo %%A
echo:
echo:
echo:
echo  ------------------------------------------------------------
echo    PRESS 1 OR 2 OR 3 to select how to delete files, or 5 to EXIT  
echo  ------------------------------------------------------------
echo:
echo  1 - Find thumbs files ^& delete them automatically
echo  2 - Find thumbs files ^& delete them manually
echo  3 - Find ^& delete fully empty directories
echo  5 - EXIT^^!
echo:
set /p M=Type 1, 2, 3 or 5 then press ENTER: 

:Input
for %%a in (1 2 3 5) DO IF %M%==%%a goto Continue else goto WrongInput

:WrongInput
echo:
echo Wrong input^^! try again.
set /p M=Type 1, 2, 3 or 5 then press ENTER: 
goto Input

:Continue 
if %M%==1 goto Action
if %M%==2 (
    set command=/p
    goto Action
)
if %M%==3 goto Action
if %M%==5 goto quit


:Action
::get destination directory path by user
title thumbs finder - amoAR ^| Step 2
cls
echo:
set /p searchPathUserInput=Enter your search source path: 
echo:

if exist %searchPathUserInput%\ (
    cls
    if %M%==3 goto EmptyDirectories
) else (
    goto Exception
)


::get user path length
(echo "%searchPathUserInput%" & echo.) | findstr /O . | more +1 | (set /p RESULT= & call exit /b %%RESULT%%)
set /a searchPathUserInputLength=%ERRORLEVEL%-6


::get substring last char
set _startchar=%searchPathUserInputLength%
set _length=1
set _donor=%searchPathUserInput%
set _lastChar=!_donor:~%_startchar%,%_length%!

set thumbs=\thumbs.db


::check valid path
if /i %_lastChar%==\ (
    set searchPath=%searchPathUserInput:~0,-1%%thumbs%
) else (
    set searchPath=%searchPathUserInput%%thumbs%
)


::search thumbs & delete
echo:
for /f "tokens=1 delims=# " %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do (
    <nul set /p =^> 

    <nul set /p =Searching
    ping 127.0.0.1 -n 2 > nul

    <nul set /p =.
    ping 127.0.0.1 -n 2 > nul


    <nul set /p =.
    ping 127.0.0.1 -n 2 > nul

    <nul set /p =.
)
echo:
echo:

set /a count=0
for /f "delims=" %%i in ('dir /a-d/s/b %searchPath%') do (
    echo Detected file - %%i
    del %command%/a/f %%~i
    set /a count=count+1
    echo:
)

if %count%==0 (
    color 06
    echo  --------------------------------------
    echo ^| End of search:  No thumb file found^^! ^|
    echo  --------------------------------------
) else (
    color 02
    if %count% lss 10 (
        echo  ----------------------------------------
        echo ^| End of search:  %count% thumb were founded^^! ^|
        echo  ----------------------------------------
    ) else (
        echo  -----------------------------------------
        echo ^| End of search:  %count% thumb were founded^^! ^|
        echo  -----------------------------------------
    )
)
echo:
echo press any key to return to menu...
pause >nul
goto menu


:EmptyDirectories
echo:
for /f "tokens=1 delims=# " %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do (
    <nul set /p =^> 

    <nul set /p =Searching
    ping 127.0.0.1 -n 2 > nul

    <nul set /p =.
    ping 127.0.0.1 -n 2 > nul


    <nul set /p =.
    ping 127.0.0.1 -n 2 > nul

    <nul set /p =.
)
echo:
echo:

set /a count=0
for /f "delims=" %%a in ('dir /s/b %searchPathUserInput% ^| sort /r') do (
    echo Detected folder - %%a
    rd %%~fa
    set /a count=count+1
    echo:
)

if %count%==0 (
    color 06
    echo  -----------------------------------------
    echo ^| End of search:  Empty folder not found^^! ^|
    echo  -----------------------------------------
) else (
    color 02
    if %count% lss 10 (
        echo  -----------------------------------------------
        echo ^| End of search:  %count% empty folder were founded^^! ^|
        echo  -----------------------------------------------
    ) else (
        echo  ------------------------------------------------
        echo ^| End of search:  %count% empty folder were founded^^! ^|
        echo  ------------------------------------------------
    )
)
echo:
echo press any key to return to menu...
pause >nul
goto menu


:Exception
cls
color 04
echo The path entered is not valid!
echo:
echo press any key to return to menu...
pause >nul
goto menu


:quit
echo:
echo ^> Goodbye^^!
endlocal
timeout 2 /nobreak >nul
exit /b 0