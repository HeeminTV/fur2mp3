::chcp 437
:: =---------------------------------------------------------=
::                                .::.                                             
:: =%%%%%:                      +@@@@@@*                                           
:: %%*                          .%.  .@@                                           
:: %%%%%%.=%%     #%%  *%%%%%:.....  #@@                                           
:: %%*    =%%     #%%  %%#   .     +@@@                                            
:: %%*    =%%     #%%  %%#       -@@@:                                             
:: %%*    =%%     #%%  %%#      @@@@@@@@+       .                     .-*##*:      
:: %%*     %%%%%%%%%%  %%#                                         =@@@+-@@@@@.    
::                              :++++-+%%#: -#%%+.  .+++++-#%%+.    %#  .@@@@@     
::                 ....        :@@@@@@@@@@@@@@@@@@ .@@@@@@*@@@@@=    .=@@@@@:      
::                 :-:        .@@@@@-=@@@@@ %@@@@+ @@@@@@ .@@@@@:   %%@@@@@+       
::                 +*=        @@@@@-:@@@@@.*@@@@# #@@@@@. @@@@@*      -@@@@@       
::                 %@#       %@@@@+.@@@@@:-@@@@@.*@@@@@=.@@@@@=#@@   +@@@@@.       
::                 *@@:     =@@@@@ @@@@@:.@@@@@.-@@@@@@@@@@%:  -@@@@@@@@-.         
::                 .@@@-                .@@@@@ .@@@@@=                             
::                  .@@@@-            .@@@@@@..@@@@@%                              
::                    #@@@@@@-....-%@@@@@@@=  =####*                               
::                      +@@@@@@@@@@@@@@@@-                                         
::                         .:*@@@@@%=..    
:: 
:: art by https://github.com/architectnt
:: =---------------------------------------------------------=
@echo ON
if exist temp_norender.txt (
copy temp_oscout.mp4 drivecopy.mp4
exit /b
)
if exist temp_osccodec.txt (
::FUUUUUUUUUUUUUUUUUUUUUUUCLK
::FUCK
::WHY ITI WONKT WORK
	set /p codec=<temp_osccodec.txt
::)
) else (
	set "codec=libx265"
)


for /f "usebackq delims=" %%A in (`powershell -Command ^
    "try { $json = Get-Content -Raw -Path '..\settings.json' | ConvertFrom-Json; " ^
    "[Console]::WriteLine($json.settings.GPU) } catch { [Console]::WriteLine('')" }`) do set "gpu=%%A"

	::set "hwaccel=-hwaccel_output_format vulkan"
	if "%gpu%"=="1" set "hwaccel=-hwaccel_output_format cuda" && set "gpu3=nvenc"
	if "%gpu%"=="2" set "hwaccel=-hwaccel_output_format qsv" && set "gpu3=qsv"
	if "%gpu%"=="3" set "hwaccel=-hwaccel_output_format vulkan" && set "gpu3=amf"
	if "%gpu%"=="4" set "hwaccel="
	if "%codec%"=="libx265" (
		if "%gpu%"=="4" (
			set "gpu2=libx265"
		) else (
			set "gpu2=hevc_%gpu3%"
		)
	) else (
		if "%gpu%"=="4" (
			set "gpu2=libx264"
		) else (
			set "gpu2=h264_%gpu3%"
		)
	)
		
REM Windows implementation of Marian Minar's answer to "ffmpeg video compression / specific file size" https://stackoverflow.com/a/61146975/2902367
SET "video=%~1"
SET "target_video_size_MB=%~2"
SET "output_file=output_%~n1 %~2MB.mp4"
REM I usually don't see a big difference between two-pass and single-pass... set to anything but "true" to turn off two-pass encoding
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
rem set maxbytesize=25780189

FOR /F "usebackq" %%A IN ('%file%') DO set size=%%~zA

if %size% LSS "25780189" (
	 copy %~1 "output_temp_oscout 20MB.mp4" 
	 rem "temp_
	 exit /b
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
::if "%twopass%" == "true" (
    ::echo Two-Pass Encoding
    ffmpeg ^
        -y ^
		-hide_banner -loglevel error ^
        %hwaccel% ^
        -i "%~1" ^
        -c:v %gpu2% ^
        -b:v %target_video_bitrate%k ^
        -pass 1 ^
        -an ^
        -f mp4 ^
        nul
::    SET "passString=-pass 2"
::) else ( echo Single-Pass Encoding )
ffmpeg ^
    %hwaccel% ^
    -i "%~1" ^
    -c:v %gpu2% ^
    -b:v %target_video_bitrate%k ^
    -pass 2 ^
	-y ^
	-hide_banner -loglevel error ^
    -c:a copy ^
    -b:a %target_audio_bitrate%k ^
    "%output_file%"
    
)
del %temp%\time.js
exit /b
GOTO :EOF

:Math
REM echo Working : "%*"
for /f %%a in ('cscript /nologo %mathPath% "%*"') do set "Result=%%a"
GOTO :EOF