@echo off
if exist "temp_furinput.fur" (

IF EXIST temp_osccodec.txt (
rmdir /S /q fur2osc
mkdir fur2osc && mkdir fur2osc\master

   rem del /q "output_temp_oscout 20MB.mp4"
   echo Seperating audio channels > temp_furrendering.txt 
   furnace.exe -noreport %* -outmode perchan -output fur2osc\temp_fur2wavwav.wav temp_furinput.fur
   echo Rendering master audio > temp_furrendering.txt 
   furnace.exe -noreport %* -output fur2osc\master\temp_fur2oscmst.wav temp_furinput.fur
   if not exist "fur2osc\master\temp_fur2oscmst.wav" (
echo `furnace.exe` did not create any `.wav` files. This is probably because the file is corrupted. > temp_fur2mp3error.txt && goto exists
)
   
) ELSE (
furnace.exe -noreport %* -output temp_fur2wavwav.wav temp_furinput.fur
   if not exist "temp_fur2wavwav.wav" (
echo `furnace.exe` did not create the `.wav` file. This is probably because the file is corrupted. > temp_fur2mp3error.txt && goto exists
)
)

goto cn

) else (

goto exists
)

:cn
IF EXIST temp_osccodec.txt (

  del /q temp_oscout.mp4
  echo Creating the `.yaml` file > temp_furrendering.txt
  powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'temp_fur2wavwav_c','Channel #')}"
  call YAMLgenerator.bat "fur2osc\*.wav" "fur2osc\master\temp_fur2oscmst.wav"

rem powershell -command "Get-ChildItem 'fur2osc\*.wav' | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name -replace 'temp_fur2wavwav_c','Channel ')}"
  echo Rendering to an oscilloscope video > temp_furrendering.txt 
  rem && rem p
  corrscope temp_fur2oscmst.yaml -r temp_oscout.mp4
  

  REM echo Compressing the video > temp_furrendering.txt 
  25mb.bat temp_oscout.mp4 20
  echo Done > temp_furrendering.txt 

 goto exists
 )
) ELSE (

   mp3init.bat .\temp_fur2wavwav.wav
goto exists
)

:exists

exit /b
