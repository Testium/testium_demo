@ECHO OFF
SET a=This is a printout
SET b=%a% and a second printout

ECHO %a%
ECHO %b%
ECHO With command %1
ECHO But wait a minute... or three...

@ping 127.0.0.1 -n 180 -w 1000 > nul

ECHO Done
