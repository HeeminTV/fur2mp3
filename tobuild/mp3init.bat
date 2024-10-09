ffmpeg.exe -y -i %~1 -vn -ar 44100 -ac 2 -b:a 240k .\output_furoutput.mp3
mp3id3init.bat output_furoutput.mp3