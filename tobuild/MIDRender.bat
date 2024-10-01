	@echo OFF
	setlocal enabledelayedexpansion 
timeout /t 3 /NOBREAK
del /q buffer_midouta.wav

if exist "buffer_mid.mid" (
echo Your file has been rendered successfully! > buffer_fur2wavmsg.txt
echo SHIT > buffer_furrendering.txt
rem ----------------
IF EXIST buffer_fur2wavosc.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master
rem timeout 1 
rem timeout /t 10 /NOBREAK
   rem action if file exists
   del /q "buffer_oscout 20MB.mp4"
   echo Creating an audio channel > buffer_oscstatus.txt 

)
if exist "buffer_sf2.sf2" (
set sf=buffer_sf2.sf2
) else (
set sf=SC-55.sf2
)
start /wait /min midirenderer-1.1.3-win64\bin\midirenderer.exe buffer_mid.mid -f !sf!

goto cn
) else (
rem echo NaN > outputfur.wav
REM copy slient.mp3 furoutput.mp3
rem timeout 1 >nul
echo The file does not exist! > buffer_fur2wavmsg.txt
goto exists
)
:exists
del /q buffer_furrendering.txt
timeout 1 >nul
rem del /q "%*"
rem echo reached >> debug_fur2wav.bat.log
exit /b

:cn
IF EXIST buffer_fur2wavosc.txt (
if not exist "buffer_mid.OGG" (
rem del /q buffer_fur2oscmst.yaml && del /q buffer_fur2wavosc.txt && del /q buffer_oscstatus.txt && del /q buffer_oscout.mp4 && del /q
 goto exists
)
if not exist "buffer_mid.ogg" (
goto exists
REM 0Z
)
rem ffmpeg.exe -i buffer_mid.ogg buffer_midout.wav
oggdec.exe -w buffer_midouta.wav .\buffer_mid.ogg

  del /q buffer_oscout.mp4

  echo Rendering to an oscilloscope video > buffer_oscstatus.txt 
  rem && rem p
  corrscope buffer_midouta.yaml -r buffer_oscout.mp4

  echo Compressing the video > buffer_oscstatus.txt 
  25mb.bat buffer_oscout.mp4 20
  echo Done > buffer_oscstatus.txt 
rem cls
 rem del /q 
 rem rmdir /q furosc
del /q buffer_*

rem echo && rem buffer_fur2oscmst
  rem goto exists
 rem exit /b
 goto exists
 rem )
) ELSE (
   rem action if the file doesn't exist
   if exist "buffer_mid.ogg" (
  rem ffmpeg.exe -y -i buffer_mid.ogg -vn -ar 44100 -ac 2 -b:a 192k .\furoutput.mp3
   mp3init.bat buffer_mid.ogg
   )
goto exists
)
