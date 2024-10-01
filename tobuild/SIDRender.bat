@echo OFF
rem echo fucksid > ufcksid.tct
rem if exist furoutput.mp3 (
del /q buffer_furrendering.txt
del /q furoutput.mp3
DEL /Q buffer_fur2wavwav.wav
timeout /t 3 /NOBREAK

if exist "buffer_sid.sid" (
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
  rem furnace.exe -noreport %* -outmode perchan -output fur2osc\buffer_fur2wavwav.wav buffer_furinput.fur
   rem furnace.exe -noreport %* -output fur2osc\master\buffer_fur2oscmst.wav buffer_furinput.fur
sidplayfp.exe --delay=0 -u2 -u3 %* -w"fur2osc/SID #1.wav" buffer_sid.sid 
sidplayfp.exe --delay=0 -u1 -u3 %* -w"fur2osc/SID #2.wav" buffer_sid.sid 
sidplayfp.exe --delay=0 -u1 -u2 %* -w"fur2osc/SID #3.wav" buffer_sid.sid 
CALL seperatedwavsetup.bat
sidplayfp.exe --delay=0 %* -w"fur2osc/master/buffer_fur2oscmst.wav" buffer_sid.sid 
   
) ELSE (
echo shibal  > ufcksid.tct
sidplayfp.exe --delay=0 %* -w"buffer_fur2wavwav.wav" buffer_sid.sid 
timeout /t 3 /NOBREAK
echo FUCK  > ufcksid.tct
rem furnace.exe -noreport %* -output buffer_fur2wavwav.wav buffer_furinput.fur
   rem action if the file doesn't exist
rem   ffmpeg.exe -i .\buffer_fur2wavwav.wav -vn -ar 44100 -ac 2 -b:a 192k .\furoutput.mp3
rem goto exists
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
if not exist "fur2osc\master\buffer_fur2oscmst.wav" (
rem del /q buffer_fur2oscmst.yaml && del /q buffer_fur2wavosc.txt && del /q buffer_oscstatus.txt && del /q buffer_oscout.mp4 && del /q buffer_furrendering.txt
rem echo && rem buffer_fur2oscmst
  rem goto exists
 rem exit /b
 goto exists
)
   rem action if file exists
  rem corrscope.exe fur2osc/
  rem  dk이거여씀del /q 'buffer_oscout 20MB.mp4'
  del /q buffer_oscout.mp4
  echo Creating the `.yaml` file > buffer_oscstatus.txt
  corrscope fur2osc\*.wav --audio fur2osc\master\buffer_fur2oscmst.wav -w
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
 rem )
) ELSE (
   rem action if the file doesn't exist
   if exist "buffer_fur2wavwav.wav" (
   ffmpeg.exe -y -i .\buffer_fur2wavwav.wav -vn -ar 44100 -ac 2 -b:a 192k .\furoutput.mp3
   mp3init.bat .\buffer_fur2wavwav.wav
   )
goto exists
)
