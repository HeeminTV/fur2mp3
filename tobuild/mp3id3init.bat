if exist buffer_fur2mp3id3title.txt (
set /p tite=<buffer_fur2mp3id3title.txt
) else (
set "tite=undefined"
)
id3-081w\id3.exe --title "%tite%" %1
del /q buffer_fur2mp3id3title.txt