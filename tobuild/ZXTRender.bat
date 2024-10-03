	@echo OFF
	setlocal enabledelayedexpansion 
timeout /t 3 /NOBREAK
del /q zxtout.mp3

start /wait /min zxtune_r5070_mingw_x86_64\zxtune123.exe --mp3 filename=zxtout.mp3 %1
mp3id3init.bat zxtout.mp3

goto exists

:exists
del /q buffer_*

exit /b
