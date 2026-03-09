@echo off

call erase_all_windows.bat

echo %DATE% %TIME% >> output.txt
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set /a "start_time=(((%%a*60+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100)"
)

echo -------------------------------------------------------------
..\..\..\Utilities\printf\printf "Start process ... \n\n"

call compile_windows_format.bat %~1 %~2 %~3 %~4 %~5   

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set /a "end_time=(((%%a*60+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100)"
)

set /a "elapsed_time=end_time - start_time"
set /a "hours=elapsed_time / 360000"
set /a "minutes=(elapsed_time %% 360000) / 6000"
set /a "seconds=(elapsed_time %% 6000) / 100"

echo -------------------------------------------------------------
..\..\..\Utilities\printf\printf "End process.\nProcessing time: %%02d:%%02d:%%02d\n"  %hours% %minutes% %seconds%
echo -------------------------------------------------------------
pause
