@echo off
setlocal EnableDelayedExpansion
:A
set /P name="What is the process? "
set condition=false
set i=0

tasklist /FI "ImageName eq %name%" /FO LIST
@echo off
for /F "tokens=2" %%K in ('tasklist /FI "ImageName eq %name%" /FO LIST ^| findstr /B "PID:"') do (
   set PID=%%K
   set arr[!i!]=%%K & set /a "i+=1"
   set condition=true
)

if %condition%==false (goto:A)

    echo.===================================
    ::run each array item through netstat command
    set "len=!i!"
    set "i=0"
    :loop
    	netstat -ano | findstr !arr[%i%]! & set /a "i+=1"
    if %i% neq %len% goto:loop


pause

:: This will print all elements in the array
::echo !arr[%i%]! & set /a "i+=1"

:: Add this after %name% in line 9 and 12 to only show currently active processes
::/FI "Status eq Running"
