#!/bin/bash

source ./erase_all_linux.bash

date >> output.txt

START_TIME=$(date +%s)

export TARGET=$1
export DEBUG_EXTCFG=$2
export MEMORY_EXTCFG=$3
export TRACE_EXTCFG=$4
export FEEDBACK_EXTCFG=$5

export SO_PATH="Linux"

echo --------------------------------------------------------------------------
printf "Start process ... \n\n"

source ./defaultenv.bash


if [ "$TARGET" = "INTEL32" ]; then  
  printf "INTEL32 target not valid: Change to INTEL64\n"
  export TARGET="INTEL64"
fi


printf "GEN Plataform $TARGET, External Config [ Debug $DEBUG_EXTCFG, Memory Control $MEMORY_EXTCFG, Trace $TRACE_EXTCFG, FeedBack $FEEDBACK_EXTCFG ]\n"
echo

printf "GEN Plataform $TARGET, External Config [ Debug $DEBUG_EXTCFG, Memory Control $MEMORY_EXTCFG, Trace $TRACE_EXTCFG, FeedBack $FEEDBACK_EXTCFG ]\n" >> output.txt
printf "\n" >> output.txt


OUTFILE="../../../../../../Common/Batch/compile/output.txt"
export OUTFILE


echo --------------------------------------------------------------------------
printf "\n[Examples Base]\n\n"
sh ./internal/compile_linux.bash ../../../Examples/Base/AppBaseExample      appbaseexample
sh ./internal/compile_linux.bash ../../../Examples/Base/Canvas2DDisplay     canvas2ddisplay
sh ./internal/compile_linux.bash ../../../Examples/Base/MemCtrlExample      memctrlexample
sh ./internal/compile_linux.bash ../../../Examples/Base/NotAppExample       notappexample
  
printf "\n[Examples Console]\n\n" 
sh ./internal/compile_linux.bash ../../../Examples/Console/BinConnPro       binconnpro
sh ./internal/compile_linux.bash ../../../Examples/Console/NetConn          netconn
sh ./internal/compile_linux.bash ../../../Examples/Console/Databases        databases
sh ./internal/compile_linux.bash ../../../Examples/Console/MiniWebServer    miniwebserver
sh ./internal/compile_linux.bash ../../../Examples/Console/ScriptsExample   scriptsexample 
sh ./internal/compile_linux.bash ../../../Examples/Console/NetCapture       netcapture 
  
printf "\n[Examples Graphics]\n\n"  
sh ./internal/compile_linux.bash ../../../Examples/Graphics/Canvas2D        canvas2d
sh ./internal/compile_linux.bash ../../../Examples/Graphics/UI_Options      ui_options
sh ./internal/compile_linux.bash ../../../Examples/Graphics/UI_Message      ui_message


OUTFILE="../../../../../Common/Batch/compile/output.txt"
export OUTFILE


echo --------------------------------------------------------------------------

printf "\n[Development tests]\n\n"
sh ./internal/compile_linux.bash ../../../Tests/DevTestsConsole             devtestconsole
sh ./internal/compile_linux.bash ../../../Tests/DevTestsDevices             devtestsdevices
sh ./internal/compile_linux.bash ../../../Tests/DevTestsCanvas2D            devtestscanvas2D

printf "\n[Unit tests]\n\n"
sh ./internal/compile_linux.bash ../../../Tests/UnitTests                   unit


echo --------------------------------------------------------------------------

printf "\n[Utilities]\n\n"
sh ./internal/compile_linux.bash ../../../Utilities/APPUpdateCreator        appupdatecreator
sh ./internal/compile_linux.bash ../../../Utilities/TranslateScan           translatescan


END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
HOURS=$((ELAPSED_TIME / 3600))
MINUTES=$(((ELAPSED_TIME % 3600) / 60 ))
SECONDS=$((ELAPSED_TIME % 60))

echo --------------------------------------------------------------------------
printf "End process.\nProcessing time: %02d:%02d:%02d\n" "$HOURS" "$MINUTES" "$SECONDS"
echo --------------------------------------------------------------------------

