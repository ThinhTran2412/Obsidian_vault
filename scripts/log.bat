@echo off
set LOGFILE=D:\Obsidian\Brain\memory\session-log.md
set MSG=%*
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set DATE=%%c-%%b-%%a
echo ## [%DATE%] %MSG% >> "%LOGFILE%"
echo Logged to %LOGFILE%
