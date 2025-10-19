#!/bin/sh

date >> Output.txt
START_TIME=$(date +%s)


echo -------------------------------------------------------------
printf "Start process ... \n\n"



echo -------------------------------------------------------------
OUTFILE="../../../../../../Common/Batch/compile/Output.txt"
export OUTFILE
printf "[Examples Linux INTEL x64]\n\n"

printf " * [Examples Base INTEL x64]\n\n"
sh ./internal/compile_linux.sh ../../../Examples/Base/AppBaseExample/Platforms/Linux /intelx64 appbaseexample
sh ./internal/compile_linux.sh ../../../Examples/Base/Canvas2DDisplay/Platforms/Linux /intelx64 canvas2ddisplay
sh ./internal/compile_linux.sh ../../../Examples/Base/MemCtrlExample/Platforms/Linux /intelx64 memctrlexample
sh ./internal/compile_linux.sh ../../../Examples/Base/NotAppExample/Platforms/Linux /intelx64 notappexample

printf " * [Examples Console INTEL x64]\n\n"
sh ./internal/compile_linux.sh ../../../Examples/Console/BinConnPro/Platforms/Linux /intelx64 binconnpro
sh ./internal/compile_linux.sh ../../../Examples/Console/NetConn/Platforms/Linux /intelx64 netconn
sh ./internal/compile_linux.sh ../../../Examples/Console/Databases/Platforms/Linux /intelx64 databases
sh ./internal/compile_linux.sh ../../../Examples/Console/MiniWebServer/Platforms/Linux /intel64 miniwebserver
sh ./internal/compile_linux.sh ../../../Examples/Console/ScriptsExample/Platforms/Linux /intel64 scriptsexample 
sh ./internal/compile_linux.sh ../../../Examples/Console/NetCapture/Platforms/Linux /intel64 netcapture 

printf " * [Examples Graphics INTEL x64]\n\n"
sh ./internal/compile_linux.sh ../../../Examples/Graphics/Canvas2D/Platforms/Linux /intel64 canvas2d
sh ./internal/compile_linux.sh ../../../Examples/Graphics/UI_Options/Platforms/Linux /intel64 ui_options
sh ./internal/compile_linux.sh ../../../Examples/Graphics/UI_Message/Platforms/Linux /intel64 ui_message



echo -------------------------------------------------------------
OUTFILE="../../../../../Common/Batch/compile/Output.txt"
export OUTFILE
printf "[Test Linux INTEL INTEL x64]\n\n"

printf " * [Development tests INTEL x64]\n\n"
sh ./internal/compile_linux.sh ../../../Tests/DevTestsConsole/Platforms/Linux /intel64 devtestconsole
sh ./internal/compile_linux.sh ../../../Tests/DevTestsDevices/Platforms/Linux /intel64 devtestsdevices
sh ./internal/compile_linux.sh ../../../Tests/DevTestsCanvas2D/Platforms/Linux /intel64 devtestscanvas2D

printf " * [Unit tests INTEL x64]\n\n"
sh ./internal/compile_linux.sh ../../../Tests/UnitTests/Platforms/Linux /intel64 unit



echo -------------------------------------------------------------
OUTFILE="../../../../../Common/Batch/compile/Output.txt"
export OUTFILE

printf "[Utilities INTEL x64]\n\n"
sh ./internal/compile_linux.sh ../../../Utilities/APPUpdateCreator/Platforms/Windows /intel64 appupdatecreator
sh ./internal/compile_linux.sh ../../../Utilities/TranslateScan/Platforms/Windows /intel64 translatescan


END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
HOURS=$((ELAPSED_TIME / 3600))
MINUTES=$(((ELAPSED_TIME % 3600) / 60 ))
SECONDS=$((ELAPSED_TIME % 60))

echo -------------------------------------------------------------
printf "End process.\nProcessing time: %02d:%02d:%02d\n" "$HOURS" "$MINUTES" "$SECONDS"
echo -------------------------------------------------------------

