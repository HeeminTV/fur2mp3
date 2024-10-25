@echo off
if exist temp_ym.ym (
echo Converting YM to VGM... > temp_furrendering.txt 
ymtovgm.exe -o temp_vgminput.vgm temp_ym.ym
if not exist "temp_ym.ym" (
echo `ymtovgm.exe` did not create the `.vgm` file. It is because the file was corrupted. > temp_fur2mp3error.txt && goto exists
)
) else (
exit /b
)
VGMRender.bat %*

exit /b