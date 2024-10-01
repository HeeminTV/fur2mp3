@echo off
goto shitthefuck
rem ffmpeg -y -i input -c:v libx264 -preset medium -b:v 555k -pass 1 -c:a libfdk_aac -b:a 128k -f mp4 /dev/null && \
rem ffmpeg -i input -c:v libx264 -preset medium -b:v 555k -pass 2 -c:a libfdk_aac -b:a 128k output.mp4
set /p dur=dur(s)
set /p tar=target(kilobits)
set /p output4=output
rem set /a xbab+=1
set /a xbab=tar/dur
if not exist buffer_osccodec.txt (
echo libx265>buffer_osccodec.txt
)
set /p codec=<buffer_osccodec.txt
rem echo fuck%codec%fuck > whatthefuck.txt
ffmpeg -y -i %* -c:v %codec% -b:v %xbab% -pass 1 -an -f null nul && ^ffmpeg -y -i %* -c:v %codec% -b:v %xbab% -pass 2 -c:a aac -b:a %xbab% %output4%

ffmpeg -y -i %* -c:v %codec% -b:v 555k -pass 1 -an -f null nul && ^ffmpeg -y -i %* -c:v %codec% -b:v 555k -pass 2 -c:a aac -b:a 128k %output4%
rem ex
pause
:shitthefuck
@echo off
if not exist buffer_osccodec.txt (
echo libx265>buffer_osccodec.txt
)
if exist norender.txt (
rem copy norendre.mp4 "buffer_oscout 20MB.mp4"
copy buffer_oscout.mp4 drivecopy.mp4
rem del /q norendre.mp4
del /q norender.txt
	 del /q buffer_osccodec.txt
	rem copy %~1 "buffer_oscout 20MB.mp4" 
	 rem "buffer_
	 exit /b
	 )
set /p codec=<buffer_osccodec.txt
del /q buffer_osccodec.txt
rem rem rem ECHO ON
REM Windows implementation of Marian Minar's answer to "ffmpeg video compression / specific file size" https://stackoverflow.com/a/61146975/2902367
SET "video=%~1"
SET "target_video_size_MB=%~2"
SET "output_file=%~dpn1 %~2MB.mp4"
REM I usually don't see a big difference between two-pass and single-pass... set to anything but "true" to turn off two-pass encoding
SET "twopass=true"
REM We need a way to do floating point arithmetic in CMD, here is a quick one. Change the path to a location that's convenient for you
set "mathPath=buffer_Math.vbs"
REM Creating the Math VBS file
REM RMif not exist '%mathPath%' (
 echo Wscript.echo replace^(eval^(WScript.Arguments^(0^)^),",","."^) > %mathPath%
REM )
echo Converting to %target_video_size_MB% MB: "%video%"

rem @echo off
setlocal
set file=%~1
set maxbytesize=25780189

FOR /F "usebackq" %%A IN ('%file%') DO set size=%%~zA

if %size% LSS %maxbytesize% (
   rem echo.File is ^< %maxbytesize% bytes
        echo.File is ^>= %maxbytesize% bytes
	 del /q buffer_osccodec.txt
	 copy %~1 "buffer_oscout 20MB.mp4" 
	 rem "buffer_
	 exit /b
rem ) ELSE (
    rem echo.File is ^>= %maxbytesize% bytes
	rem del /q buffer_osccodec.txt
	rem copy %~1 "buffer_oscout 20MB.mp4" 
	rem rem "buffer_
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
rem del /q buffer_osccodec.txt
exit /b
rem del /q buffer_osccodec.txt
GOTO :EOF

:Math
REM echo Working : "%*"
for /f %%a in ('cscript /nologo %mathPath% "%*"') do set "Result=%%a"
GOTO :EOF