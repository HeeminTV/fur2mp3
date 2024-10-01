@echo off

rem if exist furoutput.mp3 (
del /q buffer_furrendering.txt
del /q furoutput.mp3
rem )	
rem IF EXIST buffer_fur2wavosc.txt (
   rem action if file exists
rem ) ELSE (
   rem action if the file doesn't exist
rem )
if exist "buffer_furinput.fur" (
echo Error! > buffer_fur2wavmsg.txt
echo SHIT > buffer_furrendering.txt
rem ----------------
IF EXIST buffer_fur2wavosc.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master
rem timeout 1 
rem timeout /t 10 /NOBREAK
   rem action if file exists
   del /q "buffer_oscout 20MB.mp4"
   echo Seperating audio channels > buffer_oscstatus.txt 
   furnace.exe -noreport %* -outmode perchan -output fur2osc\buffer_fur2wavwav.wav buffer_furinput.fur
   furnace.exe -noreport %* -output fur2osc\master\buffer_fur2oscmst.wav buffer_furinput.fur
   
) ELSE (
furnace.exe -noreport %* -output buffer_fur2wavwav.wav buffer_furinput.fur

)

if NOT %errorlevel% == 0 ( 
echo THIS IS FUCKING ERERORRRR RRRRRRRRRRRRRRRRRR > buffer_fur2wavmsg.txt
goto exists
)
echo Your file has been rendered successfully! > buffer_fur2wavmsg.txt
goto cn
rem goto exists
) else (
rem echo NaN > outputfur.wav
copy slient.mp3 furoutput.mp3
rem timeout 1 >nul
echo The file does not exist! > buffer_fur2wavmsg.txt
goto exists
)
:exists
del /q buffer_*

timeout 1 >nul
rem del /q "%*"
rem echo reached >> debug_fur2wav.bat.log
exit /b

:cn
IF EXIST buffer_fur2wavosc.txt (
   rem action if file exists
  rem corrscope.exe fur2osc/
  rem  dk이거여씀del /q 'buffer_oscout 20MB.mp4'
  del /q buffer_oscout.mp4
  echo Creating the `.yaml` file > buffer_oscstatus.txt
  powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'buffer_fur2wavwav_c','Channel #')}"
  corrscope fur2osc\*.wav --audio fur2osc\master\buffer_fur2oscmst.wav -w
rem powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'buffer_fur2wavwav_c','Channel ')}"
  echo Rendering to an oscilloscope video > buffer_oscstatus.txt 
  rem && rem p
  corrscope buffer_fur2oscmst.yaml -r buffer_oscout.mp4
  

  echo Compressing the video > buffer_oscstatus.txt 
  25mb.bat buffer_oscout.mp4 20
  echo Done > buffer_oscstatus.txt 
rem cls
 rem del /q 
 rem rmdir /q furosc
 del /q buffer_fur2oscmst.yaml && del /q buffer_fur2wavosc.txt && del /q buffer_oscstatus.txt && del /q buffer_oscout.mp4 && del /q buffer_furrendering.txt
rem echo && rem buffer_fur2oscmst
  rem goto exists
 rem exit /b
 goto exists
 )
) ELSE (
   rem action if the file doesn't exist
   rem ffmpeg.exe -y -i .\buffer_fur2wavwav.wav -vn -ar 44100 -ac 2 -b:a 192k .\furoutput.mp3
   mp3init.bat .\buffer_fur2wavwav.wav
goto exists
)
