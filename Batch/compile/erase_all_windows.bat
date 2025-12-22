echo off


@echo off
setlocal

rem Lee cada línea como un único token (incluye espacios si están entre comillas)
for /f "usebackq delims=" %%L in ("listapp.txt") do (
   call internal/erase_artifacts %%L
)

endlocal


if exist "output.txt" ( 
  del output.txt
)

rem echo Press enter key to continue ...
rem pause
