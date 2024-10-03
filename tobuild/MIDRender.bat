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

goto exists
)
:exists
del /q buffer_furrendering.txt

exit /b

:cn
IF EXIST buffer_fur2wavosc.txt (
if not exist "buffer_mid.OGG" (

 goto exists
)
if not exist "buffer_mid.ogg" (
goto exists
REM 0Z
)

oggdec.exe -w buffer_midouta.wav .\buffer_mid.ogg

  del /q buffer_oscout.mp4

  echo Rendering to an oscilloscope video > buffer_oscstatus.txt 

  corrscope MIDRenderConfig.yaml -r buffer_oscout.mp4

  echo Compressing the video > buffer_oscstatus.txt 
  25mb.bat buffer_oscout.mp4 20
  echo Done > buffer_oscstatus.txt 
rem cls
 rem del /q 
 rem rmdir /q furosc
del /q buffer_*


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
