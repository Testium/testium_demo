@echo off

SET curdir=%~dp0

set globalConfig = "%curdir%\config\global.xml"

java -jar %curdir%\src\testium.jar --command keywords --globalconfigfile "%curdir%\config\global.xml"

pause
