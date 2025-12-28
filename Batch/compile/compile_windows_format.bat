
@echo off

set "TARGET=%~1"
set "DEBUG_EXTCFG=%~2"
set "MEMORY_EXTCFG=%~3"
set "TRACE_EXTCFG=%~4"
set "FEEDBACK_EXTCFG=%~5"

set "SO_PATH=Windows"

call defaultenv.bat

if /I "%TARGET%"=="ARM" (
    echo ARM target not valid: Change to INTEL32
    set "TARGET=INTEL32"
)

if /I "%TARGET%"=="ARM64" (
    echo ARM64 target not valid: Change to INTEL64
    set "TARGET=INTEL64"
)

set vctype=""

if exist "C:\Program Files\Microsoft Visual Studio\2022\Community" (
  set vctype=Community
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional" (
  set vctype=Professional
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise" (
  set vctype=Enterprise
)

if "%vctype%"=="" (set vctype=Enterprise)

if /I "%TARGET%"=="INTEL32" (   
    set "vcplatform=amd64_x86"
)

if /I "%TARGET%"=="INTEL64" (   
    set "vcplatform=amd64"
)

set "OLDPATH=%CD%"
set "OUTFILE=%OLDPATH%\output.txt"
set "PRINTF=%OLDPATH%\..\..\..\Utilities\printf\printf"


call "C:\Program Files\Microsoft Visual Studio\2022\%vctype%\VC\Auxiliary\Build\vcvarsall.bat" %vcplatform%
%PRINTF% "\n"

%PRINTF% "GEN Plataform %TARGET%, External Config [ Debug %DEBUG_EXTCFG%, Memory Control %MEMORY_EXTCFG%, Trace %TRACE_EXTCFG%, FeedBack %FEEDBACK_EXTCFG% ]\n"
%PRINTF% "\n" 

%PRINTF% "GEN Plataform %TARGET%, External Config [ Debug %DEBUG_EXTCFG%, Memory Control %MEMORY_EXTCFG%, Trace %TRACE_EXTCFG%, FeedBack %FEEDBACK_EXTCFG% ]\n" >> %OUTFILE% 
%PRINTF% "\n" >> %OUTFILE% 


setlocal

for /f "usebackq delims=" %%L in ("listapp.txt") do (
  call internal/compile_windows.bat %%L
)

endlocal



