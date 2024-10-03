@echo OFF

rem if exist furoutput.mp3 (
del /q buffer_furrendering.txt
del /q furoutput.mp3
DEL /Q fur2osc\master\masterout.wav
del /q buffer_fur2mp3error.txt
if exist "buffer_fmsinput.fms" (
echo Error! > buffer_fur2wavmsg.txt
echo SHIT > buffer_furrendering.txt

rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

del /q "buffer_oscout 20MB.mp4"
IF EXIST buffer_fur2wavosc.txt echo Seperating audio channels > buffer_oscstatus.txt
	move buffer_vgminput.vgm fur2osc\

start /wait /min FamiStudio\FamiStudio.exe "buffer_fmsinput.fms" nsf-export "fur2osc\buffer_fmsnsf.nsf" -export-songs:%1
if not exist "fur2osc\buffer_fmsnsf.nsf" (
echo `FamiStudio.exe` did not create `.nsf` file. It is because the file was corrupted, invalid, or the subsong value was invalid > buffer_fur2mp3error.txt && goto exists
)
start /wait /min multidumper.exe "fur2osc\buffer_fmsnsf.nsf" %~2 --fade_length=2000

echo ======================시발==================
REM ping -n 5 127.0.0.1 >nul
sox-14.4.2\sox.exe -m -v 1 fur2osc\*.wav fur2osc\master\masterout.wav

echo Your file has been rendered successfully! > buffer_fur2wavmsg.txt
goto cn
rem goto exists
) else (
rem echo NaN > outputfur.wav
copy slient.mp3 furoutput.mp3
rem rem timeout chingchangchong 1 >nul
echo The file does not exist! > buffer_fur2wavmsg.txt
goto exists
)
:exists
del /q buffer_fur2oscmst.yaml && del /q buffer_fur2wavosc.txt && del /q buffer_oscstatus.txt && del /q buffer_oscout.mp4 && del /q buffer_furrendering.txt

exit /b

:cn
IF EXIST buffer_fur2wavosc.txt (
if not exist "fur2osc\master\masterout.wav" (

goto exists
)

del /q buffer_oscout.mp4
echo Creating the `.yaml` file > buffer_oscstatus.txt
rem normalize.exe -a 8 fur2osc\*.wav
call seperatedwavsetup.bat
powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'buffer_fmsnsf - ','')}"
call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\masterout.wav"
echo Rendering to an oscilloscope video > buffer_oscstatus.txt 
rem && rem p
corrscope masterout.yaml -r buffer_oscout.mp4


echo Compressing the video > buffer_oscstatus.txt 
25mb.bat buffer_oscout.mp4 20


goto exists
rem )
) ELSE (
rem action if the file doesn't exist
if exist "fur2osc\master\masterout.wav" (
rem ffmpeg.exe -y -i fur2osc\master\masterout.wav -vn -ar 44100 -ac 2 -b:a 192k .\furoutput.mp3
mp3init.bat fur2osc\master\masterout.wav
)
goto exists
)
