#!/bin/bash


if [ -z "$TARGET" ]; then
  export TARGET=INTEL64
fi


if [ -z "$DEBUG_EXTCFG" ]; then
  export DEBUG_EXTCFG=NONE
fi


if [ -z "$USE_CLANG_EXTCFG" ]; then
  export USE_CLANG_EXTCFG=NONE
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


if [ -z "$COVERAGE_CREATEINFO_EXTERNAL_CFG" ]; then
    export COVERAGE_CREATEINFO_EXTERNAL_CFG=NONE
fi


if [ -z "$IMAGEBASE" ]; then
  export IMAGEBASE=debian
fi


if [ -z "$PATHLISTAPP" ]; then
  export PATHLISTAPP="$(pwd)/"
fi


if [ -z "$LISTAPP" ]; then
  export LISTAPP="listapp.txt"
fi


if [ -z "$APPLIST_COMPILE" ]; then
  export APPLIST_COMPILE=""
fi


if [ -z "$DOCKERDOMAIN" ]; then
  export DOCKERDOMAIN=/Projects/GEN_FrameWork/Common/Scripts/compile/
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



