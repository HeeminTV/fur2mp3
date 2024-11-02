@echo OFF
if exist "temp_sid.sid" (

IF EXIST temp_osccodec.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

rem del /q "output_temp_oscout 20MB.mp4"
echo Seperating audio channels > temp_furrendering.txt 

sidplayfp.exe --delay=0 -u2 -u3 %* -w"fur2osc/SID #1.wav" temp_sid.sid 
sidplayfp.exe --delay=0 -u1 -u3 %* -w"fur2osc/SID #2.wav" temp_sid.sid 
sidplayfp.exe --delay=0 -u1 -u2 %* -w"fur2osc/SID #3.wav" temp_sid.sid 
rem seperatedwavsetup.bat
sidplayfp.exe --delay=0 %* -w"fur2osc/master/temp_fur2oscmst.wav" temp_sid.sid 
   
) ELSE (
sidplayfp.exe --delay=0 %* -w"temp_fur2wavwav.wav" temp_sid.sid 

)
goto cn
rem goto exists
) else (
if not exist "fur2osc\temp_fmsnsf.nsf" (
echo `sidplayfp.exe` did not create any `.wav` files. This is probably because the file is corrupted or the subsong number is invalid. > temp_fur2mp3error.txt && goto exists
)

)

:cn
IF EXIST temp_osccodec.txt (
if not exist "fur2osc\master\temp_fur2oscmst.wav" (

 goto exists
)

  del /q temp_oscout.mp4
  echo Creating the `.yaml` file > temp_furrendering.txt
  call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\temp_fur2oscmst.wav"
  echo Rendering to an oscilloscope video > temp_furrendering.txt 
  rem && rem p
  corrscope temp_fur2oscmst.yaml -r temp_oscout.mp4
  

  REM echo Compressing the video > temp_furrendering.txt 
  call 25mb.bat temp_oscout.mp4 20
  echo Done > temp_furrendering.txt 
goto exists
 rem )
) ELSE (
mp3init.bat "temp_fur2wavwav.wav"
goto exists
)

:exists
exit /b
