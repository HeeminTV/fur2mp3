@echo off
if exist buffer_ym.ym (
echo Converting YM to VGM... > buffer_oscstatus.txt 
ymtovgm.exe -o buffer_vgminput.vgm buffer_ym.ym
) else (
exit /b
)
VGMRender.bat %*
del /q buffer_*

exit /b