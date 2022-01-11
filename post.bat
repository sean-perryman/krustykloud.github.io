@echo off
for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
     set dow=%%i     
     set month=%%j
     set day=%%k
     set year=%%l
)

set datestr=%year%-%month%-%day%
set string=%*
set string=%string: =-%

hugo new posts\%datestr%-%string%.md

nano content\posts\%datestr%-%string%.md
