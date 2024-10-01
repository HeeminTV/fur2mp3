	@echo OFF
	setlocal enabledelayedexpansion 
timeout /t 3 /NOBREAK
del /q zxtout.mp3

start /wait /min zxtune_r5070_mingw_x86_64\zxtune123.exe --mp3 filename=zxtout.mp3 %1
mp3id3init.bat zxtout.mp3

goto exists && rem goto cn

:exists
del /q buffer_*

exit /b
:cn
IF EXIST buffer_fur2wavosc.txt (
if not exist "buffer_mid.OGG" (
rem del /q buffer_fur2oscmst.yaml && del /q buffer_fur2wavosc.txt && del /q buffer_oscstatus.txt && del /q buffer_oscout.mp4 && del /q buffer_furrendering.txt
rem echo && rem buffer_fur2oscmst
  rem goto exists
 rem exit /b
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
del /q buffer_fur2wavosc.txt && del /q buffer_oscstatus.txt && del /q buffer_oscout.mp4 && del /q buffer_furrendering.txt
rem echo && rem buffer_fur2oscmst
  rem goto exists
 rem exit /b
 goto exists
 rem )
) ELSE (
   rem action if the file doesn't exist
   iffmpeg.exe -y -i buffer_mid.ogg -vn -ar 44100 -ac 2 -b:a 192k .\furoutput.mp3f exist "buffer_mid.ogg" (
   
   )
goto exists
)
