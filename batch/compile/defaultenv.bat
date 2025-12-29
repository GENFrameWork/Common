@echo off


if not defined TARGET (
    set "TARGET=INTEL64"
)

if not defined DEBUG_EXTCFG (
    set "DEBUG_EXTCFG=NONE"
)

if not defined MEMORY_EXTCFG (
    set "MEMORY_EXTCFG=NONE"
)

if not defined TRACE_EXTCFG (
    set "TRACE_EXTCFG=NONE"
)

if not defined FEEDBACK_EXTCFG (
    set "FEEDBACK_EXTCFG=NONE"
)

if not defined IMAGEBASE (
    set "IMAGEBASE=debian"
)

rem -------------------------------------------------------

if /I "%TARGET%"=="INTEL32" (
    set "PLATFORM_PATH=intel32"
)

if /I "%TARGET%"=="INTEL64" (
    set "PLATFORM_PATH=intel64"
)

if /I "%TARGET%"=="ARM" (
    set "PLATFORM_PATH=arm"
)

if /I "%TARGET%"=="ARM64" (
    set "PLATFORM_PATH=arm64"
)

if /I "%TARGET%"=="ANDROID" (
    set "PLATFORM_PATH=android"
)

if /I "%TARGET%"=="STM32" (
    set "PLATFORM_PATH=stm32"
)

if /I "%TARGET%"=="ESP32" (
    set "PLATFORM_PATH=esp32"
)


