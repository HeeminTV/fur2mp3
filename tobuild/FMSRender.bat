@echo OFF

if exist "temp_fmsinput.fms" (

rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

rem del /q "output_temp_oscout 20MB.mp4"
IF EXIST temp_osccodec.txt echo Seperating audio channels > temp_furrendering.txt

start /wait /min FamiStudio\FamiStudio.exe "temp_fmsinput.fms" nsf-export "fur2osc\temp_fmsnsf.nsf" -export-songs:%1
if not exist "fur2osc\temp_fmsnsf.nsf" (
echo `FamiStudio.exe` did not create the `.nsf` file. This is probably because the file is corrupted or the subsong number is invalid. > temp_fur2mp3error.txt && goto exists
)
start /wait /min multidumper.exe "fur2osc\temp_fmsnsf.nsf" %~2 --fade_length=2000
set "fileFound=0"
for %%f in (fur2osc\*.wav) do (
    set "fileFound=1"
    goto :checkResult
)
:checkResult
if %fileFound%==0 (
echo `multidumper.exe` did not create any `.wav` files. Perhaps the `.nsf` previously created by `FamiStudio.exe` is invalid or broken. > temp_fur2mp3error.txt && goto exists
)

sox-14.4.2\sox.exe -m -v 1 fur2osc\*.wav fur2osc\master\masterout.wav

goto cn

) else (

goto exists
)

:cn
IF EXIST temp_osccodec.txt (
if not exist "fur2osc\master\masterout.wav" (
echo `sox.exe` did not create the combined `.wav` file. This is a very serious and rare bug, so if you see this message, go buy a lottery ticket right away. Also don't forget to report this to the administrator! > temp_fur2mp3error.txt
goto exists
)

del /q temp_oscout.mp4
echo Creating the `.yaml` file > temp_furrendering.txt

rem seperatedwavsetup.bat
powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'temp_fmsnsf - ','')}"
call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\masterout.wav"
echo Rendering to an oscilloscope video > temp_furrendering.txt 
rem && rem p
corrscope masterout.yaml -r temp_oscout.mp4


REM echo Compressing the video > temp_furrendering.txt 
25mb.bat temp_oscout.mp4 20


goto exists
rem )
) ELSE (
rem action if the file doesn't exist
if exist "fur2osc\master\masterout.wav" (
mp3init.bat fur2osc\master\masterout.wav
)
goto exists
)

:exists

exit /b
