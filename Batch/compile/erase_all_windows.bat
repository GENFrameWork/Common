echo off

echo -------------------------------------------------------------
echo [Remove directorys]

echo
echo [Examples Base]
call internal/erase_artifacts "../../../Examples/Base/NotAppExample"
call internal/erase_artifacts "../../../Examples/Base/AppBaseExample"
call internal/erase_artifacts "../../../Examples/Base/Canvas2DDisplay"
call internal/erase_artifacts "../../../Examples/Base/MemCtrlExample"

echo
echo [Examples Console]
call internal/erase_artifacts "../../../Examples/Console/BinConnPro"
call internal/erase_artifacts "../../../Examples/Console/NetConn"
call internal/erase_artifacts "../../../Examples/Console/Databases"
call internal/erase_artifacts "../../../Examples/Console/MiniWebServer"
call internal/erase_artifacts "../../../Examples/Console/ScriptsExample"
call internal/erase_artifacts "../../../Examples/Console/NetCapture"

echo
echo [Examples Graphics]
call internal/erase_artifacts "../../../Examples/Graphics/Canvas2D"
call internal/erase_artifacts "../../../Examples/Graphics/UI_Options"
call internal/erase_artifacts "../../../Examples/Graphics/UI_Message"

echo
echo [Development tests]
call internal/erase_artifacts "../../../Tests/DevTestsConsole"
call internal/erase_artifacts "../../../Tests/DevTestsDevices"
call internal/erase_artifacts "../../../Tests/DevTestsCanvas2D"

echo
echo [Unit tests]
call internal/erase_artifacts "../../../Tests/UnitTests"

echo
echo [Utilities]
call internal/erase_artifacts "../../../Utilities/APPUpdateCreator"
call internal/erase_artifacts "../../../Utilities/TranslateScan"

echo 

if exist "output.txt" ( 
  del output.txt
)

rem echo Press enter key to continue ...
rem pause
