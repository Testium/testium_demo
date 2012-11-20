@echo off

SET curdir=%~dp0

set "cmd=%~1"
set "file=%~2"
set globalConfig = "%curdir%\config\global.xml"

if "%cmd%"=="" 	set cmd="execute"					rem if no command is set, do execute
if "%file%"==""	set file="%curdir%\test\all.xml"	rem if no file is set, use all.xml

java -jar %curdir%\src\testium.jar --command %cmd% --globalconfigfile "%curdir%\config\global.xml" --file %file%

echo Check results in C:\Temp\^<date^>
pause
