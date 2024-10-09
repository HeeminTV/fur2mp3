	@echo OFF
	setlocal enabledelayedexpansion 

if exist "buffer_mid.mid" (

IF EXIST buffer_osccodec.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

   rem del /q "output_buffer_oscout 20MB.mp4"
   echo Rendering to an audio file > buffer_furrendering.txt 

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
IF EXIST buffer_osccodec.txt (
if not exist "buffer_mid.OGG" (
echo `midirenderer.exe` did not create the `.ogg` file. This is probably because the file is corrupted or the `.mid` file is too long. > buffer_fur2mp3error.txt && goto exists


)


oggdec.exe -w buffer_midouta.wav .\buffer_mid.ogg

  del /q buffer_oscout.mp4

  echo Rendering to an oscilloscope video > buffer_furrendering.txt 

  corrscope MIDRenderConfig.yaml -r buffer_oscout.mp4

  REM echo Compressing the video > buffer_furrendering.txt 
  25mb.bat buffer_oscout.mp4 20
  echo Done > buffer_furrendering.txt 
rem cls
 rem del /q 
 rem rmdir /q furosc
del /q buffer_*


 goto exists
 rem )
) ELSE (
   rem action if the file doesn't exist
   if exist "buffer_mid.ogg" (
   mp3init.bat buffer_mid.ogg
   )
goto exists
)
