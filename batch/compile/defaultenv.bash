#!/bin/bash


if [ -z "$TARGET" ]; then
  export TARGET=INTEL64
fi


if [ -z "$DEBUG_EXTCFG" ]; then
  export DEBUG_EXTCFG=NONE
fi


if [ -z "$MEMORY_EXTCFG" ]; then
  export MEMORY_EXTCFG=NONE
fi


if [ -z "$TRACE_EXTCFG" ]; then
  export TRACE_EXTCFG=NONE
fi


if [ -z "$FEEDBACK_EXTCFG" ]; then
  export FEEDBACK_EXTCFG=NONE
fi


if [ -z "$IMAGEBASE" ]; then
  export IMAGEBASE=debian
fi


if [ -z "$PATHCOMPILE" ]; then
  export PATHCOMPILE=""
fi


if [ "$PATHCOMPILE" = "" ]; then
 export PATHCOMPILE="$(pwd)/"
fi


#-------------------------------------------------------------------------------------------


if [ "$TARGET" = "INTEL32" ]; then
  export PLATFORM_PATH="intel32"
fi


if [ "$TARGET" = "INTEL64" ]; then
  export PLATFORM_PATH="intel64"
fi


if [ "$TARGET" = "ARM" ]; then
  export PLATFORM_PATH="arm"
fi


if [ "$TARGET" = "ARM64" ]; then
  export PLATFORM_PATH="arm64"
fi


if [ "$TARGET" = "RPI" ]; then
  export PLATFORM_PATH="rpi"
fi


if [ "$TARGET" = "RPI64" ]; then
  export PLATFORM_PATH="rpi64"
fi


if [ "$TARGET" = "ANDROID" ]; then
  export PLATFORM_PATH="android"
fi


if [ "$TARGET" = "STM32" ]; then
  export PLATFORM_PATH="stm32"
fi


if [ "$TARGET" = "ESP32" ]; then
  export PLATFORM_PATH="esp32"
fi



