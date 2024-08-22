#!/bin/sh

echo -------------------------------------------------------------
echo [Remove directorys]

echo -------------------------------------------------------------
echo [Examples]
echo [Examples Base]
sh internal/erase_artifacts.sh "../../../Examples/Base/NotAppExample"
sh internal/erase_artifacts.sh "../../../Examples/Base/AppBaseExample"
sh internal/erase_artifacts.sh "../../../Examples/Base/Canvas2DDisplay"
sh internal/erase_artifacts.sh "../../../Examples/Base/MemCtrlExample"
echo [Examples Console]
sh internal/erase_artifacts.sh "../../../Examples/Console/BinConnPro"
sh internal/erase_artifacts.sh "../../../Examples/Console/Databases"
sh internal/erase_artifacts.sh "../../../Examples/Console/MiniWebServer"
sh internal/erase_artifacts.sh "../../../Examples/Console/ScriptsExample"
sh internal/erase_artifacts.sh "../../../Examples/Console/NetCapture"
echo [Examples Graphics]
sh internal/erase_artifacts.sh "../../../Examples/Graphics/Canvas2D"
sh internal/erase_artifacts.sh "../../../Examples/Graphics/UI_Options"
sh internal/erase_artifacts.sh "../../../Examples/Graphics/UI_Message"

echo -------------------------------------------------------------
echo [Tests]
echo [Development tests]
sh internal/erase_artifacts.sh "../../../Tests/DevTestsConsole"
sh internal/erase_artifacts.sh "../../../Tests/DevTestsDevices"
sh internal/erase_artifacts.sh "../../../Tests/DevTestsCanvas2D"
echo [Unit tests]           
sh internal/erase_artifacts.sh "../../../Tests/UnitTests"

echo -------------------------------------------------------------
echo [Utilities]
sh internal/erase_artifacts.sh "../../Utilities/APPUpdateCreator"
sh internal/erase_artifacts.sh "../../Utilities/CompileBuilder"

echo ""

if [ -f "Output.txt" ]; then
  rm Output.txt
fi

echo Press any key to continue ...
read KEY


