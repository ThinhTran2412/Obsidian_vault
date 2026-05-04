@echo off
set PROJECT=%1
if "%PROJECT%"=="" (
    set /p PROJECT="Tên project: "
)
set DEST=D:\Obsidian\Brain\projects\%PROJECT%
mkdir "%DEST%"
copy "D:\Obsidian\Brain\projects\_template\context.md" "%DEST%\context.md"
copy "D:\Obsidian\Brain\projects\_template\retro.md" "%DEST%\retro.md"
echo Project "%PROJECT%" created at %DEST%
