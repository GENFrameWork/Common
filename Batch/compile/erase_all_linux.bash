#!/bin/bash

echo -------------------------------------------------------------
echo [Remove directorys]

echo
echo [Examples Base]
sh internal/erase_artifacts.bash "../../../Examples/Base/NotAppExample"
sh internal/erase_artifacts.bash "../../../Examples/Base/AppBaseExample"
sh internal/erase_artifacts.bash "../../../Examples/Base/Canvas2DDisplay"
sh internal/erase_artifacts.bash "../../../Examples/Base/MemCtrlExample"

echo
echo [Examples Console]
sh internal/erase_artifacts.bash "../../../Examples/Console/BinConnPro"
sh internal/erase_artifacts.bash "../../../Examples/Console/NetConn"
sh internal/erase_artifacts.bash "../../../Examples/Console/Databases"
sh internal/erase_artifacts.bash "../../../Examples/Console/MiniWebServer"
sh internal/erase_artifacts.bash "../../../Examples/Console/ScriptsExample"
sh internal/erase_artifacts.bash "../../../Examples/Console/NetCapture"

echo
echo [Examples Graphics]
sh internal/erase_artifacts.bash "../../../Examples/Graphics/Canvas2D"
sh internal/erase_artifacts.bash "../../../Examples/Graphics/UI_Options"
sh internal/erase_artifacts.bash "../../../Examples/Graphics/UI_Message"

echo
echo [Development tests]
sh internal/erase_artifacts.bash "../../../Tests/DevTestsConsole"
sh internal/erase_artifacts.bash "../../../Tests/DevTestsDevices"
sh internal/erase_artifacts.bash "../../../Tests/DevTestsCanvas2D"

echo
echo [Unit tests]           
sh internal/erase_artifacts.bash "../../../Tests/UnitTests"

echo
echo [Utilities]
sh internal/erase_artifacts.bash "../../../Utilities/APPUpdateCreator"
sh internal/erase_artifacts.bash "../../../Utilities/TranslateScan"

echo 

if [ -f "Output.txt" ]; then
  rm Output.txt
fi

#echo Press any key to continue ...
#read KEY


