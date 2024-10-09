@echo OFF
if exist "buffer_sid.sid" (

IF EXIST buffer_osccodec.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

rem del /q "output_buffer_oscout 20MB.mp4"
echo Seperating audio channels > buffer_furrendering.txt 

sidplayfp.exe --delay=0 -u2 -u3 %* -w"fur2osc/SID #1.wav" buffer_sid.sid 
sidplayfp.exe --delay=0 -u1 -u3 %* -w"fur2osc/SID #2.wav" buffer_sid.sid 
sidplayfp.exe --delay=0 -u1 -u2 %* -w"fur2osc/SID #3.wav" buffer_sid.sid 
CALL seperatedwavsetup.bat
sidplayfp.exe --delay=0 %* -w"fur2osc/master/buffer_fur2oscmst.wav" buffer_sid.sid 
   
) ELSE (
sidplayfp.exe --delay=0 %* -w"buffer_fur2wavwav.wav" buffer_sid.sid 

)
goto cn
rem goto exists
) else (
if not exist "fur2osc\buffer_fmsnsf.nsf" (
echo `sidplayfp.exe` did not create any `.wav` files. This is probably because the file is corrupted or the subsong number is invalid. > buffer_fur2mp3error.txt && goto exists
)

)

:cn
IF EXIST buffer_osccodec.txt (
if not exist "fur2osc\master\buffer_fur2oscmst.wav" (

 goto exists
)

  del /q buffer_oscout.mp4
  echo Creating the `.yaml` file > buffer_furrendering.txt
  call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\buffer_fur2oscmst.wav"
  echo Rendering to an oscilloscope video > buffer_furrendering.txt 
  rem && rem p
  corrscope buffer_fur2oscmst.yaml -r buffer_oscout.mp4
  

  REM echo Compressing the video > buffer_furrendering.txt 
  call 25mb.bat buffer_oscout.mp4 20
  echo Done > buffer_furrendering.txt 
goto exists
 rem )
) ELSE (
mp3init.bat "buffer_fur2wavwav.wav"
goto exists
)

:exists
exit /b
