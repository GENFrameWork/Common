@echo off

set "DIR=%~1/Platforms/%SO_PATH%/%PLATFORM_PATH%"
set "OLDPATH=%CD%"


if not exist "%~1/Platforms/%SO_PATH%" (
  mkdir "%~1/Platforms/%SO_PATH%"
)


 if exist "%DIR%" (
  rmdir /s /q "%DIR%"
)

if not exist "%DIR%" (
  mkdir "%DIR%"
)

cd "%DIR%" 

%PRINTF% "\n\n[%%s]\n\n" "%~2" >> %OUTFILE% 

 
%PRINTF% "[#CMake#]\n"  >> %OUTFILE% 
%PRINTF% "Generate CMake      %%-16s ... " "%~2" 
set "GEN_CMAKE_ARGS=-DTARGET=%TARGET% -DDEBUG_EXTCFG=%DEBUG_EXTCFG% -DMEMORY_EXTCFG=%MEMORY_EXTCFG% -DTRACE_EXTCFG=%TRACE_EXTCFG% -DFEEDBACK_EXTCFG=%FEEDBACK_EXTCFG%"
if /I "%TARGET%"=="ANDROID" (
  set "GEN_CMAKE_ARGS=%GEN_CMAKE_ARGS% -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=%ANDROID_ABI% -DANDROID_PLATFORM=android-24 -DANDROID_STL=c++_shared -DCMAKE_TOOLCHAIN_FILE=..\..\..\..\..\..\ThirdPartyLibraries\android-ndk\build\cmake\android.toolchain.cmake"
)
cmake -G "Ninja" %GEN_CMAKE_ARGS% ../..  >> %OUTFILE% 
if %ERRORLEVEL% equ 0 (
    %PRINTF% "[Ok]\n"
) else (
    %PRINTF% "[Error!]\n"
)


%PRINTF% "[#Compile#]\n"  >> %OUTFILE% 
%PRINTF% "Compilate project   %%-16s ... " "%~2" 
if /I "%TARGET%"=="ANDROID" (
  ninja %~2_apk >> %OUTFILE%
) else (
  ninja >> %OUTFILE%
)
if %ERRORLEVEL% equ 0 (
    %PRINTF% "[Ok]\n"
) else (
    %PRINTF% "[Error!]\n"
)


if exist "%~2tests.exe" (
  %PRINTF% "[#Tests#]\n"  >> %OUTFILE% 
  %PRINTF% "Test project        %%-16s ... " "%~2" 
  %~2tests.exe >> %OUTFILE%
    
  if %ERRORLEVEL% equ 5 (
    %PRINTF% "[Ok]\n" 
  ) else (
    %PRINTF% "[Error!]\n"
  )
)

%PRINTF% " \n" 

cd "%OLDPATH%"
