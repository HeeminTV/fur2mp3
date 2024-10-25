@echo off
if not exist temp_osccodec.txt (
echo libx265>temp_osccodec.txt
)
if exist temp_norender.txt (
rem copy norendre.mp4 "temp_oscout 20MB.mp4"
REM copy temp_oscout.mp4 drivecopy.mp4
rem del /q norendre.mp4
del /q temp_norender.txt
	 rem del /q temp_osccodec.txt
	 exit /b
	 )
set /p optionfile=<temp_osccodec.txt
for /f "tokens=1,2" %%a in ("%optionfile%") do (
    set codec=%%a
    set twopass=%%b
)
REM Windows implementation of Marian Minar's answer to "ffmpeg video compression / specific file size" https://stackoverflow.com/a/61146975/2902367
SET "video=%~1"
SET "target_video_size_MB=%~2"
SET "output_file=output_%~n1 %~2MB.mp4"
REM I usually don't see a big difference between two-pass and single-pass... set to anything but "true" to turn off two-pass encoding
rem SET "twopass=true"
REM We need a way to do floating point arithmetic in CMD, here is a quick one. Change the path to a location that's convenient for you
set "mathPath=temp_Math.vbs"
REM Creating the Math VBS file
REM RMif not exist '%mathPath%' (
 echo Wscript.echo replace^(eval^(WScript.Arguments^(0^)^),",","."^) > %mathPath%
REM )
echo Converting to %target_video_size_MB% MB: "%video%"

rem @echo off
setlocal
echo Compressing the video > temp_furrendering.txt 
set file=%~1
set maxbytesize=25780189

FOR /F "usebackq" %%A IN ('%file%') DO set size=%%~zA

if %size% LSS %maxbytesize% (
   rem echo.File is ^< %maxbytesize% bytes
        echo.File is ^>= %maxbytesize% bytes
	 rem del /q temp_osccodec.txt
	 copy %~1 "output_temp_oscout 20MB.mp4" 
	 rem "temp_
	 exit /b
rem ) ELSE (
    rem echo.File is ^>= %maxbytesize% bytes
	rem rem del /q temp_osccodec.txt
	rem copy %~1 "temp_oscout 20MB.mp4" 
	rem rem "temp_
	rem exit /b
)
endlocal

echo -^> "%output_file%"
rem ECHO OFF && pause
SETLOCAL EnableDelayedExpansion
REM Getting the (audio) duration. TODO: watch out for differing audio/video durations?
FOR /F "delims=" %%i IN ('ffprobe -v error -show_streams -select_streams a "%~1"') DO (
    SET "line=%%i"
    if "!line:~0,9!" == "duration=" (
        SET "duration=!line:~9!"
    )
)
REM Getting the audio bitrate
FOR /F "delims=" %%i IN ('ffprobe -v error -pretty -show_streams -select_streams a "%~1"') DO (
    SET "line=%%i"
    SET /A "c=0"
    if "!line:~0,9!" == "bit_rate=" (
        FOR %%a IN (!line:~9!) DO (
            if "!c!" == "0" (
                SET "audio_rate=%%a"
            )
            SET /A "c+=1"
        )
    )
)
REM TODO: Adjust target audio bitrate. Use source bitrate for now.
SET "target_audio_bitrate=%audio_rate%"

call:Math %target_video_size_MB% * 8192 / (1.048576 * %duration%) - %target_audio_bitrate%
SET "target_video_bitrate=%result%"

echo %target_audio_bitrate% audio, %target_video_bitrate% video
SET "passString="
if "%twopass%" == "true" (
    echo Two-Pass Encoding
    ffmpeg ^
        -y ^
		-hide_banner -loglevel error ^
        -i "%~1" ^
        -c:v %codec% ^
        -b:v %target_video_bitrate%k ^
        -pass 1 ^
        -an ^
        -f mp4 ^
        nul
    SET "passString=-pass 2"
) else ( echo Single-Pass Encoding )
ffmpeg ^
    -i "%~1" ^
    -c:v %codec% ^
    -b:v %target_video_bitrate%k ^
    %passString% ^
	-y ^
	-hide_banner -loglevel error ^
    -c:a aac ^
    -b:a %target_audio_bitrate%k ^
    "%output_file%"
    
rem pause
rem rem del /q temp_osccodec.txt
exit /b
rem rem del /q temp_osccodec.txt
GOTO :EOF

:Math
REM echo Working : "%*"
for /f %%a in ('cscript /nologo %mathPath% "%*"') do set "Result=%%a"
GOTO :EOF