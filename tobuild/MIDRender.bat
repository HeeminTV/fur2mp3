@echo off
setlocal enabledelayedexpansion 
if not exist "temp_mid.mid" (
echo Couldn't find `temp_mid.mid` > temp_fur2mp3error.txt && goto exists
)
if exist "temp_sf2.sf2" (
	set sf=temp_sf2.sf2
) else (
	set sf=SC-55.sf2
)

IF "%~1"=="-1" (
	echo Rendering `.mid` to `.wav` > temp_furrendering.txt
	"TiMidity++-2.15.0\timidity.exe" temp_mid.mid --config-string="soundfont %sf%" -Ow
	if not exist "temp_mid.wav" (
	echo `timidity.exe` did not create the `.wav` file. This is probably because the file is corrupted. > temp_fur2mp3error.txt && goto exists
	)

	IF EXIST temp_osccodec.txt (
	del /q temp_oscout.mp4
	echo Creating the `.yaml` file > temp_furrendering.txt
	call YAMLgenerator.bat "temp_mid.wav" "temp_mid.wav" 4
	echo Rendering to an oscilloscope video > temp_furrendering.txt 

	corrscope temp_mid.yaml -r temp_oscout.mp4
	25mb.bat temp_oscout.mp4 20
	echo Done > temp_furrendering.txt 

	goto exists

	) else (
	mp3init.bat temp_mid.wav
	goto exists
	)
) else (
	for /F "delims=" %%I in ('python3 MIDILength.py temp_mid.mid') do set "duration=%%I"
	set /a durationout=!duration!*1000 
	set OPT=--play_length=!durationout!
	midi2vgm_opl3_windows_x86_64\midi2vgm_opl3.exe --in temp_mid.mid --out temp_vgminput.vgm --bank %~1

	VGMRender.bat %OPT%
	exit /b
)

:exists
exit /b