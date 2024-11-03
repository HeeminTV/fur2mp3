@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
rmdir /s /q temp
mkdir temp
echo Downloading 7zr.exe Please wait...
powershell "(New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7zr.exe','temp\7zr.exe')"
SET "ANSWER=y"
cls
if not exist tobuild\FamiStudio\Famistudio.exe (
echo Could not find "FamiStudio.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/BleuBleu/FamiStudio/releases/download/4.2.1/FamiStudio421-WinPortableExe.zip','temp\FamiStudio421-WinPortableExe.zip')"
powershell expand-archive 'temp\FamiStudio421-WinPortableExe.zip' 'tobuild\FamiStudio'
) else (
rem exit /b
)
)

if not exist tobuild\furnace.exe (
echo Could not find "furnace.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/tildearrow/furnace/releases/download/v0.6.7/furnace-0.6.7-win64.zip','temp\furnace-0.6.7-win64.zip')"
powershell expand-archive 'temp\furnace-0.6.7-win64.zip' 'temp\furnace-0.6.7-win64'
move /y temp\furnace-0.6.7-win64\furnace.exe tobuild\furnace.exe
) else (
rem exit /b
)
)

if not exist tobuild\corrscope.exe (
echo Could not find "corrscope.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/corrscope/corrscope/releases/download/0.10.1/corrscope-0.10.1-win64.7z','temp\corrscope-0.10.1-win64.7z')"
rem powershell "(New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7zr.exe','temp\7zr.exe')"
temp\7zr.exe x -o"tobuild" temp\corrscope-0.10.1-win64.7z

) else (
rem exit /b
)
)

if not exist tobuild\ffprobe.exe (
echo Could not find ffmpeg set. Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip','temp\ffmpeg-master-latest-win64-gpl-shared.zip')"
powershell expand-archive 'temp\ffmpeg-master-latest-win64-gpl-shared.zip' 'temp\ffmpeg'
move /y temp\ffmpeg\ffmpeg-master-latest-win64-gpl-shared\bin\ffmpeg.exe tobuild
move /y temp\ffmpeg\ffmpeg-master-latest-win64-gpl-shared\bin\ffprobe.exe tobuild

) else (
rem exit /b
)
)

if not exist tobuild\multidumper.exe (
echo Could not find "multidumper.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/maxim-zhao/multidumper/releases/download/v20220512/multidumper.zip','temp\multidumper.zip')"
powershell expand-archive 'temp\multidumper.zip' 'tobuild'
) else (
rem exit /b
)
)

if not exist tobuild\sox-14.4.2\sox.exe (
echo Could not find "sox.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://jaist.dl.sourceforge.net/project/sox/sox/14.4.2/sox-14.4.2-win32.zip?viasf=1','temp\sox-14.4.2-win32.zip')"
powershell expand-archive 'temp\sox-14.4.2-win32.zip' 'tobuild'
) else (
rem exit /b
)
)

if not exist tobuild\ymtovgm.exe (
echo Could not find "ymtovgm.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/QuinnPainter/YMtoVGM/releases/download/v1.0.0/ymtovgm.exe','tobuild\ymtovgm.exe')"
) else (
rem exit /b
)
)

if not exist tobuild\zxtune_r5070_mingw_x86_64\zxtune123.exe (
echo Could not find "zxtune123.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://bitbucket.org/zxtune/zxtune/downloads/zxtune_r5070_mingw_x86_64.zip','temp\zxtune_r5070_mingw_x86_64.zip')"
powershell expand-archive 'temp\zxtune_r5070_mingw_x86_64.zip' 'tobuild\zxtune_r5070_mingw_x86_64'
) else (
rem exit /b
)
)

if not exist tobuild\	.exe (
echo Could not find "sidplayfp.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/libsidplayfp/sidplayfp/releases/download/v2.10.0/sidplayfp-2.10.0-lib2.10.1-w64.zip','temp\sidplayfp-2.9.0-lib2.9.0-w64.zip')"
powershell expand-archive 'temp\sidplayfp-2.10.0-lib2.10.1-w64.zip' 'temp\sidplayfp-2.10.0-lib2.10.1-w64'
move /y temp\sidplayfp-2.10.0-lib2.10.1-w64\sidplayfp-2.10.0-lib2.10.1-w64\sidplayfp.exe tobuild\sidplayfp.exe
) else (
rem exit /b
)
)

::if not exist tobuild\midirenderer-1.1.3-win64\midirenderer.exe (
if not exist "TiMidity++-2.15.0\timidity.exe" (
echo Could not find "timidity.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://jaist.dl.sourceforge.net/project/timidity/TiMidity%2B%2B/TiMidity%2B%2B-2.15.0/TiMidity%2B%2B-2.15.0-w32.zip?viasf=1','temp\TiMidity++-2.15.0-w32.zip')"
powershell expand-archive 'temp\TiMidity++-2.15.0-w32.zip' 'temp\TiMidity++-2.15.0-w32'
move /y temp\TiMidity++-2.15.0-w32 tobuild\TiMidity++-2.15.0
) else (
rem exit /b
)
)

if not exist tobuild\midi2vgm_opl3_windows_x86_64\midi2vgm_opl3.exe (
echo Could not find "midi2vgm_opl3.exe". Downloading...

if /i "!ANSWER!" == "y" (
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/SudoMaker/midi2vgm/releases/download/v0.0.1/midi2vgm_opl3_windows_x86_64.7z','temp\midi2vgm_opl3_windows_x86_64.7z')"
rem powershell expand-archive 'temp\id3-081w.zip' 'tobuild\id3-081w'
temp\7zr.exe x -o"tobuild\midi2vgm_opl3_windows_x86_64" temp\midi2vgm_opl3_windows_x86_64.7z
) else (
rem exit /b
)
)

rmdir /s /q temp
echo @echo off >> run.bat
echo xcopy tobuild build /e /y >> run.bat
echo cd build >> run.bat
echo cls >> run.bat
echo :a >> run.bat
echo CALL fur2mp3reset.bat >> run.bat
echo node index.js >> run.bat

echo TIMEOUT /t 5 /NOBREAK >> run.bat
echo goto a >> run.bat
rem echo 

call npm install
call python3 -m pip install mido
echo Setup Completed. Now you can close this window and delete this script. (Run "run.bat" instead)
echo.
echo You need to config some settings like "bot token".
::echo Open build\index.js on text editor and go to line 52.
ECHO THIS IS THE FIRST TIME USING GITHUB. I HAVE NOT TESTED THIS SCRIPT. You should probably run "npm install" on your cmd
pause
exit /b
