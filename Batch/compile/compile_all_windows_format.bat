
call "C:\Program Files\Microsoft Visual Studio\2022\%1\VC\Auxiliary\Build\vcvarsall.bat" %2
..\..\..\Utilities\printf\printf "\n"


echo -------------------------------------------------------------
set "OUTFILE=..\..\..\..\..\..\Common\Batch\compile\Output.txt"
set "PRINTF=..\..\..\..\..\..\Utilities\printf\printf"

..\..\..\Utilities\printf\printf "[Examples Windows PC %3]\n\n"

..\..\..\Utilities\printf\printf " * [Examples Base %3]\n\n"
call internal/compile_windows.bat ../../../Examples/Base/NotAppExample/Platforms/Windows %3 notappexample
call internal/compile_windows.bat ../../../Examples/Base/AppBaseExample/Platforms/Windows %3 appbaseexample
call internal/compile_windows.bat ../../../Examples/Base/MemCtrlExample/Platforms/Windows %3 memctrlexample
call internal/compile_windows.bat ../../../Examples/Base/Canvas2DDisplay/Platforms/Windows %3 canvas2ddisplay

..\..\..\Utilities\printf\printf " * [Examples Console %3]\n\n"
call internal/compile_windows.bat ../../../Examples/Console/BinConnPro/Platforms/Windows %3 binconnpro
call internal/compile_windows.bat ../../../Examples/Console/NetConn/Platforms/Windows %3 netconn
call internal/compile_windows.bat ../../../Examples/Console/Databases/Platforms/Windows %3 databases
call internal/compile_windows.bat ../../../Examples/Console/MiniWebServer/Platforms/Windows %3 miniwebserver
call internal/compile_windows.bat ../../../Examples/Console/ScriptsExample/Platforms/Windows %3 scriptsexample 
call internal/compile_windows.bat ../../../Examples/Console/NetCapture/Platforms/Windows %3 netcapture 

..\..\..\Utilities\printf\printf " * [Examples Graphics %3]\n\n"
call internal/compile_windows.bat ../../../Examples/Graphics/Canvas2D/Platforms/Windows %3 canvas2d
call internal/compile_windows.bat ../../../Examples/Graphics/UI_Options/Platforms/Windows %3 ui_options
call internal/compile_windows.bat ../../../Examples/Graphics/UI_Message/Platforms/Windows %3 ui_message


echo -------------------------------------------------------------
set "OUTFILE=..\..\..\..\..\Common\Batch\compile\Output.txt"
set "PRINTF=..\..\..\..\..\Utilities\printf\printf"

..\..\..\Utilities\printf\printf "[Tests Windows PC %3]\n\n"

..\..\..\Utilities\printf\printf " * [Development tests %3]\n\n"
call internal/compile_windows.bat ../../../Tests/DevTestsConsole/Platforms/Windows %3 devtestsconsole
call internal/compile_windows.bat ../../../Tests/DevTestsDevices/Platforms/Windows %3 devtestsdevices
call internal/compile_windows.bat ../../../Tests/DevTestsCanvas2D/Platforms/Windows %3 devtestscanvas2d

..\..\..\Utilities\printf\printf " * [Unit tests %3]\n\n"
call internal/compile_windows.bat ../../../Tests/UnitTests/Platforms/Windows %3 unit     



echo -------------------------------------------------------------
set "OUTFILE=..\..\..\..\..\Common\Batch\compile\Output.txt"
set "PRINTF=..\..\..\..\..\Utilities\printf\printf"
..\..\..\Utilities\printf\printf "[Utilities Windows PC %3]\n\n"

call internal/compile_windows.bat ../../../Utilities/APPUpdateCreator/Platforms/Windows %3 appupdatecreator
call internal/compile_windows.bat ../../../Utilities/TranslateScan/Platforms/Windows %3 translatescan



