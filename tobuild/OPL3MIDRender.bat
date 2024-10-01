@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
REM SETLOCAL ENABLEDELAYEDEXPANSION DisableDelayedExpansion
del /q buffer_vgminput.vgm
rem if exist buffer_extcommand.txt (
rem set /p extcmd=<buffer_extcommand.txt
rem del /q buffer_extcommand.txt
rem ) else (
rem set "extcmd="
rem )
if "%~1" == "AUTO" (
for /F "delims=" %%I in ('python3 MIDILength.py') do set "duration=%%I"
REM del /q buffer_mid.ogg
set /a durationout=!duration!*1000 
set OPT=--play_length=!durationout!
) ELSE (
set OPT=%~1
)
if exist buffer_vgmmidi.mid (
echo Converting MIDI to VGM... > buffer_oscstatus.txt 
midi2vgm_opl3_windows_x86_64\midi2vgm_opl3.exe --in buffer_vgmmidi.mid --out buffer_vgminput.vgm %~2
) else (
exit /b
)
REM echo %OPT%AND%OPTA% > TTT.TXT 
VGMRender.bat %OPT%
REM echo %OPT% > TTT.TXT 
rem del /q ym.ym
del /q buffer_*

exit /b