rem normalize.exe -a 8 fur2osc\*.wav
::set "directory=fur2osc"
::set "silence_threshold=-50dB"

::for %%f in ("%directory%\*.wav") do (
 ::   ffmpeg -i "%%f" -af "volumedetect" -f null NUL 2>&1 | findstr /C:"max_volume: " | (
  ::      set /p "volume="
   ::     setlocal enabledelayedexpansion
     ::   set "volume=!volume:*max_volume: =!"
       :: endlocal
::        if "!volume!" == "inf" (
  ::          echo "Deleting silent file: %%f"
    ::        del "%%f"
      ::  ) else (
::            for /f "delims=dB" %%v in ("!volume!") do (
  ::              set "current_volume=%%v"
    ::            if %%v LSS %silence_threshold% (
      ::              echo "Deleting quiet file: %%f (Volume: %%v)"
        ::            del "%%f"
          ::      )
::            )
 ::       )
  ::  )
::)
rem echo "Silent files deleted."
