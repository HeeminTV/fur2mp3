ffmpeg.exe -y -i %1 -vn -ar 44100 -ac 2 -b:a 224k .\furoutput.mp3
rem if exist buffer_fur2mp3id3title.txt (
rem set /p tite=<buffer_fur2mp3id3title.txt
rem ) else (
rem set "tite=undefined"
rem )
rem id3-081w\id3.exe --title %tite% --comment "Rendered with 희민Heemin's Yumetaro Discord Bot" furoutput.mp3
mp3id3init.bat furoutput.mp3