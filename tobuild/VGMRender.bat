SETLOCAL ENABLEDELAYEDEXPANSION
@echo off
DEL /Q fur2osc\master\masterout.wav

if exist "buffer_vgminput.vgm" (

rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

rem del /q "output_buffer_oscout 20MB.mp4"
echo Seperating audio channels > buffer_furrendering.txt

move buffer_vgminput.vgm fur2osc\
	
start /wait /min multidumper.exe fur2osc\buffer_vgminput.vgm %* --fade_length=5000
set "fileFound=0"
for %%f in (fur2osc\*.wav) do (
    set "fileFound=1"
    goto :checkResult
)
:checkResult
if !fileFound!==0 (
echo `multidumper.exe` did not create any `.wav` files. This is probably because the file is corrupted or the subsong number is invalid. > buffer_fur2mp3error.txt && goto exists
)

sox-14.4.2\sox.exe -m -v 1 fur2osc\*.wav fur2osc\master\masterout.wav

goto cn

) else (
echo Couldn't find `buffer_vgminput.vgm` > buffer_fur2mp3error.txt
goto exists
)

:cn
IF EXIST buffer_osccodec.txt (
if not exist "fur2osc\master\masterout.wav" (
echo Couldn't find `masterout.wav` > buffer_fur2mp3error.txt

goto exists
)

del /q buffer_oscout.mp4
echo Creating the `.yaml` file > buffer_furrendering.txt

call seperatedwavsetup.bat
powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'buffer_vgminput - ','')}"
call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\masterout.wav"
echo Rendering to an oscilloscope video > buffer_furrendering.txt 

corrscope masterout.yaml -r buffer_oscout.mp4


REM echo Compressing the video > buffer_furrendering.txt 
25mb.bat buffer_oscout.mp4 20
echo Done > buffer_furrendering.txt 

goto exists

) ELSE (

if exist "fur2osc\master\masterout.wav" (

mp3init.bat fur2osc\master\masterout.wav
)
goto exists
)

:exists
exit /b
