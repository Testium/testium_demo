@echo off

SET curdir=%~dp0

set "cmd=%~1"
set globalConfig = "%curdir%\config\global.xml"

if "%cmd%"=="" 	set cmd="execute"					rem if no command is set, do execute

java -jar %curdir%\src\testium.jar --command %cmd% --globalconfigfile "%curdir%\config\global.xml" --file "%curdir%\test\allBrowsers.xml"

echo Check results in C:\Temp\^<date^>
pause
