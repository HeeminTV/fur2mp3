@echo Off
setlocal enabledelayedexpansion
set "filename=%~n2"
set "directory=%~dp2"
set "required=%~dp1"
echo.^^!Config > "%filename%.yaml"
echo.begin_time: 0 >> "%filename%.yaml"
echo.end_time: >> "%filename%.yaml"
echo.fps: 60 >> "%filename%.yaml"
echo.trigger_ms: 40 >> "%filename%.yaml"
echo.render_ms: 40 >> "%filename%.yaml"
echo.trigger_subsampling: 1 >> "%filename%.yaml"
echo.render_subsampling: 2 >> "%filename%.yaml"
echo.render_subfps: 2 >> "%filename%.yaml"
if "%~3"=="" (
echo.amplification: 2 >> "%filename%.yaml"
) else (
echo.amplification: %~3 >> "%filename%.yaml"
)
echo.trigger_stereo: ^^!Flatten SumAvg >> "%filename%.yaml"
echo.render_stereo: ^^!Flatten SumAvg >> "%filename%.yaml"
echo.trigger: ^^!CorrelationTriggerConfig >> "%filename%.yaml"
echo.  edge_direction: 1 >> "%filename%.yaml"
echo.  post_trigger: >> "%filename%.yaml"
echo.  post_radius: 3 >> "%filename%.yaml"
echo.  mean_responsiveness: 0.0 >> "%filename%.yaml"
echo.  edge_strength: 1.0 >> "%filename%.yaml"
echo.  slope_width: 0.25 >> "%filename%.yaml"
echo.  responsiveness: 0.5 >> "%filename%.yaml"
echo.  temp_falloff: 0.5 >> "%filename%.yaml"
echo.  reset_below: 0.3 >> "%filename%.yaml"
echo.  pitch_tracking: ^^!SpectrumConfig {} >> "%filename%.yaml"

for /f "usebackq delims=" %%A in (`powershell -Command ^
    "try { $json = Get-Content -Raw -Path '..\settings.json' | ConvertFrom-Json; " ^
    "[Console]::WriteLine($json.oscilloscope.label) } catch { [Console]::WriteLine('false') }"`) do set "osciLabel=%%A"
	
if "%osciLabel%"=="true" (
	echo.default_label: ^^!DefaultLabel FileName >> "%filename%.yaml"
)

echo.layout: ^^!LayoutConfig >> "%filename%.yaml"
echo.  orientation: v >> "%filename%.yaml"
echo.  nrows: >> "%filename%.yaml"
echo.  ncols: >> "%filename%.yaml"
echo.  stereo_orientation: v >> "%filename%.yaml"
echo.render: ^^!RendererConfig >> "%filename%.yaml"

for /f "usebackq delims=" %%A in (`powershell -Command ^
    "try { $json = Get-Content -Raw -Path '..\settings.json' | ConvertFrom-Json; " ^
    "[Console]::WriteLine($json.oscilloscope.resWidth) } catch { [Console]::WriteLine('1280') }"`) do set "xres=%%A"
	
echo.  width: %xres% >> "%filename%.yaml"

for /f "usebackq delims=" %%A in (`powershell -Command ^
    "try { $json = Get-Content -Raw -Path '..\settings.json' | ConvertFrom-Json; " ^
    "[Console]::WriteLine($json.oscilloscope.resHeight) } catch { [Console]::WriteLine('1280') }"`) do set "yres=%%A"
	
echo.  height: %yres% >> "%filename%.yaml"

for /f "usebackq delims=" %%A in (`powershell -Command ^
    "try { $json = Get-Content -Raw -Path '..\settings.json' | ConvertFrom-Json; " ^
    "[Console]::WriteLine($json.oscilloscope.lineWidth) } catch { [Console]::WriteLine('2') }"`) do set "lineWidth=%%A"
	
echo.  line_width: %lineWidth% >> "%filename%.yaml"
echo.  line_outline_width: 0.0 >> "%filename%.yaml"
echo.  grid_line_width: 1.0 >> "%filename%.yaml"
echo.  bg_color: '#000000' >> "%filename%.yaml"
echo.  bg_image: '' >> "%filename%.yaml"
echo.  init_line_color: '#ffffff' >> "%filename%.yaml"
echo.  global_line_outline_color: '#000000' >> "%filename%.yaml"
echo.  global_color_by_pitch: false >> "%filename%.yaml"
echo.  pitch_colors: >> "%filename%.yaml"
echo.  - '#ff8189' >> "%filename%.yaml"
echo.  - '#ff9155' >> "%filename%.yaml"
echo.  - '#ffba37' >> "%filename%.yaml"
echo.  - '#f7ff52' >> "%filename%.yaml"
echo.  - '#95ff85' >> "%filename%.yaml"
echo.  - '#16ffc1' >> "%filename%.yaml"
echo.  - '#00ffff' >> "%filename%.yaml"
echo.  - '#4dccff' >> "%filename%.yaml"
echo.  - '#86acff' >> "%filename%.yaml"
echo.  - '#b599ff' >> "%filename%.yaml"
echo.  - '#ed96ff' >> "%filename%.yaml"
echo.  - '#ff87ca' >> "%filename%.yaml"
echo.  grid_color: '#909090' >> "%filename%.yaml"
echo.  stereo_grid_opacity: 0.25 >> "%filename%.yaml"
echo.  midline_color: '#404040' >> "%filename%.yaml"
echo.  v_midline: false >> "%filename%.yaml"
echo.  h_midline: true >> "%filename%.yaml"
echo.  label_font: ^^!Font >> "%filename%.yaml"
echo.    family: Arial >> "%filename%.yaml"
echo.    bold: false >> "%filename%.yaml"
echo.    italic: false >> "%filename%.yaml"
echo.    size: 28.0 >> "%filename%.yaml"
echo.    toString: Arial,28,-1,5,50,0,0,0,0,0,Regular >> "%filename%.yaml"
echo.  label_position: ^^!LabelPosition LeftTop >> "%filename%.yaml"
echo.  label_padding_ratio: 0.5 >> "%filename%.yaml"
echo.  label_color_override: >> "%filename%.yaml"
echo.  antialiasing: true >> "%filename%.yaml"
echo.  res_divisor: 1.5 >> "%filename%.yaml"
echo.ffmpeg_cli: ^^!FFmpegOutputConfig >> "%filename%.yaml"
echo.  path: >> "%filename%.yaml"
echo.  video_template: -c:v libx264 -crf 18 -pix_fmt yuv420p -vf scale=out_color_matrix=bt709 -color_range 1 -colorspace bt709 -color_trc bt709 -color_primaries bt709 -movflags faststart >> "%filename%.yaml"
echo.master_audio: '%directory%%filename%.wav' >> "%filename%.yaml"
echo.channels: >> "%filename%.yaml"

REM 파워쉘을 사용하여 숫자 기반 정렬 후 출력
for /f "tokens=*" %%f in ('powershell -command "Get-ChildItem -File %~1 | Sort-Object { [int]($_.Name -replace '[^0-9]', '') } | ForEach-Object { $_.Name }"') do (
	for /f "delims=" %%a in ('node.exe MeanAmplitudeCaculate.js %required%%%f') do (
		set trueorfalse=%%a
		if not "!trueorfalse!"=="false" (
			echo.- ^^!ChannelConfig >> "%filename%.yaml"
			echo.  wav_path: '%required%%%f' >> "%filename%.yaml"
		)
	)
)

endlocal
