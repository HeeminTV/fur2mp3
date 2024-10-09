@echo off
if exist buffer_ym.ym (
echo Converting YM to VGM... > buffer_furrendering.txt 
ymtovgm.exe -o buffer_vgminput.vgm buffer_ym.ym
if not exist "buffer_ym.ym" (
echo `ymtovgm.exe` did not create the `.vgm` file. It is because the file was corrupted. > buffer_fur2mp3error.txt && goto exists
)
) else (
exit /b
)
VGMRender.bat %*

exit /b