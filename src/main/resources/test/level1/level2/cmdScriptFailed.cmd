@ECHO OFF
SET a=This is a printout
SET b=%a% and a failed printout

ECHO %a%
ECHO %b%
ECHO With parameters %1 and %2

EXIT 1
