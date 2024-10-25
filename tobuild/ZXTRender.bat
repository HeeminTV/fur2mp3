@echo OFF
setlocal enabledelayedexpansion 

start /wait /min zxtune_r5070_mingw_x86_64\zxtune123.exe --mp3 filename=output_zxtout.mp3 "%~1" 
if not exist "output_zxtout.mp3" (
echo `zxtune123.exe` did not create the `.mp3` file. It is because the file was corrupted. > temp_fur2mp3error.txt && goto exists
)
mp3id3init.bat output_zxtout.mp3

goto exists

:exists

exit /b
