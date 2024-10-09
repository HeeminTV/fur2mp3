@echo off
if exist "buffer_furinput.fur" (

IF EXIST buffer_osccodec.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

   rem del /q "output_buffer_oscout 20MB.mp4"
   echo Seperating audio channels > buffer_furrendering.txt 
   furnace.exe -noreport %* -outmode perchan -output fur2osc\buffer_fur2wavwav.wav buffer_furinput.fur
   echo Rendering master audio > buffer_furrendering.txt 
   furnace.exe -noreport %* -output fur2osc\master\buffer_fur2oscmst.wav buffer_furinput.fur
   if not exist "fur2osc\master\buffer_fur2oscmst.wav" (
echo `furnace.exe` did not create any `.wav` files. This is probably because the file is corrupted. > buffer_fur2mp3error.txt && goto exists
)
   
) ELSE (
furnace.exe -noreport %* -output buffer_fur2wavwav.wav buffer_furinput.fur
   if not exist "buffer_fur2wavwav.wav" (
echo `furnace.exe` did not create the `.wav` file. This is probably because the file is corrupted. > buffer_fur2mp3error.txt && goto exists
)
)

goto cn

) else (

goto exists
)

:cn
IF EXIST buffer_osccodec.txt (

  del /q buffer_oscout.mp4
  echo Creating the `.yaml` file > buffer_furrendering.txt
  powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'buffer_fur2wavwav_c','Channel #')}"
  call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\buffer_fur2oscmst.wav"

rem powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'buffer_fur2wavwav_c','Channel ')}"
  echo Rendering to an oscilloscope video > buffer_furrendering.txt 
  rem && rem p
  corrscope buffer_fur2oscmst.yaml -r buffer_oscout.mp4
  

  REM echo Compressing the video > buffer_furrendering.txt 
  25mb.bat buffer_oscout.mp4 20
  echo Done > buffer_furrendering.txt 

 goto exists
 )
) ELSE (

   mp3init.bat .\buffer_fur2wavwav.wav
goto exists
)

:exists

exit /b
