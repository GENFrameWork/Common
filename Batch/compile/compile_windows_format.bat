
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


call "C:\Program Files\Microsoft Visual Studio\2022\%vctype%\VC\Auxiliary\Build\vcvarsall.bat" %vcplatform%
..\..\..\Utilities\printf\printf "\n"




..\..\..\Utilities\printf\printf "GEN Plataform %TARGET%, External Config [ Debug %DEBUG_EXTCFG%, Memory Control %MEMORY_EXTCFG%, Trace %TRACE_EXTCFG%, FeedBack %FEEDBACK_EXTCFG% ]\n"
..\..\..\Utilities\printf\printf "\n" 

..\..\..\Utilities\printf\printf "GEN Plataform %TARGET%, External Config [ Debug %DEBUG_EXTCFG%, Memory Control %MEMORY_EXTCFG%, Trace %TRACE_EXTCFG%, FeedBack %FEEDBACK_EXTCFG% ]\n"  >> output.txt
..\..\..\Utilities\printf\printf "\n" >> output.txt



echo -------------------------------------------------------------
set "OUTFILE=..\..\..\..\..\..\Common\Batch\compile\output.txt"
set "PRINTF=..\..\..\..\..\..\Utilities\printf\printf"


..\..\..\Utilities\printf\printf "\n[Examples Base]\n\n"
call internal/compile_windows.bat ../../../Examples/Base/NotAppExample      notappexample
call internal/compile_windows.bat ../../../Examples/Base/AppBaseExample     appbaseexample
call internal/compile_windows.bat ../../../Examples/Base/MemCtrlExample     memctrlexample
call internal/compile_windows.bat ../../../Examples/Base/Canvas2DDisplay    canvas2ddisplay

..\..\..\Utilities\printf\printf "\n[Examples Console]\n\n"
call internal/compile_windows.bat ../../../Examples/Console/BinConnPro      binconnpro
call internal/compile_windows.bat ../../../Examples/Console/NetConn         netconn
call internal/compile_windows.bat ../../../Examples/Console/Databases       databases
call internal/compile_windows.bat ../../../Examples/Console/MiniWebServer   miniwebserver
call internal/compile_windows.bat ../../../Examples/Console/ScriptsExample  scriptsexample 
call internal/compile_windows.bat ../../../Examples/Console/NetCapture      netcapture 

..\..\..\Utilities\printf\printf "\n[Examples Graphics]\n\n"
call internal/compile_windows.bat ../../../Examples/Graphics/Canvas2D       canvas2d
call internal/compile_windows.bat ../../../Examples/Graphics/UI_Options     ui_options
call internal/compile_windows.bat ../../../Examples/Graphics/UI_Message     ui_message


set "OUTFILE=..\..\..\..\..\Common\Batch\compile\output.txt"
set "PRINTF=..\..\..\..\..\Utilities\printf\printf"


echo -------------------------------------------------------------

..\..\..\Utilities\printf\printf "\n[Development tests]\n\n"
call internal/compile_windows.bat ../../../Tests/DevTestsConsole            devtestsconsole
call internal/compile_windows.bat ../../../Tests/DevTestsDevices            devtestsdevices
call internal/compile_windows.bat ../../../Tests/DevTestsCanvas2D           devtestscanvas2D

..\..\..\Utilities\printf\printf "\n[Unit tests]\n\n"
call internal/compile_windows.bat ../../../Tests/UnitTests                  unit     


echo -------------------------------------------------------------

..\..\..\Utilities\printf\printf "\n[Utilities]\n\n"
call internal/compile_windows.bat ../../../Utilities/APPUpdateCreator       appupdatecreator
call internal/compile_windows.bat ../../../Utilities/TranslateScan          translatescan



