@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
if "%~1" == "AUTO" (
for /F "delims=" %%I in ('python3 MIDILength.py') do set "duration=%%I"
set /a durationout=!duration!*1000 
set OPT=--play_length=!durationout!
) ELSE (
set OPT=%~1
)
if exist buffer_vgmmidi.mid (
echo Converting MIDI to VGM > buffer_furrendering.txt 
midi2vgm_opl3_windows_x86_64\midi2vgm_opl3.exe --in buffer_vgmmidi.mid --out buffer_vgminput.vgm %~2
) else (
echo Couldn't find `buffer_vgmmidi.mid` > buffer_fur2mp3error.txt
exit /b
)
VGMRender.bat %OPT%
exit /b